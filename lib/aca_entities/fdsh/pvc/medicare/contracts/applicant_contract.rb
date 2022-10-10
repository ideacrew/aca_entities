# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Pvc
      module Medicare
        # Contract for PVC ApplicantContract
        class ApplicantContract < Dry::Validation::Contract
          params do
            required(:PersonSSNIdentification).filled(:string)
            required(:PersonName).filled(AcaEntities::Fdsh::Contracts::Person::PersonNameContract.params)
            required(:PersonBirthDate).filled(:date)
            optional(:PersonSexCode).maybe(:string)
          end
        end
      end
    end
  end
end