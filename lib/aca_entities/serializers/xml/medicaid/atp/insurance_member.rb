# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module Medicaid
        module Atp
          # A person who has health insurance coverage.
          # (An insurance member is called a beneficiary when Centers for Medicare & Medicaid Services provides the coverage).
          class InsuranceMember
            include HappyMapper

            tag 'InsuranceMember'
            namespace 'hix-ee'

            # An identification for a member of a Medicaid program.
            element :medicaid_identification, MedicaidIdentification

            # An identification for a member of a CHIP program.
            element :chip_identification, ChipIdentification

            def self.domain_to_mapper(insurance_member)
              mapper = self.new
              mapper.medicaid_identification = MedicaidIdentification.domain_to_mapper(insurance_member.medicaid_identification)
              mapper.chip_identification = ChipIdentification.domain_to_mapper(insurance_member.chip_identification)
              mapper
            end

            def to_hash
              {
                medicaid_identification: medicaid_identification,
                chip_identification: chip_identification
              }
            end
          end
        end
      end
    end
  end
end