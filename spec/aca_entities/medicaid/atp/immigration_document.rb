# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Atp
      # entity for #atp immigration document
      class ImmigrationDocument < Dry::Struct
        attribute :expiration_date, DocumentExpirationDate.optional.meta(omittable: true)
        attribute :document_numbers,         Types::Array.of(DocumentNumber).optional.meta(omittable: true)
        attribute :document_person_ids,      Types::Array.of(DocumentPersonIdentification).optional.meta(omittable: true)
        attribute :same_name_indicator,      Types::Bool.optional.meta(omittable: true)
        attribute :category_text,            Types::String.optional.meta(omittable: true)
        attribute :category_code,            Types::String.optional.meta(omittable: true)
      end
    end
  end
end