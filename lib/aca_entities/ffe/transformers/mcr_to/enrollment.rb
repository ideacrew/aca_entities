# frozen_string_literal: true

# This file defines the maps
module AcaEntities
  module FFE
    module Transformers
      module McrTo
        # This transformer is used for Transform the data of the FFM, MCR Enrollment Contract params
        # to CV3 Enrollment Contract params.
        # This class is PRIVATE and cannot be called from outside except from operation:
        # AcaEntities::MagiMedicaid::Operations::Mitc::GenerateRequestPayload
        class Enrollment < ::AcaEntities::Operations::Transforms::Transform
          include ::AcaEntities::Operations::Transforms::Transformer

          # record_delimiter 'enrollments'
          map 'policyTrackingNumber', 'hbx_id', function: ->(v) {v.to_s}
          map 'insurancePlanPolicyStartDate', 'effective_on',  memoize: true
          map 'insurancePlanPolicyEndDate', 'terminated_on',  memoize: true
          namespace 'insurancePolicyStatus' do
            # map 'insurancePolicyStatusDateTime'
            map 'definingInsurancePolicyStatusTypeCodeName', 'aasm_state' # TODO: Add function
          end
          map 'isActive', 'is_active'
          add_key 'market_place_kind', value: 'individual'
          add_key 'enrollment_period_kind', value: 'open_enrollment' # TODO: revisit
          map 'associatedProductDivisionReferenceTypeCodeName', 'product_kind', function: lambda { |value|
                                                                                            { HEALTHCARE: "health" }[value.to_sym]
                                                                                          }, memoize: true

          map 'selectedInsurancePlan', 'product_reference.hios_id' # TODO: check
          map 'insurancePlanVariantName', 'product_reference.name' # TODO: check
          map 'coverageYear', 'product_reference.active_year'
          map 'associatedMetalTierTypeCodeName', 'product_reference.metal_level'
          add_key 'product_reference.benefit_market_kind', value: 'aca_individual' # TODO: revisit
          add_key 'product_reference.is_dental_only', value: false # TODO: revisit
          add_key 'product_reference.product_kind', function: ->(v) { { HEALTHCARE: "health" }[v.resolve('product_kind').item.to_sym]}

          add_key 'product_reference.issuer_profile_reference.hbx_id', value: "1234" # TODO: revisit
          add_key 'product_reference.issuer_profile_reference.abbrev', value: "Abbrev" # TODO: revisit
          map 'issuerHIOSID', 'product_reference.issuer_profile_reference.hbx_carrier_id', function: ->(v) {v.to_s}, memoize: true  # TODO: check
          map 'issuerName', 'product_reference.issuer_profile_reference.name', memoize: true

          # TODO: issuer_profile_reference  check
          add_key 'issuer_profile_reference.hbx_carrier_id', function: lambda { |v|
                                                                         v.resolve(
                                                                           'product_reference.issuer_profile_reference.hbx_carrier_id'
                                                                         ).item.to_s
                                                                       }
          add_key 'issuer_profile_reference.name', function: ->(v) {v.resolve('product_reference.issuer_profile_reference.name').item}
          add_key 'issuer_profile_reference.hbx_id', value: "1234" # TODO: revisit
          add_key 'issuer_profile_reference.abbrev', value: "Abbrev" # TODO: revisit

          # add_key 'coverage_household_reference'
          map 'insuranceApplicationIdentifier', 'family_hbx_id', function: ->(v) {v.to_s} # TODO: which identifier we need to use
          add_key 'terminate_reason'
          add_key 'termination_submitted_on'
          add_key 'waiver_reason'
          add_key 'review_status'
          add_key 'external_enrollment'  # TODO: what need to set
          # add_key 'predecessor_enrollment', value: {} #TODO: what need to set
          map 'applicationSEPTypeName', 'special_enrollment_period_reference.qualifying_life_event_kind_reference.title', memoize: true
          add_key 'special_enrollment_period_reference.qualifying_life_event_kind_reference.start_on', function: lambda { |_value|
                                                                                                                   convert_to_date(
                                                                                                                     Date.parse("2021-05-10").to_s
                                                                                                                   )
                                                                                                                 }
          add_key 'special_enrollment_period_reference.qualifying_life_event_kind_reference.end_on', function: lambda { |_value|
                                                                                                                 convert_to_date(
                                                                                                                   Date.parse("2021-05-10").to_s
                                                                                                                 )
                                                                                                               }
          add_key 'special_enrollment_period_reference.qualifying_life_event_kind_reference.title',
                  function:
                    lambda { |v|
                      v.resolve(
                        'special_enrollment_period_reference.qualifying_life_event_kind_reference.title'
                      ).item
                    }
          add_key 'special_enrollment_period_reference.qualifying_life_event_kind_reference.reason',
                  function:
                    lambda { |v|
                      v.resolve(
                        'special_enrollment_period_reference.qualifying_life_event_kind_reference.title'
                      ).item
                    }
          add_key 'special_enrollment_period_reference.qualifying_life_event_kind_reference.market_kind', value: 'individual'
          add_key 'special_enrollment_period_reference.qle_on', function: ->(_value) { convert_to_date(Date.parse("2021-05-10").to_s) }
          add_key 'special_enrollment_period_reference.start_on', function: ->(_value) { convert_to_date(Date.parse("2021-05-10").to_s) }
          add_key 'special_enrollment_period_reference.submitted_at', function: ->(_value) { convert_to_date(Date.parse("2021-05-10").to_s) }
          add_key 'special_enrollment_period_reference.end_on', function: ->(_value) { convert_to_date(Date.parse("2021-05-10").to_s) }
          add_key 'special_enrollment_period_reference.effective_on', function: ->(v) { convert_to_date(v.resolve('effective_on').item.to_s)}
          add_key 'special_enrollment_period_reference.next_poss_effective_date', function: lambda { |_value|
                                                                                              convert_to_date(Date.parse("2021-05-10").to_s)
                                                                                            }
          add_key 'special_enrollment_period_reference.option1_date', function: lambda { |_value|
                                                                                  convert_to_date(
                                                                                    Date.parse("2021-05-10").to_s
                                                                                  )
                                                                                }
          add_key 'special_enrollment_period_reference.option2_date', function: ->(_value) { convert_to_date(Date.parse("2021-05-10").to_s) }
          add_key 'special_enrollment_period_reference.option3_date', function: ->(_value) { convert_to_date(Date.parse("2021-05-10").to_s) }
          # add_key 'special_enrollment_period_reference.optional_effective_on', function: lambda { |value| convert_to_date(
          # Date.parse("2021-05-10").to_s) }
          # namespace 'definedAssistor' do
          # map 'definedAssistorReferenceTypeCodeName'
          # end
          # TODO: Revisit broker
          # add_key 'broker_role_reference.npn'
          # add_key 'broker_role_reference.person_reference.hbx_id'
          # add_key 'broker_role_reference.person_reference.first_name'
          # add_key 'broker_role_reference.person_reference.middle_name'
          # add_key 'broker_role_reference.person_reference.last_name'
          # add_key 'broker_role_reference.person_reference.ssn'
          # add_key 'broker_role_reference.person_reference.no_ssn'
          # add_key 'broker_role_reference.person_reference.dob'
          # add_key 'broker_role_reference.person_reference.gender'
          # add_key 'broker_role_reference.broker_agency_reference.hbx_id'
          # add_key 'broker_role_reference.broker_agency_reference.market_kind'
          # add_key 'broker_role_reference.broker_agency_reference.name'
          # add_key 'broker_role_reference.broker_agency_reference.dba'
          # add_key 'broker_role_reference.broker_agency_reference.display_name'
          # add_key 'broker_role_reference.broker_agency_reference.fein'
          # add_key 'broker_role_reference.broker_agency_reference.corporate_npn'
          add_key 'elected_amount', function: ->(_v) {{ cents: 0.0, currency_iso: 'USD' }}
          add_key 'elected_premium_credit', function: ->(_v) {{ cents: 0.0, currency_iso: 'USD' }}
          add_key 'applied_premium_credit', function: ->(_v) {{ cents: 0.0, currency_iso: 'USD' }}
          namespace 'insurancePolicyPremium' do
            # map 'monthlyPolicyPremiumAmount'
            # map 'exchangeRateAreaReference'
            # map 'ehbPremiumAmount'
            # map 'allocatedAPTCAmount', 'elected_aptc_pct', function: ->(v) {{ cents: 0.0, currency_iso: 'USD' }} # TODO
            # map 'receivedFromOtherQHPAmount'
            map 'appliedAPTCAmount', 'applied_aptc_amount', function: ->(v) {{ cents: v.to_f, currency_iso: 'USD' }}
            # map 'distributedToOtherQHPAmount'
            # map 'distributedToSADPAmount'
            # map 'systemElectedAPTCAmount'
            # map 'individualResponsibleAmount'
          end
          # add_key 'is_any_enrollment_member_outstanding'
          # add_key 'special_verification_period'
          # add_key 'enrollment_signature'

          # add_key 'consumer_role_reference'
          # add_key 'resident_role_reference'

          add_key 'benefit_package_reference.title', value: 'package title'
          add_key 'benefit_package_reference.elected_premium_credit_strategy', value: 'unassisted'
          add_key 'benefit_coverage_period_reference.title', value: 'coverage_period title'
          add_key 'benefit_coverage_period_reference.market_place', value: 'individual'
          add_key 'benefit_coverage_period_reference.start_on', function: ->(_value) { convert_to_date(Date.parse("2021-05-10").to_s) }
          add_key 'benefit_coverage_period_reference.end_on', function: ->(_value) { convert_to_date(Date.parse("2021-05-10").to_s) }
          add_key 'benefit_coverage_period_reference.open_enrollment_start_on', function: lambda { |_value|
                                                                                            convert_to_date(Date.parse("2021-05-10").to_s)
                                                                                          }
          add_key 'benefit_coverage_period_reference.open_enrollment_end_on', function: lambda { |_value|
                                                                                          convert_to_date(Date.parse("2021-05-10").to_s)
                                                                                        }
          # add_key 'updated_by'
          # map 'documentType'
          # map 'partialDataIndicator'
          # map 'lastModifiedDateTime'
          # map 'lastModifiedBy',
          # map 'isCurrentVersion'
          # map 'versionNumber'
          # map 'versionDateTime'
          # map 'marketplaceGroupPolicyIdentifier'
          # map 'informingApplicationVersionNumber'
          # map 'supersededIndicator'
          # map 'variableDeterminationIdentifier'
          # map 'metalLevelRestrictionAppliedIndicator'
          # map 'enrollmentApplicationType'
          # map 'initiatingTransactionOriginReferenceTypeCodeName'
          # map 'benchmarkPolicyPremiumAmount'
          # map 'maxAPTCAmount'
          # map 'initiatingExchangeUserIdentifier'
          # map 'definingSLCSPReference'
          # map 'userDetail'
          # map 'numberOfPoliciesTiedToApplication'
          # map 'marketplaceGroupPolicyIdentifiersTiedToApplication'
          # namespace 'directEnrollmentPartner' do
          #   map 'partnerIdentifier'
          #   map 'partnerType'
          # end
          # map 'referencedPaymentTransactionIdentifier'
          # map 'insurancePlanPolicyCreationDateTime'
          # map 'definingPlanVariantComponentTypeCodeName'
          # map 'marketplaceGroupPolicyIdentifier'
          # map 'issuerConfirmationIndicator'
          # map 'coveredInsuredMembers', 'hbx_enrollment_members', memoize: true
          namespace 'coveredInsuredMembers' do
            rewrap 'hbx_enrollment_members', type: :array do
              rewrap '' do
                map 'subscriberIndicator', 'is_subscriber', memoize: true
                map 'insuredMemberIdentifier', 'carrier_member_id', function: ->(v) {v.to_s}  # TODO: check on this
                # map 'definingMemberAssociationToSubscriberTypeCodeName'
                # map 'definingMemberMaritalStatusTypeCodeName'
                # map 'identifyingTobaccoUseTypeCodeName'
                # map 'definingInsurancePolicyStatusTypeCodeName'
                # map 'memberEhbPremiumAmount'
                map 'memberMonthlyPolicyPremiumAmount', 'premium_amount', function: ->(v) {{ cents: v.to_f, currency_iso: 'USD' }}
                map 'memberAllocatedAPTCAmount', 'applied_aptc_amount', function: ->(v) {{ cents: v.to_f, currency_iso: 'USD' }}
                add_key 'eligibility_date', function: ->(v) {v.resolve('effective_on').item}
                add_key 'coverage_start_on', function: ->(v) {v.resolve('effective_on').item}
                add_key 'terminated_on', function: ->(v) {v.resolve('terminated_on').item}
                map 'personTrackingNumber', 'family_member_reference.person_hbx_id'
                add_key 'family_member_reference.is_primary_family_member', function: ->(v) {v.resolve('is_subscriber').item}
                add_key 'family_member_reference.family_member_hbx_id', value: '1234'
                namespace 'memberInfo' do
                  rewrap 'hbx_enrollment_members.family_member_reference', type: :hash do
                    map 'firstName', 'first_name'
                    map 'lastName', 'last_name'
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