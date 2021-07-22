# frozen_string_literal: true

require "aca_entities/atp/functions/address_builder"
require "aca_entities/atp/functions/relationship_builder"
require "aca_entities/atp/functions/lawful_presence_determination_builder"
require "aca_entities/atp/functions/build_application"
require "aca_entities/functions/age_on"
module AcaEntities
  module Atp
    module Transformers
      module Cv
        # Transformers implementation for atp payloads
        class Family < ::AcaEntities::Operations::Transforms::Transform
          include ::AcaEntities::Operations::Transforms::Transformer

          map "transfer_header.transfer_activity.transfer_id.identification_id", "family.ext_app_id"
          map 'insurance_application.insurance_applicants', 'applicants', memoize_record: true, visible: false
          map 'insurance_application.ssf_primary_contact.role_reference.ref', 'primary_applicant_identifier', memoize_record: true, visible: false
          map 'insurance_application.ssf_signer.ssf_attestation', 'ssf_attestation', memoize_record: true, visible: false
          map 'insurance_application.tax_return', 'tax_return', memoize_record: true, visible: false

          namespace 'record' do
            rewrap 'family', type: :hash do
              # map 'coverage_renewal_year_quantity', 'renewal_consent_through_year', function: ->(_value) {Date.parse("2021-05-07").year}
              add_key 'general_agency_accounts', value: ->(_v) {[]}
              add_key 'special_enrollment_periods', value: ->(_v) {[]}
              add_key 'irs_groups', value: ->(_v) {[]}
              add_key 'broker_accounts', value: ->(_v) {[]}
              add_key 'documents', value: ->(_v) {[]}
              add_key 'payment_transactions', value: ->(_v) {[]}

              namespace 'people.*', nil, context: { name: 'members' } do
                rewrap 'family.family_members', type: :array do
                  add_key 'is_consent_applicant', value: nil
                  add_key 'is_coverage_applicant', value: ->(_v) {true} # default value
                  add_key 'is_active'
                  add_key 'is_primary_applicant', function: lambda { |v|
                    primary_id = v.resolve(:primary_applicant_identifier).item
                    primary_id == v.find(/record.people.(\w+)$/).map(&:item).last
                  }
                  map 'id', 'person.ext_app_id'

                  namespace 'person_name' do
                    rewrap 'family.family_members.person', type: :hash do
                      map 'given', 'person_name.first_name', memoize: true, append_identifier: true
                      map 'middle', 'person_name.middle_name', memoize: true, append_identifier: true
                      map 'sur', 'person_name.last_name', memoize: true, append_identifier: true
                      map 'full', 'person_name.full_name', memoize: true, append_identifier: true
                      add_key 'hbx_id', value: 1234
                      add_key 'person_health.is_tobacco_user', value: nil
                      add_key 'person_health.is_physically_disabled', value: nil
                      add_key 'is_homeless', function: lambda { |v|
                        member_id = v.find(/record.people.(\w+)$/).map(&:item).last
                        applicants = v.resolve(:'insurance_application.insurance_applicants').item
                        return false unless applicants[member_id.to_sym]
                        !applicants[member_id.to_sym][:fixed_address_indicator]
                      }
                      add_key 'is_temporarily_out_of_state', function: lambda { |v|
                        member_id = v.find(/record.people.(\w+)$/).map(&:item).last
                        applicants = v.resolve(:'insurance_application.insurance_applicants').item
                        return false unless applicants[member_id.to_sym]
                        applicants[member_id.to_sym][:temporarily_lives_outside_application_state_indicator] || false # default value
                      }
                      add_key 'age_off_excluded', value: nil
                      add_key 'is_active'
                      add_key 'is_disabled', function: lambda { |v|
                        member_id = v.find(/record.people.(\w+)$/).map(&:item).last
                        applicants = v.resolve(:'insurance_application.insurance_applicants').item
                        return false unless applicants[member_id.to_sym]
                        applicants[member_id.to_sym][:blindness_or_disability_indicator]
                      }
                    end
                  end

                  map 'ssn_identification.identification_id', 'person.person_demographics.ssn', memoize: true, append_identifier: true
                  map 'sex', 'person.person_demographics.gender', memoize: true, append_identifier: true, function: ->(value) {value.downcase}
                  add_key 'person.person_demographics.no_ssn',
                          function: ->(v) { v.resolve(:'person_demographics.ssn', identifier: true).item.nil? ? "1" : "0"}
                  map 'birth_date.date', 'person.person_demographics.dob', memoize: true, append_identifier: true
                  add_key 'person.person_demographics.date_of_death'
                  add_key 'person.person_demographics.dob_check'
                  add_key 'person.person_demographics.is_incarcerated', function: lambda { |v|
                    member_id = v.find(/record.people.(\w+)$/).map(&:item).last
                    applicants = v.resolve(:'insurance_application.insurance_applicants').item
                    applicant = applicants[member_id.to_sym]
                    return false if applicant.nil?
                    applicant[:incarcerations].first[:incarceration_indicator] || false # defaulted to false if no value provided
                  }
                  add_key 'person.person_demographics.tribal_id'
                  add_key 'person.person_demographics.language_code'

                  map 'augementation', 'augementation', memoize_record: true, visible: false
                  add_key 'person.addresses', function: AcaEntities::Atp::Functions::AddressBuilder.new
                  add_key 'person.emails', function: lambda {|v|
                    # revisit if condition for emails and phone for dependents
                    # if v.resolve('family.family_members.is_primary_applicant').item ==
                    #     v.find(Regexp.new("attestations.members")).map(&:item).last
                    contacts_information = v.find(Regexp.new('record.people.*.augementation')).map(&:item).last[:contacts]
                    result = contacts_information.each_with_object([]) do |contact_info, collector|
                      if contact_info.dig(:contact, :email_id)
                        collector << { address: contact_info.dig(:contact, :email_id), kind: contact_info[:category_code].downcase }
                      end
                    end
                    result
                  }

                  add_key 'person.phones', function: lambda {|v|
                    # revisit if condition for emails and phone for dependents
                    # if v.resolve('family.family_members.is_primary_applicant').item ==
                    #     v.find(Regexp.new("attestations.members")).map(&:item).last
                    contacts_information = v.find(Regexp.new('record.people.*.augementation')).map(&:item).last[:contacts]
                    result = contacts_information.each_with_object([]) do |contact_info, collector|
                      phone = contact_info.dig(:contact, :telephone_number, :telephone, :telephone_number_full_id)
                      next unless phone

                      collector << { extension: nil,
                                     kind: contact_info[:category_code].to_s.downcase,
                                     area_code: phone.to_s[0..2],
                                     number: phone.to_s[3..9],
                                     primary: true, # default value
                                     full_phone_number: phone,
                                     start_on: nil,
                                     end_on: nil }
                    end
                    result
                  }
                  map 'us_citizen_indicator', 'us_citizen_indicator', memoize: true, append_identifier: true, visible: false
                  add_key 'person.consumer_role.lawful_presence_determination.citizen_status',
                          function: AcaEntities::Atp::Functions::LawfulPresenceDeterminationBuilder.new
                  add_key 'person.consumer_role.language_preference', function: lambda { |v|
                    preference_language = v.find(Regexp.new('record.people.*.augementation')).map(&:item).last[:preferred_languages]&.first
                    preference_language ? preference_language[:language_name].downcase : nil
                  }

                  add_key 'person.consumer_role.five_year_bar'
                  add_key 'person.consumer_role.requested_coverage_start_date', value: ->(_v) {Date.parse("2021-05-07")} # default value
                  add_key 'person.consumer_role.is_applicant', function: lambda { |v|
                    primary_id = v.resolve(:primary_applicant_identifier).item
                    primary_id == v.find(/record.people.(\w+)$/).map(&:item).last
                  }
                  add_key 'person.consumer_role.birth_location'
                  add_key 'person.consumer_role.marital_status', function: lambda { |v|
                    v.find(Regexp.new('record.people.*.augementation')).map(&:item).last[:married_indicator]
                  }
                  add_key 'person.consumer_role.is_active', value: true # default value
                  add_key 'person.consumer_role.is_applying_coverage', function: lambda { |v|
                    insurance_applicants = v.resolve(:'insurance_application.insurance_applicants').item
                    member_id = v.find(/record.people.(\w+)$/).map(&:item).last
                    insurance_applicant = insurance_applicants[member_id.to_sym]
                    insurance_applicant.nil? ? false : true
                  }
                  add_key 'person.consumer_role.bookmark_url'
                  add_key 'person.consumer_role.admin_bookmark_url'
                  add_key 'person.consumer_role.contact_method', function: lambda { |v|
                    contacts_information = v.find(Regexp.new('record.people.*.augementation')).map(&:item).last[:contacts]
                    result = contacts_information.each_with_object([]) do |contact_info, collector|
                      collector << contact_info[:category_code].downcase if contact_info[:is_primary_indicator]
                    end
                    result.first
                  }

                  add_key 'person.consumer_role.is_state_resident'
                  add_key 'person.consumer_role.identity_validation'
                  add_key 'person.consumer_role.identity_update_reason'
                  add_key 'person.consumer_role.application_validation'
                  add_key 'person.consumer_role.application_update_reason'
                  add_key 'person.consumer_role.identity_rejected'
                  add_key 'person.consumer_role.application_rejected'
                  add_key 'person.consumer_role.documents', value: ->(_v) {[]}
                  add_key 'person.consumer_role.vlp_documents', value: ->(_v) {[]}
                  add_key 'person.consumer_role.ridp_documents', value: ->(_v) {[]}
                  add_key 'person.consumer_role.verification_type_history_elements', value: ->(_v) {[]}
                  add_key 'person.consumer_role.local_residency_responses', value: ->(_v) {[]}
                  add_key 'person.consumer_role.local_residency_requests', value: ->(_v) {[]}
                  add_key 'person.person_relationships', function: AcaEntities::Atp::Functions::RelationshipBuilder.new

                  map 'race', 'person.race'
                  map 'ethnicities', 'person.ethnicity'
                end
              end

              add_key 'magi_medicaid_applications', function: AcaEntities::Atp::Functions::BuildApplication.new
            end
          end
        end
      end
    end
  end
end
