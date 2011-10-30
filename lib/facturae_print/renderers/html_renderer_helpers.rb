# -*- encoding : utf-8 -*-
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
        when "EUR"
          "€"
        when "USD"
          "$"
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
      
      def tax_abbreviation(tax_type_code)
        TAX_ABBREVIATIONS[tax_type_code]
      end
      
      def tax_description(tax_type_code, tax_rate)
        "#{tax_abbreviation(tax_type_code)} #{tax_rate.to_i}%"
      end
      
      TAX_ABBREVIATIONS = {
        '01' => 'IVA',
        '02' => 'IPSI',
        '03' => 'IGIC',
        '04' => 'IRPF',
        '05' => 'Otro',
        '06' => 'ITPAJD',
        '07' => 'IE',
        '08' => 'Ra',
        '09' => 'IGTECM',
        '10' => 'IECDPCAC',
        '11' => 'IIIMAB',
        '12' => 'ICIO',
        '13' => 'IMVDN',
        '14' => 'IMSN',
        '15' => 'IMGSN',
        '16' => 'IMPN',
        '17' => 'REIVA',
        '18' => 'REIGIC',
        '19' => 'REIPSI'
      }
    end
  end
end