module AcaEntities
  module People
    module IvlOsseEligibility
      class AdminAttestedEvidence < Dry::Struct
        include AcaEntities::Eligible::Evidence
      end
    end
  end
end
