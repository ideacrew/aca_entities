# frozen_string_literal: true

module AcaEntities
  module Eligibilities
    module Contracts
      class FamilyMemberSubjectContract < Dry::Validation::Contract
        params do
          required(:first_name).filled(:string)
          required(:last_name).filled(:string)
          required(:dob).filled(:date)
          optional(:encrypted_ssn).maybe(:string)
          required(:hbx_id).filled(:string)
          required(:person_id).filled(:string)
          required(:is_primary).filled(:bool)
        end
      end
    end
  end
end
