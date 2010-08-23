module VAST
  class Mediafile
    attr_reader :source_node
    
    def initialize(node)
      @source_node = node
    end
    
    # Location of linear file
    def url
      URI.parse @source_node.content
    end
    
    def id
      @source_node[:id]
    end
    
    # Method of delivery of ad, either "streaming" or "progressive"
    def delivery
      @source_node[:delivery]
    end
    
    # MIME type. Popular MIME types include, but are not limited to “video/x-ms-wmv” for 
    # Windows Media, and “video/x-flv” for Flash Video.
    def type
      @source_node[:type]
    end
    
    # Bitrate of encoded video in Kbps
    def bitrate
      @source_node[:bitrate].to_i
    end
    
    # Pixel dimensions of video width
    def width
      @source_node[:width].to_i
    end
    
    # Pixel dimensions of video height
    def height
      @source_node[:height].to_i
    end
    
    # Whether it is acceptable to scale the image.
    def scalable?
      @source_node[:scalable]=="true"
    end
    
    # Whether the ad must have its aspect ratio maintained when scaled
    def maintain_aspect_ratio?
      @source_node[:maintainAspectRatio]=="true"
    end
  end
end