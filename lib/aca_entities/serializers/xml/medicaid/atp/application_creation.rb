# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module Medicaid
        module Atp
          # An activity indicating that an object has been created.
          class ApplicationCreation
            include HappyMapper

            tag 'ApplicationCreation'
            namespace 'hix-core'

            has_one :creation_id, String, tag: "CreationID", namespace: "nc"
            has_one :creation_date, ActivityDate

            def self.domain_to_mapper(application)
              transfer_activity = self.new
              transfer_activity.creation_id = application&.creation_id
              transfer_activity.creation_date = ActivityDate.domain_to_mapper(application&.creation_date)
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