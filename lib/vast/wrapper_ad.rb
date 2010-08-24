module VAST
  class WrapperAd < Ad
    
    # URI of ad tag of downstream Secondary Ad Server
    def ad_tag_url
      URI.parse source_node.at('VASTAdTagURI').content
    end
    
  end
end