# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Atp
      # entity for atp PersonPreferredLanguage
      class PersonPreferredLanguage < Dry::Struct
        attribute :language_name, Types::String.optional.meta(omittable: true)
      end
    end
  end
end