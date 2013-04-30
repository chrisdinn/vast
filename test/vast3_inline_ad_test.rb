require 'test_helper'

class InlineAdTest < Test::Unit::TestCase

  def test_ad_should_know_attributes
    document_file = example_file('vast3_inline.xml')
    document = VAST::Document.parse!(document_file)
    
    inline_ad = document.inline_ads.first
    
    assert_equal 3, document.inline_ads.length
    assert_equal '3.0', document.xpath('/VAST/@version').first.value
    assert_equal "FreeWheel", inline_ad.ad_system.to_s
    assert_equal "Ooyla test m3u8 midroll 1", inline_ad.ad_title

    creative = inline_ad.linear_creatives.first
    assert_equal '2447226', creative.ad_id
    assert_equal "00:00:15", creative.duration
    assert_equal "http://g1.v.fwmrm.net/ad/l/1?s=a032&n=164515&t=1366755844262714011&adid=2447226&reid=1698599&arid=0&auid=&cn=defaultClick&et=c&_cc=&tpos=15&cr=", creative.click_tracking_urls.first.to_s

  end

end