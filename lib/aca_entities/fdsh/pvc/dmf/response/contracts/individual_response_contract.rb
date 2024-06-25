# frozen_string_literal: true

#   {
#     :IndividualResponses => [
#       {
#         :Person => {
#           :PersonSSNIdentification => {
#             :SSNIdentification => "100101000"
#           },
#           :PersonName => {
#             :PersonGivenName => "PersonGivenName0",
#             :PersonMiddleName => "PersonMiddleName0",
#             :PersonSurName => "PersonSurName0",
#             :PersonNameSuffixText => "Pers"
#           },
#           :PersonBirthDate => {
#             :Date => "2006-05-04"
#           },
#           :PersonDeathDate => {
#             :Date => "2006-05-04"
#           }
#         },
#         :SSAVerificationSupplement => {
#           :DeathConfirmationCode => "Confirmed"
#         }
#       }
#     ]
#   }
module AcaEntities
  module Fdsh
    module Pvc
      module Dmf
        module Response
          module Contracts

            # Contract for PVC IndividualResponseContract
            class IndividualResponseContract < Dry::Validation::Contract
              params do
                required(:Person).hash(AcaEntities::Fdsh::Pvc::Dmf::Response::Contracts::PersonContract.params)
                required(:SSAVerificationSupplement).hash(AcaEntities::Fdsh::Pvc::Dmf::Response::Contracts::SSAVerificationSupplementContract.params)
              end
            end
          end
        end
      end
    end
  end
end