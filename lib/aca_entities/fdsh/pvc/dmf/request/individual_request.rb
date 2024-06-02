# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Pvc
      module Dmf
        module Request
          # Entity for IndividualRequest
          class IndividualRequest < Dry::Struct

            attribute :PersonSSNIdentification, Types::String.meta(omittable: false)
            attribute :PersonName,              AcaEntities::Fdsh::Person::PersonName.meta(omittable: false)
            attribute :PersonBirthDate,         Types::Date.meta(omittable: false)
            attribute :PersonSexCode,           Types::String.optional.meta(omittable: true)
          end
        end
      end
    end
  end
end