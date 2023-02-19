# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module H36
      # Entity for h36 CompletePersonName
      class CompletePersonName < Dry::Struct
        attribute :PersonFirstName,  AcaEntities::Types::String.meta(omittable: false)
        attribute :PersonMiddleName, AcaEntities::Types::String.optional.meta(omittable: true)
        attribute :PersonLastName,  AcaEntities::Types::String.meta(omittable: false)
        attribute :SuffixName, AcaEntities::Types::String.optional.meta(omittable: true)
      end
    end
  end
end
