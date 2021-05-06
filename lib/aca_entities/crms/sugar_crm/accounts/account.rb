# frozen_string_literal: true

module AcaEntities
  module Crms
    module SugarCrm
      module Accounts
        # entity for sugar crm accounts
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
        class Account < Dry::Struct

          attribute :id,                  Types::Strict::String.meta(omittable: true)
          attribute :name,                Types::Strict::String.meta(omittable: true)
          attribute :date_entered,        Types::DateTime.optional.meta(omittable: true)
          attribute :date_modified,       Types::DateTime.optional.meta(omittable: true)
          attribute :modified_user_id,    Types::Strict::String.meta(omittable: true)
          attribute :modified_by_name,    Types::Strict::String.meta(omittable: true)
          attribute :created_by,          Types::Strict::String.meta(omittable: true)
          attribute :created_by_name,     Types::Strict::String.meta(omittable: true)
          attribute :description,         Types::Strict::String.meta(omittable: true)
          attribute :deleted,             Types::Bool.meta(omittable: true)
          attribute :assigned_user_id,    Types::Strict::String.meta(omittable: true)
          attribute :assigned_user_name,  Types::Strict::String.meta(omittable: true)
          attribute :team_count,          Types::Strict::String.meta(omittable: true)

          attribute :team_name, Types::Array do
            attribute :id,      Types::Strict::String.meta(omittable: true)
            attribute :name,    Types::Strict::String.meta(omittable: true)
            attribute :name_2,  Types::Strict::String.meta(omittable: true)
            attribute :primary, Types::Bool.meta(omittable: true)
          end

          attribute :_acl do
            attribute :fields,  Types::Hash.meta(omittable: true)
          end

          attribute :linkedin,             Types::Strict::String.meta(omittable: true)
          attribute :facebook,             Types::Strict::String.meta(omittable: true)
          attribute :twitter,              Types::Strict::String.meta(omittable: true)
          attribute :googleplus,           Types::Strict::String.meta(omittable: true)
          attribute :website,              Types::Strict::String.meta(omittable: true)

          attribute :account_type,         Types::Strict::String.meta(omittable: true)
          attribute :industry,             Types::Strict::String.meta(omittable: true)
          attribute :annual_revenue,       Types::Strict::String.meta(omittable: true)
          attribute :email,                Types::Array.of(Emails::Email).meta(omittable: true)
          attribute :email_opt_out,        Types::Bool.meta(omittable: true)
          attribute :invalid_email,        Types::Bool.meta(omittable: true)
          attribute :phone_fax,            Crm::Types::PhoneNumber.meta(omittable: true)
          attribute :phone_office,         Crm::Types::PhoneNumber.meta(omittable: true)
          attribute :phone_alternate,      Crm::Types::PhoneNumber.meta(omittable: true)
          attribute :billing_address,      Locations::Address.meta(omittable: true)
          attribute :shipping_address,     Locations::Address.meta(omittable: true)
          attribute :rating,               Types::Strict::String.meta(omittable: true)

          attribute :ownership,            Types::Strict::String.meta(omittable: true)
          attribute :employees,            Types::Strict::String.meta(omittable: true)
          attribute :ticker_symbol,        Types::Strict::String.meta(omittable: true)
          attribute :parent_id,            Types::Strict::String.meta(omittable: true)
          attribute :sic_code,             Types::Strict::String.meta(omittable: true)
          attribute :parent_name,          Types::Strict::String.meta(omittable: true)

          attribute :campaign_id,          Types::Strict::String.meta(omittable: true)
          attribute :campaign_name,        Types::Strict::String.meta(omittable: true)
          attribute :my_favorite,          Types::Bool.meta(omittable: true)
          attribute :following,            Types::Strict::String.meta(omittable: true)
          attribute :_module,              Types::Strict::String.meta(omittable: true)
          attribute :duplicate_check_rank, Types::Strict::Integer.meta(omittable: true)
        end
      end
    end
  end
end


            
