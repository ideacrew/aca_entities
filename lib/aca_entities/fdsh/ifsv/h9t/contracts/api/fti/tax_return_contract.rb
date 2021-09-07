# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Ifsv
      module H9t
        module Contracts
          module Api
            module Fti
              # FDSH schema and validation rules for {AcaEntities::Fdsh::Ifsv::H9t::Api::Fti::TaxReturn}
              class TaxReturnContract < AcaEntities::Fdsh::Ifsv::H9t::Contracts::Contract
                # @!method call(opts)
                # @param [hash] opts the parameters to validate using this contract
                # @option opts [AcaEntities::Fdsh::Types::FullyRestrictedSSNType] :PrimaryTaxFiler required
                # @option opts [AcaEntities::Fdsh::Types::FullyRestrictedSSNType] :SpouseTaxFiler required
                # @option opts [AcaEntities::Fdsh::Ifsv::H9t::Types::TaxReturnYearType] :TaxReturnYear required
                # @option opts [AcaEntities::Fdsh::Ifsv::H9t::Types::TaxReturnFilingStatusCodeKind] :TaxReturnFilingStatusCode required
                # @option opts [AcaEntities::Types::Money] :TaxReturnAGIAmount required
                # @option opts [AcaEntities::Types::Money] :TaxReturnMAGIAmount required
                # @option opts [AcaEntities::Types::Money] :TaxReturnTaxableSocialSecurityBenefitsAmount required
                # @option opts [AcaEntities::Types::Integer] :TaxReturnTotalExemptionsQuantity required
                # @return [Dry::Monads::Result]
                params do
                  required(:PrimaryTaxFiler).hash do
                    required(:TINIdentification).value(
                      AcaEntities::Fdsh::Types::FullyRestrictedSSNType
                    )
                  end

                  optional(:SpouseTaxFiler).hash do
                    optional(:TINIdentification).maybe(
                      AcaEntities::Fdsh::Types::FullyRestrictedSSNType
                    )
                  end

                  optional(:TaxReturnYear).maybe(
                    AcaEntities::Fdsh::Ifsv::H9t::Types::TaxReturnYearType
                  )

                  optional(:TaxReturnFilingStatusCode).maybe(
                    AcaEntities::Fdsh::Ifsv::H9t::Types::TaxReturnFilingStatusCodeKind
                  )

                  optional(:TaxReturnAGIAmount).maybe(AcaEntities::Types::Money)
                  optional(:TaxReturnMAGIAmount).maybe(AcaEntities::Types::Money)
                  optional(:TaxReturnTaxableSocialSecurityBenefitsAmount).maybe(
                    AcaEntities::Types::Money
                  )

                  optional(:TaxReturnTotalExemptionsQuantity).maybe(
                    AcaEntities::Types::Integer
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
