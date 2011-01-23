require File.dirname(__FILE__) + "/../spec_helper"

describe FacturaePrint::Renderers::HTMLRenderer do
  
  it "should render the given template with the given invoice object as @invoice instance variable" do
    templ = "Example with <%= @invoice.name %>"
    fake_invoice = OpenStruct.new("name" => "My first invoice ever")
    html_renderer = FacturaePrint::Renderers::HTMLRenderer.new(templ, fake_invoice)
    html_renderer.render.should == "Example with My first invoice ever"
  end
  
  it "should make FacturaePrint::Renderers::HTMLRendererHelpers methods available" do
    templ = "Example with <%= @invoice.name %> for a value of 6000 <%= currency_code('USD') %>"
    fake_invoice = OpenStruct.new("name" => "My first invoice ever")
    html_renderer = FacturaePrint::Renderers::HTMLRenderer.new(templ, fake_invoice)
    "Example with My first invoice ever for a value of 6000 $"
  end
  
end