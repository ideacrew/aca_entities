# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Ridp
      module H139
        # Contract for CurrentIncomeResponsePayloadType
        class CurrentIncomeResponsePayloadTypeContract < Dry::Validation::Contract
          params do
            optional(:response_Metadata_Type).maybe(Fdsh::Ridp::H139::ResponseMetadataTypeContract.params)
            optional(:response_Information).array(Fdsh::Ridp::H139::CurrentIncomeInfoTypeContract.params)
          end
        end
      end
    end
  end
end