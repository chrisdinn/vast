require 'test_helper'

class LinearCreativeTest < Test::Unit::TestCase
  
  def test_ad_should_know_attributes
    document_file = example_file('document_with_one_inline_ad.xml')
    document = VAST::Document.parse!(document_file)
    creative = document.inline_ads.first.linear_creatives.first
    
    assert_equal "00:00:30", creative.duration
    assert_equal "http://www.tremormedia.com", creative.click_through_url.to_s
    assert_equal "http://myTrackingURL/click1", creative.click_tracking_urls.first.to_s
    assert_equal "http://myTrackingURL/click2", creative.click_tracking_urls.last.to_s
    assert_equal "http://myTrackingURL/custom1", creative.custom_click_urls[:custom_one].to_s
    assert_equal "http://myTrackingURL/custom2", creative.custom_click_urls[:custom_two].to_s
  end
  
  
  
end