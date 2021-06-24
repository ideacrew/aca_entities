# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module Medicaid
        module Atp
          # Include XML element and type definitions.
          class ApplicationSubmission
            include HappyMapper

            tag 'ApplicationSubmission'
            namespace 'hix-core'

            has_one :creation_id, ActivityIdentification
            has_one :creation_date, ActivityDate

            def self.domain_to_mapper(application)
              transfer_activity = self.new
              transfer_activity.creation_id = ActivityIdentification.domain_to_mapper(application.application_metadata.application_ids)
              transfer_activity.creation_date = ActivityDate.domain_to_mapper(application.application_metadata.submission_date)
              transfer_activity
            end

            def to_hash
              {
                creation_id: creation_id&.to_hash,
                creation_date: creation_date&.to_hash
              }
            end
          end
        end
      end
    end
  end
end