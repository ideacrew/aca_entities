module AcaEntities
  module Eligible
    class ShopOsseEligibility < Dry::Struct
      include Eligible
      include Eligibility
      include History

      # attribute :due_on # additional attributes
      evidence :shop_osse_evidence, class_name: 'Eligible::ShopOsseEvidence'
      grant :shop_osse_grant, class_name: 'Eligible::ShopOsseGrant'
    end
  end
end
