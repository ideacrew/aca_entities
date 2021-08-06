# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Ifsv
      module H9t
        module Contracts
          module Api
            # FDSH schema and validation rules for {AcaEntities::Fdsh::Ifsv::H9t::Request}
            class RequestContract < AcaEntities::Fdsh::Ifsv::H9t::Contracts::Contract
              # @!method call(opts)
              # @param [Hash] opts the parameters to validate using this contract
              # @option opts [Date] :person_name optional
              # @option opts [AcaEntities::Fdsh::Ifsv::H3::Types::TaxFilerCategoryTypeCode] :tax_filer_category_code
              # @return [Dry::Monads::Result]
              params do
                required(:RequestID).filled(format?: /^[0-9]{1,9}$/)
                required(:IFSVApplicant).hash do
                  required(:Person).hash do
                    required(:PersonName).value(
                      AcaEntities::Fdsh::Contracts::Person::PersonNameContract
                        .params
                    )
                    required(:PersonSSNIdentification).value(
                      AcaEntities::Fdsh::Contracts::Person::PersonSSNIdentificationContract
                        .params
                    )
                  end
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
end
