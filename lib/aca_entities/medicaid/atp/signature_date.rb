# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Atp
      # entity for atp SignatureDate
      class SignatureDate < Date
        # date field required for signature date entity
        attribute :date, Types::Date.meta(omittable: false)
      end
    end
  end
end