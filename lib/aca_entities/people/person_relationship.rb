# frozen_string_literal: true

module AcaEntities
  module People
    class PersonRelationship < Dry::Struct
      attribute :relative,                              AcaEntities::People::PersonReference.meta(omittable: false)
      attribute :kind,                                  Types::String.optional.meta(omittable: false)
    end
  end
end
