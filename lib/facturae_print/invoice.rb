require 'ostruct'
require 'nokogiri'

module FacturaePrint
  
  class Invoice < OpenStruct
    
    def initialize(xml_file)
      super(nil)
      xml = Nokogiri::XML(xml_file)
      
      FacturaePrint::XMLObjectifier.build(xml.root, 
        :object => self,
        :collection_nodes => ["Invoices", "TaxesOutputs", "Items"])
    end
    
  end
  
end