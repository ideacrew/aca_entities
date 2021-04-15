# frozen_string_literal: true

module AcaEntities
  module Determinations
    class LawfulPresenceDetermination < Dry::Struct

      attribute :vlp_verified_at,                     Types::Date.optional.meta(omittable: true)
      attribute :vlp_authority,                       Types::String.optional.meta(omittable: true)
      attribute :vlp_document_id,                     Types::String.optional.meta(omittable: true) # TODO: check this
      attribute :citizen_status,                      Types::String.optional.meta(omittable: false)
      attribute :citizenship_result,                  Types::String.optional.meta(omittable: true)
      attribute :qualified_non_citizenship_result,    Types::String.optional.meta(omittable: true)
      attribute :aasm_state,                          Types::String.optional.meta(omittable: true)
      attribute :ssa_responses,                       Types::Array.of(AcaEntities::Events::EventResponse).optional.meta(omittable: true)
      attribute :ssa_requests,                        Types::Array.of(AcaEntities::Events::EventRequest).optional.meta(omittable: true)
      attribute :vlp_responses,                       Types::Array.of(AcaEntities::Events::EventResponse).optional.meta(omittable: true)
      attribute :vlp_requests,                        Types::Array.of(AcaEntities::Events::EventRequest).optional.meta(omittable: true)
    end
  end
end

