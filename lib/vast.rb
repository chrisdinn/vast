require 'vast/document'
require 'vast/ad'
require 'vast/inline_ad'
require 'vast/creative'
require 'vast/linear_creative'
require 'vast/mediafile'
require 'vast/companion_creative'
require 'vast/non_linear_creative'

# This module wraps VAST documents, as outlined by the IAB at http://www.iab.net/media/file/VAST-2_0-FINAL.pdf
module VAST
  VAST_VERSION = 2.0
  VAST_SCHEMA_XSD_FILE = File.expand_path(File.join(File.dirname(__FILE__), 'vast_2.0.1.xsd'))
  
  class VASTError < StandardError; end
  
  # Raised when parsing a VAST document that does not conform to the VAST spec XSD
  class InvalidDocumentError < VASTError; end
  
  # Raised when parsing a VAST ad node that is not complete
  class InvalidAdError < VASTError; end
  
  # Raised when parsing a VAST creative node that is not complete
  class InvalidCreativeError < VASTError; end
  
end