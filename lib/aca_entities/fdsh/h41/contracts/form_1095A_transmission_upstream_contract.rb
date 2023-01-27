# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module H41
      module Contracts
        # Contract for H41 Form1095ATransmissionUpstreamContract
        class Form1095ATransmissionUpstreamContract < Dry::Validation::Contract
          params do
            required(:Form1095AUpstreamDetail).array(
              AcaEntities::Fdsh::H41::Contracts::Form1095AUpstreamDetailContract.params
            )
          end
        end
      end
    end
  end
end