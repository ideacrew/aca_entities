# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Atp
      # entity for atp Signature
      class Signature < Dry::Struct
        attribute :date_time, SignatureDate.meta(omittable: false)
      end
    end
  end
end