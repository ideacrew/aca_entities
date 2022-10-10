# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module Fdsh
        module Pvc
          module Medicare
            # Happymapper implementation for the root object of an Request.
            class InsurancePolicy
              include HappyMapper

              tag 'InsurancePolicy'

              has_one :InsurancePolicyEffectiveDate, Date, tag: "InsurancePolicyEffectiveDate"
              has_one :InsurancePolicyExpirationDate, Date, tag: "InsurancePolicyExpirationDate"

              def self.domain_to_mapper(policy)
                mapper = self.new
                mapper.InsurancePolicyEffectiveDate = policy.InsurancePolicyEffectiveDate&.strftime
                mapper.InsurancePolicyExpirationDate = policy.InsurancePolicyExpirationDate&.strftime

                mapper
              end
            end
          end
        end
      end
    end
  end
end