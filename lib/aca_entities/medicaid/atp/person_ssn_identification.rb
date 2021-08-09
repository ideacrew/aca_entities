# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Atp
      # entity for #atp PersonSsnIdentification
      class PersonSsnIdentification < Dry::Struct
        attribute :identification_id, Types::String.meta(omittable: false)
      end
    end
  end
end