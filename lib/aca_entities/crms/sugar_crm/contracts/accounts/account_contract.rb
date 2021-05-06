# frozen_string_literal: true

module AcaEntities
  module Crms
    module SugarCrm
      module Accounts
        # contract for sugar crm accounts
        # {
        #   "id": "1c212ff9-c0d5-866d-d3ae-526e6cd47a31",
        #   "name": "Lexington Shores Corp",
        #   "date_entered": "2013-10-28T09:52:46-04:00",
        #   "date_modified": "2013-10-28T09:52:46-04:00",
        #   "modified_user_id": "1",
        #   "modified_by_name": "Administrator",
        #   "created_by": "1",
        #   "created_by_name": "Administrator",
        #   "description": "",
        #   "deleted": false,
        #   "assigned_user_id": "seed_sally_id",
        #   "assigned_user_name": "Sally Bronsen",
        #   "team_count": "",
        #   "team_name": [
        #       {
        #           "id": "West",
        #           "name": "West",
        #           "name_2": "",
        #           "primary": true
        #       }
        #   ],
        #   "linkedin": "",
        #   "facebook": "",
        #   "twitter": "",
        #   "googleplus": "",
        #   "account_type": "Customer",
        #   "industry": "Electronics",
        #   "annual_revenue": "",
        #   "phone_fax": "",
        #   "billing_address_street": "111 Silicon Valley Road",
        #   "billing_address_street_2": "",
        #   "billing_address_street_3": "",
        #   "billing_address_street_4": "",
        #   "billing_address_city": "Santa Fe",
        #   "billing_address_state": "CA",
        #   "billing_address_postalcode": "63785",
        #   "billing_address_country": "USA",
        #   "rating": "",
        #   "phone_office": "(641) 347-6902",
        #   "phone_alternate": "",
        #   "website": "www.imphone.de",
        #   "ownership": "",
        #   "employees": "",
        #   "ticker_symbol": "",
        #   "shipping_address_street": "111 Silicon Valley Road",
        #   "shipping_address_street_2": "",
        #   "shipping_address_street_3": "",
        #   "shipping_address_street_4": "",
        #   "shipping_address_city": "Santa Fe",
        #   "shipping_address_state": "CA",
        #   "shipping_address_postalcode": "63785",
        #   "shipping_address_country": "USA",
        #   "email": [
        #       {
        #           "email_address": "section.qa@example.tw",
        #           "invalid_email": false,
        #           "opt_out": false,
        #           "primary_address": true,
        #           "reply_to_address": false
        #       },
        #       {
        #           "email_address": "vegan29@example.de",
        #           "invalid_email": false,
        #           "opt_out": false,
        #           "primary_address": false,
        #           "reply_to_address": false
        #       }
        #   ],
        #   "email1": "section.qa@example.tw",
        #   "parent_id": "",
        #   "sic_code": "",
        #   "parent_name": "",
        #   "email_opt_out": false,
        #   "invalid_email": false,
        #   "campaign_id": "",
        #   "campaign_name": "",
        #   "my_favorite": false,
        #   "_acl": {
        #       "fields": {}
        #   },
        #   "following": false,
        #   "_module": "Accounts",
        #   "duplicate_check_rank": 8
        # }
        class AccountContract < ApplicationContract

          params do
            optional(:id).maybe(:string)
            optional(:name).maybe(:string)
            optional(:date_entered).maybe(:date_time)
            optional(:date_modified).maybe(:date_time)
            optional(:modified_user_id).maybe(:string)
            optional(:modified_by_name).maybe(:string)
            optional(:created_by).maybe(:string)
            optional(:created_by_name).maybe(:string)
            optional(:description).maybe(:string)
            optional(:deleted).maybe(:bool)
            optional(:assigned_user_id).maybe(:string)
            optional(:assigned_user_name).maybe(:string)
            optional(:team_count).maybe(:string)

            optional(:team_name).array(:hash) do
              optional(:id).maybe(:string)
              optional(:name).maybe(:string)
              optional(:name_2).maybe(:string)
              optional(:primary).maybe(:bool)
            end

            optional(:_acl).schema do
              optional(:fields).maybe(:hash)
            end

            optional(:linkedin).maybe(:string)
            optional(:facebook).maybe(:string)
            optional(:twitter).maybe(:string)
            optional(:googleplus).maybe(:string)
            optional(:website).maybe(:string)

            optional(:account_type).maybe(:string)
            optional(:industry).maybe(:string)
            optional(:annual_revenue).maybe(:string)
            optional(:email).array(:hash)
            optional(:email_opt_out).maybe(:bool)
            optional(:invalid_email).maybe(:bool)
            optional(:phone_fax).maybe(Crm::Types::PhoneNumber)
            optional(:phone_office).maybe(Crm::Types::PhoneNumber)
            optional(:phone_alternate).maybe(Crm::Types::PhoneNumber)
            optional(:billing_address).maybe(Locations::Address)
            optional(:shipping_address).maybe(Locations::Address)
            optional(:rating).maybe(:string)

            optional(:ownership).maybe(:string)
            optional(:employees).maybe(:string)
            optional(:ticker_symbol).maybe(:string)
            optional(:parent_id).maybe(:string)
            optional(:sic_code).maybe(:string)
            optional(:parent_name).maybe(:string)

            optional(:campaign_id).maybe(:string)
            optional(:campaign_name).maybe(:string)
            optional(:my_favorite).maybe(:bool)
            optional(:following).maybe(:string)
            optional(:_module).maybe(:string)
            optional(:duplicate_check_rank).maybe(:integer)
          end
        end
      end
    end
  end
end



