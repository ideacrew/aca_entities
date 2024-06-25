# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Pvc
      module Dmf
        module Response
          module Contracts

            # Contract for PVC IndividualResponseContract
            class PersonContract < Dry::Validation::Contract
              params do
                required(:PersonSSNIdentification).hash(AcaEntities::Fdsh::Pvc::Dmf::Response::Contracts::PersonSSNIdentificationContract.params)
                required(:PersonName).hash(AcaEntities::Fdsh::Pvc::Dmf::Response::Contracts::PersonNameContract.params)
                required(:PersonBirthDate).hash(AcaEntities::Fdsh::Pvc::Dmf::Response::Contracts::PersonBirthDateContract.params)
                required(:PersonDeathDate).hash(AcaEntities::Fdsh::Pvc::Dmf::Response::Contracts::PersonDeathDateContract.params)
              end
            end
          end
        end
      end
    end
  end
end