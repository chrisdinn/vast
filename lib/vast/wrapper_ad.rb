module VAST
  # Points to another VAST document on a different server.
  #
  # WrapperAds may include any number of tracking urls to allow CompanionCreatives to be served 
  # from an InlineAd response but tracked separately from the Impression. It may also include 
  # tracking elements for separately tracking LinearCreative or NonLinearCreative views or events. 
  #
  # The server providing the WrapperAd may not know exactly which creative elements are to be 
  # delivered downline in inline ads; in that case the WrapperAd should include placeholders for 
  # the maximum set of Creatives that could be played within the Video Player.
  class WrapperAd < Ad
    
    # URI of ad tag of downstream Secondary Ad Server
    def ad_tag_url
      URI.parse source_node.at('VASTAdTagURI').content.strip
    end
    
  end
end