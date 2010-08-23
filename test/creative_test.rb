require 'test_helper'

class CreativeTest < Test::Unit::TestCase
  
  def test_should_know_attributes
    document_with_creative = example_file('document_with_one_inline_ad.xml')
    document = VAST::Document.parse!(document_with_creative)
    creative = VAST::Creative.new(document.root.at('Linear'))
    
    assert_equal "6012", creative.id
    assert_equal "601364", creative.ad_id
    assert_equal "1", creative.sequence
    assert_equal "params=for&request=gohere", creative.ad_parameters
  end
  
  def test_should_know_its_ad
    document_with_creative = example_file('document_with_one_inline_ad.xml')
    document = VAST::Document.parse!(document_with_creative)
    creative = VAST::Creative.new(document.root.at('Linear'))
    
    assert creative.ad.kind_of?(VAST::Ad), "Creative should know it's Ad"
    assert_equal creative.source_node.ancestors('Ad').first[:id], creative.ad.id
  end
  
  def test_should_know_tracking_urls_for_all_events
    document_with_creative = example_file('document_with_one_inline_ad.xml')
    document = VAST::Document.parse!(document_with_creative)
    creative = document.ads.first.linear_creatives.first
    
    assert_equal "http://myTrackingURL/creativeView", creative.tracking_urls[:creative_view].to_s
    assert_equal "http://myTrackingURL/start", creative.tracking_urls[:start].to_s
    ## There are more tracking urls, refer to spec for complete list
  end
  
end