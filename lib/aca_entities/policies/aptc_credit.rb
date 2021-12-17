# frozen_string_literal: true

module AcaEntities
  module Policies
    # entity for AptcCredit
    class AptcCredit < Dry::Struct
      attribute :start_on,      Types::String.optional.meta(omittable: true)
      attribute :end_on,        Types::String.optional.meta(omittable: true)
      attribute :aptc,      Types::Float.optional.meta(omittable: true)
      attribute :pre_amt_tot,  Types::Float.optional.meta(omittable: true)
      attribute :tot_res_amt,  Types::Float.optional.meta(omittable: true)
    end
  end
end
