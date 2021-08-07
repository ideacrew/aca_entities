# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Ifsv
      module H9t
        module Contracts
          # Inheritence Contract Class
          class Contract < Dry::Validation::Contract
            register_macro(:fdsh_request_id_format) do
              unless /^[0-9]{1,9}$/.match?(value)
                key.failure(
                  "Invalid RequestID format: #{value}. Must be numeric, 1-9 characters in length"
                )
              end
            end
          end
        end
      end
    end
  end
end
