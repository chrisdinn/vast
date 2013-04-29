module VAST
  # A complete VAST document
  class Document < Nokogiri::XML::Document
    @macros = ["ERRORCODE", "CONTENTPLAYHEAD", "CACHEBUSTING", "ASSETURI"]

    def self.eval_macro(xml_string)
    end

    # Parse a VAST XML document
    def self.parse(*args)
      # VAST 3 support macro, need to uri escape all macros
      if (args[0].is_a? String)
        @macros.each{|x|  args[0].gsub!("[#{x}]", "%5B#{x}%5D")}
      end
      super(*args)
    end
    
    # Same as parse, but raises InvalidDocumentError if document is not valid
    def self.parse!(*args)
      document = parse(*args)
      raise InvalidDocumentError unless document.valid?
      document
    end
    
    # Checks whether document conforms to the VAST XML Schema Definitions, accessible at
    # http://www.iab.net/iab_products_and_industry_services/508676/digitalvideo/vast
    def valid?
      version_node = self.xpath('/VAST/@version').first
      major_version = version_node ? version_node.value.to_i : 0
      case major_version
      when 2
        xsd_file = VAST_SCHEMA_XSD_FILE
      when 3
        xsd_file = VAST3_SCHEMA_XSD_FILE
      else
        return false
      end
      xsd = Nokogiri::XML::Schema(File.read(xsd_file))
      xsd.valid?(self)
    end
    
    # A single VAST response may include multiple Ads from multiple advertisers. It will be up to the 
    # Video Player to determine the order, timing, placement, etc for the multiple ads. However, the 
    # player should generally respect the sequential order of the Ad elements within the ad.
    #
    # If no ads of any type are available, it would be indicated by the absence of any ads.
    def ads
      self.root.xpath('.//Ad').to_a.collect do |node|
        Ad.create(node)
      end
    end
    
    # All inline ads
    def inline_ads
      ads.select{ |ad| ad.kind_of?(VAST::InlineAd) }
    end

    def ad_pod_ads
      ads.select{ |ad| ad.sequence.is_a? Numeric }.sort{|x, y| x.sequence <=> y.sequence }
    end

    def stand_alone_ads
      ads.select{ |ad| !ad.sequence.is_a?(Numeric) }
    end
    
    # All wrapper ads
    def wrapper_ads
      ads.select{ |ad| ad.kind_of?(VAST::WrapperAd) }
    end
  end
end