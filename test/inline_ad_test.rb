require 'test_helper'

class InlineAdTest < Test::Unit::TestCase

  def test_ad_should_know_attributes
    document_file = example_file('document_with_one_inline_ad.xml')
    document = VAST::Document.parse!(document_file)
    inline_ad = document.inline_ads.first
    
    assert_equal "http://mySurveyURL/survey", inline_ad.survey_url.to_s
    assert_equal "VAST 2.0 Instream Test 1", inline_ad.ad_title
  end

end