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

      rule(:assistance_year) do
        if key? && values
          error = "out-of-range assistance_year: #{values[:assistance_year]}"
          key.failure(error) unless (AcaEntities::SBM_START_ON.year..nil).cover? values[:assistance_year]
        end
      end

      rule(:end_on, :start_on) do
        if key?(:end_on) && key?(:start_on)
          error = 'must be after start_on'
          key.failure(error) if values[:end_on] < values[:start_on]
        end
      end

      rule(:broker_accounts).each do |index:|
        if key?(:end_on) && key?(:start_on)
          error = 'must be after start_on'
          key([:broker_accounts, index, :end_on]).failure(error) if value[:end_on] < value[:start_on]
        end
      end

      rule(:special_enrollment_periods).each do |index:|
        if key?(:end_on) && key?(:start_on)
          error = 'must be after start_on'
          key([:special_enrollment_periods, index, :end_on]).failure(error) if value[:end_on] < value[:start_on]
        end
      end

      rule(:general_agency_accounts).each do |index:|
        if key?(:end_on) && key?(:start_on)
          error = 'must be after start_on'
          key([:general_agency_accounts, index, :end_on]).failure(error) if value[:end_on] < value[:start_on]
        end
      end

      # rubocop:disable Style/Next
      # rubocop:disable Layout/MultilineOperationIndentation
      # rubocop:disable Style/SoleNestedConditional
      # rubocop:disable Metrics/BlockNesting
      # rubocop:disable Layout/ArrayAlignment
      rule(:family_members).each do |index:|
        next unless key? && value

        if key?(:person)
          if key?(:individual_market_transitions)
            value.dig(:person, :individual_market_transitions).each_with_index do |imt, imt_index|
              next unless imt[:end_on] && imt[:start_on]
              if imt[:end_on] < imt[:start_on]
                error = 'must be after start_on'
                key([:family_members, index, :person, :individual_market_transitions, imt_index, :end_on]).failure(error)
              end
            end
          end

          if key?(:consumer_role)
            value.dig(:person, :consumer_role).tap do |cr|
              next unless cr[:is_applying_coverage]
              if key?(value.dig(:person, :person_demographics, :is_incarcerated)) &&
                      value.dig(:person, :person_demographics, :is_incarcerated).to_s.empty?
                error = 'Incarceration question must be answered'
                key([:family_members, index, :person, :person_demographics, :is_incarcerated]).failure(error)
              end
            end
          end
        end
      end

      rule(:households).each do |index:|
        if key?(:end_date) && key?(:start_date)
          if value[:end_date] < value[:start_date]
            error = 'must be after start_date'
            key([:households, index, :end_date]).failure(error)
          end
        end

        if key?(:tax_households)
          value[:tax_households].each_with_index do |th, th_index|
            if key?(th[:end_date]) && key?(th[:start_date])
              error = 'must be after start_date'
              key([:households, index, :tax_households, th_index, :end_date]).failure(error)
            end
          end
        end

        if key?(:hbx_enrollments)
          value[:hbx_enrollments].each_with_index do |hbx, hbx_index|
            if key?(hbx[:terminated_on]) && key?([:effective_on])
              if hbx[:terminated_on] < hbx[:effective_on]
                error = 'must be after effective_on'
                key([:households, index, :hbx_enrollments, hbx_index, :terminated_on]).failure(error)
              end
            end

            if key?(hbx[:market_place_kind])
              case hbx[:market_place_kind]
              when 'individual'
                next unless hbx[:consumer_role_reference].nil? || !hbx[:consumer_role_reference].is_a?(Hash)
                key([:households, index, :hbx_enrollments, hbx_index, :consumer_role_reference,
                      hbx_index]).failure(text: 'consumer_role_reference should be populated')
              when 'coverall'
                next unless hbx[:resident_role_reference].nil? || !hbx[:resident_role_reference].is_a?(Hash)
                key([:households, index, :hbx_enrollments, hbx_index, :resident_role_reference,
                      hbx_index]).failure(text: 'resident_role_reference should be populated')
              when 'employer_sponsored', 'employer_sponsored_cobra'
                # TODO
              end
            end

            if key?(hbx[:enrollment_period_kind])
              case hbx[:enrollment_period_kind]
              when 'special_enrollment'
                if key?(hbx[:special_enrollment_period_reference])
                  error = 'special_enrollment_period_reference should be populated'
                  key([:households, index, :hbx_enrollments, hbx_index, :special_enrollment_period_reference]).failure(error)
                end
              when 'open_enrollment'
                # TODO
              end
            end

            if key?(hbx[:product_kind])
              case hbx[:product_kind]
              when 'health'
              # TODO
              when 'dental'
                # TODO
              end
            end

            if key?(hbx[:special_enrollment_period_reference])
              hbx[:special_enrollment_period_reference].tap do |sepr|
                if key?(sepr[:end_on]) && key?(sepr[:start_on])
                  if sepr[:end_on] < sepr[:start_on]
                    error = 'must be after start_on'
                    key([:households, index, :hbx_enrollments, hbx_index, :special_enrollment_period_reference, :end_on]).failure(error)
                  end
                end
              end
            end

            if key?(hbx[:benefit_coverage_period_reference])
              hbx[:benefit_coverage_period_reference].tap do |bcpr|
                if key?(bcpr[:end_on]) && key?(bcpr[:start_on])
                  if bcpr[:end_on] < bcpr[:start_on]
                    error = 'must be after start_on'
                    key([:households, index, :hbx_enrollments, hbx_index, :benefit_coverage_period_reference, :end_on]).failure(error)
                  end
                end

                if  key?(bcpr[:open_enrollment_end_on]) && key?(bcpr[:open_enrollment_start_on])
                  if bcpr[:open_enrollment_end_on] < bcpr[:open_enrollment_start_on]
                    error = 'must be after open_enrollment_start_on'
                    key([:households, index, :hbx_enrollments, hbx_index, :benefit_coverage_period_reference, :open_enrollment_end_on]).failure(error)
                  end
                end
              end
            end

            if key?(hbx[:hbx_enrollment_members])
              hbx[:hbx_enrollment_members].each_with_index do |hbxm, hbxm_index|
                if key?(hbxm[:coverage_end_on]) && key?(hbxm[:coverage_start_on])
                  if hbxm[:coverage_end_on] < hbxm[:coverage_start_on]
                    error = 'must be after open_enrollment_start_on'
                    key([:households, index, :hbx_enrollments, hbx_index, :hbx_enrollment_members, hbxm_index, :coverage_end_on]).failure(error)
                  end
                end
              end
            end
          end
        end
      end
      # rubocop:enable Layout/ArrayAlignment
      # rubocop:enable Metrics/BlockNesting
      # rubocop:enable Style/SoleNestedConditional
      # rubocop:enable Layout/MultilineOperationIndentation
      # rubocop:enable Style/Next

    end
  end
end
