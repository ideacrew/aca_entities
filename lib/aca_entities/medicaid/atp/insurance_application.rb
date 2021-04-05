# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Atp
      # entity for atp InsuranceApplication
      class InsuranceApplication < Dry::Struct

        attribute :application_metadta, ApplicationMetadta.meta(omittable: false)
        attribute :attestation, Attestation.meta(omittable: false)
      end
    end
  end
end
