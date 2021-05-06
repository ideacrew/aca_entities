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
        # contract for sugar_crm Opportunities
        class OpportunityContract < ApplicationContract

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

            optional(:opportunity_type).maybe(:string)
            optional(:account_name).maybe(:string)
            optional(:account_id).maybe(:string)
            optional(:campaign_id).maybe(:string)
            optional(:campaign_name).maybe(:string)
            optional(:lead_source).maybe(:string)
            optional(:amount).maybe(:string)
            optional(:base_rate).maybe(:string)
            optional(:amount_usdollar).maybe(:string)
            optional(:currency_id).maybe(:string)
            optional(:currency_name).maybe(:string)
            optional(:currency_symbol).maybe(:string)
            optional(:date_closed).maybe(:date_time)
            optional(:date_closed_timestamp).maybe(:integer)
            optional(:next_step).maybe(:string)
            optional(:sales_stage).maybe(:string)
            optional(:sales_status).maybe(:string)
            optional(:probability).maybe(:string)
            optional(:best_case).maybe(:string)
            optional(:worst_case).maybe(:string)
            optional(:commit_stage).maybe(:string)
            optional(:total_revenue_line_items).maybe(:string)
            optional(:closed_revenue_line_items).maybe(:string)
            optional(:contact_role).maybe(:string)
            optional(:my_favorite).maybe(:bool)
            optional(:following).maybe(:string)
            optional(:_module).maybe(:string)
            optional(:duplicate_check_rank).maybe(:string)
          end
        end
      end
    end
  end
end