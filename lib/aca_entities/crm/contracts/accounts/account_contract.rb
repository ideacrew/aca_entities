# frozen_string_literal: true

module AcaEntities
  module Crm
    module Accounts
      # conract for crm account
      class AccountContract < ApplicationContract

        params do

          required(:name).filled(:string)
          required(:contacts_count).filled(:integer)
          required(:opportunities_count).filled(:integer)

          optional(:report_to_account).maybe(:string)
          optional(:managing_division).maybe(:hash)
          optional(:division_kind).maybe(:string)
          optional(:division_name).maybe(:string)
          optional(:divisions).array(:hash)
          optional(:user).maybe(:hash)
          optional(:lead).maybe(:hash)
          optional(:assigned_to).maybe(:hash)
          optional(:subscribed_users).array(:hash)

          optional(:access).maybe(:string)
          optional(:title).maybe(:string)
          optional(:department).maybe(:string)
          optional(:source).maybe(:string)

          optional(:email).maybe(Crm::Types::Email)
          optional(:alt_email).maybe(Crm::Types::Email)
          optional(:phone).maybe(Crm::Types::PhoneNumber)
          optional(:mobile).maybe(Crm::Types::PhoneNumber)

          optional(:linkedin).maybe(:string)
          optional(:facebook).maybe(:string)
          optional(:twitter).maybe(:string)
          optional(:date_of_birth).maybe(:date)
          optional(:category).maybe(:string)

          optional(:do_not_call).maybe(:bool)
          optional(:background_info).maybe(:string)

          optional(:created_at).maybe(:date_time)
          optional(:updated_at).maybe(:date_time)
          optional(:deleted_at).maybe(:date_time)
        end

        # rule(:user, :assigned_to) do
        #   if key? && value
        #     result = Users::UserContract.new.call(value)
        #     key.failure(text: "invalid user", error: result.errors.to_h) if result&.failure?
        #   end
        # end

        # rule(:subscribed_users).each do  |key, value|
        #   if key? && value
        #     result = Users::UserContract.new.call(value)
        #     key.failure(text: "invalid user", error: result.errors.to_h) if result&.failure?
        #   end
        # end

        # rule(:managing_division) do
        #   if key? && value
        #     result = Accounts::AccountContract.new.call(value)
        #     key.failure(text: "invalid account", error: result.errors.to_h) if result&.failure?
        #   end
        # end

        # rule(:divisions).each do |key, value|
        #   if key? && value
        #     result = Accounts::AccountContract.new.call(value)
        #     key.failure(text: "invalid account", error: result.errors.to_h) if result&.failure?
        #   end
        # end

        # rule(:lead) do
        #   if key? && value
        #     result = Leads::LeadContract.new.call(value)
        #     key.failure(text: "invalid lead", error: result.errors.to_h) if result&.failure?
        #   end
        # end
      end
    end
  end
end