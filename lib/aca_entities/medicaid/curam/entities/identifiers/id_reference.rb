# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Curam
      module Identifiers
        # entity for id reference
        class IdReference < Dry::Struct

          attribute :source_system_key, Types::String.optional.meta(omittable: true)
          attribute :ids,               Types::Array.of(Curam::Identifiers::Id).optional.meta(omittable: true)
        end
      end
    end
  end
end
