# frozen_string_literal: true

require 'dry/monads'
require 'dry/monads/do'
require 'securerandom'

# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Curam
      module MagiMedicaidEligibilityDeterminations
        # IngestMagiMedicaidEligibilityDetermination Command
        class IngestMagiMedicaidEligibilityDeterminationCommand < Sequent::Command
          attrs(
            aggregate_id: String,
            payload: String,
            magi_medicaid_eligibility_determination: MagiMedicaidEligibilityDeterminationValueObject,
            checksum: String
          )

          validates :payload, presence: true, allow_blank: false
          validates :checksum, presence: true, allow_blank: false
          validates :magi_medicaid_eligibility_determination, presence: true

          extend Dry::Monads[:result]

          def self.call(attrs = {})
            aggregate_id = SecureRandom.uuid
            checksum = Digest::SHA2.new(512).hexdigest(attrs[:payload]) + attrs[:payload].length.to_s
            command = new(
              attrs.merge(
                {
                  aggregate_id: aggregate_id,
                  checksum: checksum
                }
              )
            )
            if command.valid?
              Sequent.command_service.execute_commands command
              Success(
                MagiMedicaidEligibilityDeterminationRecordedResult.new({
                                                                         aggregate_id: aggregate_id,
                                                                         checksum: checksum
                                                                       })
              )
            else
              Failure(command.errors)
            end
          end
        end
      end
    end
  end
end