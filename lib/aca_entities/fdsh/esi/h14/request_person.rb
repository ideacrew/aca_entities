# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Esi
      module H14
        # Entity for Fdsh ESI(employer sponsored insurance) VerificationRequest
        class RequestPerson < Dry::Struct
          attribute :PersonBirthDate,  Types::Date.meta(omittable: false)
          attribute :PersonName,              AcaEntities::Fdsh::Person::PersonName.meta(omittable: false)
          attribute :PersonSexCode, Types::String.optional.meta(omittable: false)
          attribute :PersonSSNIdentification, AcaEntities::Fdsh::Person::PersonSsnIdentification.meta(omittable: false)
        end
      end
    end
  end
end