# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Ifsv
      module H9t
        module Contracts
          module Api
            module Fti
              # FDSH schema and validation rules for {AcaEntities::Fdsh::Ifsv::H9t::Api::Fti::Household}
              class HouseholdContract < AcaEntities::Fdsh::Ifsv::H9t::Contracts::Contract
                # @!method call(opts)
                # @param [hash] opts the parameters to validate using this contract
                # @option opts [AcaEntities::Types::Money] :Income required
                # @option opts [Array<AcaEntities::Fdsh::Ifsv::H9t::Api::Fti::Verification>] :ApplicantVerification required
                # @option opts [Array<AcaEntities::Fdsh::Ifsv::H9t::Api::Fti::Verification>] :DependentVerification optional
                # @return [Dry::Monads::Result]
                params do
                  required(:Income).filled(AcaEntities::Types::Money)

                  required(:ApplicantVerification).array(
                    AcaEntities::Fdsh::Ifsv::H9t::Contracts::Api::Fti::VerificationContract
                      .params
                  )

                  optional(:DependentVerification).array(
                    AcaEntities::Fdsh::Ifsv::H9t::Contracts::Api::Fti::VerificationContract
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
end
