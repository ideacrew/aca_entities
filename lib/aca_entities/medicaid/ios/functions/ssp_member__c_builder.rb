# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Ios
      module Functions
        # build SSP_Member__c for IOS transform
        class SspMemberCBuilder
          include ::AcaEntities::Operations::Transforms::HashFunctions

          # TODO: check on logic for ? mappings
          TAX_KINDS_MAP = { 'dependent' => 'D',
                            # ? => 'E'	Dependent of individual not in the household
                            'joint' => 'M',
                            'separate' => 'S',
                            'tax_filer' => 'H',
                            'single' => 'H',
                            # ? => 'A'	Not Applicable
                            'non_filer' => 'I' }.freeze

          CONTACT_METHOD_MAP = {
            # TO DO:
            # confirm types to use from EA and map to IOS codes
            # below types are from EA
            # ["Email", "Mail", "Text"] => "Paper, Electronic and Text Message communications",
            # ["Email", "Text"] => "Electronic and Text Message communications",
            # ["Email", "Mail"] => "Paper and Electronic communications",
            # ["Mail", "Text"] => "Paper and Text Message communications",
            # ["Text"] => "Only Text Message communication",
            # ["Mail"] => "Only Paper communication",
            # ["Email"] => "Only Electronic communications"
          }.freeze

          # TO DO: map to IOS living arrangement codes below
          # CH	Living in your home
          # AS	Away attending school
          # CO	Jail or Prison
          # DA	Drug/Alcohol Treatment Center
          # H	  Homeless
          # HS	Homeless Shelter
          # MI	Hospital
          # NF	Nursing Facility
          # YC	Youth Center (e.g. Long Creek Youth Development Center)
          # MA	Mental Health Facility (e.g Dorothea Dix, Riverview)
          # SB	Domestic Violence Shelter
          # SL	Sober Living Home
          LIVING_ARRANGEMENT_MAP = {

          }.freeze

          def call(cache)
            # TO DO
            # loop through applicants/people (?? depends on mappings)
            # build hash of field mappings
            # return array of SSP_Member__c hashes
            @memoized_data = cache

            family_members = @memoized_data.resolve('family.family_members_hash').item
            application = @memoized_data.resolve('family.magi_medicaid_applications').item
            applicants = application[:applicants]
            applicants.map do |applicant|
              # next unless applicant[:is_applying_coverage] <- TODO: uncomment (unless we are sending non-applicants?)
              family_member = family_members.values.detect {|family_member| family_member[:hbx_id] == applicant[:person_hbx_id]}
              contact_method = family_member.dig(:consumer_role, :contact_method)
              home_address = applicant[:addresses].detect {|address| address[:kind] == 'home'}
              mailing_address = applicant[:addresses].detect {|address| address[:kind] == 'mailing'}

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

              member_hash = {
                'FirstName__c' => applicant&.dig(:name, :first_name),
                'LATypeCode__c' => "",
                'PreferredNotificationMethodCode__c' => CONTACT_METHOD_MAP[contact_method],
                'TaxFilerMemberCurrent__r' => { 'IndividualId__c' => applicant&.dig(:claimed_as_tax_dependent_by, :person_hbx_id) }, # check if Id field should be used instead
                'LastName__c' => applicant&.dig(:name, :last_name),
                'MemberProgramsApplied__c' => true, # default value
                'IsFederalRecognizedIndianTribeToggle__c' => boolean_string(applicant&.dig(:indian_tribe_member)),
                'IsPregnant__c' => applicant&.dig(:pregnancy_information, :is_pregnant),
                'TaxFilerStatusCurrentYear__c' => TAX_KINDS_MAP[applicant&.dig(:tax_filer_kind)],
                'IsFixedAddressToggle__c' => !applicant&.dig(:is_homeless),
                'HasDifferentMailingAddress__c' => "", # check about logic on spreadsheet; does this actually map to same_with_primary?
                'PhysicalAddressLine1__c' => home_address&.dig(:address_1),
                'PhysicalAddressLine2__c' => home_address&.dig(:address_2),
                'PhysicalCity__c' => home_address&.dig(:city),
                'PhysicalStateCode__c' => home_address&.dig(:state),
                'PhysicalZipCode5__c' => home_address&.dig(:zip)&.split('-')&.at(0),
                'PhysicalZipCode4__c' => home_address&.dig(:zip)&.split('-')&.at(1),
                'PhysicalCountyCode__c' => home_address&.dig(:county),
                'MailingAddressLine1__c' => mailing_address&.dig(:address_1),
                'MailingAddressLine2__c' => mailing_address&.dig(:address_2),
                'MailingCity__c' => mailing_address&.dig(:city),
                'MailingStateCode__c' => mailing_address&.dig(:state),
                'MailingZipCode5__c' => mailing_address&.dig(:zip)&.split('-')&.at(0),
                'MailingZipCode4__c' => mailing_address&.dig(:zip)&.split('-')&.at(1),
                'MailingCountyCode__c' => mailing_address&.dig(:county)
              }

              # Use this if TaxFilerMemberCurrent__r is not actually required
              # if claimed_as_tax_dependent_by
              #   claimant_hash = {
              #     'TaxFilerMemberCurrent__r' => { 'Id' => applicant&.dig(:claimed_as_tax_dependent_by, :person_hbx_id) }
              #   }
              #   member_hash.merge!(claimant_hash)
              # end
              member_hash
            end
          end
        end
      end
    end
  end
end