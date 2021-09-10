# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Rrv
      module Ifsv
        # Entity for RRV IfsvResponseCodeDetail
        class IfsvResponseCodeDetail < Dry::Struct
          attribute :ResponseCd, AcaEntities::Types::String.optional.meta(omittable: true)
          attribute :ResponseCodeDescription, AcaEntities::Types::String.optional.meta(omittable: true)
        end
      end
    end
  end
end