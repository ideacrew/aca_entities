# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Rrv
      module Ifsv
        # Contract for RRV Medicare
        class IfsvResponseCodeDetailContract < Dry::Validation::Contract
          params do
            required(:ResponseCd).filled(:string)
            required(:ResponseCodeDescription).filled(:string)
          end
        end
      end
    end
  end
end