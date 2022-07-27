# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Ios
      module Functions
        # build SSP_Benefits__c for IOS transform
        class SspBenefitsCBuilder
          include ::AcaEntities::Operations::Transforms::HashFunctions

          def call(cache)
            @memoized_data = cache

            application = @memoized_data.resolve('family.magi_medicaid_applications').item
            applicants = application[:applicants]
            applicants.map do |applicant|
              next unless applicant[:benefits] && applicant[:benefits].any?
              applicant[:benefits].map do |benefit|
                {
                  :BeginDate__c => benefit&.dig(:start_on),
                  :EndDate__c => benefit&.dig(:end_on),
                  :Id => applicant&.dig(:hbx_id)
                }
              end
            end.flatten.compact
          end
        end
      end
    end
  end
end