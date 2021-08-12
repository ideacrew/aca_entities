# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module Fdsh
        module Esi
          module H14
            # Happymapper implementation for the root object of an Applicant MEC Information.
            class MonthlyPremiumAmount
              include HappyMapper
              register_namespace 'ext', 'http://vesim.dsh.cms.gov/extension/1.0'

              tag 'MonthlyPremiumAmount'
              namespace 'ext'

              has_one :EmployeePremiumAmount, EmployeePremiumAmount
              has_one :FamilyPremiumAmount, FamilyPremiumAmount

              def self.domain_to_mapper(monthly_premium)
                mapper = self.new
                if monthly_premium.EmployeePremiumAmount
                  mapper.EmployeePremiumAmount = EmployeePremiumAmount.domain_to_mapper(monthly_premium.EmployeePremiumAmount)
                end
                if monthly_premium.FamilyPremiumAmount
                  mapper.FamilyPremiumAmount = FamilyPremiumAmount.domain_to_mapper(monthly_premium.FamilyPremiumAmount)
                end

                mapper
              end
            end
          end
        end
      end
    end
  end
end
