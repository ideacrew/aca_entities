# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Rrv
      module Ifsv
        # Contract for RRV Medicare
        class ErrorMessageDetailContract < Dry::Validation::Contract
          params do
            required(:ErrorMessageCd).filled(:string)
            optional(:ErrorMessageTxt).filled(:string)
            optional(:XpathContent).filled(:string)
          end
        end
      end
    end
  end
end