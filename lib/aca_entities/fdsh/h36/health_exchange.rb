# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module H36
      # Entity for h36 entity HealthExchange
      class HealthExchange < Dry::Struct
        attribute :SubmissionYr, AcaEntities::Types::String.meta(omittable: false)
        attribute :SubmissionMonthNum, AcaEntities::Types::String.meta(omittable: false)
        attribute :ApplicableCoverageYr, AcaEntities::Types::String.meta(omittable: false)
        attribute :IndividualExchange, AcaEntities::Fdsh::H36::IndividualExchange.meta(omittable: false)
      end
    end
  end
end
