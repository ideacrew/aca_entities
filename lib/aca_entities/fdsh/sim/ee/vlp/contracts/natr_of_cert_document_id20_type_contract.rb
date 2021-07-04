# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Sim
      module Ee
        module Vlp
          # Entity for Fdsh Vlp NatrOfCertDocumentID20Type
          class NatrOfCertDocumentID20TypeContract < Dry::Validation::Contract
            params do
              required(:naturalizationNumber).filled(:string)
              optional(:alienNumber).maybe(:string)
            end
          end
        end
      end
    end
  end
end