# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Rrv
      module Ifsv
        # Entity for RRV IFSV ErrorMessageDetail
        class ErrorMessageDetail < Dry::Struct
          attribute :ErrorMessageCd, AcaEntities::Types::String.meta(omittable: false)
          attribute :ErrorMessageTxt, AcaEntities::Types::String.optional.meta(omittable: true)
          attribute :XpathContent, AcaEntities::Types::String.optional.meta(omittable: true)
        end
      end
    end
  end
end