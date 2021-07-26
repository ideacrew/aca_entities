# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Vlp
      module H92
        # Entity for Fdsh Vlp ArrayOfSponsorshipData
        class ArrayOfSponsorshipData < Dry::Struct

          attribute :SponsorshipData,    Types::Array.of(Fdsh::Vlp::H92::SponsorshipData).meta(omittable: false)
        end
      end
    end
  end
end