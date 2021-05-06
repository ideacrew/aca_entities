# frozen_string_literal: true

module AcaEntities
  module Crms
    module SugarCrm
      module Activities
        # entity for sugar_crm Activities
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
        class Activity < Dry::Struct

          attribute :id,                  Types::Strict::String.meta(omittable: true)
          attribute :date_entered,        Types::Strict::String.meta(omittable: true)
          attribute :date_modified,       Types::Strict::String.meta(omittable: true)
          attribute :created_by,          Types::Strict::String.meta(omittable: true)
          attribute :deleted,             Types::Strict::String.meta(omittable: true)
          attribute :parent_id,           Types::Strict::String.meta(omittable: true)
          attribute :parent_type,         Types::Strict::String.meta(omittable: true)
          attribute :activity_type,       Types::Strict::String.meta(omittable: true)
          attribute :data,                Types::Hash.meta(omittable: true)
          attribute :comment_count,       Types::Strict::Integer.meta(omittable: true)
          attribute :last_comment,         Types::Hash.meta(omittable: true)
          attribute :fields,               Types::Array.meta(omittable: true)
          attribute :first_name,           Types::Strict::String.meta(omittable: true)
          attribute :last_name,            Types::Strict::String.meta(omittable: true)
          attribute :created_by_name,      Types::Strict::String.meta(omittable: true)
        end
      end
    end
  end
end

