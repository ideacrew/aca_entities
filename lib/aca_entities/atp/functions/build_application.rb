# frozen_string_literal: true

# rubocop:disable Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity, Metrics/MethodLength, Layout/LineLength, Metrics/AbcSize, Metrics/ClassLength
module AcaEntities
  module Atp
    module Functions
      # build application and applicants
      class BuildApplication
        def call(cache)
          @memoized_data = cache
          insurance_applicants = @memoized_data.resolve(:'insurance_application.insurance_applicants').item
          @primary_applicant_identifier = @memoized_data.resolve(:primary_applicant_identifier).item

          result = insurance_applicants.each_with_object([]) do |applicant, collector|

            @applicant_hash = applicant[1]
            @applicant_identifier = @applicant_hash[:id]
            @member_hash = @memoized_data.find(Regexp.new("record.people.#{@applicant_identifier}.augementation")).first.item

            # @applicant_identifier = member.name.split('.').last

            # m_identifier = "attestations.members.#{@applicant_identifier}"
            # @attestations_family_hash = @memoized_data.find(Regexp.new("#{m_identifier}.family"))&.first&.item
            @incomes_hash = @memoized_data.find(Regexp.new("record.people.#{@applicant_identifier}.augementation")).first.item[:incomes]
            @employments_hash = @memoized_data.find(Regexp.new("record.people.#{@applicant_identifier}.augementation")).first.item[:employments]
            # @insurance_coverage_hash = @memoized_data.find(Regexp.new("#{m_identifier}.insuranceCoverage"))&.first&.item

            # collector << member.item.merge!(applicant_hash)
            collector << applicant_hash
            collector
          end

          [application_hash.merge!(applicants: result)]
        end

        private

        def application_hash
          {
            hbx_id: '1234', # default value
            us_state: 'ME', # default value
            assistance_year: 2021, # default_value
            parent_living_out_of_home_terms: @memoized_data.resolve('parent_living_out_of_home_terms').item,
            report_change_terms: @memoized_data.resolve('report_change_terms').item,
            medicaid_terms: @memoized_data.resolve('medicaid_terms').item,
            is_renewal_authorized: @memoized_data.resolve('is_renewal_authorized').item,
            family_reference: { hbx_id: @memoized_data.resolve('family.hbx_id').item.to_s }
          }
        end

        def income_hash
          return [] if @incomes_hash.nil?

          result = job_income_hash
          result << self_emp_income_hash[0] unless self_emp_income_hash.empty?
          result << unemp_income_hash[0] unless unemp_income_hash.empty?
          result << other_income_hash[0] unless other_income_hash.empty?
          result
        end

        INCOME_FREQUENCY_MAP = { "annually" => "yearly",
                                 'biweekly' => 'biweekly',
                                 'daily' => 'daily',
                                 'half_yearly' => 'half_yearly',
                                 'monthly' => 'monthly',
                                 'quarterly' => 'quarterly',
                                 'weekly' => 'weekly' }.freeze

        def job_income_hash
          return [] if @incomes_hash.nil?

          @incomes_hash.each_with_object([]) do |income, result|
            next unless income[:category_code] == 'Wages'
            employer_hash = @employments_hash.select {|hash| hash[:employer][:employer_id] == income[:source_organization_reference][:ref]}.first
            contact_information = employer_hash[:employer][:organization_primary_contact_information] if employer_hash
            result << {
              'kind' => 'wages_and_salaries',
              'amount' => income[:amount],
              'amount_tax_exempt' => 0,
              'employer_name' => employer_hash ? employer_hash[:employer][:category_text] : nil,
              'frequency_kind' => INCOME_FREQUENCY_MAP[income[:frequency][:frequency_code].downcase],
              'start_on' => Date.parse('2021-05-07').to_s, # default value
              'end_on' => nil,
              'is_projected' => false, # default value
              'employer_address' =>
              if contact_information
                {
                  'address_1' => contact_information[:mailing_address] || '123test', # default value
                  'address_2' => '',
                  'address_3' => '',
                  'county' => '',
                  'country_name' => '',
                  'kind' => 'work', # default value
                  'city' => contact_information[:mailing_address] || 'was', # default value
                  'state' => contact_information[:mailing_address] || 'DC', # default value
                  'zip' => contact_information[:mailing_address] || '23421' # default value
                }
              end,
              'employer_phone' =>
              if contact_information
                {
                  'kind' => 'work', # default value
                  'country_code' => '',
                  'area_code' => contact_information[:telephone_number][0..2] || '987', # default value
                  'number' => contact_information[:telephone_number][3..9] || '6547890', # default value
                  'extension' => '',
                  'full_phone_number' => contact_information[:telephone_number] || '9876547890' # default value
                }
              end
            }
            result
          end
        end

        def self_emp_income_hash
          return [] if @incomes_hash.nil?

          @incomes_hash.each_with_object([]) do |income, result|
            next unless income[:category_code] == 'SelfEmployment'

            result << {
              'kind' => 'net_self_employment',
              'amount' => income[:amount],
              'amount_tax_exempt' => 0,
              'frequency_kind' => income[:frequency][:frequency_code].capitalize,
              'start_on' => Date.parse('2021-05-07'), # default value
              'end_on' => nil,
              'is_projected' => false
            }
            result
          end
        end

        # Wages
        # Unemployment
        # Unspecified
        # SelfEmployment
        # SocialSecurity
        # Pension
        # RentalOrRoyalty
        # Retirement
        # Interest
        # Alimony
        # CapitalGains
        # CashSupport
        # Scholarship
        # FarmingOrFishing

        def unemp_income_hash
          return if @incomes_hash.nil?

          @incomes_hash.each_with_object([]) do |income, result|
            next unless income[:category_code] == 'Unemployment'

            result << {
              "kind" => "unemployment_income",
              "amount" => income[:amount],
              "amount_tax_exempt" => 0, # default value
              'frequency_kind' => income[:frequency][:frequency_code].capitalize,
              "start_on" => Date.parse('2021-05-07'), # default value
              "end_on" => nil,
              "is_projected" => false # default value
            }
            result
          end
        end

        OTHER_INCOME_TYPE_KIND = {
          Alimony: 'alimony_and_maintenance',
          CapitalGains: 'Capital gains',
          dividend: 'Dividends',
          Interest: 'Interest',
          Pension: 'Pension or retirement',
          Retirement: 'Pension or retirement',
          RENTAL_OR_ROYALTY_INCOME: 'rental_and_royalty',
          SocialSecurity: 'Social Security',
          american_indian_and_alaskan_native: 'American Indian/Alaska Native income',
          employer_funded_disability: 'Employer-funded disability payments',
          estate_trust: 'Estate and trust',
          FarmingOrFishing: 'Farming or fishing',
          foreign: 'Foreign income',
          other: 'Other taxable income',
          INVESTMENT_INCOME: 'INVESTMENT_INCOME',
          prizes_and_awards: 'Prizes and awards',
          Scholarship: 'Taxable scholarship payments'
        }.freeze

        def other_income_hash
          return [] if @incomes_hash.nil?

          @incomes_hash.each_with_object([]) do |income, result|
            next if OTHER_INCOME_TYPE_KIND[:"#{income[:category_code]}"].nil?

            result << {
              'kind' => OTHER_INCOME_TYPE_KIND[:"#{income[:category_code]}"],
              'amount' => income[:amount],
              'amount_tax_exempt' => 0,
              'frequency_kind' => income[:frequency][:frequency_code].capitalize,
              'start_on' => Date.parse('2021-05-07'), # default value
              'end_on' => nil,
              'is_projected' => false
            }
            result
          end
        end

        DEDUCTION_TYPE = {
          ALIMONY_PAYMENT: 'alimony_paid',
          deductable_part_of_self_employment_taxes: 'Deductible part of self-employment taxes',
          domestic_production_activities: 'Domestic production activities deduction',
          penalty_on_early_withdrawal_of_savings: 'Penalty on early withdrawal of savings',
          educator_expenses: 'Educator expenses',
          self_employment_sep_simple_and_qualified_plans: 'Self-employmed SEP, SIMPLE, and qualified plans',
          self_employed_health_insurance: 'Self-employed health insurance',
          student_loan_interest: 'Student loan interest',
          moving_expenses: 'Moving expenses',
          health_savings_account: 'Health savings account',
          ira_deduction: 'IRA deduction',
          reservists_performing_artists_and_fee_basis_government_official_expenses: 'Certain business expenses of reservists, performing artists, and fee-basis government officials',
          tuition_and_fees: 'Tuition and fees',
          OTHER_DEDUCTION: 'OTHER_DEDUCTION'
        }.freeze

        def deduction_hash
          return [] if @incomes_hash.nil?

          @incomes_hash.each_with_object([]) do |income, result|
            next if DEDUCTION_TYPE[:"#{income[:incomeSourceType]}"].nil?

            result << {
              'kind' => DEDUCTION_TYPE[:"#{income[:incomeSourceType]}"],
              'amount' => income[:incomeAmount],
              'amount_tax_exempt' => 0,
              'frequency_kind' => income[:incomeFrequencyType].capitalize,
              'start_on' => Date.parse('2021-05-07'), # default value
              'end_on' => nil,
              'is_projected' => false
            }
            result
          end
        end

        def benefits_hash
          return [] if @applicant_hash[:esi_associations].empty?

          result = []
          # esi_associations = @applicant_hash[:esi_associations].first
          %w[is_enrolled is_eligible].each do |status| # default loop , should get value from payload
            # @insurance_coverage_hash[:enrolledCoverages].each do |ic|
            # next if ic[:insuranceMarketType] == 'NONE'

            result << {
              'kind' => nil, # default value
              'status' => status,
              # 'insurance_kind' => ic['insuranceMarketType'],
              'start_on' => Date.parse('2021-05-07'), # default value
              'end_on' => nil
            }
            # end
          end
          result
        end

        def benefits_esc_hash
          return [] if @applicant_hash[:esi_associations].empty?

          []
          # @insurance_coverage_hash[:employerSponsoredCoverageOffers].each_with_object([]) do |(_k, esc), result|
          #   result << {
          #     'employee_cost' => esc[:lcsopPremium],
          #     'kind' => 'employer_sponsored_insurance', # default value
          #     'status' => 'is_enrolled', # default value
          #     # 'insurance_kind' => 'employer_sponsored_insurance', # default value
          #     :employer => { employer_name: esc[:employer][:name],
          #                    employer_id: '123456789' }, # default value
          #     'is_esi_waiting_period' => esc[:waitingPeriodIndicator],
          #     'is_esi_mec_met' => esc[:employerOffersMinValuePlan],
          #     'esi_covered' => 'self', # default value
          #     'start_on' => Date.parse('2021-05-07'), # default value
          #     'end_on' => nil,
          #     'employee_cost_frequency' => esc[:lcsopPremiumFrequencyType]&.capitalize,
          #     'employer_address' =>
          #     {
          #       'address_1' => '21313312', # default value
          #       'address_2' => '',
          #       'address_3' => '',
          #       'county' => '',
          #       'country_name' => '',
          #       'kind' => 'work', # default value
          #       'city' => 'was',  # default value
          #       'state' => 'DC',  # default value
          #       'zip' => '31232'
          #     }, # default value
          #     'employer_phone' =>
          #     {
          #       'kind' => 'work', # default value
          #       'country_code' => '',
          #       'area_code' => esc[:employer][:employerPhoneNumber][0..2],
          #       'number' => esc[:employer][:employerPhoneNumber][3..9],
          #       'extension' => '',
          #       'full_phone_number' => esc[:employer][:employerPhoneNumber]
          #     }
          #   }

          # end
        end

        def name_hash
          { first_name: @memoized_data.find(Regexp.new("first_name.#{@applicant_identifier}"))&.first&.item,
            middle_name: @memoized_data.find(Regexp.new("middle_name.#{@applicant_identifier}"))&.first&.item || '',
            # default value, create new contract and entities for create family and IAP
            last_name: @memoized_data.find(Regexp.new("last_name.#{@applicant_identifier}"))&.first&.item,
            name_sfx: @memoized_data.find(Regexp.new("name_sfx.#{@applicant_identifier}"))&.first&.item || '',
            name_pfx: @memoized_data.find(Regexp.new("name_pfx.#{@applicant_identifier}"))&.first&.item || '',
            full_name: [@memoized_data.find(Regexp.new("first_name.#{@applicant_identifier}"))&.first&.item,
                        @memoized_data.find(Regexp.new("last_name.#{@applicant_identifier}"))&.first&.item].join(' '),
            alternate_name: @memoized_data.find(Regexp.new("alternate_name.#{@applicant_identifier}"))&.first&.item || 'nil' }
        end

        def demographic_hash
          { gender: @memoized_data.find(Regexp.new("person_demographics.gender.#{@applicant_identifier}"))&.first&.item&.capitalize,
            dob: @memoized_data.find(Regexp.new("person_demographics.dob.#{@applicant_identifier}"))&.first&.item,
            ethnicity: [],
            race: nil,
            is_veteran_or_active_military: @member_hash[:us_verteran_indicator] || false,
            is_vets_spouse_or_child: nil }
        end

        def attestation_hash
          # TODO: refactor for multiple entries of incarcerations
          {
            is_incarcerated: @applicant_hash[:incarcerations].first[:incarceration_indicator],
            is_self_attested_disabled: false, # default value
            is_self_attested_blind: false, # default value
            is_self_attested_long_term_care: false # default value
          }
        end

        def pregnancy_information_hash
          pregancy_info = @member_hash[:pregnancy_status]
          {
            is_pregnant: pregancy_info[:status_indicator] || false,
            is_enrolled_on_medicaid: nil,
            is_post_partum_period: false, # default value
            expected_children_count: pregancy_info[:expected_baby_quantity],
            pregnancy_due_on: pregancy_info[:status_indicator] ? Date.today.prev_month : nil, # default value
            pregnancy_end_on: nil
          }
        end

        def foster_care_hash
          {
            is_former_foster_care: @applicant_hash[:foster_care_indicator],
            age_left_foster_care: @applicant_hash[:age_left_foster_care],
            foster_care_us_state: @applicant_hash[:foster_care_state],
            had_medicaid_during_foster_care: @applicant_hash[:had_medicaid_during_foster_care_indicator]
          }
        end

        def student_hash
          {
            is_student: @applicant_hash[:student_indicator] || false, # default value
            student_kind: nil, # needs refactor for other student kinds
            student_school_kind: nil,
            student_status_end_on: nil
          }
        end

        def family_member_reference_hash
          {
            family_member_hbx_id: '1234', # default value
            first_name: @memoized_data.find(Regexp.new("first_name.#{@applicant_identifier}"))&.first&.item,
            last_name: @memoized_data.find(Regexp.new("last_name.#{@applicant_identifier}"))&.first&.item,
            person_hbx_id: '1234', # default value
            is_primary_family_member: @primary_applicant_identifier == @applicant_identifier
          }
        end

        def citizenship_immigration_hash
          { citizen_status: AcaEntities::Atp::Functions::LawfulPresenceDeterminationBuilder.new.call(@memoized_data, @applicant_identifier),
            is_resident_post_092296: nil,
            is_lawful_presence_self_attested: nil }
        end

        def applicant_hash
          non_magi = @memoized_data.find(Regexp.new('attestations.members.*.nonMagi')).map(&:item).last

          {
            is_primary_applicant: @applicant_identifier == @primary_applicant_identifier,
            name: name_hash,
            identifying_information: { encrypted_ssn: nil,
                                       has_ssn: !@memoized_data.find(Regexp.new("person_demographics.ssn.#{@applicant_identifier}"))&.first&.item.nil? },
            demographic: demographic_hash,
            attestation: attestation_hash,
            native_american_information: nil,
            citizenship_immigration_status_information: citizenship_immigration_hash,
            is_consumer_role: true, # default value
            is_resident_role: nil,
            is_applying_coverage: true, # default value
            is_consent_applicant: nil,
            vlp_document: nil,
            family_member_reference: family_member_reference_hash,
            person_hbx_id: '1234', # default value
            is_required_to_file_taxes: false, # default value
            tax_filer_kind: 'tax_filer', # default value . #To memoise and extract data from taxRelationships
            is_joint_tax_filing: false, # default value
            # # add method to check for joint filing using this value
            is_claimed_as_tax_dependent: false, # default value
            claimed_as_tax_dependent_by: nil, # default value
            student: student_hash,
            is_refugee: nil, # default value
            is_trafficking_victim: nil, # default value
            foster_care: foster_care_hash,
            pregnancy_information: pregnancy_information_hash,
            is_subject_to_five_year_bar: nil, # default value
            is_five_year_bar_met: nil, # default value
            is_forty_quarters: nil, # default value
            is_ssn_applied: nil, # default value
            non_ssn_apply_reason: nil, # default value
            moved_on_or_after_welfare_reformed_law: nil, # default value
            is_currently_enrolled_in_health_plan: nil, # default value
            has_daily_living_help: @applicant_hash[:long_term_care_indicator],
            need_help_paying_bills: false, # default value
            has_job_income: !job_income_hash.empty?,
            has_self_employment_income: !self_emp_income_hash.empty?,
            has_unemployment_income: !unemp_income_hash.empty?,
            has_other_income: !other_income_hash.empty?,
            has_deductions: !deduction_hash.empty?,
            has_enrolled_health_coverage: !benefits_hash.empty?, # default value
            has_eligible_health_coverage: !benefits_hash.empty?, # default value
            addresses: AcaEntities::Atp::Functions::AddressBuilder.new.call(@memoized_data, @applicant_identifier), # default value
            emails: email_hash, # default value
            phones: phone_hash, # default value
            incomes: income_hash || [],
            benefits: benefits_hash << benefits_esc_hash[0] || [],
            deductions: deduction_hash || [],
            is_medicare_eligible: false, # default value
            has_insurance: false, # default value
            has_state_health_benefit: false, # default value
            had_prior_insurance: false, # default value
            # prior_insurance_end_date: Date.parse("2021-05-07"), # default value
            age_of_applicant: AcaEntities::Functions::AgeOn.new(on_date: Date.today.strftime('%Y/%m/%d'))
                                                           .call(Date.strptime(@memoized_data.find(Regexp.new("person_demographics.dob.#{@applicant_identifier}"))&.first&.item, "%m/%d/%Y").strftime('%Y/%m/%d')),
            is_self_attested_long_term_care: non_magi.nil? ? false : non_magi[:longTermCareIndicator],
            hours_worked_per_week: '2'
          }
        end

        def email_hash
          contacts_information = @member_hash[:contacts]
          contacts_information.each_with_object([]) do |contact_info, collector|
            if contact_info.dig(:contact, :email_id)
              collector << { address: contact_info.dig(:contact, :email_id), kind: contact_info[:category_code].downcase }
            end
          end
        end

        def phone_hash
          contacts_information = @member_hash[:contacts]
          contacts_information.each_with_object([]) do |contact_info, collector|
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
        end
      end
    end
  end
end
# rubocop:enable Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity, Metrics/MethodLength, Layout/LineLength, Metrics/AbcSize, Metrics/ClassLength
