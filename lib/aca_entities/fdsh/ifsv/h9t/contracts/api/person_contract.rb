# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Ifsv
      module H9t
        module Contracts
          module Api
            # FDSH schema and validation rules for {AcaEntities::Fdsh::Ifsv::H9t::Api::Person}
            class PersonContract < AcaEntities::Fdsh::Ifsv::H9t::Contracts::Contract
              # @!method call(opts)
              # @param [hash] opts the parameters to validate using this contract
              # @option opts [AcaEntities::Fdsh::Person::PersonName] :PersonName required
              # @option opts [AcaEntities::Fdsh::Person::PersonSSNIdentification] :PersonSSNIdentification required
              # @return [Dry::Monads::Result]
              params do
                required(:PersonName).value(
                  AcaEntities::Fdsh::Contracts::Person::PersonNameContract
                    .params
                )
                required(:PersonSSNIdentification).value(
                  AcaEntities::Fdsh::Contracts::Person::PersonSSNIdentificationContract
                    .params
                )
              end
            end
          end
        end
      end
    end
  end
end
