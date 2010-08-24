module VAST
  class Extension < Element

    # Extension type
    def type
      source_node[:type]
    end
    
    # Access to the XML contents of this extension, as a Nokogiri::XML::Node
    # http://nokogiri.rubyforge.org/nokogiri/Nokogiri/XML/Node.html. Alias of
    # Extension#source_node
    def xml
      source_node
    end
  end
end