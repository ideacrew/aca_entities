# frozen_string_literal: true

require 'dry-struct'

module AcaEntities
  module Determinations
    class LawfulPresenceDetermination

      attribute :vlp_verified_at,                     Types::Date.optional.meta(omittable: false)
      attribute :vlp_authority,                       Types::String.optional.meta(omittable: false)
      attribute :vlp_document_id,                     Types::String.optional.meta(omittable: false) # TODO: check this
      attribute :citizen_status,                      Types::String.optional.meta(omittable: false)
      attribute :citizenship_result,                  Types::String.optional.meta(omittable: false)
      attribute :qualified_non_citizenship_result,    Types::String.optional.meta(omittable: false)
      attribute :aasm_state,                          Types::String.optional.meta(omittable: false)
      attribute :ssa_responses,                       Types::Strict::Array.of(AcaEntities::Events::EventResponse).optional.meta(omittable: false)
      attribute :ssa_requests,                        Types::Strict::Array.of(AcaEntities::Events::EventRequest).optional.meta(omittable: false)
      attribute :vlp_responses,                       Types::Strict::Array.of(AcaEntities::Events::EventResponse).optional.meta(omittable: false)
      attribute :vlp_requests,                        Types::Strict::Array.of(AcaEntities::Events::EventRequest).optional.meta(omittable: false)
    end
  end
end

