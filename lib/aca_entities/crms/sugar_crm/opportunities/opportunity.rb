# frozen_string_literal: true

module AcaEntities
  module Crms
    module SugarCrm
      module Opportunities
        # {
        #     "id": "5529e246-c42f-04e0-1989-526e6d3029c6",
        #     "name": "Lexington Shores Corp - 311 Units",
        #     "date_entered": "2013-10-28T09:52:46-04:00",
        #     "date_modified": "2013-10-28T09:52:46-04:00",
        #     "modified_user_id": "1",
        #     "modified_by_name": "Administrator",
        #     "created_by": "1",
        #     "created_by_name": "Administrator",
        #     "description": "",
        #     "deleted": false,
        #     "assigned_user_id": "seed_sally_id",
        #     "assigned_user_name": "Sally Bronsen",
        #     "team_count": "",
        #     "team_name": [
        #         {
        #             "id": "West",
        #             "name": "West",
        #             "name_2": "",
        #             "primary": true
        #         }
        #     ],
        #     "opportunity_type": "",
        #     "account_name": "Lexington Shores Corp",
        #     "account_id": "1c212ff9-c0d5-866d-d3ae-526e6cd47a31",
        #     "campaign_id": "",
        #     "campaign_name": "",
        #     "lead_source": "Partner",
        #     "amount": 10413,
        #     "base_rate": 1,
        #     "amount_usdollar": 10413,
        #     "currency_id": "-99",
        #     "currency_name": "",
        #     "currency_symbol": "",
        #     "date_closed": "2014-03-30",
        #     "date_closed_timestamp": 1396187804,
        #     "next_step": "",
        #     "sales_stage": "Prospecting",
        #     "sales_status": "New",
        #     "probability": 10,
        #     "best_case": 11795,
        #     "worst_case": 9031,
        #     "commit_stage": "exclude",
        #     "total_revenue_line_items": 5,
        #     "closed_revenue_line_items": 1,
        #     "contact_role": "",
        #     "my_favorite": false,
        #     "_acl": {
        #         "fields": {}
        #     },
        #     "following": false,
        #     "_module": "Opportunities",
        #     "duplicate_check_rank": 0
        #  }
        # entity for sugar_crm Opportunities
        class Opportunity < Dry::Struct

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

          attribute :opportunity_type,            Types::Strict::String.meta(omittable: true)
          attribute :account_name,                Types::Strict::String.meta(omittable: true)
          attribute :account_id,                  Types::Strict::String.meta(omittable: true)
          attribute :campaign_id,                 Types::Strict::String.meta(omittable: true)
          attribute :campaign_name,               Types::Strict::String.meta(omittable: true)
          attribute :lead_source,                 Types::Strict::String.meta(omittable: true)
          attribute :amount,                      Types::Strict::Integer.meta(omittable: true)
          attribute :base_rate,                   Types::Strict::Integer.meta(omittable: true)
          attribute :amount_usdollar,             Types::Strict::Integer.meta(omittable: true)
          attribute :currency_id,                 Types::Strict::String.meta(omittable: true)
          attribute :currency_name,               Types::Strict::String.meta(omittable: true)
          attribute :currency_symbol,             Types::Strict::String.meta(omittable: true)
          attribute :date_closed,                 Types::DateTime.optional.meta(omittable: true)
          attribute :date_closed_timestamp,       Types::Strict::Integer.meta(omittable: true)
          attribute :next_step,                   Types::Strict::String.meta(omittable: true)
          attribute :sales_stage,                 Types::Strict::String.meta(omittable: true)
          attribute :sales_status,                Types::Strict::String.meta(omittable: true)
          attribute :probability,                 Types::Strict::Integer.meta(omittable: true)
          attribute :best_case,                   Types::Strict::Integer.meta(omittable: true)
          attribute :worst_case,                  Types::Strict::Integer.meta(omittable: true)
          attribute :commit_stage,                Types::Strict::String.meta(omittable: true)
          attribute :total_revenue_line_items,    Types::Strict::Integer.meta(omittable: true)
          attribute :closed_revenue_line_items,   Types::Strict::Integer.meta(omittable: true)
          attribute :contact_role,                Types::Strict::String.meta(omittable: true)
          attribute :my_favorite,                 Types::Bool.meta(omittable: true)
          attribute :following,                   Types::Strict::String.meta(omittable: true)
          attribute :_module,                     Types::Strict::String.meta(omittable: true)
          attribute :duplicate_check_rank,        Types::Strict::Integer.meta(omittable: true)

        end
      end
    end
  end
end