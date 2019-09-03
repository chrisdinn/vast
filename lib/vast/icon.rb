require_relative 'resource.rb'

module VAST
  # Any number of Mediafile objects can be provided for a single Ad, but it is assumed that all Mediafiles belongs
  # to a single Ad object represent the same creative unit with the same  duration, Ad-ID (ISCI code), etc.
  class Icon < Element
    include VAST::Resource

    def initialize(node)
      super(node)
      after_initialize(node)
    end
    
    def program
      source_node[:program]
    end
    
    def width
      source_node[:width].to_i
    end

    def height
      source_node[:height].to_i
    end
    
    def xPosition
      source_node[:xPosition].to_i
    end

    def yPosition
      source_node[:yPosition].to_i
    end
    
    def duration
      source_node[:duration].to_i
    end

    def offset
      source_node[:offset].to_i
    end
    
    # Defines the method to use for communication with the companion
    def api_framework
      source_node[:apiFramework]
    end

    def click_through_url
      URI.parse source_node.at('IconClickThrough').content.strip
    end

    def click_tracking_url
      URI.parse source_node.at('IconClickTracking').content.strip
    end

    def view_tracking_url
      URI.parse source_node.at('IconViewTracking').content.strip
    end
    
    # end of class
  end
end
