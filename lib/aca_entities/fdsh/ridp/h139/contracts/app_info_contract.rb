# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Ridp
      module H139
        # Contract for FarsRequest
        class AppInfoContract < Dry::Validation::Contract

          params do
            required(:applies_to).schema do
              required(:name).filled(:string)
              optional(:namespace).maybe(:string)
            end

            required(:base).schema do
              required(:name).filled(:string)
              optional(:namespace).maybe(:string)
            end

            required(:reference_target).schema do
              required(:name).filled(:string)
              optional(:namespace).maybe(:string)
            end

            required(:deprecated).schema do
              required(:value).filled(:bool)
            end

            required(:resource).schema do
              required(:name).filled(:string)
            end

            optional(:conformant_indicator).maybe(:bool)
            optional(:external_adapter_type_indicator).maybe(:bool)
            optional(:augmented_type_indicator).maybe(:bool)
            optional(:augmented_element_indicator).maybe(:bool)
          end
        end
      end
    end
  end
end