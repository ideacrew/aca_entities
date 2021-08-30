# frozen_string_literal: true

# rubocop:disable  Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity, Metrics/MethodLength, Layout/LineLength, Metrics/AbcSize
module AcaEntities
  module Functions
    # build iap applicant
    class ApplicantBuilder

      attr_reader :memoized_data, :member, :member_identifier, :primary_applicant_identifier, :attestations_family_hash

      def call(memoized_data, member)
        @memoized_data = memoized_data
        @member = member
        @primary_applicant_identifier = memoized_data.resolve('family.family_members.is_primary_applicant').item
        @member_identifier = member.name.split('.').last
        @attestations_family_hash = memoized_data.find(Regexp.new("attestations.members.#{member.name.split('.').last}.family"))&.first&.item

        build_applicant_hash
      end

      private

      def build_applicant_hash
        [name_hash,
         demographic_hash,
         identifying_info_hash,
         attestation_hash,
         citizenship_hash,
         member_reference_hash,
         student_hash,
         pregnancy_info_hash,
         foster_care_hash,
         income_hash,
         benefits_hash,
         tax_info_hash,
         vlp_document_hash,
         address_hash,
         email_hash,
         phone_hash,
         additonal_info_hash].reduce(:merge)
      end

      def income_hash
        AcaEntities::Functions::Income.new.call(memoized_data, member)
      end

      def benefits_hash
        AcaEntities::Functions::Benefit.new.call(memoized_data, member_identifier)
      end

      def tax_info_hash
        AcaEntities::Functions::TaxFilerBuilder.new.call(memoized_data, member)
      end

      def vlp_document_hash
        # iap accepts only one vlp document
        { vlp_document: AcaEntities::Functions::BuildVlpDocument.new.call(memoized_data, member_identifier).first }
      end

      def address_hash
        mailing_address = memoized_data.resolve("attestations.members.#{member_identifier}.demographic.mailingAddress").item&.merge!(kind: "mailing")
        home_address = memoized_data.resolve("attestations.members.#{member_identifier}.demographic.homeAddress").item&.merge!(kind: "home")
        transient_address = memoized_data.resolve("attestations.members.#{member_identifier}.demographic.transientAddress").item&.merge!(kind: "transient")
        addresses =  [mailing_address, home_address, transient_address].compact.each_with_object([]) do |address, collect|
          collect << AcaEntities::Ffe::Transformers::Cv::Address.transform(address)
        end

        { addresses: addresses }
      end

      def email_hash
        { emails:  AcaEntities::Functions::Email.new.call(memoized_data, member_identifier) }
      end

      def phone_hash
        { phones: AcaEntities::Functions::Phone.new.call(memoized_data, member_identifier) }
      end

      def name_hash
        # default value, create new contract and entities for create family and IAP
        member_name = { first_name: memoized_data.find(Regexp.new("first_name.#{member_identifier}"))&.first&.item,
                        middle_name: memoized_data.find(Regexp.new("middle_name.#{member_identifier}"))&.first&.item || '',
                        last_name: memoized_data.find(Regexp.new("last_name.#{member_identifier}"))&.first&.item,
                        name_sfx: memoized_data.find(Regexp.new("name_sfx.#{member_identifier}"))&.first&.item || '',
                        name_pfx: memoized_data.find(Regexp.new("name_pfx.#{member_identifier}"))&.first&.item || '',
                        full_name: [memoized_data.find(Regexp.new("first_name.#{member_identifier}"))&.first&.item,
                                    memoized_data.find(Regexp.new("last_name.#{member_identifier}"))&.first&.item].join('.'),
                        alternate_name: memoized_data.find(Regexp.new("alternate_name.#{member_identifier}"))&.first&.item || '' }

        { name: member_name }
      end

      def demographic_hash
        veteran_indicator = memoized_data.find(Regexp.new("#{member_identifier}.other.veteranIndicator"))&.first&.item

        member_demographic = {
          gender: memoized_data.find(Regexp.new("person_demographics.gender.#{member_identifier}"))&.first&.item&.capitalize,
          dob: memoized_data.find(Regexp.new("person_demographics.dob.#{member_identifier}"))&.first&.item,
          ethnicity: [],
          race: nil,
          is_veteran_or_active_military: veteran_indicator || false,
          is_vets_spouse_or_child: nil
        }

        { demographic: member_demographic }
      end

      def attestation_hash
        m_identifier_non_magi = "attestations.members.#{member_identifier}.nonMagi"
        non_magi = memoized_data.find(Regexp.new(m_identifier_non_magi)).map(&:item).last

        member_attestation = {
          is_incarcerated: false, # default value
          is_self_attested_disabled: non_magi.nil? ? false : non_magi[:blindOrDisabledIndicator] || false,
          is_self_attested_blind: non_magi.nil? ? false : non_magi[:blindOrDisabledIndicator] || false,
          is_self_attested_long_term_care: non_magi.nil? ? false : (non_magi[:longTermCareIndicator] || false)
        }

        { attestation: member_attestation }
      end

      def pregnancy_info_hash
        pregnancy_info = {
          is_pregnant: attestations_family_hash[:pregnancyIndicator] || false,
          is_enrolled_on_medicaid: nil,
          is_post_partum_period: false, # default value
          expected_children_count: attestations_family_hash[:babyDueQuantity],
          pregnancy_due_on: nil,
          pregnancy_end_on: nil
        }

        { pregnancy_information: pregnancy_info }
      end

      def foster_care_hash
        foster_care = {
          is_former_foster_care: attestations_family_hash[:fosterCareIndicator] || false,
          age_left_foster_care: attestations_family_hash[:fosterCareEndAge],
          foster_care_us_state: attestations_family_hash[:fosterCareState],
          had_medicaid_during_foster_care: attestations_family_hash[:medicaidDuringFosterCareIndicator]
        }

        { foster_care: foster_care }
      end

      def student_hash
        student = {
          is_student: !attestations_family_hash[:fullTimeStatusIndicator].nil?,
          student_kind: attestations_family_hash[:fullTimeStatusIndicator] ? 'full_time' : nil, # needs refactor for other student kinds
          student_school_kind: nil,
          student_status_end_on: nil
        }

        { student: student }
      end

      def member_reference_hash
        member_reference = {
          family_member_hbx_id: member_identifier, # default value
          first_name: memoized_data.find(Regexp.new("first_name.#{member_identifier}"))&.first&.item,
          last_name: memoized_data.find(Regexp.new("last_name.#{member_identifier}"))&.first&.item,
          person_hbx_id: '1234', # default value
          is_primary_family_member: primary_applicant_identifier == member_identifier
        }

        { family_member_reference: member_reference }
      end

      def citizenship_hash
        member_citizenship = {
          citizen_status: AcaEntities::Functions::BuildLawfulPresenceDetermination.new.call(memoized_data, member_identifier),
          is_resident_post_092296: nil,
          is_lawful_presence_self_attested: nil
        }

        { citizenship_immigration_status_information: member_citizenship }
      end

      def identifying_info_hash
        identifying_info = {
          encrypted_ssn: nil,
          has_ssn: !memoized_data.find(Regexp.new("person_demographics.ssn.#{member_identifier}"))&.first&.item.nil?
        }

        { identifying_information: identifying_info }
      end

      def additonal_info_hash
        non_magi = memoized_data.find(Regexp.new('attestations.members.*.nonMagi')).map(&:item).last

        {
          is_primary_applicant: member_identifier == primary_applicant_identifier,
          person_hbx_id: member_identifier,
          is_applying_coverage: memoized_data.find(Regexp.new("is_coverage_applicant.#{member_identifier}"))&.first&.item,
          age_of_applicant: AcaEntities::Functions::AgeOn.new(on_date: Date.parse('2021-01-01')).call(memoized_data.find(Regexp.new("person_demographics.dob.#{member_identifier}"))&.first&.item),

          native_american_information: nil,
          is_consumer_role: nil,
          is_resident_role: nil,

          is_consent_applicant: nil,

          is_refugee: nil, # default value
          is_trafficking_victim: nil, # default value

          is_subject_to_five_year_bar: nil, # default value
          is_five_year_bar_met: nil, # default value
          is_forty_quarters: nil, # default value
          is_ssn_applied: nil, # default value
          non_ssn_apply_reason: nil, # default value
          moved_on_or_after_welfare_reformed_law: nil, # default value
          is_currently_enrolled_in_health_plan: nil, # default value
          has_daily_living_help: nil, # default value
          need_help_paying_bills: nil, # default value

          is_medicare_eligible: false, # default value
          has_insurance: false, # default value
          has_state_health_benefit: false, # default value
          had_prior_insurance: false, # default value
          # prior_insurance_end_date: Date.parse("2021-05-07"), # default value

          is_self_attested_long_term_care: non_magi.nil? ? false : non_magi[:longTermCareIndicator] || false
        }
      end
    end
  end
end
# rubocop:enable Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity, Metrics/MethodLength, Layout/LineLength, Metrics/AbcSize
