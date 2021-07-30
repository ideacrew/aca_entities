# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Atp
      # entity for atp IncomeCompatibilityDetermination
      class IncomeCompatibilityDetermination < Dry::Struct

        attribute :activity_identification, ActivityIdentification.optional.meta(omittable: true)
        attribute :activity_date, ActivityDate.optional.meta(omittable: true)
      end
    end
  end
end