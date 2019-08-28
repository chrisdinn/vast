require_relative 'resource.rb'

module VAST
  # Commonly text, display ads, rich media, or skins that wrap around the video experience. These ads come 
  # in a number of sizes and shapes and typically run alongside or surrounding the video player.
  class CompanionCreative < Creative
    include Resource

    def initialize(node)
      super(node)
      after_initialize(node)
    end
    
    def id
      source_node[:id]
    end
    
    # Width in pixels of companion
    def width
      source_node[:width].to_i
    end
    
    # Height in pixels of companion
    def height
      source_node[:height].to_i
    end
    
    # Width in pixels of expanding companion ad when in expanded state  
    def expanded_width
      source_node[:expandedWidth].to_i
    end
    
    # Height in pixels of expanding companion ad when in expanded state  
    def expanded_height
      source_node[:expandedHeight].to_i
    end
    
    # Defines the method to use for communication with the companion
    def api_framework
      source_node[:apiFramework]
    end
    
    # URI to open as destination page when user clicks on the video
    def click_through_url
      URI.parse source_node.at('CompanionClickThrough').content.strip
    end
    
    # Alternate text to be displayed when companion is rendered in HTML environment.
    def alt_text
      node = source_node.at('AltText')
      node.nil? ? nil : node.content
    end
  end
end
