# frozen_string_literal: true

module AcaEntities
  module People
    module IvlOsseEligibility
      class Grant < Dry::Struct
        include AcaEntities::Eligible::Grant
      end
    end
  end
end
