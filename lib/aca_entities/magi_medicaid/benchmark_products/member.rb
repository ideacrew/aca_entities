# frozen_string_literal: true

module AcaEntities
  module MagiMedicaid
    module BenchmarkProducts
      # Cv3 IAP Entity for BenchmarkProduct.
      class Member < Dry::Struct
        attribute :applicant_reference, AcaEntities::MagiMedicaid::ApplicantReference.meta(omittable: false)
        attribute :relationship_with_primary, Types::String.meta(omittable: false)
        attribute :age_on_effective_date, Types::Integer.meta(omittable: false)
      end
    end
  end
end
