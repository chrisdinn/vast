module VAST
  class CompanionCreative < Creative
    
    def id
      @source_node[:id]
    end
    
    # Width in pixels of companion
    def width
      @source_node[:width].to_i
    end
    
    # Height in pixels of companion
    def height
      @source_node[:height].to_i
    end
    
    # Width in pixels of expanding companion ad when in expanded state  
    def expanded_width
      @source_node[:expandedWidth].to_i
    end
    
    # Height in pixels of expanding companion ad when in expanded state  
    def expanded_height
      @source_node[:expandedHeight].to_i
    end
    
    # URI to open as destination page when user clicks on the video
    def click_through_url
      URI.parse @source_node.at('CompanionClickThrough').content
    end
    
    # Alternate text to be displayed when companion is rendered in HTML environment.
    def alt_text
      node = @source_node.at('AltText')
      node.nil? ? nil : node.content
    end
    
    # Type of companion resource, returned as a symbol. Either :static, :iframe, or :html.
    def resource_type
      if @source_node.at('StaticResource')
        :static
      elsif @source_node.at('IFrameResource')
        :iframe
      elsif @source_node.at('HTMLResource')
        :html
      end
    end
    
    # Returns MIME type of static creative
    def creative_type
      if resource_type == :static
        @source_node.at('StaticResource')[:creativeType]
      end
    end
    
    # Returns URI for static or iframe resource
    def resource_url
      case resource_type
      when :static
        URI.parse @source_node.at('StaticResource').content
      when :iframe
        URI.parse @source_node.at('IFrameResource').content
      end
    end
    
    # Returns HTML text for html resource
    def resource_html
      if resource_type == :html
        @source_node.at('HTMLResource').content
      end
    end
  end
end
