# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Atp
      # entity for atp Insurance Member
      class InsuranceMember < Dry::Struct

        attribute :medicaid_identification, MedicaidIdentification.optional.meta(omittable: true)
        attribute :chip_identification, ChipIdentification.optional.meta(omittable: true)
      end
    end
  end
end
