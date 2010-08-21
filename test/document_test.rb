require 'test_helper'

class DocumentTest < Test::Unit::TestCase

  def test_should_wrap_nokogiri_xml_document
    document = VAST::Document.new
    assert document.kind_of?(Nokogiri::XML::Document)
  end
  
  def test_should_create_valid_document_from_valid_xml_file
    valid_vast_document_file = example_file('document_with_no_ads.xml')
    document = VAST::Document.parse(valid_vast_document_file)
    assert document.valid?
  end

  def test_should_create_invalid_document_from_invalid_xml_file
    invalid_vast_document_file = example_file('invalid_document.xml')
    document = VAST::Document.parse(invalid_vast_document_file)
    assert !document.valid?
  end

  def test_should_raise_error_when_bang_parsing_invalid_document
    invalid_vast_document_file = example_file('invalid_document.xml')
    assert_raise VAST::InvalidDocumentError do
      document = VAST::Document.parse!(invalid_vast_document_file)
    end
  end

  def test_empty_document_should_have_no_ads
    document_with_no_ads = example_file('document_with_no_ads.xml')
    document = VAST::Document.parse!(document_with_no_ads)
    assert_equal [], document.ads
  end

  def test_document_with_one_ad
    document_with_one_ad = example_file('document_with_one_inline_ad.xml')
    document = VAST::Document.parse!(document_with_one_ad)
    
    assert_equal 1, document.ads.count
    assert document.ads.first.kind_of?(VAST::InlineAd)
  end
  
  def test_document_with_more_than_one_ads
    document_with_two_ads = example_file('document_with_two_inline_ads.xml')
    document = VAST::Document.parse!(document_with_two_ads)
    
    assert_equal 2, document.ads.count
    document.ads.each do |ad|
      assert ad.kind_of?(VAST::Ad)
    end
  end
  
  def test_document_should_know_inline_ads
    document_file = example_file('document_with_one_inline_and_one_wrapper_ad.xml')
    document = VAST::Document.parse!(document_file)
    
    assert_equal 1, document.inline_ads.count
    document.inline_ads.each do |ad|
      assert ad.kind_of?(VAST::InlineAd)
    end
  end
  
  def test_document_should_know_wrapper_ads
    document_file = example_file('document_with_one_inline_and_one_wrapper_ad.xml')
    document = VAST::Document.parse!(document_file)
    
    assert_equal 1, document.wrapper_ads.count
    document.wrapper_ads.each do |ad|
      assert ad.kind_of?(VAST::WrapperAd)
    end
  end
end