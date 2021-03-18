# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Atp
      # entity for #atp application meta data
      class ApplicationMetadata < Dry::Struct

        attribute :application_id, Types::String
        attribute :original_signature_date, Types::Date.optional.meta(omittable: true)
        attribute :application_signature_date, Types::DateTime
        attribute :creation_date, Types::DateTime
        attribute :update_date, Types::DateTime.optional.meta(omittable: true)
        attribute :financial_assistance_indicator, Types::Bool.optional.meta(omittable: true)
        attribute :medicaid_determination_indicator, Types::Bool.optional.meta(omittable: true)
        attribute :identification_category_text, Types::String
      end
    end
  end
end
