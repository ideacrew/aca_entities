# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module Medicaid
        module Atp
          # An activity of establishing an eligibility basis.
          class EligibilityBasisDetermination
            include HappyMapper

            tag 'EligibilityBasisDetermination'
            namespace 'hix-ee'

            has_one :activity_identification, ActivityIdentification
            has_one :activity_date, ActivityDate

            def self.domain_to_mapper(eligibility_basis_determination)
              mapper = self.new
              mapper.activity_identification = ActivityIdentification.domain_to_mapper(eligibility_basis_determination.activity_identification)
              mapper.activity_date = ActivityDate.domain_to_mapper(eligibility_basis_determination.activity_date)
              mapper
            end

            def to_hash
              {
                activity_identification: activity_identification&.to_hash,
                activity_date: activity_date&.to_hash
              }
            end
          end
        end
      end
    end
  end
end