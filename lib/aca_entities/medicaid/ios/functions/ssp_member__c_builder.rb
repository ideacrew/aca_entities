# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Ios
      module Functions
        # build SSP_Member__c for IOS transform
        class SspMemberCBuilder
          def call(cache)
            # TO DO
            # loop through applicants/people (?? depends on mappings)
            # build hash of field mappings
            # return array of SSP_Member__c hashes
            @memoized_data = cache
            application = @memoized_data.resolve('family.magi_medicaid_applications').item
            applicants = application[:applicants]
            applicants.map do |applicant|
              # next unless applicant[:is_applying_coverage] <- TODO: uncomment (unless we are sending non-applicants?)
              home_address = applicant[:addresses].detect {|address| address[:kind] == 'home'}
              mailing_address = applicant[:addresses].detect {|address| address[:kind] == 'mailing'}
              address = mailing_address || home_address

              # REQUIRED FIELDS
              # FirstName__c: "Jane",
              # LATypeCode__c: "Code",
              # PreferredNotificationMethodCode__c: "email",
              # TaxFilerMemberCurrent__r: { IndividualId__c: 129 },
              # LastName__c: "Doe",
              # MemberProgramsApplied__c: "MA",
              # IsFederalRecognizedIndianTribeToggle__c: "N",
              # IsPregnant__c: "N",
              # TaxFilerStatusCurrentYear__c: "S",
              # IsFixedAddressToggle__c: "N",
              # HasDifferentMailingAddress__c: "N"
              {
                'MailingAddressLine1__c' => address[:address_1],
                'MailingCity__c' => address[:address_2],
                'MailingStateCode__c' => address[:state],
                'MailingZipCode5__c' => address[:zip]&.slice(/\d{5}/),
                'MailingAddressLine2__c' => address[:address_2]
              }

            end
          end
        end
      end
    end
  end
end