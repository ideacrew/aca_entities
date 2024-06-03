# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Pvc
      module Dmf
        module Request
          # A unique reference to a living person; assigned by the United States Social Security Administration
          class PersonSsnIdentification < Dry::Struct
            # @!attribute [r] IdentificationID
            # A data type for a representation of an identity
            # @return [String]
            attribute :SSNIdentification, Types::String.meta(omittable: false)
          end
        end
      end
    end
  end
end
