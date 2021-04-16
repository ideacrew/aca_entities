# frozen_string_literal: true

# This file defines the maps
module AcaEntities
  module Medicaid
    module Transforms
      module McrTo
        # Transform Keys and Values
        class CvInput < ::AcaEntities::Operations::Transforms::Transform
          include ::AcaEntities::Operations::Transforms::Transformer
          # import AcaEntities::Mcr::Transformations
          # transform functions
          # record_delimiter ''
          # record_delimiter nil
          record_delimiter 'applications.identifier.result' # TODO: support wild card ex. applications.*.result (prefer Regex)
          # source_vocabulary :mcr

          # TODO: namespace_map "source || output"

          AgeOn = AcaEntities::Functions::AgeOn.new(on_date: "2020-1-1")

          map "coverageYear", 'calender_year'
          map "insuranceApplicationIdentifier", 'application_identifier'

          namespace 'attestations' do
            rewrap '' do
              map "insuranceApplicationIdentifier", "insurance_application_identifier"
              map "applicationVersionNumber", "application_version_number"
              map "lastModifiedDateTime", "last_modified_date_time"
              map "lastModifiedUserId", "last_modified_user_id"
            end

            rewrap 'family' do
              map "coverageYear", "coverage_year"
              add_key 'hbx_id', 1234
              # map 'renewEligibilityYearQuantity', 'renewal_consent_through_year',
              # -> {|year | year + value_of("attestations.application.applicationSignatures")}
              add_key 'vlp_documents_status'
              add_key 'min_verifications_due_date'
              add_key 'special_enrollment_periods'
              add_key 'irs_groups'
              add_key 'broker_agency_accounts'
              add_key 'general_agency_accounts'
              add_key 'documents'
              add_key 'payment_transactions'
              add_key 'financial_assistance_applications'

              map 'sampleKey', 'sample_key'

              # add_context 'application.contactMemberIdentifier', AcaEntities::Functions::PrimaryApplicantBuilder
              # add_context 'household.familyRelationships', AcaEntities::Functions::PersonRelationshipBuilder
              # add_context "application.contactInformation", AcaEntities::Functions::PrimaryApplicantBuilder

              # map "application.contactInformation.email", "family_members.person.emails", AcaEntities::Functions::PrimaryApplicant
              # map "application.contactInformation.primaryPhoneNumber", "family_members.person.phones", AcaEntities::Functions::PrimaryApplicant

              map 'application.contactMemberIdentifier', 'family.family_members.is_primary_applicant',
                  { memoize: true, function: AcaEntities::Functions::PrimaryApplicantBuilder }

              # namespace 'members.*', context: {ref: 'members', element: 'id', type: 'members'} do
              namespace 'members.*', nil, context: { name: 'members' } do

                # rewrap 'attestations.members.*', 'family.family_members', type: :array do
                rewrap 'family.family_members', type: :array do

                  add_key 'is_primary_applicant', ->(v) { v.resolve('family.family_members.is_primary_applicant').item == v.resolve(:members).item }

                  namespace 'demographic' do
                    rewrap 'family.family_members.person' do

                      # add_key 'emails', -> v { v.context(:primary_contact_information).emails }
                      # add_key 'phones', -> v { v.context(:primary_contact_information).phones }
                      # add_key 'person_relationships', -> v { v.context(:person_relationships).person_relationships }

                      add_namespace 'identifiers', 'family.family_members.person.identifiers', type: :array do
                        add_key 'source_system_key', 'ccr' # source_vocabulary

                        add_namespace 'ids', 'family.family_members.person.identifiers.ids', type: :array do
                          add_key 'key', ->(v) { v.resolve(:members).name } # should be derived based on context
                          add_key 'item', ->(v) { v.resolve(:members).item } # should pick id from the source payload
                        end
                      end

                      namespace 'name' do
                        rewrap 'family.family_members.person.names', type: :array do
                          map 'firstName', 'first_name'
                          map 'lastName', 'last_name'
                        end
                      end

                      map 'americanIndianAlaskanNativeIndicator', 'americanIndianAlaskanNativeIndicator'

                      add_key 'no_ssn', 'false'
                      map 'ssn', 'encrypted_ssn' # , Dry::Transformer(:nest, :address, [:street, :zipcode])
                      # map 'birthDate', 'age', -> v { age_of(v) }
                      map 'birthDate', 'age', AgeOn

                      # map 'birthDate', 'age' do |value|
                      #   age_of(value)
                      #   nest
                      # end

                      # map 'type', 'kind',  '-> (value){ value.to_s.downcase }'
                      map 'status', 'is_active',  ->(value) { boolean(value)}
                      map 'sex', 'gender', ->(value) { value.to_s.downcase }

                      # map 'incarcerationType', 'is_incarcerated',  '-> (value){ AcaEntities::Types::McrToCvIncarcerationKind[value] }'
                      # map 'computed.members.*.ssnStatusReason', 'no_ssn'
                      # add_key 'hbx_id'
                      map 'blindOrDisabledIndicator', 'is_disabled'
                      add_key 'ethnicity'
                      add_key 'race'
                      add_key 'tribal_id'
                      # add_key 'language_code' , "default: en"
                      map 'noHomeAddressIndicator', 'is_homeless'
                      map 'liveOutsideStateTemporarilyIndicator', 'is_temporarily_out_of_state'

                      namespace 'mailingAddress' do
                        rewrap 'family.family_members.person.addresses', type: :array do
                          # add_key 'has_fixed_address'
                          # map 'mailingAddress', 'kind'
                          add_key 'kind', 'mailing'
                          map 'streetName1', 'address_1'
                          # add_key 'address_2'
                          map 'cityName', 'city' #
                          map 'countyName', 'county'
                          map 'countyFipsCode', 'county_code'
                          map 'stateCode', 'state'
                          map 'zipCode', 'zip'
                          map 'countryCode', 'country_name'
                          # add_key 'validation_status'
                          # add_key 'start_on'
                          # add_key 'end_on'
                          # map 'liveOutsideStateTemporarilyIndicator', 'lives_outside_state_temporarily'
                        end
                      end

                      namespace "homeAddress" do
                        rewrap 'family.family_members.person.addresses', type: :array do
                          # add_key 'has_fixed_address'
                          # map 'homeAddress', 'kind'
                          add_key 'kind', 'home'
                          map 'streetName1', 'address_1'
                          # add_key 'address_2'
                          map 'cityName', 'city'
                          map 'countyName', 'county'
                          map 'countyFipsCode', 'county_code'
                          map 'stateCode', 'state'
                          map 'zipCode', 'zip'
                          map 'countryCode', 'country_name'
                          # add_key 'validation_status'
                          # add_key 'start_on'
                          # add_key 'end_on'
                          # map 'liveOutsideStateTemporarilyIndicator', 'lives_outside_state_temporarily'
                        end
                      end
                    end
                  end
                end

                # add_key 'person_relationships'
                # add_key 'relative_hbx_id'
                # add_key 'kind'
                # add_key 'hbx_id'
              end

              # namespace 'households'
              #   # construct relationships according
              #   map "familyRelationships"
              # end

              # add_key 'households'
              # add_key 'coverage_households'
              # add_key 'tax_households'
            end
          end
        end
      end
    end
  end
end

# support record_delimiter under transform operation
# implement mappings dsl
# register mappings using Dry Container
# execute mappings from Dry Container while parsing data under Transform
# create IO stream with parsed & mapped records
# persiste IO stream records to output file

# pass block to exeute end of each record, to yield back to executing program
#   - record counter
