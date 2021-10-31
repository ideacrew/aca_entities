# frozen_string_literal: true

module AcaEntities
  module Contracts
    module Families
      # Schema and validation rules for {AcaEntities::Families::FamilyMemberReference}
      class FamilyMemberReferenceContract < Dry::Validation::Contract
        # @!method call(opts)
        # @param [Hash] opts the parameters to validate using this contract
        # @option opts [String] :hbx_id required
        # @option opts [String] :first_name optional
        # @option opts [String] :last_name optional
        # @option opts [String] :person_hbx_id optional
        # @option opts [String] :is_primary_family_member optional
        # @return [Dry::Monads::Result]
        params do
          required(:family_member_hbx_id).value(:str?)
          optional(:first_name).maybe(:string)
          optional(:last_name).maybe(:string)
          optional(:person_hbx_id).maybe(:string)
          optional(:is_primary_family_member).maybe(:bool)
          optional(:age).maybe(:integer)
          optional(:ssn).maybe(:string)
          optional(:encrypted_ssn).maybe(:string)
          optional(:dob).maybe(:date)
        end
      end
    end
  end
end
