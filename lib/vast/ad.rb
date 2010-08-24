module VAST
  class Ad < Element
    
    # Create proper ad type
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
    
    # Name of source ad server
    def ad_system
      ad_system_node = source_node.at("AdSystem")
      if ad_system_node
        ad_system_node.content
      else
        raise InvalidAdError, "missing AdSystem node in Ad"   
      end
    end
    
    # URI to request if ad does not play due to error
    def error_url
      error_url_node = source_node.at("Error")
      URI.parse(error_url_node.content) if error_url_node
    end
    
    # Returns an array containing all linear creatives
    def linear_creatives
      source_node.xpath('.//Creative/Linear').to_a.collect do |node|
        LinearCreative.new(node)
      end
    end
    
    # Returns an array containing all non linear creatives
    def non_linear_creatives
      source_node.xpath('.//Creative/NonLinearAds/NonLinear').to_a.collect do |node|
        NonLinearCreative.new(node)
      end
    end
    
    # Returns an array containing all companion creatives
    def companion_creatives
      source_node.xpath('.//Creative/CompanionAds/Companion').to_a.collect do |node|
        CompanionCreative.new(node)
      end
    end
    
    # Each Ad should contain at least one impression.
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
    
  end
  
  class WrapperAd < Ad; end
end