# frozen_string_literal: true

require 'dry-struct'

module Iap

  class Applicant < Dry::Struct

    # field :is_primary_applicant, type: Boolean, default: false
    # field :is_incarcerated, type: Boolean
    # field :is_disabled, type: Boolean
    # field :ethnicity, type: Array
    # field :race, type: String
    # field :indian_tribe_member, type: Boolean
    # field :tribal_id, type: String

    attribute :addresses,       Types::Array.of(AcaEntities::Address).optional.meta(omittable: true)

    attribute :relationships,   Types::Array.of(Iap::Relationship).optional.meta(omittable: true)

    attribute :incomes,         Types::Array.of(Iap::Income).optional.meta(omittable: true)
    attribute :benefits,        Types::Array.of(Iap::Benefit).optional.meta(omittable: true)
    attribute :deductions,      Types::Array.of(Iap::Deduction).optional.meta(omittable: true)
    attribute :verifications,   Types::Array.of(Iap::Verification).optional.meta(omittable: true)

  end
end
