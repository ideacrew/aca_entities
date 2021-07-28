# frozen_string_literal: true

require_relative 'date_contract'

module AcaEntities
  module Medicaid
    module Contracts
      # SignatureDate information contract
      class SignatureDateContract < DateContract
        params do
          # date field required for signature date entity
          required(:date).filled(:date)
        end
      end
    end
  end
end