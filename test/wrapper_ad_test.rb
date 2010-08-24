require 'test_helper'

class WrapperAdTest < Test::Unit::TestCase
  
  def test_should_know_ad_tag_url
    document_with_wrapper_ad = example_file('document_with_one_wrapper_ad.xml')
    document = VAST::Document.parse!(document_with_wrapper_ad)

    ad_node = document.root.xpath('.//Ad').first
    ad = VAST::WrapperAd.new(ad_node)

    assert ad.ad_tag_url.kind_of?(URI)
    assert_equal "http://demo.tremormedia.com/proddev/vast/vast_inline_linear.xml", ad.ad_tag_url.to_s
  end
  
end