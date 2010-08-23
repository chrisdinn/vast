module VAST
  class Creative
    attr_reader :source_node
    
    def initialize(node)
      @source_node = node
    end
    
    def ad
      Ad.create @source_node.ancestors('Ad').first
    end
    
    def id
      creative_node[:id]
    end
    
    def ad_id
      creative_node[:AdID]
    end
    
    # The preferred order in which multiple Creatives should be displayed
    def sequence
      creative_node[:sequence]
    end
    
    # Data to be passed into the video ad.
    def ad_parameters
      @source_node.at('AdParameters').content
    end
    
    def tracking_urls
      tracking_urls = {}
      @source_node.xpath('.//Tracking').to_a.collect do |node|
        underscored_name = underscore(node[:event])
        tracking_urls[underscored_name.to_sym] = URI.parse(node.content)
      end
      tracking_urls
    end
    
    protected
    
    def underscore(camel_cased_word)
       camel_cased_word.to_s.gsub(/::/, '/').
          gsub(/([A-Z]+)([A-Z][a-z])/,'\1_\2').
          gsub(/([a-z\d])([A-Z])/,'\1_\2').
          tr("-", "_").
          downcase
    end
    
    private
    
    def creative_node
      @source_node.ancestors('Creative').first
    end
  end
  
  class NonLinearCreative < Creative; end
end