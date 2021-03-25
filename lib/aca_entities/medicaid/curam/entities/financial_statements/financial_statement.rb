# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Curam
      module FinancialStatements
        # entity for curam FinancialStatement
        class FinancialStatement < Dry::Struct

          attribute :tax_filing_status,      Types::TaxFilingStatusKind.meta(omittable: false)
          attribute :is_tax_filing_together, Types::Bool.meta(omittable: false)
          attribute :incomes,                Types::Array.of(FinancialStatements::Income).meta(omittable: false)
        end
      end
    end
  end
end
