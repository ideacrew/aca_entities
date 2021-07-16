# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Atp
      # entity for atp Signature
      class Signature < Dry::Struct
        attribute :signature_date, SignatureDate.meta(omittable: false)
        attribute :signature_name, SignatureDate.optional.meta(omittable: true)
      end
    end
  end
end