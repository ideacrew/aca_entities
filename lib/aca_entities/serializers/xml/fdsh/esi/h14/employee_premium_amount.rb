# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module Fdsh
        module Esi
          module H14
            # Happymapper implementation for the root object of an Applicant MEC Information.
            class EmployeePremiumAmount
              include HappyMapper
              register_namespace 'ext', 'http://vesim.dsh.cms.gov/extension/1.0'
              register_namespace 'hix-ee', 'http://hix.cms.gov/0.1/hix-ee'

              tag 'EmployeePremiumAmount'
              namespace 'ext'

              element :InsurancePremiumAmount, Float, tag: 'InsurancePremiumAmount', namespace: 'hix-ee'

              def self.domain_to_mapper(employee_premium)
                mapper = self.new
                mapper.InsurancePremiumAmount = employee_premium.InsurancePremiumAmount

                mapper
              end
            end
          end
        end
      end
    end
  end
end
