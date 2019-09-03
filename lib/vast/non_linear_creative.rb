require_relative 'resource.rb'

module VAST
  # NonLinearCreative runs concurrently with the video content so the users see the ad while viewing 
  # the content. Non-linear video ads can be delivered as text, graphical ads, or as video overlays.
  class NonLinearCreative < Creative
    include VAST::Resource

    def initialize(node)
      super(node)
      after_initialize(node)
    end

    def id
      source_node[:id]
    end
    
    # Width in pixels
    def width
      source_node[:width].to_i
    end
    
    # Height in pixels
    def height
      source_node[:height].to_i
    end
    
    # Width in pixels when in expanded state  
    def expanded_width
      source_node[:expandedWidth].to_i
    end
    
    # Height in pixels when in expanded state  
    def expanded_height
      source_node[:expandedHeight].to_i
    end
    
    # Defines the method to use for communication with the companion
    def api_framework
      source_node[:apiFramework]
    end
    
    # URI to open as destination page when user clicks on creative
    def click_through_url
      URI.parse source_node.at('NonLinearClickThrough').content.strip
    end

    def click_tracking_url
      URI.parse source_node.at('NonLinearClickTracking').content.strip
    end
    
    # Whether it is acceptable to scale the mediafile.
    def scalable?
      source_node[:scalable]=="true"
    end
    
    # Whether the mediafile must have its aspect ratio maintained when scaled
    def maintain_aspect_ratio?
      source_node[:maintainAspectRatio]=="true"
    end
    
    # Suggested duration to display non-linear ad, typically for animation to complete. 
    # Expressed in standard time format hh:mm:ss  
    def min_suggested_duration
      source_node[:minSuggestedDuration]
    end
  end
end
