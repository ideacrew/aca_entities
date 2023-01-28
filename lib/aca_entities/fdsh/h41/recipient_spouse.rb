# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module H41
      # Entity for h41 RecipientSpouse
      class RecipientSpouse
        attribute :OtherCompletePersonName,  AcaEntities::Fdsh::H41::OtherCompletePersonName.meta(omittable: false)
        attribute :SSN,  AcaEntities::Types::String.optional.meta(omittable: true)
        attribute :BirthDt,  AcaEntities::Types::Date.optional.meta(omittable: true)
      end
    end
  end
end
