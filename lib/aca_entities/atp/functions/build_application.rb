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
          @tax_return = @memoized_data.resolve(:'insurance_application.tax_returns').item
          people_augementation = @memoized_data.find(Regexp.new("record.people.*.augementation"))

          result = people_augementation.each_with_object([]) do |person_augementation, collector|
            id = person_augementation.name.split(".")[2]
            @applicant_hash = insurance_applicants[id.to_sym]
            @applicant_identifier = id
            @member_hash = person_augementation.item

            @tribal_augmentation = @memoized_data.find(Regexp.new("record.people.#{id}.tribal_augmentation")).map(&:item).last

            # @applicant_identifier = member.name.split('.').last

            # m_identifier = "attestations.members.#{@applicant_identifier}"
            # @attestations_family_hash = @=.find(Regexp.new("#{m_identifier}.family"))&.first&.item
            @incomes_hash = @member_hash[:incomes]
            @expenses_hash = @member_hash[:expenses]
            @employments_hash = @member_hash[:employments]
            # @insurance_coverage_hash = @memoized_data.find(Regexp.new("#{m_identifier}.insuranceCoverage"))&.first&.item

            # collector << member.item.merge!(applicant_hash)
            collector << applicant_hash
            collector
          end

          # result = insurance_applicants.each_with_object([]) do |applicant, collector|

          #   @applicant_hash = applicant[1]
          #   @applicant_identifier = @applicant_hash[:id]
          #   @member_hash = @memoized_data.find(Regexp.new("record.people.#{@applicant_identifier}.augementation")).first.item

          #   # @applicant_identifier = member.name.split('.').last

          #   # m_identifier = "attestations.members.#{@applicant_identifier}"
          #   # @attestations_family_hash = @memoized_data.find(Regexp.new("#{m_identifier}.family"))&.first&.item
          #   @incomes_hash = @memoized_data.find(Regexp.new("record.people.#{@applicant_identifier}.augementation")).first.item[:incomes]
          #   @expenses_hash = @memoized_data.find(Regexp.new("record.people.#{@applicant_identifier}.augementation")).first.item[:expenses]
          #   @employments_hash = @memoized_data.find(Regexp.new("record.people.#{@applicant_identifier}.augementation")).first.item[:employments]
          #   # @insurance_coverage_hash = @memoized_data.find(Regexp.new("#{m_identifier}.insuranceCoverage"))&.first&.item

          #   # collector << member.item.merge!(applicant_hash)
          #   collector << applicant_hash
          #   collector
          # end

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
          # result << self_emp_income_hash[0] unless self_emp_income_hash.empty?
          result.concat(self_emp_income_hash)
          # result << unemp_income_hash[0] unless unemp_income_hash.empty?
          result.concat(unemp_income_hash)
          # result << other_income_hash[0] unless other_income_hash.empty?
          result.concat(other_income_hash)
          result
        end

        FREQUENCY_CODE_MAP = { "annually" => "yearly",
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
            employer_hash = @employments_hash.select {|hash| hash[:employer][:id] == income[:source_organization_reference][:ref]}.first
            contact_information = employer_hash[:employer][:organization_primary_contact_information] if employer_hash
            date_range = income[:earned_date_range]
            result << {
              'kind' => 'wages_and_salaries',
              'amount' => income[:amount],
              'amount_tax_exempt' => 0,
              'employer_name' => employer_hash ? employer_hash[:employer][:category_text] : nil,
              'frequency_kind' => FREQUENCY_CODE_MAP[income[:frequency][:frequency_code].downcase],
              'start_on' => (date_range && date_range[:start_date]) ? income[:earned_date_range][:start_date][:date] : nil,
              'end_on' => (date_range && date_range[:end_date]) ? income[:earned_date_range][:end_date][:date] : nil,
              'is_projected' => false, # default value
              'employer_address' =>
              if contact_information && contact_information[:mailing_address] && contact_information[:mailing_address][:address]
                mailing = contact_information[:mailing_address][:address]
                # Check presence of required fields
                if !mailing[:location_street].nil? && !mailing[:location_city_name].nil? && !mailing[:location_state_us_postal_service_code].nil? && !mailing[:location_postal_code].nil?
                  {
                    'address_1' => mailing[:location_street][:street_full_text],
                    'address_2' => mailing[:address_secondary_unit_text],
                    'address_3' => '',
                    'county' => mailing[:location_county_name],
                    'country_name' => '',
                    'kind' => 'work',
                    'city' => mailing[:location_city_name],
                    'state' => mailing[:location_state_us_postal_service_code],
                    'zip' => mailing[:location_postal_code]
                    # 'address_1' => mailing[:location_street][:street_full_text] || '123test', # default value
                    # 'address_2' => mailing[:address_secondary_unit_text],
                    # 'address_3' => '',
                    # 'county' => mailing[:location_county_name],
                    # 'country_name' => '',
                    # 'kind' => 'work', # default value
                    # 'city' => mailing[:location_city_name] || 'was', # default value
                    # 'state' => mailing[:location_state_us_postal_service_code] || 'DC', # default value
                    # 'zip' => mailing[:location_postal_code] || '23421' # default value
                  }
                end
              end,
              'employer_phone' =>
              if contact_information && contact_information[:telephone_number]
                {
                  'kind' => 'work', # default value
                  'country_code' => '',
                  # 'area_code' => contact_information[:telephone_number][0..2] || '987', # default value
                  # 'number' => contact_information[:telephone_number][3..9] || '6547890', # default value
                  # 'extension' => '',
                  # 'full_phone_number' => contact_information[:telephone_number] || '9876547890' # default value
                  'area_code' => contact_information[:telephone_number][0..2],
                  'number' => contact_information[:telephone_number][3..9],
                  'extension' => '',
                  'full_phone_number' => contact_information[:telephone_number]
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

            date_range = income[:earned_date_range]
            start_date = date_range ? date_range[:start_date] : nil
            end_date = date_range ? date_range[:end_date] : nil

            result << {
              'kind' => 'net_self_employment',
              'amount' => income[:amount],
              'amount_tax_exempt' => 0,
              'frequency_kind' => FREQUENCY_CODE_MAP[income[:frequency][:frequency_code].downcase],
              'start_on' => start_date ? start_date[:date] : nil,
              'end_on' => end_date ? end_date[:date] : nil,
              'is_projected' => false
            }
            result
          end
        end

        def unemp_income_hash
          return if @incomes_hash.nil?

          @incomes_hash.each_with_object([]) do |income, result|
            next unless income[:category_code] == 'Unemployment'

            date_range = income[:earned_date_range]
            start_date = date_range ? date_range[:start_date] : nil
            end_date = date_range ? date_range[:end_date] : nil

            result << {
              "kind" => "unemployment_income",
              "amount" => income[:amount],
              "amount_tax_exempt" => 0, # default value
              'frequency_kind' => FREQUENCY_CODE_MAP[income[:frequency][:frequency_code].downcase],      
              'start_on' => start_date ? start_date[:date] : nil,
              'end_on' => end_date ? end_date[:date] : nil,
              "is_projected" => false # default value
            }
            result
          end
        end

        OTHER_INCOME_TYPE_KIND = {
          'Alimony' => 'alimony_and_maintenance',
          'CapitalGains' => 'capital_gains',
          'Interest' => 'interest',
          'Pension' => 'pension_retirement_benefits',
          'Retirement' => 'pension_retirement_benefits',
          'RentalOrRoyalty' => 'rental_and_royalty',
          'SocialSecurity' => 'social_security_benefit',
          'FarmingOrFishing' => 'farming_and_fishing',
          'Unspecified' => 'other',
          'Winnings' => 'prizes_and_awards',
          'Scholarship' => 'scholorship_payments',
          'CanceledDebt' => 'other',
          'CourtAward' => 'other',
          'JuryDuty' => 'other',
          'CashSupport' => 'other'
        }.freeze

        def other_income_hash
          return [] if @incomes_hash.nil?

          @incomes_hash.each_with_object([]) do |income, result|
            next if OTHER_INCOME_TYPE_KIND[income[:category_code]].nil?

            date_range = income[:earned_date_range]
            start_date = date_range ? date_range[:start_date] : nil
            end_date = date_range ? date_range[:end_date] : nil

            result << {
              'kind' => OTHER_INCOME_TYPE_KIND[income[:category_code]].downcase,
              'amount' => income[:amount],
              'amount_tax_exempt' => 0,
              'frequency_kind' => FREQUENCY_CODE_MAP[income[:frequency][:frequency_code].downcase],
              # 'start_on' => (date_range && date_range[:start_date]) ? income[:earned_date_range][:start_date][:date] :Date.parse('2021-05-07').to_s, # default value
              # 'end_on' => (date_range && date_range[:end_date]) ? income[:earned_date_range][:end_date][:date] : nil, # default value,
              'start_on' => start_date ? start_date[:date] : nil,
              'end_on' => end_date ? end_date[:date] : nil,
              'is_projected' => false
            }
            result
          end
        end

        DEDUCTION_TYPE = {
          'Alimony' => 'alimony_paid',
          # 'Deductible part of self-employment taxes' => 'deductable_part_of_self_employment_taxes',
          # 'Domestic production activities deduction' => 'domestic_production_activities',
          # 'Penalty on early withdrawal of savings' => 'penalty_on_early_withdrawal_of_savings',
          # 'Educator expenses' => 'educator_expenses',
          # 'Self-employmed SEP, SIMPLE, and qualified plans' => 'self_employment_sep_simple_and_qualified_plans',
          # 'Self-employed health insurance' => 'self_employed_health_insurance',
          # 'Moving expenses' => 'moving_expenses',
          # 'Health savings account' => 'health_savings_account',
          # 'IRA deduction' => 'ira_deduction',
          # 'Certain business expenses of reservists, performing artists, and fee-basis government officials' => 'reservists_performing_artists_and_fee_basis_government_official_expenses',
          # 'Tuition and fees' => 'tuition_and_fees',
          # 'OTHER_DEDUCTION' => 'OTHER_DEDUCTION',
          'StudentLoanInterest' => 'student_loan_interest'
        }.freeze

        def deduction_hash
          return [] if @expenses_hash.nil?

          @expenses_hash.each_with_object([]) do |expense, result|
            next if DEDUCTION_TYPE[expense[:category_code]].nil?
            result << {
              'kind' => DEDUCTION_TYPE[expense[:category_code]],
              'amount' => expense[:amount],
              'frequency_kind' => FREQUENCY_CODE_MAP[expense[:frequency][:frequency_code].downcase]
              # 'start_on' => (date_range && date_range[:start_date]) ? income[:earned_date_range][:start_date][:date] : Date.parse('2021-05-07').to_s, # default value
              # 'end_on' => (date_range && date_range[:end_date]) ? income[:earned_date_range][:end_date][:date] : nil # default value
            }
            result
          end
        end

        INSURANCE_KINDS = {
          'Private' => 'private_individual_and_family_coverage',
          'CHIP' => 'child_health_insurance_plan',
          'Medicaid' => 'medicaid',
          'Medicare' => 'medicare',
          'TRICARE' => 'tricare',
          'COBRA' => 'cobra',
          'VeteranHealthProgram' => 'veterans_benefits',
          'PeaceCorps' => 'health_care_for_peace_corp_volunteers',
          'Employer' => "employer_sponsored_insurance",    
          'UnspecifiedFullCoverage' => 'other_full_benefit_coverage',
          'UnspecifiedLimitedCoverage' => 'other_limited_benefit_coverage'
        }.freeze

        def benefits_hash
          return [] if @applicant_hash.nil?
          # return [] if @applicant_hash[:esi_associations].empty?
          return [] if @applicant_hash[:non_esi_coverage_indicators].empty? || !@applicant_hash[:non_esi_coverage_indicators].first
          return [] if @applicant_hash[:non_esi_policies].empty?

          result = []

          @applicant_hash[:non_esi_policies].each do |policy|
            result << {
              'kind' => 'is_enrolled', # default value
              'insurance_kind' => INSURANCE_KINDS[policy[:source_code]],
              'start_on' => Date.new(Date.today.year, 1, 1), # default value
              'end_on' => nil
            }
          end
          # esi_associations = @applicant_hash[:esi_associations].first
          # %w[is_enrolled is_eligible].each do |status| # default loop , should get value from payload
          # @insurance_coverage_hash[:enrolledCoverages].each do |ic|
          # next if ic[:insuranceMarketType] == 'NONE'

          #   result << {
          #     'kind' => status, # default value
          #     # 'insurance_kind' => ic['insuranceMarketType'],
          #     'start_on' => Date.parse('2021-05-07'), # default value
          #     'end_on' => nil
          #   }
          #   # end
          # end
          result
        end

        def benefits_esc_hash
          return [] if @applicant_hash.nil?
          return [] if @applicant_hash[:esi_associations].empty?

          result = []
          @applicant_hash[:esi_associations].each do |esi|              
            result << {
              'esi_covered' => 'self', # default value
              'kind' => esi[:enrolled_indicator] ? 'is_enrolled' : nil,
              'insurance_kind' => INSURANCE_KINDS['Employer'],
              'is_esi_waiting_period' => nil, # default value
              'is_esi_mec_met' => nil, # default value
              'start_on' => Date.new(Date.today.year, 1, 1), # default value
              'end_on' => nil
            }
          end
          result
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
          if @applicant_hash.nil?
            {
              is_incarcerated: false,
              is_self_attested_disabled: false,
              is_self_attested_blind: false,
              is_self_attested_long_term_care: false
            }
          else
            incarceration = @applicant_hash[:incarcerations].first[:incarceration_indicator]
            disability = @applicant_hash[:blindness_or_disability_indicator]
            long_term_care = @applicant_hash[:long_term_care_indicator]
            {
              is_incarcerated: incarceration.nil? ? false : incarceration,
              is_self_attested_disabled: disability.nil? ? false : disability,
              is_self_attested_blind: disability ? nil : false,
              is_self_attested_long_term_care: long_term_care.nil? ? false : long_term_care
            }
          end
        end

        def pregnancy_information_hash
          pregancy_info = @member_hash[:pregnancy_status]
          {
            is_pregnant: pregancy_info.nil? ? false : pregancy_info[:status_indicator],
            is_enrolled_on_medicaid: nil,
            is_post_partum_period: false, # default value
            expected_children_count: pregancy_info.nil? ? 0 : pregancy_info[:expected_baby_quantity],
            pregnancy_due_on: nil, # default value
            pregnancy_end_on: nil
          }
        end

        def foster_care_hash
          {
            is_former_foster_care: @applicant_hash.nil? ? false : @applicant_hash[:foster_care_indicator],
            age_left_foster_care: @applicant_hash.nil? ? nil : @applicant_hash[:age_left_foster_care],
            foster_care_us_state: @applicant_hash.nil? ? nil : @applicant_hash[:foster_care_state],
            had_medicaid_during_foster_care: @applicant_hash.nil? ? nil : @applicant_hash[:had_medicaid_during_foster_care_indicator]
          }
        end

        def student_hash
          {
            is_student: @applicant_hash.nil? ? false : (@applicant_hash[:student_indicator] || false), # default value
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

        TAX_FILER_KIND = {
          "0" => "single",
          "1" => "single",
          "2" => "joint",
          "3" => "separate",
          "4" => "tax_filer",
          "5" => "tax_filer",
          "6" => "separate",
          "7" => "tax_filer"
        }.freeze

        def applicant_hash
          # non_magi = @memoized_data.find(Regexp.new('attestations.members.*.nonMagi')).map(&:item).last
          applicant_is_primary_tax_filer = @tax_return[:tax_household][:primary_tax_filer][:role_reference][:ref] == @applicant_identifier
          tax_dependents = @tax_return.nil? ? nil : @tax_return[:tax_household][:tax_dependents].collect {|a| a[:role_reference][:ref]}

          is_tax_filer = if !@tax_return.nil? && @tax_return[:tax_household]
                           if applicant_is_primary_tax_filer
                             true
                           else
                             @tax_return[:tax_household][:spouse_tax_filer] == @applicant_identifier
                           end
                         else
                           false
                         end

          tribe_indicator = @tribal_augmentation[:american_indian_or_alaska_native_indicator]

          joint_tax_filing_status = @tax_return[:status_code] == '2' if is_tax_filer

          is_head_of_household =  if !@tax_return.nil? && @tax_return[:tax_household] && applicant_is_primary_tax_filer
                                    @tax_return[:status_code] == '4' || @tax_return[:status_code] == '7'
                                  end
          lawful_presence_status = @applicant_hash[:lawful_presence_status] if @applicant_hash
          lawful_presence_status_eligibility =  if lawful_presence_status && lawful_presence_status[:lawful_presence_status_eligibility]
                                                  lawful_presence_status[:lawful_presence_status_eligibility][:eligibility_indicator] ? true : nil
                                                else
                                                  nil
                                                end
binding.pry
          {
            is_primary_applicant: @applicant_identifier == @primary_applicant_identifier,
            name: name_hash,
            identifying_information: { encrypted_ssn: nil,
                                       has_ssn: !@memoized_data.find(Regexp.new("person_demographics.ssn.#{@applicant_identifier}"))&.first&.item.nil? },
            demographic: demographic_hash,
            attestation: attestation_hash,
            native_american_information: nil,
            indian_tribe_member: tribe_indicator,
            tribal_state: tribe_indicator ? @tribal_augmentation[:location_state_us_postal_service_code] : nil,
            tribal_name: tribe_indicator ? @tribal_augmentation[:person_tribe_name] : nil,
            citizenship_immigration_status_information: citizenship_immigration_hash,
            eligible_immigration_status: lawful_presence_status_eligibility,
            is_consumer_role: true, # default value
            is_resident_role: nil,
            is_applying_coverage: !@applicant_hash.nil?, # default value
            is_consent_applicant: nil,
            vlp_document: nil,
            family_member_reference: family_member_reference_hash,
            person_hbx_id: @applicant_identifier, # default value
            is_required_to_file_taxes: is_tax_filer, # default value
            # tax_filer_kind: 'tax_filer', # default value . #To memoise and extract data from taxRelationships
            tax_filer_kind: @tax_return.nil? ? nil : TAX_FILER_KIND[@tax_return[:status_code]],
            is_filing_as_head_of_household: is_head_of_household ? true : false,
            is_joint_tax_filing: joint_tax_filing_status,
            is_claimed_as_tax_dependent: tax_dependents.nil? ? nil : tax_dependents.include?(@applicant_identifier), # default value
            claimed_as_tax_dependent_by: @primary_applicant_identifier, # default value to primary
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
            has_daily_living_help: @applicant_hash.nil? ? false : @applicant_hash[:long_term_care_indicator],
            need_help_paying_bills: !@applicant_hash.nil? && !@applicant_hash[:recent_medical_bills_indicator].nil? ? @applicant_hash[:recent_medical_bills_indicator] : false,
            has_job_income: !job_income_hash.empty?,
            has_self_employment_income: !self_emp_income_hash.empty?,
            has_unemployment_income: !unemp_income_hash.empty?,
            has_other_income: !other_income_hash.empty?,
            has_deductions: !deduction_hash.empty?,
            # has_enrolled_health_coverage: !benefits_hash.empty?, # default value
            has_enrolled_health_coverage: !benefits_hash.concat(benefits_esc_hash).select {|h| h['kind'] == 'is_enrolled' }.empty?,
            # has_eligible_health_coverage: !benefits_hash.empty?, # default value
            # has_eligible_health_coverage: !benefits_hash.concat(benefits_esc_hash).select {|h| h['kind'] == 'is_eligible' }.empty?,
            has_eligible_health_coverage: nil,
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
            # is_self_attested_long_term_care: non_magi.nil? ? false : non_magi[:longTermCareIndicator],
            is_primary_caregiver: !@applicant_hash.nil? && !@applicant_hash[:parent_caretaker_indicator].nil? ? @applicant_hash[:parent_caretaker_indicator] : false,
            hours_worked_per_week: '2' # default value??
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
