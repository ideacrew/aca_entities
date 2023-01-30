# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module H41
      module Operations
        # BuildH41Request
        class BuildH41Request
          include Dry::Monads[:result, :do, :try]

          def call(families)
            payload = yield construct_h41_request(families)
            validated_payload = yield validate_payload(payload)
            request_entity = yield h41_request_entity(validated_payload)

            Success(request_entity)
          end

          private

          def validate_payload(payload)
            result = AcaEntities::Fdsh::H41::Contracts::Form1095aTransmissionUpstreamContract.new.call(payload)
            result.success? ? Success(result) : Failure("Invalid H41 request due to #{result.errors.to_h}")
          end

          def h41_request_entity(payload)
            Success(AcaEntities::Fdsh::H41::Form1095ATransmissionUpstream.new(payload.to_h))
          end

          def construct_h41_request(families)
            request_groups = families.collect do |family|
              family.households.collect do |household|
                household.insurance_agreements.collect do |agreement|
                  construct_policy_request(agreement, family)
                end
              end
            end
            request = { Form1095AUpstreamDetail: request_groups.flatten }
            Success(request)
          end

          def construct_policy_request(agreement, family)
            agreement.insurance_policies.collect do |insurance_policy|
              next if insurance_policy.aptc_csr_tax_households.empty?

              provider = agreement.insurance_provider
              insurance_policy.aptc_csr_tax_households.collect do |tax_household|
                recipient = fetch_recipient(tax_household, agreement, family)
                recipient_spouse = fetch_recipient_spouse(tax_household)
                has_aptc = tax_household.months_of_year.any? { |month| month.coverage_information && month.coverage_information.tax_credit.cents.to_f > 0 }

                form_1095a_upstream_detail = {
                  RecordSequenceNum: insurance_policy.policy_id,
                  TaxYr: agreement.plan_year.to_s,
                  CorrectedInd: "0",
                  VoidInd: "0",
                  MarketplaceId: "02.ME*.SBE.001.001",
                  Policy: construct_policy(insurance_policy, provider),
                  Recipient: construct_recipient(recipient)
                }
                if has_aptc && recipient_spouse.present?
                  form_1095a_upstream_detail.merge!(RecipientSpouse: construct_recipient_spouse(recipient_spouse))
                end
                form_1095a_upstream_detail.merge!(CoverageHouseholdGrp: construct_coverage_group(tax_household))
                form_1095a_upstream_detail.merge!(RecipientPolicyInformation: construct_premium_information(tax_household))
                form_1095a_upstream_detail
              end
            end.compact
          end

          def construct_premium_information(tax_household)
            {
              JanPremiumInformation: premium_information(tax_household, 1),
              FebPremiumInformation: premium_information(tax_household, 2),
              MarPremiumInformation: premium_information(tax_household, 3),
              AprPremiumInformation: premium_information(tax_household, 4),
              MayPremiumInformation: premium_information(tax_household, 5),
              JunPremiumInformation: premium_information(tax_household, 6),
              JulPremiumInformation: premium_information(tax_household, 7),
              AugPremiumInformation: premium_information(tax_household, 8),
              SepPremiumInformation: premium_information(tax_household, 9),
              OctPremiumInformation: premium_information(tax_household, 10),
              NovPremiumInformation: premium_information(tax_household, 11),
              DecPremiumInformation: premium_information(tax_household, 12),
              AnnualPolicyTotalAmounts: construct_annual_premium_totals(tax_household)
            }
          end

          def construct_annual_premium_totals(tax_household)
            annual_premiums = tax_household.annual_premiums
            annual_aptc_amount = annual_premiums.tax_credit.cents.to_f
            slcsp = annual_premiums.slcsp_benchmark_premium.cents.to_f
            {
              AnnualPremiumAmt: annual_premiums.total_premium.cents.to_f,
              AnnualPremiumSLCSPAmt: annual_aptc_amount.present? && annual_aptc_amount > 0 ? slcsp : 0.00,
              AnnualAdvancedPTCAmt: annual_aptc_amount.present? && annual_aptc_amount > 0 ? annual_aptc_amount : 0.00
            }
          end

          def premium_information(tax_household, month)
            month = Date::MONTHNAMES[month]
            monthly_premium = tax_household.months_of_year.detect { |month_of_year| month_of_year.month == month }
            if monthly_premium
              coverage_information = monthly_premium.coverage_information
              aptc_amount = coverage_information.tax_credit.cents.to_f
              {
                MonthlyPremiumAmt: coverage_information.total_premium.cents.to_f,
                MonthlyPremiumSLCSPAmt: aptc_amount > 0 ? coverage_information.slcsp_benchmark_premium.cents.to_f : 0.00,
                MonthlyAdvancedPTCAmt:  aptc_amount > 0 ? aptc_amount : 0.00
              }
            else
              {
                MonthlyPremiumAmt: 0.00,
                MonthlyPremiumSLCSPAmt: 0.00,
                MonthlyAdvancedPTCAmt: 0.00
              }
            end
          end

          def construct_coverage_group(tax_household)
            covered_individuals = tax_household.covered_individuals
            {
              CoveredIndividuals: construct_covered_individuals(covered_individuals)
            }
          end

          def construct_covered_individuals(covered_individuals)
            covered_individuals.collect do |individual|
              {
                InsuredPerson: { OtherCompletePersonName: { PersonFirstNm: individual.person.person_name.first_name,
                                                            PersonLastNm: individual.person.person_name.last_name },
                                 SSN: decrypt_ssn(individual.person.person_demographics&.encrypted_ssn),
                                 BirthDt: individual.person.person_demographics.dob, },
                CoverageStartDt: individual.coverage_start_on,
                CoverageEndDt: individual.coverage_end_on
              }
            end
          end

          def construct_recipient(recipient)
            {
              OtherCompletePersonName: { PersonFirstNm: recipient.person.person_name.first_name,
                                         PersonLastNm: recipient.person.person_name.last_name },
              SSN: decrypt_ssn(recipient.person.person_demographics.encrypted_ssn),
              BirthDt: recipient.person.person_demographics.dob,
              UsAddressGroup: construct_address(recipient)
            }
          end

          def construct_recipient_spouse(recipient_spouse)
            {
              OtherCompletePersonName: { PersonFirstNm: recipient_spouse.person.person_name.first_name,
                                         PersonLastNm: recipient_spouse.person.person_name.last_name },
              SSN: decrypt_ssn(recipient_spouse.person.person_demographics.encrypted_ssn),
              BirthDt: recipient_spouse.person.person_demographics.dob,
            }
          end

          def construct_address(recipient)
            address = fetch_address(recipient)
            street_address = address.address_1
            street_address += ", #{address.address_2}" if address.address_2.present?
            {
              AddressLine1Txt: street_address,
              CityNm: address.city,
              USStateCd: address.state,
              USZIPCd: address.zip
            }
          end

          def fetch_address(recipient)
            if recipient.person
              recipient.person.addresses.detect { |address| address.kind == 'mailing' } || recipient.person.addresses.first
            else
              recipient.addresses.detect { |address| address.kind == 'mailing' } || recipient.addresses.first
            end
          end

          def construct_policy(policy, provider)
            {
              MarketPlacePolicyNum: policy.policy_id,
              PolicyIssuerNm: provider.title,
              PolicyStartDt: policy.start_on,
              PolicyTerminationDt: policy.end_on
            }
          end

          def fetch_recipient(tax_household, agreement, family)
            tax_filers = tax_household.covered_individuals.select { |covered_individual| covered_individual.filer_status == 'tax_filer' }
            tax_filer =
              if tax_filers.count == 1
                tax_filers[0]
              elsif tax_filers.count > 1
                tax_filers.detect { |tx_filer| tx_filer.relation_with_primary == 'self' }
              end

            return tax_filer if tax_filer.present?

            family.family_members.detect do |family_member|
              family_member.person.hbx_id == agreement.contract_holder.hbx_id
            end
          end

          def fetch_recipient_spouse(tax_household)
            tax_household.covered_individuals.detect do |covered_individual|
              covered_individual.relation_with_primary == 'spouse'
            end
          end

          def decrypt_ssn(encrypted_ssn)
            return if encrypted_ssn.blank?

            AcaEntities::Operations::Encryption::Decrypt.new.call({ value: encrypted_ssn }).value!
          end
        end
      end
    end
  end
end
