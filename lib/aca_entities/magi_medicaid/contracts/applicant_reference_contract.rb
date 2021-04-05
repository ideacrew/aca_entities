# frozen_string_literal: true

module AcaEntities
  module MagiMedicaid
    module Contracts
      # Contract for ApplicantReference.
      class ApplicantReferenceContract < Dry::Validation::Contract

        params do
          required(:first_name).filled(:string)
          required(:last_name).filled(:string)
          required(:dob).filled(:date)
          required(:person_hbx_id).filled(:string)
          optional(:encrypted_ssn).maybe(:string)
        end
      end
    end
  end
end
