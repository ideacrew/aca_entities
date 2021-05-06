# frozen_string_literal: true

module AcaEntities
  module Crms
    module SugarCrm
      module Leads

        # {
        #   "id":"ecba9f86-4a4a-def6-359c-505a5b33f014",
        #   "name":"John Smith",
        #   "date_entered":"2012-09-19T23:54:54+0000",
        #   "date_modified":"2012-09-19T23:54:54+0000",
        #   "modified_user_id":"1",
        #   "created_by":"1",
        #   "deleted":0,
        #   "team_id":"1",
        #   "team_set_id":"1",
        #   "first_name":"John",
        #   "last_name":"Smith",
        #   "full_name":"John Smith",
        #   "do_not_call":false,
        #   "converted":false,
        #   "lead_source":"Support Portal User Registration",
        #   "status":"New",
        #   "preferred_language":"en_us",
        #   "email":[

        #   ],
        #   "my_favorite":false
        # }
        # Contract for sugar_crm Leads
        class LeadContract < ApplicationContract

          params do
            optional(:id).maybe(:string)
            optional(:name).maybe(:string)
            optional(:date_entered).maybe(:date_time)
            optional(:date_modified).maybe(:date_time)
            optional(:modified_user_id).maybe(:string)
            optional(:created_by).maybe(:string)
            optional(:deleted).maybe(:string)
            optional(:team_id).maybe(:string)
            optional(:team_set_id).maybe(:string)
            optional(:first_name).maybe(:string)
            optional(:last_name).maybe(:string)
            optional(:full_name).maybe(:string)
            optional(:do_not_call).maybe(:bool)
            optional(:converted).maybe(:bool)
            optional(:lead_source).maybe(:string)
            optional(:status).maybe(:string)
            optional(:preferred_language).maybe(:string)
            optional(:email).array(Emails::Email)
            optional(:my_favorite).maybe(:Bool)
          end
        end
      end
    end
  end
end