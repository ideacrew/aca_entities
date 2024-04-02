# frozen_string_literal: true

require "aca_entities/atp/functions/address_builder"
require "aca_entities/atp/functions/relationship_builder"
require "aca_entities/atp/functions/vlp_document_hash_builder"
require "aca_entities/atp/functions/lawful_presence_determination_builder"
require "aca_entities/atp/functions/build_application"
require "aca_entities/functions/age_on"
require 'aca_entities/atp/transformers/cv/phone'
require 'aca_entities/atp/transformers/cv/vlp_document'
require 'dry/monads'
require 'dry/monads/do'

module AcaEntities
  module Atp
    module Transformers
      module Cv
        # Transformers implementation for atp payloads
        class Family < ::AcaEntities::Operations::Transforms::Transform
          include ::AcaEntities::Operations::Transforms::Transformer

          PHONE_KINDS = %w[home work mobile fax].freeze

          map "transfer_header.transfer_activity.transfer_id.identification_id", "family.ext_app_id"
          map 'insurance_application.insurance_applicants', 'applicants', memoize_record: true, visible: false
          map 'insurance_application.ssf_primary_contact.role_reference.ref', 'primary_applicant_identifier', memoize_record: true, visible: false
          map 'insurance_application.ssf_signer.ssf_attestation', 'ssf_attestation', memoize_record: true, visible: false
          map 'insurance_application.tax_returns', 'tax_returns', memoize_record: true, visible: false
          map 'insurance_application.application_identifications.identification_id', 'external_id', memoize_record: true, visible: false
          map 'insurance_application.coverage_renewal_year_quantity', 'coverage_renewal_year_quantity', memoize: true, visible: false

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
                      map 'given', 'person_name.first_name', memoize: true, append_identifier: true, function: ->(v) {v&.capitalize}
                      map 'middle', 'person_name.middle_name', memoize: true, append_identifier: true, function: ->(v) {v&.capitalize}
                      map 'sur', 'person_name.last_name', memoize: true, append_identifier: true, function: ->(v) {v&.capitalize}
                      map 'full', 'person_name.full_name', memoize: true, append_identifier: true,
                                                           function: ->(v) {v&.split&.map {|name| name.capitalize}&.join(" ")}
                      add_key 'hbx_id', value: 1234
                      add_key 'person_health.is_tobacco_user', value: "unknown"
                      add_key 'person_health.is_physically_disabled', value: nil
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
                        applicants[member_id.to_sym][:blindness_or_disability_indicator] || false # default value
                      }
                    end
                  end

                  map 'ssn_identification.identification_id', 'person.demographics.ssn', memoize: true, append_identifier: true, function:
                  lambda { |v|
                    return nil unless v
                    result = AcaEntities::Operations::Encryption::Encrypt.new.call({ value: v })
                    result.success? ? result.value! : nil
                  }
                  map 'sex', 'person.demographics.gender', memoize: true, append_identifier: true, function: ->(value) {value.downcase}
                  add_key 'person.demographics.no_ssn',
                          function: ->(v) { v.resolve(:'demographics.ssn', identifier: true).item.nil?}
                  map 'birth_date.date', 'person.demographics.dob', memoize: true, append_identifier: true
                  add_key 'person.demographics.dob', memoize: true, append_identifier: true, function: lambda { |v|
                    member_id = v.find(/record.people.(\w+)$/).map(&:item).last
                    v.resolve("person.demographics.dob.#{member_id}").item
                  }
                  add_key 'person.demographics.date_of_death'
                  add_key 'person.demographics.dob_check'
                  add_key 'person.demographics.is_incarcerated', memoize: true, function: lambda { |v|
                    member_id = v.find(/record.people.(\w+)$/).map(&:item).last
                    applicants = v.resolve(:'insurance_application.insurance_applicants').item
                    applicant = applicants[member_id.to_sym]
                    return false if applicant.nil? || applicant[:incarcerations].empty?
                    applicant[:incarcerations].first[:incarceration_indicator] || false # defaulted to false if no value provided
                  }
                  add_key 'person.demographics.tribal_id'
                  add_key 'person.demographics.language_code'

                  map 'tribal_augmentation', 'tribal_augmentation', memoize_record: true, visible: false
                  add_key 'person.demographics.tribal_state', function: lambda { |v|
                    tribal_augmentation = v.find(Regexp.new('record.people.*.tribal_augmentation')).map(&:item).last
                    tribe_indicator = tribal_augmentation[:american_indian_or_alaska_native_indicator]
                    return nil unless tribe_indicator
                    tribal_augmentation[:location_state_us_postal_service_code]
                  }
                  add_key 'person.demographics.tribal_name', function: lambda { |v|
                    tribal_augmentation = v.find(Regexp.new('record.people.*.tribal_augmentation')).map(&:item).last
                    tribe_indicator = tribal_augmentation[:american_indian_or_alaska_native_indicator]
                    return nil unless tribe_indicator
                    tribal_augmentation[:person_tribe_name]
                  }
                  map 'augementation', 'augementation', memoize_record: true, visible: false
                  add_key 'person.addresses', memoize_record: true, function: AcaEntities::Atp::Functions::AddressBuilder.new
                  add_key 'person.is_homeless', function: lambda { |v|
                    member_id = v.find(/record.people.(\w+)$/).map(&:item).last
                    contacts_information = v.find(Regexp.new("record.people.#{member_id}.augementation")).map(&:item).last[:contacts]
                    contacts_information.select { |co| co[:category_code].downcase == "home" && co[:contact][:mailing_address].present? }.empty?
                  }
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
                      next unless phone && PHONE_KINDS.include?(contact_info[:category_code]&.downcase)

                      collector << AcaEntities::Atp::Transformers::Cv::Phone.transform(contact_info)
                    end
                    result
                  }
                  map 'us_citizen_indicator', 'us_citizen_indicator', memoize: true, append_identifier: true, visible: false
                  add_key 'person.consumer_role.lawful_presence_determination.citizen_status', function: lambda { |v|
                    member_id = v.find(/record.people.(\w+)$/).map(&:item).last
                    AcaEntities::Atp::Functions::LawfulPresenceDeterminationBuilder.new.call(v, member_id)
                  }
                  add_key 'person.consumer_role.language_preference', function: lambda { |v|
                    preference_language = v.find(Regexp.new('record.people.*.augementation')).map(&:item).last[:preferred_languages]&.first
                    preference_language ? preference_language[:language_name].downcase.titleize : nil
                  }

                  add_key 'person.consumer_role.five_year_bar'
                  add_key 'person.consumer_role.requested_coverage_start_date', value: ->(_v) {Date.parse("2021-05-07")} # default value
                  add_key 'person.consumer_role.is_applicant', function: lambda { |v|
                    primary_id = v.resolve(:primary_applicant_identifier).item
                    primary_id == v.find(/record.people.(\w+)$/).map(&:item).last
                  }
                  add_key 'person.consumer_role.birth_location'
                  add_key 'person.consumer_role.marital_status', function: lambda { |v|
                    married_indicator = v.find(Regexp.new('record.people.*.augementation')).map(&:item).last[:married_indicator]
                    married_indicator ? "married" : ""
                  }
                  add_key 'person.consumer_role.is_active', value: true # default value
                  add_key 'person.consumer_role.is_applying_coverage', function: lambda { |v|
                    insurance_applicants = v.resolve(:'insurance_application.insurance_applicants').item
                    member_id = v.find(/record.people.(\w+)$/).map(&:item).last
                    insurance_applicant = insurance_applicants[member_id.to_sym]
                    !insurance_applicant.nil?
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
                  add_key 'person.consumer_role.vlp_documents', function: lambda {|v|
                    member_id = v.find(/record.people.(\w+)$/).map(&:item).last
                    applicants = v.resolve(:'insurance_application.insurance_applicants').item
                    return [] unless member_id && applicants
                    insurance_applicant = applicants[member_id.to_sym]
                    lawful_presence_status = insurance_applicant[:lawful_presence_status] if insurance_applicant
                    vlp_documents = lawful_presence_status[:immigration_documents] if lawful_presence_status
                    result = vlp_documents&.each_with_object([]) do |document, collector|
                      next unless document
                      # builder will handle the document number and person id arrays for the transformer by expanding hash
                      document_hash = AcaEntities::Atp::Functions::VlpDocumentHashBuilder.new.call(document)
                      collector << AcaEntities::Atp::Transformers::Cv::VlpDocument.transform(document_hash)
                    end
                    result
                  }
                  add_key 'person.consumer_role.ridp_documents', value: ->(_v) {[]}
                  add_key 'person.consumer_role.verification_type_history_elements', value: ->(_v) {[]}
                  add_key 'person.consumer_role.local_residency_responses', value: ->(_v) {[]}
                  add_key 'person.consumer_role.local_residency_requests', value: ->(_v) {[]}
                  add_key 'person.person_relationships', function: AcaEntities::Atp::Functions::RelationshipBuilder.new

                  map 'race', 'person.race'
                  map 'ethnicities', 'person.demographics.ethnicity', memoize_record: true, append_identifier: true, visible: false
                  add_key 'person.demographics.ethnicity', function: lambda { |v|
                    member_id = v.find(/record.people.(\w+)$/).map(&:item).last
                    ethnicity = v.resolve("person.demographics.ethnicity.#{member_id}").item
                    ethnicity.nil? ? ["", "", "", "", "", "", ""] : ethnicity
                  }
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
