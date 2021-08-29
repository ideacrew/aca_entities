# frozen_string_literal: true

module AcaEntities
  module Functions
    # build person email
    class BenefitBuilder

      attr_reader :insurance_coverage_hash

      def call(memoized_data, member)
        @insurance_coverage_hash = memoized_data.find(Regexp.new("attestations.members.#{member.name.split('.').last}.insuranceCoverage"))&.first&.item

        member_benefits
      end

      private

      def member_benefits
        {
          has_enrolled_health_coverage: !benefits_hash.empty?, # default value
          has_eligible_health_coverage: !benefits_hash.empty?, # default value
          benefits: (benefits_hash + benefits_esc_hash)
        }
      end

      def benefits_hash
        return [] if insurance_coverage_hash.nil?

        result = []
        %w[is_enrolled is_eligible].each do |status| # default loop , should get value from payload
          insurance_coverage_hash[:enrolledCoverages].each do |ic|
            next if ic[:insuranceMarketType] == 'NONE'

            result << {
                'kind' => "private_individual_and_family_coverage", # TODO: check this value #[:insuranceMarketType]&.downcase, # default value
                'status' => status,
                # 'insurance_kind' => ic['insuranceMarketType'],
                'start_on' => Date.parse('2021-01-01'), # default value
                'end_on' => nil
            }
          end
        end
        result
      end

      def benefits_esc_hash
        return [] if insurance_coverage_hash.nil?
        return [] if insurance_coverage_hash[:employerSponsoredCoverageOffers].nil?
        insurance_coverage_hash[:employerSponsoredCoverageOffers].each_with_object([]) do |(_k, esc), result|
          begin
            result << {
                'employee_cost' => (esc[:lcsopPremium] || "0.0"),
                'kind' => 'employer_sponsored_insurance', # default value
                'status' => 'is_enrolled', # default value
                # 'insurance_kind' => 'employer_sponsored_insurance', # default value
                :employer => { employer_name: esc[:employer][:name],
                               employer_id: '123456789' }, # default value
                'is_esi_waiting_period' => esc[:waitingPeriodIndicator],
                'is_esi_mec_met' => esc[:employerOffersMinValuePlan],
                'esi_covered' => 'self', # default value
                'start_on' => Date.parse('2021-01-01'), # default value
                'end_on' => nil,
                'employee_cost_frequency' => (esc[:lcsopPremiumFrequencyType]&.capitalize || "Monthly"),
                'employer_address' =>
                    {
                        'address_1' => '21313312', # default value
                        'address_2' => '',
                        'address_3' => '',
                        'county' => '',
                        'country_name' => '',
                        'kind' => 'work', # default value
                        'city' => 'was',  # default value
                        'state' => 'DC',  # default value
                        'zip' => '31232'
                    }, # default value
                'employer_phone' =>
                    {
                        'kind' => 'work', # default value
                        'country_code' => '',
                        'area_code' => emp_phone(esc).nil? ? nil : emp_phone(esc)[0..2],
                        'number' => emp_phone(esc).nil? ? nil : emp_phone(esc)[3..9],
                        'extension' => '',
                        'full_phone_number' => emp_phone(esc).nil? ? nil : emp_phone(esc)
                    }
            }
          rescue StandardError => e
            puts "error in benefits_esc_hash #{e}"
          end
          result
        end
      end

      # TODO: refactor
      def emp_phone(esc)
        if !esc[:employer][:employerPhoneNumber].nil?
          esc[:employer][:employerPhoneNumber]
        elsif !esc[:employer][:contact].nil?
          esc[:employer][:contact][:phoneNumber]
        end
      end
    end
  end
end

