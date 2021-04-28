# frozen_string_literal: true

# This file defines the maps
module AcaEntities
  module Operations
    module TransformExamples
      module McrTo
        # Transform Keys and Values
        class CvInput < ::AcaEntities::Operations::Transforms::Transform
          include ::AcaEntities::Operations::Transforms::Transformer

          record_delimiter 'applications.identifier.result'
          # source_vocabulary :mcr

          AgeOn = AcaEntities::Functions::AgeOn.new(on_date: "2020-1-1")

          map 'coverageYear', 'family.magi_medicaid_applications.assistance_year'

          namespace 'attestations' do
            rewrap 'family', type: :hash do
              # map "insuranceApplicationIdentifier", "insurance_application_identifier"

              # add_key 'hbx_id', ''
              # map 'renewEligibilityYearQuantity', 'renewal_consent_through_year'
              # add_key 'min_verifications_due_date'
              # add_key 'special_enrollment_periods'
              # add_key 'irs_groups'
              # add_key 'broker_agency_accounts'
              # add_key 'general_agency_accounts'
              # add_key 'documents'
              # add_key 'payment_transactions'
              map 'application.contactMemberIdentifier', 'family.family_members.is_primary_applicant',
                  { memoize: true, function: AcaEntities::Functions::PrimaryApplicantBuilder }

              namespace 'members.*', nil, context: { name: 'members' } do
                rewrap 'family.family_members', type: :array do
                  # add_key 'hbx_id', ''
                  # add_key 'is_primary_applicant', ->(v) { v.resolve('family.family_members.is_primary_applicant').item == v.resolve(:members).item }
                  # map 'requestingCoverageIndicator', 'is_coverage_applicant'

                  namespace 'demographic' do
                    rewrap 'family.family_members.person', type: :hash do
                      # add_key 'hbx_id', ''
                      # add_key 'emails', -> v { v.context(:primary_contact_information).emails }
                      # add_key 'phones', -> v { v.context(:primary_contact_information).phones }
                      # add_key 'person_relationships', -> v { v.context(:person_relationships).person_relationships }

                      # add_namespace 'identifiers', 'family.family_members.person.identifiers', type: :array do
                      #   add_key 'source_system_key', 'ccr' # source_vocabulary

                      #   add_namespace 'ids', 'family.family_members.person.identifiers.ids', type: :array do
                      #     add_key 'key', ->(v) { v.resolve(:members).name } # should be derived based on context
                      #     add_key 'item', ->(v) { v.resolve(:members).item } # should pick id from the source payload
                      #   end
                      # end

                      # namespace 'name' do
                      #   rewrap 'family.family_members.person.person_name', type: :hash do
                      #     map 'firstName', 'first_name', context: { name: 'first_name' }
                      #     map 'lastName', 'last_name', context: { name: 'last_name' }
                      #      add_key 'full_name', ->(v) { [v.resolve(:first_name).item, v.resolve(:last_name).item].join(" ") }
                      #   end
                      # end


                      map 'ssn', 'person_demographics.ency', :nest
                      # map 'sex', 'person_demographics.sex', :nest,->(value) { value.to_s.downcase }
                      # map 'birthDate', 'person_demographics.birthDate', :nest, AgeOn
                      # add_key 'person_demographics.ethnicity'
                      # add_key 'person_demographics.race'
                      # add_key 'person_demographics.tribal_id'
                      # add_key 'person_demographics.no_ssn', 'false'

                      # map 'americanIndianAlaskanNativeIndicator', 'americanIndianAlaskanNativeIndicator'

                      # # # map 'type', 'kind',  '-> (value){ value.to_s.downcase }'
                      # # map 'sex', 'gender', ->(value) { value.to_s.downcase }

                      # # # # map 'incarcerationType', 'is_incarcerated',  '-> (value){ AcaEntities::Types::McrToCvIncarcerationKind[value] }'
                      # # # # map 'computed.members.*.ssnStatusReason', 'no_ssn'
                      # # # map 'blindOrDisabledIndicator', 'is_disabled'
          
                      # # # add_key 'language_code' , "default: en"
                      # map 'noHomeAddressIndicator', 'is_homeless'
                      # map 'liveOutsideStateTemporarilyIndicator', 'is_temporarily_out_of_state'

                      # namespace 'mailingAddress' do
                      #   rewrap 'family.family_members.person.addresses', type: :array do
                      #     # add_key 'has_fixed_address'
                      #     # map 'mailingAddress', 'kind'
                      #     add_key 'kind', 'mailing'
                      #     map 'streetName1', 'address_1'
                      #     # add_key 'address_2'
                      #     map 'cityName', 'city' #
                      #     map 'countyName', 'county'
                      #     map 'countyFipsCode', 'county_code'
                      #     map 'stateCode', 'state'
                      #     map 'zipCode', 'zip'
                      #     map 'countryCode', 'country_name'
                      #     # add_key 'validation_status'
                      #     # add_key 'start_on'
                      #     # add_key 'end_on'
                      #     # map 'liveOutsideStateTemporarilyIndicator', 'lives_outside_state_temporarily'
                      #   end
                      # end

                      # namespace "homeAddress" do
                      #   rewrap 'family.family_members.person.addresses', type: :array do
                      #     # add_key 'has_fixed_address'
                      #     # map 'homeAddress', 'kind'
                      #     add_key 'kind', 'home'
                      #     map 'streetName1', 'address_1'
                      #     # add_key 'address_2'
                      #     map 'cityName', 'city'
                      #     map 'countyName', 'county'
                      #     map 'countyFipsCode', 'county_code'
                      #     map 'stateCode', 'state'
                      #     map 'zipCode', 'zip'
                      #     map 'countryCode', 'country_name'
                      #     # add_key 'validation_status'
                      #     # add_key 'start_on'
                      #     # add_key 'end_on'
                      #     # map 'liveOutsideStateTemporarilyIndicator', 'lives_outside_state_temporarily'
                      #   end
                      # end
                    end
                  end
                end
              end

              namespace 'application' do
                namespace 'legalAttestations' do
                  rewrap 'magi_medicaid_applications', type: :hash do
                    map "absentParentAgreementIndicator", "parent_living_out_of_home_terms"
                    map "changeInformationAgreementIndicator", "report_change_terms"
                    map "medicaidRequirementAgreementIndicator", "medicaid_terms"
                    map "renewalAgreementIndicator", "is_renewal_authorized"
                  end
                end
              end
            end
          end
        end
      end
    end
  end
end