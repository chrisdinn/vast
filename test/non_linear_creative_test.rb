require 'test_helper'

class NonLinearCreativeTest < Test::Unit::TestCase
  
  def test_should_know_attributes
    document_file = example_file('document_with_one_inline_ad.xml')
    document = VAST::Document.parse!(document_file)
    creative = document.inline_ads.first.non_linear_creatives.first
   
    assert_equal "special_overlay", creative.id
    assert_equal 300, creative.width
    assert_equal 50, creative.height
    assert_equal 600, creative.expanded_width
    assert_equal 500, creative.expanded_height
    assert_equal "http://t3.liverail.com", creative.click_through_url.to_s
    assert_equal "VPAID", creative.api_framework 
    assert creative.scalable?
    assert creative.maintain_aspect_ratio?
  end
  
  def test_should_know_static_resource
    document_file = example_file('document_with_one_inline_ad.xml')
    document = VAST::Document.parse!(document_file)
    creative_with_static_resource = document.inline_ads.first.non_linear_creatives.first
    
    assert_equal :static, creative_with_static_resource.resource_type
    assert_equal "image/jpeg", creative_with_static_resource.creative_type
    assert_equal "http://cdn.liverail.com/adasset/228/330/overlay.jpg", creative_with_static_resource.resource_url.to_s
  end

  def test_should_know_iframe_resource
    document_file = example_file('document_with_one_inline_ad.xml')
    document = VAST::Document.parse!(document_file)
    creative_with_iframe_resource = document.inline_ads.first.non_linear_creatives.last
    
    assert_equal :iframe, creative_with_iframe_resource.resource_type
    assert_equal "http://ad3.liverail.com/util/non_linear.php", creative_with_iframe_resource.resource_url.to_s
  end
end