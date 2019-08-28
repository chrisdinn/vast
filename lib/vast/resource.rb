# frozen_string_literal: true

module VAST
  # This class is a mixin used by other classes that contain a non-linear
  # resource.
  module Resource
    def after_initialize(node)
      @source_node = node
    end

    # Type of non-linear resource, returned as a symbol. Either :static,
    # :iframe, or :html.
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
      @source_node.at('StaticResource')[:creativeType] \
        if resource_type == :static
    end

    # Returns URI for static or iframe resource
    def resource_url
      case resource_type
      when :static
        URI.parse @source_node.at('StaticResource').content.strip
      when :iframe
        URI.parse @source_node.at('IFrameResource').content.strip
      end
    end

    # Returns HTML text for html resource
    def resource_html
      @source_node.at('HTMLResource').content if resource_type == :html
    end
  end
end
