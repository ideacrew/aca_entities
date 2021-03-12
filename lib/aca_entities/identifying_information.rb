# frozen_string_literal: true

module AcaEntities
  class IdentifyingInformation < Dry::Struct

    attribute :ssn,       Types::String.optional.meta(omittable: true)
    attribute :hbx_id,    Types::String.optional.meta(omittable: true)
    attribute :medicaid_id, Types::String.optional.meta(omittable: true)
    attribute :chip_id, Types::String.optional.meta(omittable: true)
    # Indicates the person is the primary insured for another person's offer of insurance (not enrolled)
    attribute :primary_insured, Types::Bool.optional.meta(omittable: true)
    attribute :temporary_id, Types::String.optional.meta(omittable: true)
    attribute :application_signature,  Types::String.optional.meta(omittable: true)
  end
end
