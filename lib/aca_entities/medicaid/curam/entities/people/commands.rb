# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Curam
      module People
        module Commands
          # create person command
          class CreatePerson < Sequent::Command
            attrs aggregate_id: String, person: PersonValueObject

            include ::Curam::Commands::QuackLikeACreateOperation
          end

          class UpdatePerson < Sequent::Command
            attrs aggregate_id: String, person: PersonValueObject

            include ::Curam::Commands::QuackLikeAnOperation
          end
        end
      end
    end
  end
end