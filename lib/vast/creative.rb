module VAST
  class Creative < Element
    
    def ad
      Ad.create source_node.ancestors('Ad').first
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
      source_node.at('AdParameters').content
    end
    
    # Returns a hash, keyed by event name, containing an array of URIs to be called for each event.
    def tracking_urls
      tracking_urls = {}
      source_node.xpath('.//Tracking').to_a.collect do |node|
        underscored_name = underscore(node[:event])
        if tracking_urls[underscored_name.to_sym]
           tracking_urls[underscored_name.to_sym] << URI.parse(node.content)
        else
           tracking_urls[underscored_name.to_sym] = [URI.parse(node.content)]
        end
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
      source_node.ancestors('Creative').first
    end
  end
end