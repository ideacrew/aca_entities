# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module Medicaid
        module Atp
          # A data type for a tax return as filed with the Internal Revenue Service.
          class TaxReturn
            include HappyMapper

            tag 'TaxReturn'
            namespace 'hix-ee'

            # A number of exemptions claimed on a tax return
            element :total_exemptions_quantity, Integer, tag: 'TaxReturnTotalExemptionsQuantity', namespace: "hix-ee"

            # A kind of filing status
            element :status_code, String, tag: "TaxReturnFilingStatusCode", namespace: "hix-ee"

            # A year for which taxes are being filed.
            element :tax_return_year, Integer, tag: 'TaxReturnYear', namespace: "hix-ee"

            has_one :tax_household, TaxHousehold

            # True if the tax return includes dependents; false otherwise.
            element :tax_return_includes_dependent_indicator, Boolean, tag: 'TaxReturnIncludesDependentIndicator', namespace: "hix-ee"

            def self.domain_to_mapper(tax_r)
              mapper = self.new
              mapper.total_exemptions_quantity = tax_r.total_exemptions_quantity
              mapper.status_code = tax_r.status_code
              mapper.tax_return_year = tax_r.tax_return_year
              mapper.tax_household = TaxHousehold.domain_to_mapper(tax_r.tax_household)
              mapper.tax_return_includes_dependent_indicator = tax_r.tax_return_includes_dependent_indicator
              mapper
            end

            def to_hash
              {
                total_exemptions_quantity: total_exemptions_quantity,
                status_code: status_code,
                tax_return_year: tax_return_year,
                tax_return_includes_dependent_indicator: tax_return_includes_dependent_indicator,
                tax_household: tax_household&.to_hash
              }
            end
          end
        end
      end
    end
  end
end