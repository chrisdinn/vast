module VAST
  class Element
    attr_reader :source_node

    def initialize(node)
      @source_node = node
    end
  end
end
