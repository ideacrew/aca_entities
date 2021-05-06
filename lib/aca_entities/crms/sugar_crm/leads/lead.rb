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
        # entity for sugar_crm Leads
        class Lead < Dry::Struct


          attribute :id,                  Types::Strict::String.meta(omittable: true)
          attribute :name,                Types::Strict::String.meta(omittable: true)
          attribute :date_entered,        Types::DateTime.optional.meta(omittable: true)
          attribute :date_modified,       Types::DateTime.optional.meta(omittable: true)
          attribute :modified_user_id,    Types::Strict::String.meta(omittable: true)
          attribute :created_by,          Types::Strict::String.meta(omittable: true)
          attribute :deleted,             Types::Strict::Integer.meta(omittable: true)
          attribute :team_id,             Types::Strict::String.meta(omittable: true)
          attribute :team_set_id,         Types::Strict::String.meta(omittable: true)
          attribute :first_name,          Types::Strict::String.meta(omittable: true)
          attribute :last_name,           Types::Strict::String.meta(omittable: true)
          attribute :full_name,           Types::Strict::String.meta(omittable: true)
          attribute :do_not_call,         Types::Bool.meta(omittable: true)
          attribute :converted,           Types::Bool.meta(omittable: true)
          attribute :lead_source,         Types::Strict::String.meta(omittable: true)
          attribute :status,              Types::Strict::String.meta(omittable: true)
          attribute :preferred_language,  Types::Strict::String.meta(omittable: true)
          attribute :email,               Types::Array.of(Emails::Email).meta(omittable: true)
          attribute :my_favorite,         Types::Bool.meta(omittable: true)

        end
      end
    end
  end
end