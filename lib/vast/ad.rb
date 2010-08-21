module VAST
  class Ad
    attr_reader :source_node
    
    def initialize(node)
      @source_node = node
    end
    
    # Create proper ad type
    def self.create(node)
      if node.at('.//InLine')
        InlineAd.new(node)
      elsif node.at('.//Wrapper')
        WrapperAd.new(node)
      else
        raise InvalidAdError
      end
    end
    
    def creatives
      @source_node.xpath('.//Creative').to_a.collect do |node|
        Creative.create(node)
      end
    end
    
    def linear_creatives
      creatives.select{ |creative| creative.kind_of?(LinearCreative)  }
    end
    
    def non_linear_creatives
      creatives.select{ |creative| creative.kind_of?(NonLinearCreative)  }
    end
    
    def companion_creatives
      creatives.select{ |creative| creative.kind_of?(CompanionCreative)  }
    end
  end
  
  class InlineAd < Ad; end
  class WrapperAd < Ad; end
end