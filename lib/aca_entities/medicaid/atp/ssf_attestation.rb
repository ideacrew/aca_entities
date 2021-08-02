# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Atp
      # entity for atp SsfAttestation
      class SsfAttestation < Dry::Struct
        attribute :non_perjury_indicator,            Types::Bool.meta(omittable: false)
        attribute :not_incarcerated_indicators,      Types::Array.of(NotIncarceratedIndicator).meta(omittable: false)
        attribute :information_changes_indicator,    Types::Bool.meta(omittable: false)
        attribute :collections_agreement_indicator,  Types::Bool.optional.meta(omittable: true)
        attribute :medicaid_obligations_indicator,   Types::Bool.optional.meta(omittable: true)
        attribute :privacy_agreement_indicator,      Types::Bool.optional.meta(omittable: true)
        attribute :pending_charges_indicator,        Types::Bool.optional.meta(omittable: true)
        attribute :application_terms_indicator,      Types::Bool.optional.meta(omittable: true)
      end
    end
  end
end
