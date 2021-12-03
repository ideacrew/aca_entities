# frozen_string_literal: true

module AcaEntities
  module Contracts
    module Enrollees
      # Schema and validation rules for Glue {AcaEntities::Enrollees::EnrolleeDemographics} .
      class EnrolleeDemographicsContract < Dry::Validation::Contract
        params do
          required(:dob).filled(:date)
          optional(:ssn).maybe(:string)
          required(:gender_code).filled(:string)
          optional(:tobacco_use_code).maybe(:string)
        end
      end
    end
  end
end
