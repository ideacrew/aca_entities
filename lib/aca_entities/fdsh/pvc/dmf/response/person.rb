# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Pvc
      module Dmf
        module Response
          # Entity for IndividualRequest
          class Person < Dry::Struct

            attribute :PersonSSNIdentification, Fdsh::Pvc::Dmf::Response::PersonSSNIdentification.optional.meta(omittable: true)
            attribute :PersonName, Fdsh::Pvc::Dmf::Response::PersonName.optional.meta(omittable: true)
            attribute :PersonBirthDate, Fdsh::Pvc::Dmf::Response::PersonBirthDate.optional.meta(omittable: true)
            attribute :PersonDeathDate, Fdsh::Pvc::Dmf::Response::PersonDeathDate.optional.meta(omittable: true)
          end
        end
      end
    end
  end
end