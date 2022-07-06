# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Ios
      module Functions
        # build SSP_Member__c for IOS transform
        class SspMemberCBuilder
          def call(cache)
            @memoized_data = cache

            application = @memoized_data.resolve('family.magi_medicaid_applications').item
            applicants = application[:applicants]
            applicants.map do |applicant|
              # next unless applicant[:is_applying_coverage] <- uncomment (unless we are sending non-applicants?)
              home_address = applicant[:addresses].detect {|address| address[:kind] == 'home'}
              mailing_address = applicant[:addresses].detect {|address| address[:kind] == 'mailing'}
              address = mailing_address || home_address

              {
                'MailingAddressLine1__c' => address[:address_1],
                'MailingCity__c' => address[:address_2],
                'MailingStateCode__c' => address[:state],
                'MailingZipCode5__c' => address[:zip]&.slice(/\d{5}/),
                'MailingAddressLine2__c' => address[:address_2],
                "breaking_key" => "should break"
              }

            end
            # TO DO
            # loop through applicants/people (?? depends on mappings)
            # call transform on individual applicant/person
            # return array of transformed members
          end
        end
      end
    end
  end
end