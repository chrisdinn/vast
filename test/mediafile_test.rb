require 'test_helper'

class MediafileTest < Test::Unit::TestCase  
  def test_should_know_attributes
    document_file = example_file('document_with_one_inline_ad.xml')
    document = VAST::Document.parse!(document_file)
    mediafile = VAST::Mediafile.new(document.at('MediaFile'))
    
    assert_equal "http://cdnp.tremormedia.com/video/acudeo/Carrot_400x300_500kb.flv", mediafile.url.to_s
    assert_equal "firstFile", mediafile.id
    assert_equal "progressive", mediafile.delivery
    assert_equal "video/x-flv", mediafile.type
    assert_equal 400, mediafile.width
    assert_equal 300, mediafile.height
    assert_equal 500, mediafile.bitrate
    assert_equal "VPAID", mediafile.api_framework
    assert mediafile.scalable?
    assert mediafile.maintain_aspect_ratio?
  end
end