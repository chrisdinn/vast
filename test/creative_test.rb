require 'test_helper'

class CreativeTest < Test::Unit::TestCase
 
  def test_should_initialize_linear_creative
    document_with_linear_creative = example_file('document_with_one_inline_ad.xml')
    document = VAST::Document.parse!(document_with_linear_creative)

    linear_node = document.root.at('Creative/Linear')
    creative_node = linear_node.parent
    
    creative = VAST::Creative.create(creative_node)
    assert creative.kind_of?(VAST::LinearCreative), "Creative should be kind of LinearCreative"
  end
  
  def test_should_initialize_non_linear_creative
    document_with_non_linear_creative = example_file('document_with_one_inline_ad.xml')
    document = VAST::Document.parse!(document_with_non_linear_creative)
        
    non_linear_node = document.root.at('Creative/NonLinearAds')
    creative_node = non_linear_node.parent
    
    creative = VAST::Creative.create(creative_node)
    assert creative.kind_of?(VAST::NonLinearCreative), "Creative should be kind of NonLinearCreative"
  end
  
  def test_should_initialize_companion_creative
    document_with_companion_creative = example_file('document_with_one_wrapper_ad.xml')
    document = VAST::Document.parse!(document_with_companion_creative)
    
    companion_ads_node = document.root.at('Creative/CompanionAds')
    creative_node = companion_ads_node.parent
    
    creative = VAST::Creative.create(creative_node)
    assert creative.kind_of?(VAST::CompanionCreative), "Creative should be kind of CompanionCreative"
  end
  
  def test_should_raise_error_if_no_creative_type_specified
    document_with_creative_missing_type = example_file('invalid_document_with_missing_creative_type.xml')
    document = VAST::Document.parse(document_with_creative_missing_type)
    assert !document.valid?
    
    creative = document.root.at('Creatives/Creative')
    assert_raise VAST::InvalidCreativeError, "should raise error" do
      creative = VAST::Creative.create(creative)
    end
  end
  
  def test_should_know_its_ad
    document_with_creative = example_file('document_with_one_inline_ad.xml')
    document = VAST::Document.parse!(document_with_creative)
    creative = VAST::Creative.create(document.root.at('Creative'))
    
    assert creative.ad.kind_of?(VAST::Ad), "Creative should know it's Ad"
    assert_equal creative.source_node.ancestors('Ad').first[:id], creative.ad.id
  end
  
  
end