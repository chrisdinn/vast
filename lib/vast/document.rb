module VAST
  # A complete VAST document
  class Document < Nokogiri::XML::Document
    
    # Parse a VAST XML document
    def self.parse(*args)
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
      xsd = Nokogiri::XML::Schema(File.read(VAST_SCHEMA_XSD_FILE))
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
    
    # All wrapper ads
    def wrapper_ads
      ads.select{ |ad| ad.kind_of?(VAST::WrapperAd) }
    end
  end
end