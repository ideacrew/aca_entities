# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Pvc
      module Medicare
        # Entity for IndividualRequest
        class IndividualRequest < Dry::Struct
          attribute :Applicant,  Fdsh::Pvc::Medicare::Applicant.meta(omittable: false)
          attribute :InsurancePolicy, Fdsh::Pvc::Medicare::InsurancePolicy.meta(omittable: false)
        end
      end
    end
  end
end