# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Atp
      # entity for atp SignatureDate
      class SignatureDate < Dry::Struct
        attribute :date, Types::Date.meta(omittable: false)
      end
    end
  end
end