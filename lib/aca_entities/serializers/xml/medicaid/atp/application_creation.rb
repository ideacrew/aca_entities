# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module Medicaid
        module Atp
          class ApplicationCreation
            include HappyMapper
            register_namespace 'hix-core', 'http://hix.cms.gov/0.1/hix-core'

            tag 'ApplicationCreation'
            namespace 'hix-core'

            has_one :creation_id, ActivityIdentification
            has_one :creation_date, ActivityDate

            def self.domain_to_mapper(application)
              transfer_activity = self.new
              transfer_activity.creation_id = ActivityIdentification.domain_to_mapper(application.application_metadata.application_id)
              transfer_activity.creation_date = ActivityDate.domain_to_mapper(application.application_metadata.creation_date)
              transfer_activity
            end
          end
        end
      end
    end
  end
end