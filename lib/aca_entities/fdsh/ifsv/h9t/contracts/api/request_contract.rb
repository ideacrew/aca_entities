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
                required(:RequestID).filled(:string)

                # required(:RequestID).filled(format?: /^[0-9]{1,9}$/)
                required(:IFSVApplicants).array(
                  AcaEntities::Fdsh::Ifsv::H9t::Contracts::Api::IFSVApplicantContract
                    .params
                )
              end

              rule(:RequestID).validate(:fdsh_request_id_format)
            end
          end
        end
      end
    end
  end
end