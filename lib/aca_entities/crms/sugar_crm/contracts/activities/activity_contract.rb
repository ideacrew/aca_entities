# frozen_string_literal: true

module AcaEntities
  module Crms
    module SugarCrm
      module Activities
        # contract for sugar_crm Activities
        #   {
        #     "id": "22fb8b16-de1d-f1dc-b15b-51240efde177",
        #     "date_entered": "2013-02-19T23:47:11+00:00",
        #     "date_modified": "2013-02-19T23:47:11+00:00",
        #     "created_by": "1",
        #     "deleted": "0",
        #     "parent_id": "f5bb0331-2c0f-5c7c-b4db-5123caac0056",
        #     "parent_type": "Contacts",
        #     "activity_type": "post", This will be the type of activity performed.
        #     "data": {"value": "This is a test post on a contact I'm subscribed to."},
        #     "comment_count": 0, This will be set to the total number of comments on the post.
        #     "last_comment": { This will be the last comment on the post, which can be used to create a comment model on the frontend.
        #                       "deleted": 0,
        #                        "data": []
        #                     },
        #     "fields": [],
        #     "first_name": null,
        #     "last_name": "Administrator",
        #     "created_by_name": " Administrator"
        #   }
        class ActivityContract < ApplicationContract
          params do
            optional(:id).maybe(:string)
            optional(:date_entered).maybe(:string)
            optional(:date_modified).maybe(:string)
            optional(:created_by).maybe(:string)
            optional(:deleted).maybe(:string)
            optional(:parent_id).maybe(:string)
            optional(:parent_type).maybe(:string)
            optional(:activity_type).maybe(:string)
            optional(:data).maybe(:hash)
            optional(:comment_count).maybe(:integer)
            optional(:last_comment).maybe(:hash)
            optional(:fields).maybe(:array)
            optional(:first_name).maybe(:string)
            optional(:last_name).maybe(:string)
            optional(:created_by_name).maybe(:string)
          end
        end
      end
    end
  end
end

