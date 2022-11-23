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

      rule(:broker_accounts).each do |index:|
        next unless key? && value.is_a?(Hash)
        if value[:end_on] && value[:start_on] && (value[:end_on] < value[:start_on])
          key([:broker_accounts, index, :end_on]).failure('end on must be after start on date')
        end
      end

      def check_consumer_role_citizen_status(consumer_role_reference, failure_message)
        # if consumer is applying for coverage and citizen status is nil, we want to return a failure
        return unless consumer_role_reference[:is_applying_coverage] && consumer_role_reference[:citizen_status].nil?
        failure_message.failure(text: "Citizen status must be filled")
      end

      rule(:special_enrollment_periods).each do |index:|
        next unless key? && value.is_a?(Hash)
        if value[:end_on] && value[:start_on] && (value[:end_on] < value[:start_on])
          key([:special_enrollment_periods, index, :end_on]).failure('End on must be after start on date')
        end
      end

      rule(:general_agency_accounts).each do |index:|
        next unless key? && value.is_a?(Hash)
        if value[:end_on] && value[:start_on] && (value[:end_on] < value[:start_on])
          key([:general_agency_accounts, index, :end_on]).failure('end on must be after start on date')
        end
      end

      rule(:family_members).each do |index:|
        next unless key? && value.is_a?(Hash)

        next unless value[:person].is_a?(Hash)
        if value.dig(:person, :individual_market_transitions).is_a?(Array)
          value.dig(:person, :individual_market_transitions).each_with_index do |imt, imt_index|
            if imt[:end_on] && imt[:start_on] && (imt[:end_on] < imt[:start_on])
              key([:family_members, index, :person, :individual_market_transitions, imt_index, :end_on]).failure('end on must be after start on date')
            end
          end
        end

        next unless value.dig(:person, :consumer_role).is_a?(Hash)
        value.dig(:person, :consumer_role).tap do |cr|
          if cr[:is_applying_coverage] && value.dig(:person,
                                                    :person_demographics).key?(:is_incarcerated) && value.dig(:person, :person_demographics,
                                                                                                              :is_incarcerated).to_s.empty?
            key([:family_members, index, :person, :person_demographics, :is_incarcerated]).failure(text: 'Incarceration question must be answered')
          end
        end
      end

      rule(:households).each do |index:|
        next unless key?
        if value[:end_date] && value[:start_date] && value[:end_date] < value[:start_date]
          key([:households, index, :end_date]).failure('End on must be after start on date')
        end

        if value[:tax_households].is_a?(Array)
          value[:tax_households].each_with_index do |th, th_index|
            if th[:end_date] && th[:start_date] && th[:end_date] < th[:start_date]
              key([:households, index, :tax_households, th_index, :end_date]).failure('End on must be after start on date')
            end
          end
        end

        next unless value[:hbx_enrollments].is_a?(Array)
        value[:hbx_enrollments].each_with_index do |hbx, hbx_index|
          if hbx[:terminated_on] && hbx[:effective_on] && (hbx[:terminated_on] < hbx[:effective_on])
            key([:households, index, :hbx_enrollments, hbx_index, :terminated_on]).failure('must be on or after effective_on.')
          end

          if hbx[:market_place_kind]
            case hbx[:market_place_kind]
            when 'individual'
              if hbx[:consumer_role_reference].nil? || !hbx[:consumer_role_reference].is_a?(Hash)
                key([:households, index, :hbx_enrollments, hbx_index, :consumer_role_reference,
                     hbx_index]).failure(text: 'consumer_role_reference should be populated')
              end
              if hbx[:consumer_role_reference].is_a?(Hash)
                citizen_status_failure = key([:households, index, :hbx_enrollments, hbx_index, :consumer_role_reference,
                                              hbx_index])
                check_consumer_role_citizen_status(hbx[:consumer_role_reference], citizen_status_failure)
              end
            when 'coverall'
              if hbx[:resident_role_reference].nil? || !hbx[:resident_role_reference].is_a?(Hash)
                key([:households, index, :hbx_enrollments, hbx_index, :resident_role_reference,
                     hbx_index]).failure(text: 'resident_role_reference should be populated')
              end
            when 'employer_sponsored', 'employer_sponsored_cobra'
              # TODO
            end
          end

          if hbx[:enrollment_period_kind]
            case hbx[:enrollment_period_kind]
            when 'special_enrollment'
              if hbx[:special_enrollment_period_reference].nil? || !hbx[:special_enrollment_period_reference].is_a?(Hash)
                key([:households, index, :hbx_enrollments, hbx_index,
                     :special_enrollment_period_reference]).failure(text: 'special_enrollment_period_reference should be populated')
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
                key([:households, index, :hbx_enrollments, hbx_index, :special_enrollment_period_reference,
                     :end_on]).failure('End on must be after start on date')
              end
            end
          end

          if hbx[:benefit_coverage_period_reference].is_a?(Hash)
            hbx[:benefit_coverage_period_reference].tap do |bcpr|
              if bcpr[:end_on] && bcpr[:start_on] && (bcpr[:end_on] < bcpr[:start_on])
                key([:households, index, :hbx_enrollments, hbx_index, :benefit_coverage_period_reference,
                     :end_on]).failure('end on must be after start on date')
              end

              if bcpr[:open_enrollment_end_on] && bcpr[:open_enrollment_start_on] &&
                 (bcpr[:open_enrollment_end_on] < bcpr[:open_enrollment_start_on])
                key([:households, index, :hbx_enrollments, hbx_index, :benefit_coverage_period_reference,
                     :open_enrollment_end_on]).failure('open enrollment_end_on must be after open_enrollment_start_on')
              end
            end
          end

          next unless hbx[:hbx_enrollment_members].is_a?(Array)
          hbx[:hbx_enrollment_members].each_with_index do |hbxm, hbxm_index|
            if hbxm[:coverage_end_on] && hbxm[:coverage_start_on] && (hbxm[:coverage_end_on] < hbxm[:coverage_start_on])
              key([:households, index, :hbx_enrollments, hbx_index, :hbx_enrollment_members, hbxm_index,
                   :coverage_end_on]).failure('must be on or after coverage_start_on.')
            end
          end
        end
      end
    end
  end
end
