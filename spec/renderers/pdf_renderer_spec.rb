require File.dirname(__FILE__) + "/../spec_helper"

describe FacturaePrint::Renderers::PDFRenderer do
  
  before(:each) do
    @invoice = OpenStruct.new("name" => "My first invoice ever")
  end
  
  it "should render the given template using HTMLRenderer and use it to render with PDFKit" do
    templ = "Example with <%= @invoice.name %>"
    
    pdf_renderer = FacturaePrint::Renderers::PDFRenderer.new(templ, @invoice)
    kit_mock = mock()
    kit_mock.stub(:to_pdf).and_return("PDF RESULT")
    
    PDFKit.should_receive(:new).with("Example with My first invoice ever", anything()).and_return(kit_mock)
    pdf_renderer.render.should == "PDF RESULT"
  end
  
  it "should append stylesheet string passed in the stylesheet option" do
    templ = "Example with <%= @invoice.name %>"
    css = "* { border:1px solid red; }"
    
    pdf_renderer = FacturaePrint::Renderers::PDFRenderer.new(templ, @invoice, :stylesheet => css)
    kit_mock = mock()
    kit_mock.stub(:to_pdf).and_return("PDF RESULT")
    
    PDFKit.should_receive(:new).with("<style>#{css}</style>Example with My first invoice ever", anything()).and_return(kit_mock)
    pdf_renderer.render.should == "PDF RESULT"
  end
  
  it "should append stylesheet string passed in the stylesheet option to the head section if there is one" do
    templ = "<html><head><title>Invoice</title></head><body>Example with <%= @invoice.name %></body></html>"
    css = "* { border:1px solid red; }"
    
    pdf_renderer = FacturaePrint::Renderers::PDFRenderer.new(templ, @invoice, :stylesheet => css)
    kit_mock = mock()
    kit_mock.stub(:to_pdf).and_return("PDF RESULT")
    
    PDFKit.should_receive(:new).with("<html><head><title>Invoice</title><style>#{css}</style></head><body>Example with My first invoice ever</body></html>", anything()).and_return(kit_mock)
    pdf_renderer.render.should == "PDF RESULT"
  end
  
  it "should pass given options to PDFKit" do
    templ = "Example with <%= @invoice.name %>"
    
    pdf_renderer = FacturaePrint::Renderers::PDFRenderer.new(templ, @invoice, :page_size => "A4")
    kit_mock = mock()
    kit_mock.stub(:to_pdf).and_return("PDF RESULT")
    
    PDFKit.should_receive(:new).with("Example with My first invoice ever", {:page_size => "A4"}).and_return(kit_mock)
    pdf_renderer.render.should == "PDF RESULT"
  end
  
end