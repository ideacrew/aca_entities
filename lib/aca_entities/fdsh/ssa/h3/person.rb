# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Ssa
      module H3
        # Entity for Fdsh SSAVerification Request
        class Person < Dry::Struct

          attribute :PersonSSNIdentification, Types::String.meta(omittable: false)

          attribute :PersonName,              AcaEntities::Fdsh::Person::PersonName.meta(omittable: false)
          attribute :PersonBirthDate,         AcaEntities::Fdsh::Person::PersonBirthDate.meta(omittable: false)
        end
      end
    end
  end
end
