# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Ios
      module Functions
        # build SspApplicationCBuilder for IOS transform
        class SspApplicationCBuilder
          include ::AcaEntities::Operations::Transforms::HashFunctions
          def call(cache)
            @memoized_data = cache
            application = @memoized_data.resolve('family.magi_medicaid_applications').item
            primary_applicant = application[:applicants].detect {|applicant| applicant[:is_primary_applicant]}
            anyone_enrolled = false
            applicants = application[:applicants]
            applicants.map do |applicant|
              next unless (applicant[:benefits]) &&
                          (applicant[:benefits].detect {|benefits| benefits[:kind] == 'employer_sponsored_insurance'}) &&
                          (applicant[:benefits].detect {|benefits| benefits[:status] != 'is_enrolled'})
              anyone_enrolled = true
            end
            {
              'ApplicationEsignFirstName__c' => primary_applicant[:name][:first_name],
              'ApplicationEsignMiddleInitial__c' => primary_applicant[:name][:middle_name],
              'ApplicationEsignLastName__c' => primary_applicant[:name][:last_name],
              'NotEnrolledInHealthCareCoverageToggle__c' => boolean_string(anyone_enrolled)
            }
          end
        end
      end
    end
  end
end