require 'thor'

module FacturaePrint
  class CLI < Thor
    
    desc "html facturae_xml eruby_template", "Generates an html version for a facturae xml"
    method_option :output, :type => :string, :aliases => "-o", :banner => "Output to a file instead of into stdio"
    def html(facturae_xml, eruby_template)
      invoice = FacturaePrint::Invoice.new(File.read(facturae_xml))
      template = File.read(eruby_template)
      
      html_renderer = FacturaePrint::Renderers::HTMLRenderer.new(template, invoice)
      rendered_html = html_renderer.render
      
      if options[:output]
        File.open(options[:output], 'w') { |f| f.write(rendered_html) }
      else
        shell.say(rendered_html)
      end
    end
    
    desc "pdf facturae_xml eruby_template", "Generates a pdf version for a facturae xml"
    method_option :stylesheet, :type => :string, :aliases => "-s", :banner => "Use the given CSS stylesheet on rendering"
    method_option :output, :type => :string, :aliases => "-o", :banner => "Output to a file instead of into stdio"
    def pdf(facturae_xml, eruby_template)
      invoice = FacturaePrint::Invoice.new(File.read(facturae_xml))
      template = File.read(eruby_template)
      renderer_options = {}
      renderer_options[:stylesheet] = File.read(options[:stylesheet]) if options[:stylesheet]

      pdf_renderer = FacturaePrint::Renderers::PDFRenderer.new(template, invoice, renderer_options)
      rendered_pdf = pdf_renderer.render
      
      if options[:output]
        File.open(options[:output], 'w') { |f| f.write(rendered_pdf) }
      else
        shell.say(rendered_pdf)
      end
    end
    
  end
end