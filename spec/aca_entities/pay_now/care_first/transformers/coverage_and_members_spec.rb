# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/pay_now/care_first'

RSpec.describe AcaEntities::PayNow::CareFirst::Transformers::CoverageAndMembers do

    describe 'When a valid hash is passed' do
      let(:additional_info_payload) do
        {
            'coverage_and_members':
            {
              'hbx_enrollment': enrollment,
              'members': members
            }
        }
      end
      let(:enrollment) do
        {
            "hbx_id": "50272480",
            "effective_on": "2023-04-01",
            "aasm_state": "coverage_selected",
            "market_place_kind": "individual",
            "enrollment_period_kind": "special_enrollment",
            "terminated_on": nil,
            "product_kind": "health",
            "total_premium": 408.55,
            "applied_aptc_amount": {
                "cents": 0,
                "currency_iso": "USD"
            },
            "hbx_enrollment_members": [
                {
                    "family_member_reference": {
                        "family_member_hbx_id": "50001267",
                        "age": 37,
                        "first_name": "Benito",
                        "last_name": "Test",
                        "person_hbx_id": "50001267",
                        "is_primary_family_member": true
                    },
                    "is_subscriber": true,
                    "eligibility_date": "2023-04-01",
                    "coverage_start_on": "2023-04-01",
                    "coverage_end_on": nil,
                    "tobacco_use": "NA",
                    "slcsp_member_premium": {
                        "cents": 39771,
                        "currency_iso": "USD"
                    }
                }
            ],
            "is_receiving_assistance": false,
            "consumer_role_reference": {
                "is_active": true,
                "is_applying_coverage": true,
                "is_applicant": true,
                "is_state_resident": false,
                "lawful_presence_determination": {},
                "citizen_status": "us_citizen"
            },
            "product_reference": {
                "hios_id": "86052DC0400010-01",
                "name": "BlueChoice HMO HSA Standard $6,350",
                "active_year": 2023,
                "is_dental_only": false,
                "metal_level": "bronze",
                "benefit_market_kind": "aca_individual",
                "csr_variant_id": "01",
                "is_csr": false,
                "family_deductible": "$6350 per person | $12700 per group",
                "individual_deductible": "$6,350",
                "product_kind": "health",
                "rating_method": "Age-Based Rates",
                "pediatric_dental_ehb": 0.0,
                "family_rated_premiums": {},
                "issuer_profile_reference": {
                    "hbx_id": "88d36bc5e5054e849d67c32955ed00fd",
                    "name": "CareFirst",
                    "abbrev": "GHMSI"
                }
            },
            "issuer_profile_reference": {
                "hbx_id": "88d36bc5e5054e849d67c32955ed00fd",
                "name": "CareFirst",
                "abbrev": "GHMSI",
                "phone": "8554443121"
            },
            "special_enrollment_period_reference": {
                "qualifying_life_event_kind_reference": {
                    "start_on": "2015-10-10",
                    "title": "Lost or will soon lose other health insurance ",
                    "reason": "lost_access_to_mec",
                    "market_kind": "individual"
                },
                "qle_on": "2023-03-19",
                "start_on": "2023-01-18",
                "end_on": "2023-05-18",
                "effective_on": "2023-04-01",
                "submitted_at": "2023-03-03T19:28:28.000+00:00"
            }
        }
      end
      let(:members) do
        [member]
      end
      let(:member) do
        {}
      end

    it 'should return transformed data' do
      result = described_class.transform(additional_info_payload)
        # coverage_kind
        expect(result[:additional_information]).to have_key(:coverage_kind)
        expect(result[:additional_information][:coverage_kind]).to eq('urn:openhbx:terms:v1:qhp_benefit_coverage#health')

        # primary
        # expect(result[:additional_information]).to have_key(:primary)
        # add additional attribute expectations

        # members
        # result[:additional_information][:members].each do |member|
            # expect(member).to have_key(:exchange_assigned_member_id)
            # add additional attribute expectations
        # end
    end
  end
end