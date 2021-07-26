# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Vlp
      module H92
        # Entity for Fdsh Vlp SponsorshipData
        class ArrayOfSponsorshipDataContract < Dry::Validation::Contract
          params do
            required(:SponsorshipData).array(Fdsh::Vlp::H92::SponsorshipDataContract.params)
          end
        end
      end
    end
  end
end