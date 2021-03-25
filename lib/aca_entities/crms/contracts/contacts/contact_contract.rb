# frozen_string_literal: true

module Crms
  module Contacts
    class ContactContract < ApplicationContract
      params do
        optional(:identifiers).array(:hash)
        optional(:user).maybe(:hash)
        optional(:account_contact).maybe(:hash)

        # optional(:account).maybe(:hash)
        optional(:lead).maybe(:hash)
        optional(:campaign).maybe(:hash)
        optional(:assigned_to).maybe(:hash)
        optional(:reporting_user).maybe(:hash)
        optional(:subscribed_users).array(:hash)

        optional(:tasks).array(:hash)
        optional(:addresses).array(:hash)
        optional(:emails).array(CovidMost::Types::Email)

        optional(:contact_opportunities).array(:hash)
        optional(:opportunities).array(:hash)

        optional(:index_case_opportunities).array(:hash)
        optional(:contact_investigations).array(:hash)
        optional(:consents).array(:hash)
        optional(:outreach_priority).maybe(:integer)

        required(:first_name).filled(:string)
        required(:last_name).filled(:string)
        optional(:preferred_name).maybe(:string)
        optional(:date_of_birth).maybe(:date)
        optional(:ssn).maybe(:string)
        optional(:gender).maybe(CovidMost::Types::GenderKind)
        optional(:preferred_language).maybe(:string)
        optional(:used_interpreter).maybe(CovidMost::Types::YesNoUnknownKind)

        optional(:access).maybe(:string)
        optional(:title).maybe(:string)
        optional(:department).maybe(:string)
        optional(:source).maybe(:string)

        optional(:reports_to).maybe(:integer)

        optional(:email).maybe(CovidMost::Types::Email)
        optional(:alt_email).maybe(CovidMost::Types::Email)
        optional(:phone).maybe(CovidMost::Types::PhoneNumber)
        optional(:mobile).maybe(CovidMost::Types::PhoneNumber)

        optional(:linkedin).maybe(:string)
        optional(:facebook).maybe(:string)
        optional(:twitter).maybe(:string)

        optional(:do_not_call).maybe(:bool)
        optional(:background_info).maybe(:string)

        optional(:created_at).maybe(:date_time)
        optional(:updated_at).maybe(:date_time)
        optional(:deleted_at).maybe(:date_time)
      end

      rule(:user, :reporting_user, :assigned_to) do
        if key? && value
          result = Users::UserContract.new.call(value)
          if result&.failure?
            key.failure(text: 'invalid user', error: result.errors.to_h)
          end
        end
      end

      rule(:subscribed_users).each do |key, value|
        if key? && value
          result = Users::UserContract.new.call(value)
          if result&.failure?
            key.failure(text: 'invalid user', error: result.errors.to_h)
          end
        end
      end

      rule(:account) do
        if key? && value
          result = Accounts::AccountContract.new.call(value)
          if result&.failure?
            key.failure(text: 'invalid account', error: result.errors.to_h)
          end
        end
      end

      rule(:account_contact) do
        if key? && value
          result = Accounts::AccountContactContract.new.call(value)
          if result&.failure?
            key.failure(
              text: 'invalid account contact',
              error: result.errors.to_h
            )
          end
        end
      end

      rule(:lead) do
        if key? && value
          result = Leads::LeadContract.new.call(value)
          if result&.failure?
            key.failure(text: 'invalid lead', error: result.errors.to_h)
          end
        end
      end

      rule(:campaign) do
        if key? && value
          result = Campaigns::CampaigContract.new.call(value)
          if result&.failure?
            key.failure(text: 'invalid campaign', error: result.errors.to_h)
          end
        end
      end

      rule(:tasks).each do |key, value|
        if key? && value
          result = Tasks::TaskContract.new.call(value)
          if result&.failure?
            key.failure(text: 'invalid task', error: result.errors.to_h)
          end
        end
      end

      rule(:addresses).each do |key, value|
        if key? && value
          result = Locations::AddressContract.new.call(value)
          if result&.failure?
            key.failure(text: 'invalid address', error: result.errors.to_h)
          end
        end
      end

      rule(:opportunities, :contact_opportunities).each do |key, value|
        if key? && value
          result = Opportunities::OpportunityContract.new.call(value)
          if result&.failure?
            key.failure(text: 'invalid opportunity', error: result.errors.to_h)
          end
        end
      end

      rule(:identifiers).each do |key, value|
        if key? && value
          result = Identifiers::IdsContract.new.call(value)
          if result&.failure?
            key.failure(text: 'invalid identifier', error: result.errors.to_h)
          end
        end
      end

      rule(:index_case_opportunities).each do |key, value|
        if key? && value
          result = IndexCases::IndexCaseOpportunityContract.new.call(value)
          if result&.failure?
            key.failure(
              text: 'invalid index case opportunity',
              error: result.errors.to_h
            )
          end
        end
      end

      rule(:consents).each do |key, value|
        if key? && value
          result = Consents::ConsentContract.new.call(value)
          if result&.failure?
            key.failure(text: 'invalid consents', error: result.errors.to_h)
          end
        end
      end
    end
  end
end
