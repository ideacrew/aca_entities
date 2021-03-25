# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module FosterCares
      # Mongoid persistance model
      # class FosterCareModel
      # end

      # ActiveRecord persistance model
      # class FosterCareRecord
      # end

      # Entity for FosterCare.
      class FosterCare < Dry::Struct
        attribute :attested_foster_care,
                  Types::Bool.optional.meta(omittable: true)
        attribute :age_left_foster_care,
                  Types::Integer.optional.meta(omittable: true)
        attribute :foster_care_us_state_code,
                  Types::String.optional.meta(omittable: true)
        attribute :had_medicaid_during_foster_care,
                  Types::Bool.optional.meta(omittable: true)
      end
    end
  end
end
