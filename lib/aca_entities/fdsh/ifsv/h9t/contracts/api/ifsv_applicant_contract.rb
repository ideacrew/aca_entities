# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Ifsv
      module H9t
        module Contracts
          module Api
            # FDSH schema and validation rules for {AcaEntities::Fdsh::Ifsv::H9t::Api::IFSVApplicant}
            class IFSVApplicantContract < AcaEntities::Fdsh::Ifsv::H9t::Contracts::Contract
              # @!method call(opts)
              # @param [hash] opts the parameters to validate using this contract
              # @option opts [AcaEntities::Fdsh::Ifsv::H9t::Api::Person] :Person required
              # @option opts [AcaEntities::Fdsh::Ifsv::H9t::Types::TaxFilerCategoryCodeKind] :TaxFilerCategoryCode required
              # @return [Dry::Monads::Result]
              params do
                required(:Person).value(
                  AcaEntities::Fdsh::Ifsv::H9t::Contracts::Api::PersonContract
                    .params
                )
                required(:TaxFilerCategoryCode).value(
                  AcaEntities::Fdsh::Ifsv::H9t::Types::TaxFilerCategoryCodeKind
                )
              end
            end
          end
        end
      end
    end
  end
end
