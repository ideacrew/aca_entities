# frozen_string_literal: true

module AcaEntities
  module Eligibilities
    module Osse
      module Contracts
        # contract for { Subject }
        class SubjectContract < Dry::Validation::Contract
          params do
            # required(:gid).filled(type?: URI)
            required(:title).filled(:string)
            optional(:description).maybe(:hash)
            required(:key).maybe(type?: URI)
            required(:klass).filled(:string)
          end
        end
      end
    end
  end
end
