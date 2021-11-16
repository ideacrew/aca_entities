# frozen_string_literal: true

module AcaEntities
  module Policies
    # entity for AptcCredit
    class AptcCredit < Dry::Struct
      attribute :start_on,      Types::Date.optional.meta(omittable: true)
      attribute :end_on,        Types::Date.optional.meta(omittable: true)
      attribute :aptc,      Types::Decimal.optional.meta(omittable: true)
      attribute :pre_amt_tot,  Types::Decimal.optional.meta(omittable: true)
      attribute :tot_res_amt,  Types::Decimal.optional.meta(omittable: true)
    end
  end
end
