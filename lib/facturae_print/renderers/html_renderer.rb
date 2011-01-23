require 'erubis'

module FacturaePrint
  module Renderers
    class HTMLRenderer
    
      def initialize(template, invoice)
        @template = template
        @invoice = invoice
      end
    
      def render
        eruby = Erubis::Eruby.new(@template)
        __context = Erubis::Context.new
        class << __context
          include FacturaePrint::Renderers::HTMLRendererHelpers
        end
        __context[:invoice] = @invoice
        eruby.evaluate(__context)
      end
    
    end
  end
end