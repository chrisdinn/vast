module VAST
  class InlineAd < Ad
    
    # URI of request to survey vendor
    def survey_url
      URI.parse source_node.at('Survey').content
    end
    
    # Common name of ad
    def ad_title
      source_node.at('AdTitle').content
    end
    
  end
end

