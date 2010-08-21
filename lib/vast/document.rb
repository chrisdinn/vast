module VAST
  class Document < Nokogiri::XML::Document
    # Raises InvalidDocumentError if document doesnot conform to VAST Schema XSD
    def self.parse!(*args)
      document = parse(*args)
      raise InvalidDocumentError unless document.valid?
      document
    end
    
    # Checks whether document conforms to VAST Schema XSD 
    def valid?
      xsd = Nokogiri::XML::Schema(File.read(VAST_SCHEMA_XSD_FILE))
      xsd.valid?(self)
    end
    
    # All ads in the document
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