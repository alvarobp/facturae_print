require "spec_helper"

describe FacturaePrint::Invoice do
  
  before(:each) do
    @invoice = FacturaePrint::Invoice.new(fixture('facturae.xml'))
  end
  
  it "should instantiate as an OpenStruct mapping fe:Facturae node children" do
    @invoice.file_header.schema_version = "3.1"
    @invoice.file_header.batch.batch_identifier = "12345678A"
    @invoice.parties.seller_party.individual.name.should == "John"
    @invoice.parties.seller_party.individual.first_surname.should == "Developer"
  end
  
  it "should build the proper collections" do
    # Collections: Invoices, TaxesOutputs, Items
    @invoice.invoices.should be_a(Array)
    @invoice.invoices.size.should == 1
    @invoice.invoices.first.taxes_outputs.should be_a(Array)
    @invoice.invoices.first.taxes_outputs.first.tax_rate.should == "-15.00"
    @invoice.invoices.first.items.should be_a(Array)
    @invoice.invoices.first.items.size.should == 2
    @invoice.invoices.first.items[0].item_description = "Working too hard"
    @invoice.invoices.first.items[1].item_description = "Working not as hard as before"
  end
  
end