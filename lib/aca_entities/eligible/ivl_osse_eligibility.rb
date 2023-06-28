module Eligible
  class IvlOsseEligibility < Dry::Struct
    include Eligible
    include Eligibility
    include History

    attribute :due_on # additional attributes

    evidence :ivl_osse_evidence, class_name: 'AcaEntities::Eligible::IvlOsseEvidence'
    grant :ivl_osse_grant, class_name: 'AcaEntities::Eligible::IvlOsseGrant'
  end
end
