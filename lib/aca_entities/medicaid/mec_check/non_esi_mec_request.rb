# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module MecCheck
      # entity for NonEsiMecRequest
      class NonEsiMecRequest < Dry::Struct
        attribute :non_esi_mec_individual_information, NonEsiMecIndividualInformation.meta(omittable: false)
      end
    end
  end
end