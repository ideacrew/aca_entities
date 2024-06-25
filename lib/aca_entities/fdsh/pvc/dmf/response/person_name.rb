# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Pvc
      module Dmf
        module Response
          # Entity for IndividualRequest
          class PersonName < Dry::Struct

            attribute :PersonGivenName, Types::String.optional.meta(omittable: true)
            attribute :PersonMiddleName, Types::String.optional.meta(omittable: true)
            attribute :PersonSurName, Types::String.optional.meta(omittable: true)
            attribute :PersonNameSuffixText, Types::String.optional.meta(omittable: true)

          end
        end
      end
    end
  end
end