# frozen_string_literal: true

require 'aca_entities/atp/transformers/cv/phone'
require 'aca_entities/atp/transformers/cv/other_questions'
require 'aca_entities/atp/transformers/cv/deduction'
require 'aca_entities/atp/transformers/cv/income'
require 'aca_entities/atp/transformers/cv/contact_info'

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
            family_reference: { hbx_id: @memoized_data.resolve('family.hbx_id').item.to_s },
            aptc_effective_date: Date.today # default value
          }
        end

        def income_hash
          return [] if @incomes_hash.nil?

          result = job_income_hash
          result.concat(self_emp_income_hash)
          result.concat(unemp_income_hash)
          result.concat(other_income_hash)
          result
        end

        def check_employer_address(contact_info)
          !contact_info.dig(:location_street, :street_full_text).nil? && !mailing[:location_city_name].nil? && !mailing[:location_state_us_postal_service_code].nil? && !mailing[:location_postal_code].nil? &&
            !contact_info.dig(:location_street, :street_full_text).empty? && !mailing[:location_city_name].empty? && !mailing[:location_state_us_postal_service_code].empty? && !mailing[:location_postal_code].empty?
        end

        def job_income_hash
          return [] if @incomes_hash.nil?

          @incomes_hash.each_with_object([]) do |income, result|
            next unless income[:category_code] == 'Wages'
            employer_hash = @employments_hash.select {|hash| hash[:employer][:id] == income[:source_organization_reference][:ref]}.first
            contact_information = employer_hash[:employer][:organization_primary_contact_information] if employer_hash
            transformed_income = AcaEntities::Atp::Transformers::Cv::Income.transform(income)
            result << {
              'employer_name' => employer_hash ? employer_hash[:employer][:category_text] : nil,
              'employer_address' =>
              if contact_information && contact_information[:mailing_address] && contact_information[:mailing_address][:address]
                mailing = contact_information[:mailing_address][:address]

                AcaEntities::Atp::Transformers::Cv::ContactInfo.transform(mailing) if check_employer_address(mailing)
              end,
              'employer_phone' =>
              if contact_information && contact_information[:telephone_number]
                AcaEntities::Atp::Transformers::Cv::ContactInfo.transform(contact_information[:telephone_number])
              end
            }.merge(transformed_income)
            result
          end
        end

        def self_emp_income_hash
          return [] if @incomes_hash.nil?

          @incomes_hash.each_with_object([]) do |income, result|
            next unless income[:category_code] == 'SelfEmployment'

            result << AcaEntities::Atp::Transformers::Cv::Income.transform(income)
            result
          end
        end

        def unemp_income_hash
          return if @incomes_hash.nil?

          @incomes_hash.each_with_object([]) do |income, result|
            next unless income[:category_code] == 'Unemployment'

            result << AcaEntities::Atp::Transformers::Cv::Income.transform(income)
            result
          end
        end

        def other_income_hash
          return [] if @incomes_hash.nil?

          @incomes_hash.each_with_object([]) do |income, result|
            next if AcaEntities::Atp::Types::OtherIncomeKinds[income[:category_code]].nil?

            result << AcaEntities::Atp::Transformers::Cv::Income.transform(income)
            result
          end
        end

        def deduction_hash
          return [] if @expenses_hash.nil?

          @expenses_hash.each_with_object([]) do |expense, result|
            next if AcaEntities::Atp::Types::DeductionKinds[expense[:category_code]].nil?

            result << AcaEntities::Atp::Transformers::Cv::Income.transform(expense)
            result
          end
        end

        def benefits_hash
          return [] if @applicant_hash.nil?
          # return [] if @applicant_hash[:esi_associations].empty?
          return [] if @applicant_hash[:non_esi_coverage_indicators].empty? || !@applicant_hash[:non_esi_coverage_indicators].first
          return [] if @applicant_hash[:non_esi_policies].empty?

          result = []

          @applicant_hash[:non_esi_policies].each do |policy|
            result << {
              'kind' => 'is_enrolled', # default value
              'insurance_kind' => AcaEntities::Atp::Types::InsuranceKinds[policy[:source_code]],
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
              'insurance_kind' => AcaEntities::Atp::Types::InsuranceKinds['Employer'],
              'is_esi_waiting_period' => nil, # default value
              'is_esi_mec_met' => nil, # default value
              'start_on' => Date.new(Date.today.year, 1, 1), # default value
              'end_on' => nil
            }
          end
          result
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
          { gender: @memoized_data.find(Regexp.new("person_demographics.gender.#{@applicant_identifier}"))&.first&.item&.downcase,
            dob: @memoized_data.find(Regexp.new("person_demographics.dob.#{@applicant_identifier}"))&.first&.item,
            ethnicity: [],
            race: nil,
            is_veteran_or_active_military: @member_hash[:us_verteran_indicator] || false,
            is_vets_spouse_or_child: nil }
        end

        def other_questions
          AcaEntities::Atp::Transformers::Cv::OtherQuestions.transform(@applicant_hash.nil? ? {}.merge(pergnancy: @member_hash[:pregnancy_status]) : @applicant_hash.merge(pergnancy: @member_hash[:pregnancy_status]))
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

        def tax_returns_hash
          applicant_is_primary_tax_filer = @tax_return.nil? ? nil : @tax_return[:tax_household][:primary_tax_filer][:role_reference][:ref] == @applicant_identifier
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

          joint_tax_filing_status = @tax_return[:status_code] == '2' if is_tax_filer && @tax_return[:status_code].present?

          is_head_of_household =  if !@tax_return.nil? && @tax_return[:tax_household] && applicant_is_primary_tax_filer
                                    @tax_return[:status_code] == '4' || @tax_return[:status_code] == '7'
                                  end
          { tax_dependents: tax_dependents,
            is_tax_filer: is_tax_filer,
            joint_tax_filing_status: joint_tax_filing_status,
            is_head_of_household: is_head_of_household }
        end

        def applicant_hash
          # non_magi = @memoized_data.find(Regexp.new('attestations.members.*.nonMagi')).map(&:item).last
          tribe_indicator = @tribal_augmentation[:american_indian_or_alaska_native_indicator]
          lawful_presence_status = @applicant_hash[:lawful_presence_status] if @applicant_hash
          lawful_presence_status_eligibility = if lawful_presence_status && lawful_presence_status[:lawful_presence_status_eligibility]
                                                 lawful_presence_status[:lawful_presence_status_eligibility][:eligibility_indicator] ? true : nil
                                               end

          {
            is_primary_applicant: @applicant_identifier == @primary_applicant_identifier,
            name: name_hash,
            identifying_information: { encrypted_ssn: nil,
                                       has_ssn: !@memoized_data.find(Regexp.new("person_demographics.ssn.#{@applicant_identifier}"))&.first&.item.nil? },
            demographic: demographic_hash,
            attestation: other_questions[:attestation],
            native_american_information: nil,
            indian_tribe_member: tribe_indicator,
            tribal_state: tribe_indicator ? @tribal_augmentation[:location_state_us_postal_service_code] : nil,
            tribal_name: tribe_indicator ? @tribal_augmentation[:person_tribe_name] : nil,
            citizenship_immigration_status_information: @applicant_hash.nil? ? nil : citizenship_immigration_hash,
            eligible_immigration_status: lawful_presence_status_eligibility,
            is_consumer_role: true, # default value
            is_resident_role: nil,
            is_applying_coverage: !@applicant_hash.nil?, # default value
            is_consent_applicant: nil,
            vlp_document: nil,
            family_member_reference: family_member_reference_hash,
            person_hbx_id: @applicant_identifier, # default value
            is_required_to_file_taxes: tax_returns_hash[:is_tax_filer], # default value
            # tax_filer_kind: 'tax_filer', # default value . #To memoise and extract data from taxRelationships
            tax_filer_kind: @tax_return.nil? ? nil : TAX_FILER_KIND[@tax_return[:status_code]],
            is_filing_as_head_of_household: tax_returns_hash[:is_head_of_household] ? true : false,
            is_joint_tax_filing: tax_returns_hash[:joint_tax_filing_status],
            is_claimed_as_tax_dependent: tax_returns_hash[:tax_dependents].nil? ? nil : tax_returns_hash[:tax_dependents].include?(@applicant_identifier), # default value
            claimed_as_tax_dependent_by: @primary_applicant_identifier, # default value to primary
            student: other_questions[:student],
            is_refugee: nil, # default value
            is_trafficking_victim: nil, # default value
            foster_care: other_questions[:foster_care],
            pregnancy_information: other_questions[:pregnancy_information],
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
            age_of_applicant: get_age(@memoized_data.find(Regexp.new("person_demographics.dob.#{@applicant_identifier}"))&.first&.item),
            # is_self_attested_long_term_care: non_magi.nil? ? false : non_magi[:longTermCareIndicator],
            is_primary_caregiver: !@applicant_hash.nil? && !@applicant_hash[:parent_caretaker_indicator].nil? ? @applicant_hash[:parent_caretaker_indicator] : false,
            hours_worked_per_week: '2' # default value??
          }
        end

        def get_age(age)
          age_date = age.respond_to?(:strftime) ? Date.strptime(age, "%m/%d/%Y") : Date.parse(age)
          AcaEntities::Functions::AgeOn.new(on_date: Date.today.strftime('%Y/%m/%d'))
                                                         .call(age_date.strftime('%Y/%m/%d'))
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

            collector << AcaEntities::Atp::Transformers::Cv::Phone.transform(contact_info)
          end
        end
      end
    end
  end
end
# rubocop:enable Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity, Metrics/MethodLength, Layout/LineLength, Metrics/AbcSize, Metrics/ClassLength
