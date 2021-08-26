# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Ridp
      module H139
        # Entity for CurrentIncomeResponsePayloadType
        class CurrentIncomeResponsePayloadType < Dry::Struct

          attribute :response_Metadata_Type,   Fdsh::Ridp::H139::ResponseMetadataType.optional.meta(omittable: true)
          attribute :response_Information,     Types::Array.of(Fdsh::Ridp::H139::CurrentIncomeInfoType).optional.meta(omittable: true)
        end
      end
    end
  end
end