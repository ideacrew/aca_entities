# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module Medicaid
        module Atp
          # An activity indicating that an object has been updated.
          class ApplicationUpdate
            include HappyMapper

            tag 'ApplicationUpdate'
            namespace 'hix-core'

            has_one :activity_id, ActivityIdentification
            has_one :activity_date, ActivityDate

            def self.domain_to_mapper(application)
              mapper = self.new
              mapper.activity_id = ActivityIdentification.domain_to_mapper(application.activity_id)
              mapper.activity_date = ActivityDate.domain_to_mapper(application.activity_date)
              mapper
            end

            def to_hash
              {
                activity_id: activity_id&.to_hash,
                activity_date: activity_date&.to_hash
              }
            end
          end
        end
      end
    end
  end
end