require 'pdfkit'

module FacturaePrint
  module Renderers
    class PDFRenderer
    
      def initialize(template, invoice, args={})
        @template = template
        @invoice = invoice
        @stylesheet = args.delete(:stylesheet)
        @pdfkit_options = args
      end
      
      def render
        html = FacturaePrint::Renderers::HTMLRenderer.new(@template, @invoice).render
        
        append_stylesheet_tag(html, (@stylesheet.is_a?(IO) ? @stylesheet.read : @stylesheet)) if @stylesheet
        PDFKit.new(html, @pdfkit_options).to_pdf
      end
      
      private
      
      def append_stylesheet_tag(html_string, stylesheet)
        if html_string.match(/<\/head>/)
          html_string.gsub!(/(<\/head>)/, "<style>#{stylesheet}</style>"+'\1')
        else
          html_string.insert(0, "<style>#{stylesheet}</style>")
        end
      end
    
    end
  end
end