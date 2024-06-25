# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Pvc
      module Dmf
        module Response
          # Entity for IndividualRequest
          class PersonBirthDate < Dry::Struct

            attribute :Date, Types::Date.optional.meta(omittable: true)
          end
        end
      end
    end
  end
end