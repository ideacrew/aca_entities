# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Sim
      module Ee
        module Vlp
          # Entity for Fdsh Vlp Agency3InitVerifRequestSetType
          class Agency3InitVerifRequestSetType < Dry::Struct

            attribute :dhsid,                                Types::Strict::String.meta(omittable: false)  # TODO: types id
            attribute :firstName,                            Types::Strict::String.meta(omittable: false)
            attribute :middleName,                           Types::Strict::String.meta(omittable: true)
            attribute :lastName,                             Types::Strict::String.meta(omittable: false)
            attribute :dateOfBirth,                          Types::Strict::Date.meta(omittable: false)
            attribute :aka,                                  Types::Strict::String.meta(omittable: true)
            attribute :i94Number,                            Types::Strict::String.meta(omittable: true)
            attribute :comments,                             Types::Strict::String.meta(omittable: true)
            attribute :requestedCoverageStartDate,           Types::Strict::Date.meta(omittable: true)
            attribute :fiveYearBarApplicabilityIndicator,    Types::Strict::Bool.meta(omittable: true)
            attribute :requestSponsorDataIndicator,          Types::Strict::Bool.meta(omittable: true)
            attribute :requestGrantDateIndicator,            Types::Strict::Bool.meta(omittable: true)
            attribute :requesterCommentsForHub,              Types::Strict::String.meta(omittable: true)
            attribute :categoryCode,                         Types::Strict::String.meta(omittable: true)

          end
        end
      end
    end
  end
end