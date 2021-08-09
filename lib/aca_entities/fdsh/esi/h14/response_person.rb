# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Esi
      module H14
        # Entity for Fdsh ESI(employer sponsored insurance) VerificationResponse
        class ResponsePerson < Dry::Struct
          attribute :PersonSSNIdentification,  AcaEntities::Fdsh::Person::PersonSSNIdentification.meta(omittable: false)
        end
      end
    end
  end
end