# frozen_string_literal: true

module AcaEntities
  module MagiMedicaid
    module Contracts
      # Contract for ApplicationReference.
      class ApplicationReferenceContract < Dry::Validation::Contract

        params do
          required(:hbx_id).filled(:string)
        end
      end
    end
  end
end
