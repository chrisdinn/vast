module VAST
  class LinearCreative < Creative
    
    # Duration of creative
    def duration
      source_node.at('Duration').content
    end
    
    # URI to open as destination page when user clicks on the video
    def click_through_url
      URI.parse source_node.at('ClickThrough').content
    end
    
    # An array of URIs to request for tracking purposes when user clicks on the video
    def click_tracking_urls
      source_node.xpath('.//ClickTracking').to_a.collect do |node|
        URI.parse node.content
      end
    end
    
    # A hash of URIs to request on custom events such as hotspotted video. This library
    # required custom click urls to identify themselves with an `id` attribute, which is
    # used as the key for this hash
    def custom_click_urls
      custom_click_urls = {}
      source_node.xpath('.//CustomClick').to_a.collect do |node|
        key = underscore(node[:id]).to_sym
        custom_click_urls[key] = URI.parse(node.content)
      end
      custom_click_urls
    end
    
    def mediafiles
      source_node.xpath('.//MediaFile').to_a.collect do |node|
        Mediafile.new(node)
      end
    end
  end
end