# frozen_string_literal: true

require "aca_entities/atp/functions/tax_return_builder"
require "aca_entities/atp/functions/income_builder"
require "aca_entities/atp/functions/expense_builder"
require "aca_entities/atp/functions/applicant_builder"
require "aca_entities/atp/functions/employment_builder"
require "aca_entities/atp/functions/build_outbound_relationship"
require 'aca_entities/atp/functions/verification_metadata_builder'
require 'aca_entities/atp/functions/medicaid_household_builder'
require "aca_entities/atp/functions/contact_builder"
require 'aca_entities/atp/transformers/aces/applicant'
require 'aca_entities/atp/transformers/aces/ssf_signer'

require 'dry/monads'
require 'dry/monads/do'

# rubocop:disable Metrics/ClassLength
module AcaEntities
  module Atp
    module Transformers
      module Aces
        # Transformers implementation for atp payloads
        class Family < ::AcaEntities::Operations::Transforms::Transform
          include ::AcaEntities::Operations::Transforms::Transformer

          ContactPreferenceCode = { "mobile" => "TextMessage",
                                    "email" => "Email",
                                    "mail" => "Mail" }.freeze

          namespace 'family' do
            rewrap 'aces', type: :hash do
              map 'external_app_id', 'ext_app_id'
              map 'hbx_id', 'hbx_id', memoize: true, visible: false
              map 'magi_medicaid_applications.us_state', 'us_state', memoize: true, visible: false
              add_key "senders", function: lambda { |v|
                state_code = v.resolve('us_state').item
                [{ category_code: 'Exchange',
                   county_name: nil,
                   state_code: state_code,
                   id: "Sender" }] # default
              }

              add_key "receivers", function: lambda { |_v|
                [{ category_code: 'Exchange',
                   id: "medicaidReceiver" }] # default
              }

              add_namespace 'transfer_header', 'aces.transfer_header', type: :hash do
                add_namespace 'transfer_activity', 'aces.transfer_header.transfer_activity', type: :hash do
                  add_namespace 'transfer_id', 'aces.transfer_header.transfer_activity.transfer_id', type: :hash do
                    add_key 'identification_id', function: ->(v) { "#{v.resolve('hbx_id').item}_#{DateTime.now.strftime('%Y%m%dT%H%M')}" }
                    add_key 'identification_category_text'
                    add_key 'identification_jurisdiction'
                  end

                  add_namespace 'transfer_date', 'aces.transfer_header.transfer_activity.transfer_date', type: :hash do
                    add_key 'date_time', value: ->(_v) { DateTime.now}
                  end

                  # add_key 'number_of_referrals', value: ->(_v) {} # this field is populated below
                  add_key 'recipient_code', value: 'MedicaidCHIP'
                  # add_key 'state_code', value: 'ME'
                  add_key 'state_code', function: ->(v) { v.resolve('us_state').item }
                end
                add_key 'recipient_state_code'
              end

              # map 'households', 'households', memoize_record: true, visible: false

              namespace 'magi_medicaid_applications' do
                rewrap 'aces.insurance_application', type: :hash  do
                  # map 'us_state', 'us_state'
                  add_key 'requesting_financial_assistance', value: ->(_v) {true}

                  add_key 'requesting_medicaid', value: ->(_v) {true}
                  add_key 'tax_return_access', value: ->(_v) {true}
                  map "hbx_id", "application_identifications", function: lambda { |v|
                    [{ :identification_id => "SBM#{v}", :identification_category_text => "Exchange", :identification_jurisdiction => nil }]
                  }

                  # add_key 'application_creation.creation_id'
                  # add_key 'application_creation.creation_date', value: ->(_v) {{ :date => "", :date_time => "", :year => nil, :year_month => nil }}

                  add_namespace 'application_submission', 'aces.insurance_application.application_submission', type: :hash do
                    add_key 'activity_id'
                    add_namespace 'activity_date', 'aces.insurance_application.application_submission.activity_date', type: :hash do
                      add_key 'date', value: ->(_v) { Date.today }
                    end
                  end

                  # add_key 'application_updates.activity_id'
                  # add_key 'application_updates.activity_date', value: ->(_v) {{ :date => "", :date_time => "", :year => nil, :year_month => nil }}

                  # map "assistance_year", 'assistance_year'
                  # map "parent_living_out_of_home_terms", 'assistance_year'
                  # map "report_change_terms", 'report_change_terms'
                  # map "medicaid_terms", 'medicaid_terms'
                  # map "is_renewal_authorized", 'is_renewal_authorized'
                  map 'mitc_households', 'mitc_households', memoize_record: true, visible: false
                  map 'applicants', 'applicants', memoize_record: true, visible: false

                  # add_key 'insurance_applicants', function: AcaEntities::Atp::Functions::ApplicantBuilder.new
                  add_key 'insurance_applicants', function: lambda { |v|
                                                              applicants_hash = v.resolve('family.magi_medicaid_applications.applicants').item
                                                              applicants_hash.each_with_object([]) do |applicant_hash, collector|
                                                                applicant = applicant_hash[1]
                                                                collector << AcaEntities::Atp::Transformers::Aces::Applicant.transform(applicant)
                                                              end
                                                            }

                  add_key 'assister_association'
                  # add_key 'tax_return_access', value: ->v {}
                  add_key 'coverage_renewal_year_quantity', value: ->(_v) {5}
                  map 'tax_households', 'tax_households', memoize_record: true, visible: false
                end
              end

              add_key 'transfer_header.transfer_activity.number_of_referrals',
                      function: lambda { |v|
                                  v.resolve('family.magi_medicaid_applications.applicants').item.count
                                }

              namespace 'family_members.*', nil, context: { name: 'members' } do
                rewrap 'aces.people', type: :array do
                  map 'hbx_id', 'id', function: ->(v) {"SBM#{v}"}
                  map 'is_primary_applicant', 'is_primary_applicant', memoize: true, visible: false, append_identifier: true
                  namespace 'person' do

                    map 'person_name.first_name', 'person_name.given', function: lambda { |v|
                      first_name = v&.gsub(/[^A-Za-z\-' ]/, ' ')
                      first_name&.strip&.empty? ? "BLANK FIRST" : first_name
                    }
                    map 'person_name.middle_name', 'person_name.middle', function: lambda { |v|
                      middle_name = v&.gsub(/[^A-Za-z\-' ]/, ' ')
                      middle_name&.strip&.empty? ? "BLANK MIDDLE" : middle_name
                    }
                    map 'person_name.last_name', 'person_name.sur', function: lambda { |v|
                      last_name = v&.gsub(/[^A-Za-z\-' ]/, ' ')
                      last_name&.strip&.empty? ? "BLANK LAST" : last_name
                    }
                    add_key 'person_name.suffix'
                    # map 'person_name.full_name', 'person_name.full' # removed as per business validation
                    add_key 'us_citizen_indicator', function: lambda { |v|
                      member_id = v.find(/family.family_members.(\w+)$/).map(&:item).last
                      applicants_hash = v.resolve('family.magi_medicaid_applications.applicants').item
                      applicant_hash = applicants_hash[member_id.to_sym]
                      if applicant_hash
                        citizenship_information = applicant_hash[:citizenship_immigration_status_information]
                        citizen_status = citizenship_information[:citizen_status]
                      end
                      citizen_status == 'us_citizen'
                    }
                    add_key 'living_indicator', value: ->(_v) {true}
                    map 'person_demographics.encrypted_ssn', 'ssn_identification.identification_id', function: lambda { |v|
                      return nil unless v
                      result = AcaEntities::Operations::Encryption::Decrypt.new.call({ value: v })
                      result.success? ? result.value! : nil
                    }
                    map 'person_demographics.gender', 'sex', function: ->(v) {v.capitalize}
                    map 'race', 'race'
                    add_key 'ethnicities'
                    map 'person_demographics.dob', 'birth_date.date',  memoize: true, visible: true, append_identifier: true,
                                                                       function: lambda { |v|
                                                                                   if v.respond_to?(:strftime)
                                                                                     Date.strptime(v, "%Y-%m-%d")
                                                                                   else
                                                                                     Date.parse(v)
                                                                                   end
                                                                                 }
                    add_key 'age_measure.measure_point_value', value: lambda { |v|
                      member_id = v.find(/family.family_members.(\w+)$/).map(&:item).last
                      applicants_hash = v.resolve('family.magi_medicaid_applications.applicants').item
                      applicant_hash = applicants_hash[member_id.to_sym]
                      applicant_hash ? applicant_hash[:age_of_applicant] : nil
                    }
                    map 'person_demographics.tribal_state', 'tribal_augmentation.location_state_us_postal_service_code', memoize: true, visible: true
                    map 'person_demographics.tribal_name', 'tribal_augmentation.person_tribe_name', memoize: true, visible: true
                    map 'person_demographics.is_incarcerated', 'is_incarcerated', memoize: true, visible: false, append_identifier: true

                    add_key 'tribal_augmentation.american_indian_or_alaska_native_indicator',
                            function: lambda { |v|
                                        !v.resolve(:'tribal_augmentation.location_state_us_postal_service_code').item.nil? &&
                                          !v.resolve(:'tribal_augmentation.person_tribe_name').item.nil?
                                      }

                    map 'consumer_role.marital_status', 'person_augmentation.married_indicator', function: ->(v) { v.nil? ? false : (v == "MARRIED")}
                    map 'consumer_role.language_preference', 'language_preference', memoize_record: true, visible: false
                    map 'consumer_role.contact_method', 'consumer_role.contact_method', memoize_record: true, visible: false, append_identifier: true
                    add_key 'person_augmentation.us_naturalized_citizen_indicator', function: lambda { |v|
                      member_id = v.find(/family.family_members.(\w+)$/).map(&:item).last
                      applicants_hash = v.resolve('family.magi_medicaid_applications.applicants').item
                      applicant_hash = applicants_hash[member_id.to_sym]
                      if applicant_hash
                        citizenship_information = applicant_hash[:citizenship_immigration_status_information]
                        citizen_status = citizenship_information[:citizen_status]
                      end
                      citizen_status == 'naturalized_citizen'
                    }

                    add_key 'person_augmentation.preferred_languages', function: lambda { |v|
                      language = v.resolve(:language_preference).item
                      [language_name: v.resolve(:language_preference).item,
                       :speaks_language_indicator => !language.blank?,
                       :writes_language_indicator => !language.blank?]
                    }
                    add_key 'person_augmentation.pregnancy_status', function: lambda { |v|
                      member_id = v.find(/family.family_members.(\w+)$/).map(&:item).last
                      applicants_hash = v.resolve('family.magi_medicaid_applications.applicants').item
                      applicant_hash = applicants_hash[member_id.to_sym]
                      if applicant_hash
                        pregnancy_information = applicant_hash[:pregnancy_information]
                        due_date = pregnancy_information[:pregnancy_due_on]
                        date_range = { :end_date => { :date => Date.parse(due_date) } } if due_date

                        { :status_indicator => pregnancy_information[:is_pregnant],
                          :status_valid_date_range => date_range,
                          :expected_baby_quantity => pregnancy_information[:expected_children_count] }
                      end
                    }

                    add_key 'person_augmentation.us_veteran_indicator', function: lambda { |v|
                      member_id = v.find(/family.family_members.(\w+)$/).map(&:item).last
                      applicants_hash = v.resolve('family.magi_medicaid_applications.applicants').item
                      applicant_hash = applicants_hash[member_id.to_sym]
                      applicant_hash.dig(:demographic, :is_veteran_or_active_military) if applicant_hash
                    }
                    add_key 'person_augmentation.incomes', function: AcaEntities::Atp::Functions::IncomeBuilder.new
                    add_key 'person_augmentation.expenses', function: AcaEntities::Atp::Functions::ExpenseBuilder.new
                    add_key 'person_augmentation.employments', function: AcaEntities::Atp::Functions::EmploymentBuilder.new
                    add_key 'person_augmentation.family_relationships', function: AcaEntities::Atp::Functions::BuildOutboundRelationship.new
                    add_key 'person_augmentation.contacts', function: AcaEntities::Atp::Functions::ContactBuilder.new

                  end
                end
              end

              add_key 'physical_households', function: lambda { |v|
                applicants_hash = v.resolve('family.magi_medicaid_applications.applicants').item
                result = applicants_hash.keys.map(&:to_s).each_with_object([]) do |id, collect|
                  collect << { :ref => "SBM#{id}" }
                end
                [{ :household_member_references => result, :household_size_quantity => result.size }]
              }

              add_key 'insurance_application.ssf_primary_contact', function: lambda { |v|
                ref = v.find(Regexp.new('is_primary_applicant.*')).select {|a|  a.item == true}.first.name.split('.').last
                contact_preference = v.find(Regexp.new('consumer_role.contact_method.*')).select {|a|  a.name.split('.').last == ref}.first.item
                { role_reference: { ref: "SBM#{ref}" }, contact_preference: ContactPreferenceCode[contact_preference] }
              }

              add_key 'insurance_application.ssf_signer', value: lambda { |v|
                ref = v.find(Regexp.new('is_primary_applicant.*')).select {|a|  a.item == true}.first.name.split('.').last
                applicant_hash = v.resolve("family.magi_medicaid_applications.applicants").item
                person_name_hash = applicant_hash[ref.to_sym][:name]
                ::AcaEntities::Atp::Transformers::Aces::SsfSigner.transform(person_name_hash.merge!(ref: ref))
              }
              add_key 'insurance_application.ssf_signer.ssf_signer_authorized_representative_association'
              add_key 'insurance_application.ssf_signer.ssf_attestation', value: lambda { |v|
                primary_applicant_id = v.find(Regexp.new("is_primary_applicant.*")).select {|i| i.item == true}.last.name.split('.').last
                incarceration_indicator = v.find(Regexp.new("is_incarcerated.#{primary_applicant_id}")).last

                { not_incarcerated_indicators: [{ value: !incarceration_indicator.item, metadata: "vm2009583325215611507" }],
                  :collections_agreement_indicator => true, # default value
                  :medicaid_obligations_indicator => true, # default value
                  :non_perjury_indicator => true, # default value
                  :privacy_agreement_indicator => true, # default value
                  :pending_charges_indicator => true, # default value
                  :information_changes_indicator => true, # default value
                  :application_terms_indicator => true } # default value
              }
              add_key "verification_metadata", function: ::AcaEntities::Atp::Functions::VerificationMetadataBuilder.new
              add_key "tax_returns", function: ::AcaEntities::Atp::Functions::TaxReturnBuilder.new
              add_key "medicaid_households", function: ::AcaEntities::Atp::Functions::MedicaidHouseholdBuilder.new
            end
          end
        end
      end
    end
  end
end
# rubocop:enable Metrics/ClassLength