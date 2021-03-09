# frozen_string_literal: true

require 'dry-struct'
require 'aca_entities/applicant_role'
require 'aca_entities/vlp_document'

module Iap
  class Applicant < ::AcaEntities::ApplicantRole
    # field :is_primary_applicant, type: Boolean, default: false
    # field :is_incarcerated, type: Boolean
    # field :is_disabled, type: Boolean
    # field :ethnicity, type: Array
    # field :race, type: String
    # field :indian_tribe_member, type: Boolean
    # field :tribal_id, type: String

    attribute :age_of_applicant,                Types::Integer.optional.meta(omittable: true)
    attribute :person_hbx_id,                   Types::String.optional.meta(omittable: true)

    attribute :vlp_subject,                     Iap::Types::VlpDocumentKind.optional.meta(omittable: true)
    attribute :expiration_date,                 Types::Date.optional.meta(omittable: true)
    attribute :vlp_description,                 Types::String.optional.meta(omittable: true)
    attribute :is_former_foster_care,           Types::Bool.optional.meta(omittable: true)
    attribute :age_left_foster_care,            Types::Bool.optional.meta(omittable: true)
    attribute :foster_care_us_state,            Types::Bool.optional.meta(omittable: true)
    attribute :had_medicaid_during_foster_care, Types::Bool.optional.meta(omittable: true)

    attribute :relationships,   Types::Array.of(Iap::Relationship).optional.meta(omittable: true)

    attribute :incomes,         Types::Array.of(Iap::Income).optional.meta(omittable: true)
    attribute :benefits,        Types::Array.of(Iap::Benefit).optional.meta(omittable: true)
    attribute :deductions,      Types::Array.of(Iap::Deduction).optional.meta(omittable: true)
    attribute :verifications,   Types::Array.of(Iap::Verification).optional.meta(omittable: true)
  end
end
