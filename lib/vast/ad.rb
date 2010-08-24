module VAST
  # Contains some combination of video, companions, and non-linear units for a single advertiser.
  #
  # A single VAST response may include multiple Ads from multiple advertisers. It will be up to 
  # the Video Player to determine the order, timing, placement, etc for the multiple ads. However, 
  # the player should generally respect the sequential order of the Ad elements within a VAST response.
  #
  # The VAST response does not contain information on the placement or timing of each ad. It is up 
  # to the Video Player to determine the optimal inclusion points of the ads.
  #
  # Can either be a InlineAd, meaning it contains all the elements necessary to display the 
  # visual experience, or a WrapperAd, which points to a downstream VAST document that must be 
  # requested from another server.
  # 
  # An Ad may include one or more pieces of creative that are part of a single execution. For example, an Ad 
  # may include a linear video element with a set of companion banners; this would be reflected by two Creative
  # elements, one LinearCreative and one CompanionCreative.
  class Ad < Element
    
    # Creates proper ad type
    def self.create(node)
      if node.at('InLine')
        InlineAd.new(node)
      elsif node.at('Wrapper')
        WrapperAd.new(node)
      else
        raise InvalidAdError
      end
    end
    
    # Ad id, if indicated
    def id
      source_node[:id]
    end
    
    # Returns name of source ad server
    def ad_system
      ad_system_node = source_node.at("AdSystem")
      if ad_system_node
        ad_system_node.content
      else
        raise InvalidAdError, "missing AdSystem node in Ad"   
      end
    end
    
    # Returns URI to request if ad does not play due to error.
    def error_url
      error_url_node = source_node.at("Error")
      URI.parse(error_url_node.content) if error_url_node
    end
    
    # Returns an array containing all linear creatives.
    def linear_creatives
      source_node.xpath('.//Creative/Linear').to_a.collect do |node|
        LinearCreative.new(node)
      end
    end
    
    # This is a convenience method for when only the first piece of linear creative is needed. 
    # It's common for an ad to contain only one piece of linear creative.
    def linear_creative
      linear_creatives.first
    end
    
    # Returns an array containing all non linear creatives.
    def non_linear_creatives
      source_node.xpath('.//Creative/NonLinearAds/NonLinear').to_a.collect do |node|
        NonLinearCreative.new(node)
      end
    end
    
    # Returns an array containing all companion creatives.
    def companion_creatives
      source_node.xpath('.//Creative/CompanionAds/Companion').to_a.collect do |node|
        CompanionCreative.new(node)
      end
    end
    
    # Each Ad must contain at least one impression.
    def impression
      URI.parse(source_node.at('Impression').content)
    end
    
    # Array of all impressions available for this ad, excluding those specific
    # to a particular creative.
    def impressions
      source_node.xpath('.//Impression').to_a.collect do |node|
        URI.parse(node)
      end
    end
    
    # All extensions included with this ad.
    def extensions
      source_node.xpath('.//Extension').to_a.collect do |node|
        Extension.new(node)
      end
    end
  end
end