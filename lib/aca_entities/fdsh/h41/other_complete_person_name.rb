# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module H41
      # Entity for h41 OtherCompletePersonName
      class OtherCompletePersonName
        attribute :PersonFirstNm,  AcaEntities::Types::String.meta(omittable: false)
        attribute :PersonMiddleNm, AcaEntities::Types::String.optional.meta(omittable: true)
        attribute :PersonLastNm,  AcaEntities::Types::String.meta(omittable: false)
        attribute :SuffixNm, AcaEntities::Types::String.optional.meta(omittable: true)
      end
    end
  end
end
