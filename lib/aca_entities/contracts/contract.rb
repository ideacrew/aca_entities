# frozen_string_literal: true

module AcaEntities
  module Contracts
    # Configuration values and shared rules and macros for {AcaEntities::Medicaid} validation contracts
    class Contract < Dry::Validation::Contract
      # config.messages.backend - the localization backend to use. Supported values are: :yaml and :i18n
      # config.messages.backend = :i18n
      # config.messages.default_locale - default I18n-compatible locale identifier
      # config.messages.default_locale = :en
      # config.messages.load_paths - an array of files paths that are used to load messages
      # config.messages.top_namespace - the key in the locale files under which messages are defined, by default it's dry_validation
      # config.messages.namespace - custom messages namespace for a contract class. Use this to differentiate common messages

      rule(:renewal_consent_through_year) do
        if key? && values[:renewal_consent_through_year] && !(2014..2025).cover?(values[:renewal_consent_through_year])
          key.failure('Not a valid renewal_consent_through_year')
        end
      end

      rule(:documents).each do |index:|
        next unless key? && value.is_a?(Hash)
        key([:documents, :rights, index]).failure('Not a valid document right') if value[:rights] && !DocumentRights.include?(value[:rights])
      end

      rule(:broker_accounts).each do |index:|
        next unless key? && value.is_a?(Hash)
        if value[:end_on] && value[:start_on] && (value[:end_on] < value[:start_on])
          key([:broker_accounts, :end_on, index]).failure('end on must be after start on date')
        end
      end

      rule(:special_enrollment_periods).each do |index:|
        next unless key? && value.is_a?(Hash)
        if value[:end_on] && value[:start_on] && (value[:end_on] < value[:start_on])
          key([:special_enrollment_periods, :end_on, index]).failure('End on must be after start on date')
        end

        if value[:csl_num] && !(6..12).cover?(value[:csl_num].length)
          key([:special_enrollment_periods, :csl_num,
               index]).failure('Not a valid naturalization_number')
        end
      end

      rule(:general_agency_accounts).each do |index:|
        next unless key? && value.is_a?(Hash)
        if value[:end_on] && value[:start_on] && (value[:end_on] < value[:start_on])
          key([:general_agency_accounts, :end_on, index]).failure('end on must be after start on date')
        end
      end

      rule(:payment_transactions).each do |index:|
        next unless key? && value.is_a?(Hash)
        key([:payment_transactions, :enrollment_id, index]).failure('Enrollment id is blank') if value[:enrollment_id] && !value[:enrollment_id]

        if value[:enrollment_effective_date] && !value[:enrollment_effective_date]
          key([:payment_transactions, :enrollment_effective_date,
               index]).failure('Enrollment effective on is not a date')
        end
      end

      rule(:family_members).each do |_index:|
        next unless key? && value.is_a?(Hash)

        next unless value[:person].is_a?(Hash)
        if value.dig(:person, :individual_market_transitions).is_a?(Array)
          value.dig(:person, :individual_market_transitions).each_with_index do |imt, imt_index|
            if imt[:end_on] && imt[:start_on] && (imt[:end_on] < imt[:start_on])
              key([:individual_market_transitions, :end_on,
                   imt_index]).failure('end on must be after start on date')
            end
          end
        end

        next unless value.dig(:person, :consumer_role).is_a?(Hash)
        value.dig(:person, :consumer_role).tap do |cr|
          if cr[:is_applying_coverage] && value.dig(:person, :person_demographics, :is_incarcerated).to_s.empty?
            key([:consumer_role, :is_applying_coverage]).failure(text: 'Incarceration question must be answered')
          end

          if cr[:vlp_documents].is_a?(Array)

            cr[:vlp_documents].each_with_index do |vlpd, vlpd_index|
              if vlpd[:alien_number] && (vlpd[:alien_number].length != 9)
                key([:vlp_documents, :alien_number, vlpd_index]).failure('Not a valid alien_number')
              end

              if vlpd[:citizenship_number] && !(6..12).cover?(vlpd[:citizenship_number].length)
                key([:vlp_documents, :citizenship_number,
                     vlpd_index]).failure('Not a valid citizenship_number')
              end

              if vlpd[:i94_number] && vlpd[:i94_number].length == 11
                key([:vlp_documents, :i94_number,
                     vlpd_index]).failure('Not a valid i94_number')
              end

              if vlpd[:naturalization_number] && !(6..12).cover?(vlpd[:naturalization_number].length)
                key([:vlp_documents, :naturalization_number,
                     vlpd_index]).failure('Not a valid naturalization_number')
              end

              if vlpd[:passport_number] && !(6..12).cover?(vlpd[:passport_number].length)
                key([:vlp_documents, :passport_number,
                     vlpd_index]).failure('Not a valid passport_number')
              end

              key([:vlp_documents, :sevis_id, vlpd_index]).failure('Not a valid sevis_id') if vlpd[:sevis_id] && vlpd[:sevis_id].length == 10

              if vlpd[:visa_number] && vlpd[:visa_number].length == 8
                key([:vlp_documents, :visa_number, vlpd_index]).failure('Not a valid visa_number')
              end

              if vlpd[:receipt_number] && vlpd[:receipt_number].length == 13
                key([:vlp_documents, :receipt_number, vlpd_index]).failure('Not a valid receipt_number')
              end

              if vlpd[:card_number] && vlpd[:card_number].length == 13
                key([:vlp_documents, :card_number, vlpd_index]).failure('Not a valid card_number')
              end
            end
          end
        end
      end

      rule(:households).each do |index:|
        next unless key?
        if value[:end_date] && value[:start_date] && value[:end_date] < value[:start_date]
          key([:households, :end_date, index]).failure('End on must be after start on date')
        end

        if value[:tax_households].is_a?(Array)
          value[:tax_households].each_with_index do |th, th_index|
            if th[:end_date] && th[:start_date] && th[:end_date] < th[:start_date]
              key([:tax_households, :end_date, th_index]).failure('End on must be after start on date')
            end
          end
        end

        next unless value[:hbx_enrollments].is_a?(Array)
        value[:hbx_enrollments].each_with_index do |hbx, hbx_index|
          if hbx[:terminated_on] && hbx[:effective_on] && (hbx[:terminated_on] < hbx[:effective_on])
            key([:hbx_enrollments, :terminated_on,
                 hbx_index]).failure('must be on or after effective_on.')
          end

          if hbx[:market_place_kind]
            case hbx[:market_place_kind]
            when 'individual'
              if hbx[:consumer_role_reference].nil? || !hbx[:consumer_role_reference].is_a?(Hash)
                key([:hbx_enrollments, :market_place_kind,
                     hbx_index]).failure(text: 'consumer_role field should be populated')
              end
            when 'coverall'
              if hbx[:resident_role_reference].nil? || !hbx[:resident_role_reference].is_a?(Hash)
                key([:hbx_enrollments, :market_place_kind,
                     hbx_index]).failure(text: 'resident_role_id field should be populated')
              end
            when 'employer_sponsored', 'employer_sponsored_cobra'
              # TODO
            end
          end

          if hbx[:enrollment_period_kind]
            case hbx[:enrollment_period_kind]
            when 'special_enrollment'
              if hbx[:special_enrollment_period_reference].nil? || !hbx[:special_enrollment_period_reference].is_a?(Hash)
                key([:hbx_enrollments, :enrollment_period_kind,
                     hbx_index]).failure(text: 'special_enrollment_period_id field should be populated')
              end
            when 'open_enrollment'
              # TODO
            end
          end

          if hbx[:product_kind]
            case hbx[:product_kind]
            when 'health'
            # TODO
            when 'dental'
              # TODO
            end
          end

          if hbx[:special_enrollment_period_reference].is_a?(Hash)
            hbx[:special_enrollment_period_reference].tap do |sepr|
              if sepr[:end_on] && sepr[:start_on] && (sepr[:end_on] < sepr[:start_on])
                key([:special_enrollment_period_reference, :end_on,
                     hbx_index]).failure('End on must be after start on date')
              end
            end
          end

          if hbx[:benefit_coverage_period_reference].is_a?(Hash)
            hbx[:benefit_coverage_period_reference].tap do |bcpr|
              if bcpr[:end_on] && bcpr[:start_on] && (bcpr[:end_on] < bcpr[:start_on])
                key([:benefit_coverage_period_reference, :end_on,
                     hbx_index]).failure('end on must be after start on date')
              end

              if bcpr[:open_enrollment_end_on] && bcpr[:open_enrollment_start_on] &&
                 (bcpr[:open_enrollment_end_on] < bcpr[:open_enrollment_start_on])
                key([:benefit_coverage_period_reference, :end_on,
                     hbx_index]).failure('open enrollment_end_on must be after open_enrollment_start_on')
              end
            end
          end

          next unless hbx[:hbx_enrollment_members].is_a?(Array)
          hbx[:hbx_enrollment_members].each_with_index do |hbxm, _hbxm_index|
            if hbxm[:coverage_end_on] && hbxm[:coverage_start_on] && (hbxm[:coverage_end_on] < hbxm[:coverage_start_on])
              key([:hbx_enrollment_members, :coverage_end_on,
                   hbx_index]).failure('must be on or after coverage_start_on.')
            end
          end
        end
      end
    end
  end
end
