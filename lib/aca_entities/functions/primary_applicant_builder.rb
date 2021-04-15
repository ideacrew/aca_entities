# frozen_string_literal: true

# rubocop:disable Style/HashConversion
module AcaEntities
  module Functions
    # builds hash for primary and non primary applicant
    class PrimaryApplicantBuilder
      def self.call(name, data)
        Hash[name, data.values.first]
      end

    end
  end
end

# rubocop:enable Style/HashConversion