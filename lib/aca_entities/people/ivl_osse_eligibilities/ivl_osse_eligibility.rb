# frozen_string_literal: true

module AcaEntities
  module People
    module IvlOsseEligibilities
      class IvlOsseEligibility < AcaEntities::Eligible::Eligibility

        # attribute :due_on # additional attributes

        evidence :ivl_osse_evidence,
                 class_name:
                   'AcaEntities::People::IvlOsseEligibilities::AdminAttestedEvidence'
        grant :ivl_osse_grant,
              class_name: 'AcaEntities::People::IvlOsseEligibilities::IvlOsseGrant'
      end
    end
  end
end
