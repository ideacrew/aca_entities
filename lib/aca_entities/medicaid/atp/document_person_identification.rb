# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Atp
      # entity for #atp document person identification
      class DocumentPersonIdentification < Dry::Struct
        attribute :identification_id,             Types::String.meta(omittable: false)
        attribute :identification_category_text,  Types::String.optional.meta(omittable: true)
        attribute :identification_jurisdiction,  Types::String.optional.meta(omittable: true)
      end
    end
  end
end