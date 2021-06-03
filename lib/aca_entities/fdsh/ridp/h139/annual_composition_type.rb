# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Ridp
      module H139
        # Entity for AnnualCompensationType
        class AnnualCompensationType < Dry::Struct

          attribute :annual_compensation_information,
                    Types::Array.of(Fdsh::Ridp::H139::AnnualCompensationInformationType).optional.meta(omittable: true)

        end
      end
    end
  end
end