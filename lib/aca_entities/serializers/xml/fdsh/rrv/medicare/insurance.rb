# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module Fdsh
        module Rrv
          module Medicare
            # Happymapper implementation for the root object of an Request.
            class Insurance
              include HappyMapper

              tag 'Insurance'

              has_one :InsuranceEffectiveDate, Date, tag: "InsuranceEffectiveDate"
              has_one :InsuranceEndDate, Date, tag: "InsuranceEndDate"

              def self.domain_to_mapper(policy)
                mapper = self.new
                mapper.InsuranceEffectiveDate = policy.InsuranceEffectiveDate&.strftime
                mapper.InsuranceEndDate = policy.InsuranceEndDate&.strftime

                mapper
              end
            end
          end
        end
      end
    end
  end
end