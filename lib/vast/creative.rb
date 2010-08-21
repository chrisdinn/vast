module VAST
  class Creative
    attr_reader :source_node
    
    def initialize(node)
      @source_node = node
    end
    
    # Create proper ad type
    def self.create(node)
      if node.at('Linear')
        LinearCreative.new(node)
      elsif node.at('NonLinearAds')
        NonLinearCreative.new(node)
      elsif node.at('CompanionAds')
        CompanionCreative.new(node)
      else
        raise InvalidCreativeError
      end
    end
  end
  
  class LinearCreative < Creative; end
  class NonLinearCreative < Creative; end
  class CompanionCreative < Creative; end
end