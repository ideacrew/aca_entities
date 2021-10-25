# frozen_string_literal: true

module AcaEntities
  module Accounts
    class User < Dry::Struct
      attribute :attestations,
                Types::Array
                  .of(AcaEntities::Attestations::Attestation)
                  .optional
                  .meta(omittable: true)
      attribute :approved, Types::Bool.optional.meta(omittable: true)
      attribute :email, Types::String.optional.meta(omittable: true)
      attribute :oim_id, Types::String.optional.meta(omittable: true)
      attribute :hint, Types::Bool.optional.meta(omittable: true)
      attribute :identity_confirmed_token,
                Types::String.optional.meta(omittable: true)
      attribute :identity_final_decision_code,
                Types::String.optional.meta(omittable: true)
      attribute :identity_final_decision_transaction_id,
                Types::String.optional.meta(omittable: true)
      attribute :identity_response_code,
                Types::String.optional.meta(omittable: true)
      attribute :identity_response_description_text,
                Types::String.optional.meta(omittable: true)
      attribute :identity_verified_date,
                Types::Date.optional.meta(omittable: true)
      attribute :idp_uuid, Types::String.optional.meta(omittable: true)
      attribute :idp_verified, Types::Bool.optional.meta(omittable: true)
      attribute :last_portal_visited,
                Types::String.optional.meta(omittable: true)
      attribute :preferred_language,
                Types::String.optional.meta(omittable: true)
      attribute :profile_type, Types::String.optional.meta(omittable: true)
      attribute :roles,
                Types::Array.of(Types::String).optional.meta(omittable: true)
      attribute :timestamp,
                AcaEntities::TimeStamp.optional.meta(omittable: true)
    end
  end
end
