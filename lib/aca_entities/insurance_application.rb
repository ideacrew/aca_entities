# frozen_string_literal: true

module AcaEntities
  class InsuranceApplication < Dry::Struct

    attribute :application_metadta, ApplicationMetadta.meta(omittable: false)
    attribute :attestation, Attestation.meta(omittable: false)
  end
end
