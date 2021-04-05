# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Atp
      # entity for atp ImmigrationDocument
      class ImmigrationDocument < Dry::Struct

        attribute :expiration_date, Types::Date.optional.meta(omittable: true)
        attribute :document_number, Types::String.optional.meta(omittable: true)
        attribute :document_type_code, Types::String.optional.meta(omittable: true)
        attribute :document_type_other_code, Types::String.optional.meta(omittable: true)
        attribute :name_of_other_document, Types::String.optional.meta(omittable: true)
      end
    end
  end
end
