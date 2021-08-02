# frozen_string_literal: true

require 'aca_entities/atp/transformers/aces/applicant'

module AcaEntities
  module Atp
    module Functions
      # build application and applicants
      class ApplicantBuilder
        def call(cache)
          applicants_hash = cache.resolve('family.magi_medicaid_applications.applicants').item
          applicants_hash.each_with_object([]) do |applicant_hash, collector|
            applicant = applicant_hash[1]

            collector << AcaEntities::Atp::Transformers::Aces::Applicant.transform(applicant)
          end
        end
      end
    end
  end
end
