# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Ifsv
      module H3
        module Contracts
          # FDSH schema and validation rules for {AcaEntities::Fdsh::Person::PersonName}
          class IfsvRequestContract < Contract
            # @!method call(opts)
            # @param [Hash] opts the parameters to validate using this contract
            # @option opts [Date] :person_name optional
            # @option opts [AcaEntities::Fdsh::Ifsv::H3::Types::TaxFilerCategoryTypeCode] :tax_filer_category_code
            # @return [Dry::Monads::Result]
            params do
              required(:RequestID).filled(format?: /^[0-9]{1,9}$/)
              required(:IFSVAppliant).value(:string)
              required(:Person).hash do
                # required(:PersonName).value(
                #   AcaEntities::Fdsh::Person::PersonName
                # )
                required(:TaxFilerCategoryCode).value(
                  AcaEntities::Fdsh::Ifsv::H3::Types::TaxFilerCategoryCodeKind
                )
              end
            end
          end
        end
      end
    end
  end
end
