# frozen_string_literal: true

module AcaEntities
  module Evidences
    # contract for CodeDescription
    class CodeDescriptionContract < Dry::Validation::Contract
      params do
        optional(:kind).maybe(:string)
        optional(:description).maybe(:string)
      end
    end
  end
end
