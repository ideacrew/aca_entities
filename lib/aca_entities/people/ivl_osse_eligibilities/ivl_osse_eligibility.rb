# frozen_string_literal: true

module AcaEntities
  module People
    module IvlOsseEligibilities
      class IvlOsseEligibility < AcaEntities::Eligible::Eligibility
        include AcaEntities::Eligible::Eligible
  
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
