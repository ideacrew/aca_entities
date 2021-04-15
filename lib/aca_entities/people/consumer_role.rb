# frozen_string_literal: true

module AcaEntities
  module People
    class ConsumerRole < Dry::Struct

      attribute :five_year_bar,                            Types::Bool.optional.meta(omittable: false)
      attribute :requested_coverage_start_date,            Types::Date.optional.meta(omittable: false)
      attribute :aasm_state,                               Types::String.optional.meta(omittable: false)
      attribute :is_applicant,                             Types::Bool.optional.meta(omittable: false)
      attribute :birth_location,                           Types::String.optional.meta(omittable: true)
      attribute :marital_status,                           Types::String.optional.meta(omittable: false)
      attribute :is_active,                                Types::Bool.optional.meta(omittable: true)
      attribute :is_applying_coverage,                     Types::Bool.optional.meta(omittable: true)
      # TODO: Check this
      # attribute :raw_event_responses,                      Types::String.optional.meta(omittable: true)
      attribute :bookmark_url,                             Types::String.optional.meta(omittable: true)
      attribute :admin_bookmark_url,                       Types::String.optional.meta(omittable: true)
      attribute :contact_method,                           Types::String.optional.meta(omittable: true)
      attribute :language_preference,                      Types::String.optional.meta(omittable: true)
      attribute :is_state_resident,                        Types::Bool.optional.meta(omittable: false)
      attribute :identity_validation,                      Types::String.optional.meta(omittable: false)
      attribute :identity_update_reason,                   Types::String.optional.meta(omittable: false)
      attribute :application_validation,                   Types::String.optional.meta(omittable: false)
      attribute :application_update_reason,                Types::String.optional.meta(omittable: false)
      attribute :identity_rejected,                        Types::Bool.optional.meta(omittable: false)
      attribute :application_rejected,                     Types::Bool.optional.meta(omittable: false)

      attribute :documents,                                Types::Array.of(AcaEntities::Documents::Document).optional.meta(omittable: true)
      attribute :vlp_documents,                            Types::Array.of(AcaEntities::Documents::VlpDocument).optional.meta(omittable: false)
      attribute :ridp_documents,
                Types::Array.of(AcaEntities::Documents::RidpDocument).optional.meta(omittable: false)
      attribute :verification_type_history_elements,
                Types::Array.of(AcaEntities::Verifications::VerificationTypeHistoryElement).optional.meta(omittable: false)
      attribute :lawful_presence_determination,            AcaEntities::Determinations::LawfulPresenceDetermination.optional.meta(omittable: false)
      attribute :local_residency_responses,                Types::Array.of(AcaEntities::Events::EventResponse).optional.meta(omittable: true)
      attribute :local_residency_requests,                 Types::Array.of(AcaEntities::Events::EventRequest).optional.meta(omittable: true)
    end
  end
end
