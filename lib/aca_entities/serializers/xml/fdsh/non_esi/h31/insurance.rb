# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module Fdsh
        module NonEsi
          module H31
            # Happymapper implementation for the Insurance.
            class Insurance
              include HappyMapper
              register_namespace 'nc', 'http://niem.gov/niem/niem-core/2.0'

              tag 'Insurance'
              namespace 'nc'

              has_one :InsuranceEffectiveDate, InsuranceEffectiveDate
              has_one :InsuranceEndDate, InsuranceEndDate

              def self.domain_to_mapper(policy)
                mapper = self.new
                if policy.InsuranceEffectiveDate.present?
                  mapper.InsuranceEffectiveDate = InsuranceEffectiveDate.domain_to_mapper(policy.InsuranceEffectiveDate)
                end
                mapper.InsuranceEndDate = InsuranceEndDate.domain_to_mapper(policy.InsuranceEndDate) if policy.InsuranceEndDate.present?

                mapper
              end
            end
          end
        end
      end
    end
  end
end