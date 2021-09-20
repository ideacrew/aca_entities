# frozen_string_literal: true

require_relative "../contacts/contact_contract"

module Crms
  module Accounts
    # Schema and validation rules for the {Crms::Accounts::Account} entity
    class AccountContract < AcaEntities::Contracts::Contract
      # @!method call(opts)
      # @param [Hash] opts the parameters to validate using this contract
      # @option opts [String] :name required
      # @option opts [Integer] :contacts_count required
      # @option opts [Integer] :opportunities_count required
      # @option opts [String] :report_to_account optional
      # @return [Dry::Monads::Result] result

      params do
        required(:primary_person_hbx_id).filled(:string)
        required(:name).filled(:string)
        required(:contacts_count).filled(:integer)
        required(:contacts).array(::AcaEntities::Crms::Contacts::ContactContract.params)

        optional(:email).maybe(:string)
        optional(:alt_email).maybe(:string)
        optional(:phone).maybe(:string)
        optional(:mobile).maybe(:string)
        optional(:date_of_birth).maybe(:date)
        optional(:category).maybe(:string)

        optional(:do_not_call).maybe(:bool)
        optional(:background_info).maybe(:string)

        optional(:created_at).maybe(:date_time)
        optional(:updated_at).maybe(:date_time)
        optional(:deleted_at).maybe(:date_time)
      end
    end
  end
end
