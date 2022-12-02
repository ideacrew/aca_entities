# frozen_string_literal: true

module AcaEntities
  module Locations
    module Addresses
      module Smarty
        module Contracts
          # Schema and validation rules for {AcaEntities::Locations::Smarty::Lookup}
          class LookupContract < Contract
            # @!method call(opts)
            # @param [Hash] opts the parameters to validate using this contract
            # @option opts [String] :input_id optional
            # @option opts [String] :street optional
            # @option opts [String] :street2 optional
            # @option opts [String] :secondary optional
            # @option opts [String] :city optional
            # @option opts [String] :state optional
            # @option opts [String] :zipcode optional
            # @option opts [String] :lastline optional
            # @option opts [String] :addressee optional
            # @option opts [String] :urbanization optional
            # @option opts [Integer] :candidates optional
            # @option opts [Locations::Addresses::Smarty::Types::AddressMatchKind] :match optional
            # @return [Dry::Monads::Result]
            params do
              optional(:input_id).maybe(:string)
              required(:street).filled(:string)
              optional(:street2).value(:string)
              optional(:secondary).maybe(:string)
              optional(:city).maybe(:string)
              optional(:state).maybe(:string)
              optional(:zipcode).maybe(:string)
              optional(:lastline).maybe(:string)
              optional(:addressee).maybe(:string)
              optional(:urbanization).value(:string)
              optional(:candidates).maybe(:integer)
              optional(:match).maybe(Locations::Addresses::Smarty::Types::AddressMatchKind)
            end
          end
        end
      end
    end
  end
end
