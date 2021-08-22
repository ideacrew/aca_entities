# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module Fdsh
        module NonEsi
          module H31
            # Happymapper implementation for the root object of an Request.
            class InsurancePolicy
              include HappyMapper
              register_namespace 'vnem', 'http://vnem.ee.sim.dsh.cms.hhs.gov'

              tag 'InsurancePolicy'
              namespace 'vnem'

              has_one :InsurancePolicyEffectiveDate, Date, tag: "InsurancePolicyEffectiveDate", namespace: "vnem"
              has_one :InsurancePolicyExpirationDate, Date, tag: "InsurancePolicyExpirationDate", namespace: "vnem"

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