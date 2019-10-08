require 'test_helper'

class ExtensionTest < Test::Unit::TestCase
  
  def test_should_know_attributes_type
    document_file = example_file('document_with_one_inline_ad.xml')
    document = VAST::Document.parse!(document_file)
    extension = VAST::Extension.new(document.at('Extension'))
    
    assert_equal "DART", extension.type
  end
  
  def test_should_know_attributes_xml
    document_file = example_file('document_with_one_inline_ad.xml')
    document = VAST::Document.parse!(document_file)
    extension = VAST::Extension.new(document.at('Extension'))
    
    assert_equal extension.source_node, extension.xml
  end
end
