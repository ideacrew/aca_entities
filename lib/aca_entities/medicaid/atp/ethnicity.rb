# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Atp
      # entity for #atp Ethnicity
      class Ethnicity < Dry::Struct
        attribute :text, Types::String.optional.meta(omittable: true)
      end
    end
  end
end