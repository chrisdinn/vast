require 'test_helper'

class DocumentTest < Test::Unit::TestCase

  def test_should_wrap_nokogiri_xml_document
    document = VAST::Document.new
    assert document.kind_of?(Nokogiri::XML::Document)
  end
  
  def test_should_create_valid_document_from_valid_xml_file
    valid_vast_document_file = File.expand_path(File.join(File.dirname(__FILE__), 'examples', 'document_with_no_ads.xml'))
    document = VAST::Document.parse(File.read(valid_vast_document_file))
    assert document.valid?
  end

  def test_should_create_invalid_document_from_invalid_xml_file
    invalid_vast_document_file = File.expand_path(File.join(File.dirname(__FILE__), 'examples', 'invalid_document.xml'))
    document = VAST::Document.parse(File.read(invalid_vast_document_file))
    assert !document.valid?
  end

  def test_should_raise_error_when_bang_parsing_invalid_document_with
    invalid_vast_document_file = File.expand_path(File.join(File.dirname(__FILE__), 'examples', 'invalid_document.xml'))
    assert_raise VAST::InvalidDocumentError do
      document = VAST::Document.parse!(File.read(invalid_vast_document_file))
    end
  end

end