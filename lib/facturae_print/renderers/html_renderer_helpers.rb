require 'date'

module FacturaePrint
  module Renderers
    module HTMLRendererHelpers
      
      def to_currency(amount)
        @invoice_currency_symbol ||= currency_symbol(@invoice.invoices.first.invoice_issue_data.invoice_currency_code)
        "#{amount} #{@invoice_currency_symbol}"
      end
      
      def currency_symbol(currency_code)
        case currency_code
        when "EUR": "€"
        when "USD": "$"
        else
          currency_code
        end
      end
      
      def individual_full_name(individual)
        [individual.name, individual.first_surname, individual.second_surname].compact.join(' ')
      end
      
      def formatted_date(date, strftime="%d/%m/%Y")
        (date.is_a?(String) ? Date.parse(date) : date).strftime(strftime)
      end
    end
  end
end