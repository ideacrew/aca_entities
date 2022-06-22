# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Ios
      # entity for ios RecordType
      class RecordType < Dry::Struct
        attribute :DeveloperName, Types::String.optional.meta(omittable: true)
      end
    end
  end
end