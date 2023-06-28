module Eligible
  class ShopOsseEligibility < Dry::Struct
    include Eligible::Eligible
    include Eligible::Eligibility

    attribute :due_on # additional attributes

    evidences :shop_osse_eligibility
    grants :shop_osse_grant
  end
end