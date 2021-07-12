# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Contracts
      # Contract for Incarceration
      class IncarcerationContract < Dry::Validation::Contract

        params do
          optional(:metadata).maybe(:string)
          optional(:incarceration_date).maybe(:hash)
          optional(:incarceration_indicator).maybe(:bool)
        end
      end
    end
  end
end
