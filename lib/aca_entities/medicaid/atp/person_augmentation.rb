# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Atp
      # entity for atp PersonAugmentation
      class PersonAugmentation < Dry::Struct
        attribute :married_indicator, Types::Bool.optional.meta(omittable: true)
        attribute :preferred_languages, Types::Array.of(PersonPreferredLanguage).optional.meta(omittable: true) 
        attribute :contacts, Types::Array.of(PersonContactInformationAssociation).optional.meta(omittable: true) 
        attribute :persons, Types::Array.of(PersonAssociation).optional.meta(omittable: true)
      end
    end
  end
end