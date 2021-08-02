# frozen_string_literal: true

require "aca_entities/atp/functions/income_builder"
require "aca_entities/atp/functions/expense_builder"
require "aca_entities/atp/functions/applicant_builder"
require "aca_entities/atp/functions/employment_builder"
require "aca_entities/atp/functions/build_outbound_relationship"
require "aca_entities/atp/functions/contact_builder"
# require "aca_entities/atp/functions/lawful_presence_determination_builder"
# require "aca_entities/atp/functions/build_application"
# require "aca_entities/functions/age_on"

module AcaEntities
  module Atp
    module Transformers
      module Aces
        # Transformers implementation for atp payloads
        class Family < ::AcaEntities::Operations::Transforms::Transform
          include ::AcaEntities::Operations::Transforms::Transformer

          namespace 'family' do
            map 'ext_app_id', 'ext_app_id'

            namespace 'magi_medicaid_applications' do
              rewrap 'insurance_application' do
                map 'us_state', 'us_state'
                map "hbx_id", "application_identifications", function: lambda { |v|
                  [{ :identification_id => v, :identification_category_text => "Exchange", :identification_jurisdiction => nil }]
                }
                add_key 'application_creation.creation_id'
                add_key 'application_creation.creation_date', value: ->(_v) {{ :date => "", :date_time => "", :year => nil, :year_month => nil }}
                add_key 'application_submission.activity_id'
                add_key 'application_submission.activity_date', value: ->(_v) {{ :date => "", :date_time => "", :year => nil, :year_month => nil }}
                add_key 'application_updates.activity_id'
                add_key 'application_updates.activity_date', value: ->(_v) {{ :date => "", :date_time => "", :year => nil, :year_month => nil }}
                map "assistance_year", 'assistance_year'
                map "parent_living_out_of_home_terms", 'assistance_year'
                map "report_change_terms", 'report_change_terms'
                map "medicaid_terms", 'medicaid_terms'
                map "is_renewal_authorized", 'is_renewal_authorized'
                map 'applicants', 'applicants', memoize_record: true, visible: false

                add_key 'insurance_applicants', value: lambda { |v|
                                                         applicants_hash = v.resolve('family.magi_medicaid_applications.applicants').item
                                                         result = applicants_hash.each_with_object([]) do |applicant_hash, collector|
                                                           applicant = applicant_hash[1]
                                                           collector << { :role_reference => { :ref => applicant[:person_hbx_id] },
                                                                          :esi_eligible_indicator => nil,
                                                                          :fixed_address_indicator => true,
                                                                          :incarcerations => [{
                                                                            :incarceration_indicator => applicant[:attestation][:is_incarcerated], :incarceration_date => nil
                                                                          }],
                                                                          :absent_parent_or_spouse_code => nil,
                                                                          :blindness_or_disability_indicator => applicant[:is_self_attested_disabled] && applicant[:is_self_attested_blind],
                                                                          :coverage_during_previous_six_months_indicator => nil,
                                                                          :eligible_itu_services_indicator => nil,
                                                                          :lawful_presence_status => nil,
                                                                          :long_term_care_indicator => applicant[:is_self_attested_long_term_care],
                                                                          :non_esi_coverage_indicators => [],
                                                                          :parent_caretaker_indicator => true,
                                                                          :received_itu_services_indicator => nil,
                                                                          :recent_medical_bills_indicator => nil,
                                                                          :state_benefits_through_public_employee_indicator => nil,
                                                                          :student_indicator => applicant[:student][:is_student],
                                                                          :esi_associations => [],
                                                                          :non_esi_policies => [],
                                                                          :emergency_medicaid_eligibilities => [],
                                                                          :medicaid_magi_eligibilities => [],
                                                                          :medicaid_non_magi_eligibilities => [],
                                                                          :aptc_eligibilities => [],
                                                                          :exchange_eligibilities => [],
                                                                          :csr_eligibilities => [],
                                                                          :chip_eligibilities => [],
                                                                          :temporarily_lives_outside_application_state_indicator => nil,
                                                                          :age_left_foster_care => applicant[:age_left_foster_care],
                                                                          :foster_care_state => applicant[:foster_care_state],
                                                                          :had_medicaid_during_foster_care_indicator => applicant[:had_medicaid_during_foster_care],
                                                                          :lives_with_minor_age_dependent_indicator => nil,
                                                                          :household_exception_indicator => nil,
                                                                          :foster_care_indicator => applicant[:foster_care_indicator],
                                                                          :parent_average_hours_worked_per_week_values => nil }
                                                         end
                                                       }

                add_key 'assister_association'
                add_key 'tax_return_access'
                add_key 'coverage_renewal_year_quantity'
              end
            end

            namespace 'family_members.*', nil, context: { name: 'members' } do
              rewrap 'people', type: :array do
                map 'is_primary_applicant', 'is_primary_applicant', memoize: true, visible: false, append_identifier: true
                namespace 'person' do

                  map 'person_name.first_name', 'person_name.given'
                  map 'person_name.middle_name', 'person_name.middle'
                  map 'person_name.last_name', 'person_name.sur'
                  add_key 'person_name.suffix'
                  map 'person_name.full_name', 'person_name.full'
                  add_key 'us_citizen_indicator', function: lambda { |v|
                    member_id = v.find(/family.family_members.(\w+)$/).map(&:item).last
                    applicants_hash = v.resolve('family.magi_medicaid_applications.applicants').item
                    applicant_hash = applicants_hash[member_id.to_sym]
                    citizenship_information = applicant_hash[:citizenship_immigration_status_information]
                    citizen_status = citizenship_information[:citizen_status]
                    citizen_status == 'us_citizen'
                  }
                  add_key 'living_indicator'
                  map 'person_demographics.ssn', 'ssn_identification.identification_id'
                  map 'person_demographics.gender', 'sex'
                  map 'race', 'race'
                  add_key 'ethnicities'
                  map 'person_demographics.dob', 'birth_date.date',  memoize: true, visible: true, append_identifier: true
                  add_key 'age_measure.measure_point_value', value: lambda { |v|
                    member_id = v.find(/family.family_members.(\w+)$/).map(&:item).last
                    applicants_hash = v.resolve('family.magi_medicaid_applications.applicants').item
                    applicant_hash = applicants_hash[member_id.to_sym]
                    applicant_hash[:age_of_applicant]
                  }
                  add_key 'birth_date.date_time'
                  add_key 'birth_date.year'
                  add_key 'birth_date.year_month'
                  map 'person_demographics.tribal_state', 'tribal_augmentation.location_state_us_postal_service_code', memoize: true, visible: true
                  map 'person_demographics.tribal_name', 'tribal_augmentation.person_tribe_name', memoize: true, visible: true
                  add_key 'tribal_augmentation.american_indian_or_alaska_native_indicator', function: lambda { |v|
                                                                                                        !v.resolve(:'tribal_augmentation.location_state_us_postal_service_code').item.nil? && !v.resolve(:'tribal_augmentation.person_tribe_name').item.nil?
                                                                                                      }

                  map 'consumer_role.marital_status', 'augementation.married_indicator'
                  map 'consumer_role.language_preference', 'language_preference', memoize_record: true, visible: false
                  map 'consumer_role.contact_method', 'consumer_role.contact_method', memoize_record: true, visible: false, append_identifier: true
                  add_key 'augementation.us_naturalized_citizen_indicator', function: lambda { |v|
                    member_id = v.find(/family.family_members.(\w+)$/).map(&:item).last
                    applicants_hash = v.resolve('family.magi_medicaid_applications.applicants').item
                    applicant_hash = applicants_hash[member_id.to_sym]
                    citizenship_information = applicant_hash[:citizenship_immigration_status_information]
                    citizen_status = citizenship_information[:citizen_status]
                    citizen_status == 'naturalized_citizen'
                  }

                  add_key 'augementation.preferred_languages', function: lambda { |v|
                    [language_name: v.resolve(:language_preference).item, :speaks_language_indicator=> nil, :writes_language_indicator=> nil]
                  }
                  add_key 'augementation.pregnancy_status', function: lambda { |v|
                    member_id = v.find(/family.family_members.(\w+)$/).map(&:item).last
                    applicants_hash = v.resolve('family.magi_medicaid_applications.applicants').item
                    applicant_hash = applicants_hash[member_id.to_sym]
                    pregnancy_information = applicant_hash[:pregnancy_information]

                    { :status_indicator => pregnancy_information[:is_pregnant], :status_valid_date_range => nil, :expected_baby_quantity => pregnancy_information[:expected_children_count] }
                  }

                  add_key 'augementation.incomes', function: AcaEntities::Atp::Functions::IncomeBuilder.new
                  add_key 'augementation.expenses', function: AcaEntities::Atp::Functions::ExpenseBuilder.new
                  add_key 'augementation.employments', function: AcaEntities::Atp::Functions::EmploymentBuilder.new
                  add_key 'augementation.family_relationships', function: AcaEntities::Atp::Functions::BuildOutboundRelationship.new
                  add_key 'augementation.contacts', function: AcaEntities::Atp::Functions::ContactBuilder.new

                end
              end
            end

            add_key 'physical_households', function: -> v {
              applicants_hash = v.resolve('family.magi_medicaid_applications.applicants').item
              result = applicants_hash.keys.map(&:to_s).each_with_object([]) do |id,collect|
                collect << {:ref=> id}
              end
            [{:household_member_references=> result, :household_size_quantity=>nil}]
            }
            
            add_key 'insurance_application.ssf_primary_contact', function: lambda { |v|
              ref = v.find(Regexp.new('is_primary_applicant.*')).select {|a|  a.item == true}.first.name.split('.').last
              contact_preference = v.find(Regexp.new('consumer_role.contact_method.*')).select {|a|  a.name.split('.').last == ref}.first.item
              { role_reference: { ref: ref }, contact_preference: contact_preference }
            }

            add_key 'insurance_application.ssf_signer', value: lambda { |v|
              ref = v.find(Regexp.new('is_primary_applicant.*')).select {|a|  a.item == true}.first.name.split('.').last
              applicant_hash = v.resolve("family.magi_medicaid_applications.applicants").item
              person_name_hash = applicant_hash[ref.to_sym][:name]
              { role_reference: { ref: ref },
                signature: { signature_name: { :given => person_name_hash[:first_name], :middle => person_name_hash[:middle_name], :sur => person_name_hash[:last_name], :suffix => person_name_hash[:name_sfx], :full => person_name_hash[:full_name] },
                             signature_date: nil } }
            }
            add_key 'insurance_application.ssf_signer.ssf_signer_authorized_representative_association'
            add_key 'insurance_application.ssf_signer.ssf_attestation', value: lambda { |v|
              incarceration_indicators = v.find(Regexp.new("incarcerations.incarceration_indicator.*"))
              result = incarceration_indicators.each_with_object([]) do |input, collect|
                collect << { value: !input.item, metadata: input.name.split('.').last }
              end
              { not_incarcerated_indicators: result,
                :collections_agreement_indicator => nil,
                :medicaid_obligations_indicator => nil,
                :non_perjury_indicator => nil,
                :privacy_agreement_indicator => nil,
                :pending_charges_indicator => nil,
                :information_changes_indicator => nil,
                :application_terms_indicator => nil }
            }
          end
        end
      end
    end
  end
end
