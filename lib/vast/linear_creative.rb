module VAST
  # LinearCreative is presented before, in the middle of, or after the video content is consumed by the user, 
  # in very much the same way a TV commercial can play before, during or after the chosen program.
  class LinearCreative < Creative
    
    # Duration of creative
    def duration
      source_node.at('Duration').content
    end
    
    # VAST 3
    def skipoffset
      source_node[:skipoffset]
    end
    
    # URI to open as destination page when user clicks on the video
    def click_through_url
      URI.parse source_node.at('ClickThrough').content.strip
    end
    
    # An array of URIs to request for tracking purposes when user clicks on the video
    def click_tracking_urls
      source_node.xpath('.//ClickTracking').to_a.collect do |node|
        URI.parse node.content.strip
      end
    end
    
    # A hash of URIs to request on custom events such as hotspotted video. This library
    # required custom click urls to identify themselves with an `id` attribute, which is
    # used as the key for this hash
    def custom_click_urls
      custom_click_urls = {}
      source_node.xpath('.//CustomClick').to_a.collect do |node|
        key = underscore(node[:id]).to_sym
        custom_click_urls[key] = URI.parse(node.content.strip)
      end
      custom_click_urls
    end
    
    # Returns mediafiles containing the information required to display the linear creative's media
    # 
    # It is assumed that all mediafiles accessible represent the same creative unit with the same 
    # duration, Ad-ID (ISCI code), etc.
    def mediafiles
      source_node.xpath('.//MediaFile').to_a.collect do |node|
        Mediafile.new(node)
      end
    end

    def icons
      source_node.xpath('.//Icon').to_a.collect do |node|
        Icon.new(node)
      end
    end
    
  end
end