# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Rrv
      module Medicare
        # Entity for IndividualRequest
        class IndividualRequest < Dry::Struct
          attribute :Applicant,  Fdsh::Rrv::Medicare::Applicant.meta(omittable: false)
          attribute :InsurancePolicy, Fdsh::Rrv::Medicare::InsurancePolicy.meta(omittable: false)
        end
      end
    end
  end
end