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
  end
end