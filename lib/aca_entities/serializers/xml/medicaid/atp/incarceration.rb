# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module Medicaid
        module Atp
          # A description of the applicant's incarceration history.
          class Incarceration
            include HappyMapper

            tag 'InsuranceApplicantIncarceration'
            namespace 'hix-ee'

            attribute :metadata, String, namespace: "niem-s"

            # True if the person is incarcerated; false otherwise.
            has_one :incarceration_date, IncarcerationDate

            # True if the person is incarcerated; false otherwise.
            element :incarceration_indicator, Boolean, tag: 'IncarcerationIndicator', namespace: 'hix-core'

            def self.domain_to_mapper(inc)
              mapper = self.new
              mapper.metadata = inc.metadata
              mapper.incarceration_date = IncarcerationDate.domain_to_mapper(inc.incarceration_date)
              mapper.incarceration_indicator = inc.incarceration_indicator
              mapper
            end

            def to_hash
              {
                incarceration_indicator: incarceration_indicator,
                incarceration_date: incarceration_date&.to_hash
              }
            end
          end
        end
      end
    end
  end
end