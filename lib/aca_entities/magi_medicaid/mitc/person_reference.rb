# frozen_string_literal: true

module AcaEntities
  module MagiMedicaid
    module Mitc
      class PersonReference < Dry::Struct

        attribute :person_id,  Types::String.meta(omitttable: false)

      end
    end
  end
end
