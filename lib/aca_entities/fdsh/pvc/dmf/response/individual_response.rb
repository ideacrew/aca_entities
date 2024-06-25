# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Pvc
      module Dmf
        module Response
          # Entity for IndividualRequest
          class IndividualResponse < Dry::Struct
            attribute :Person, Fdsh::Pvc::Dmf::Response::Person.optional.meta(omittable: true)
            attribute :SSAVerificationSupplement, Fdsh::Pvc::Dmf::Response::SSAVerificationSupplement.optional.meta(omittable: true)
          end
        end
      end
    end
  end
end