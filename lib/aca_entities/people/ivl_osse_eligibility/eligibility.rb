# frozen_string_literal: true

module AcaEntities
  module People
    module IvlOsseEligibility
      class Eligibility < Dry::Struct
        include AcaEntities::Eligible::Eligible
        include AcaEntities::Eligible::Eligibility

        # attribute :due_on # additional attributes

        evidence :ivl_osse_evidence,
                 class_name:
                   'AcaEntities::People::IvlOsseEligibility::AdminAttestedEvidence'
        grant :ivl_osse_grant,
              class_name: 'AcaEntities::People::IvlOsseEligibility::Grant'
      end
    end
  end
end
