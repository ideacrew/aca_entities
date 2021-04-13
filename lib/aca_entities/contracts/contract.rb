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
        if key? && values[:renewal_consent_through_year]
          key.failure('Not a valid renewal_consent_through_year') unless (2014..2025).cover?(values[:renewal_consent_through_year])
        end
      end

      rule(:documents).each do |index:|
        if key? && value.is_a?(Hash)
          if value[:rights]
            key([:documents, :rights, index]).failure('Not a valid document right') unless DocumentRights.include?(value[:rights])
          end
        end
      end

      rule(:broker_accounts).each do |index:|
        if key? && value.is_a?(Hash)
          if value[:end_on] && value[:start_on]
            key([:broker_accounts, :end_on, index]).failure('end on must be after start on date') if value[:end_on] < value[:start_on]
          end
        end
      end

      rule(:special_enrollment_periods).each do |index:|
        if key? && value.is_a?(Hash)
          if value[:end_on] && value[:start_on]
            key([:special_enrollment_periods, :end_on, index]).failure('End on must be after start on date') if value[:end_on] < value[:start_on]
          end

          if value[:csl_num]
            key([:special_enrollment_periods, :csl_num, index]).failure('Not a valid naturalization_number') unless (6..12).cover?(value[:csl_num].length)
          end
        end
      end

      rule(:general_agency_accounts).each do |index:|
        if key? && value.is_a?(Hash)
          if value[:end_on] && value[:start_on]
            key([:general_agency_accounts, :end_on, index]).failure('end on must be after start on date') if value[:end_on] < value[:start_on]
          end
        end
      end

      rule(:payment_transactions).each do |index:|
        if key? && value.is_a?(Hash)
          if value[:enrollment_id]
            key([:payment_transactions, :enrollment_id, index]).failure('Enrollment id is blank') unless value[:enrollment_id]
          end

          if value[:enrollment_effective_date]
            key([:payment_transactions, :enrollment_effective_date, index]).failure('Enrollment effective on is not a date') unless value[:enrollment_effective_date]
          end
        end
      end

      rule(:family_members).each do |index:|
        if key? && value.is_a?(Hash)

          if value[:person].is_a?(Hash)
            if value.dig(:person, :individual_market_transitions).is_a?(Array)
              value.dig(:person, :individual_market_transitions).each_with_index do |value, index|
                if value[:end_on] && value[:start_on]
                  key([:individual_market_transitions, :end_on, index]).failure('end on must be after start on date') if value[:end_on] < value[:start_on]
                end
              end
            end

            if value.dig(:person, :consumer_role).is_a?(Hash)
              is_incarcerated =  value.dig(:person, :person_demographics, :is_incarcerated)
              value.dig(:person, :consumer_role).tap do |value|
                if value[:is_applying_coverage] && is_incarcerated.to_s.empty?
                  key([:consumer_role, :is_applying_coverage]).failure(text: 'Incarceration question must be answered')
                end

                if value[:vlp_documents].is_a?(Array)

                  value[:vlp_documents].each_with_index do |value, index|
                    if value[:alien_number]
                      key([:vlp_documents, :alien_number, index]).failure('Not a valid alien_number') if value[:alien_number].length != 9
                    end

                    if value[:citizenship_number]
                      key([:vlp_documents, :citizenship_number, index]).failure('Not a valid citizenship_number') unless (6..12).cover?(value[:citizenship_number].length)
                    end

                    if value[:i94_number]
                      key([:vlp_documents, :i94_number, index]).failure('Not a valid i94_number') unless value[:i94_number].length != 11
                    end

                    if value[:naturalization_number]
                      key([:vlp_documents, :naturalization_number, index]).failure('Not a valid naturalization_number') unless (6..12).cover?(value[:naturalization_number].length)
                    end

                    if value[:passport_number]
                      key([:vlp_documents, :passport_number, index]).failure('Not a valid passport_number') unless (6..12).cover?(value[:passport_number].length)
                    end

                    if value[:sevis_id]
                      key([:vlp_documents, :sevis_id, index]).failure('Not a valid sevis_id') unless value[:sevis_id].length != 10
                    end

                    if values[:visa_number]
                      key([:vlp_documents, :visa_number, index]).failure('Not a valid visa_number') unless value[:visa_number].length != 8
                    end

                    if value[:receipt_number]
                      key([:vlp_documents, :receipt_number, index]).failure('Not a valid receipt_number') unless value[:receipt_number].length != 13
                    end

                    if value[:card_number]
                      key([:vlp_documents, :card_number, index]).failure('Not a valid card_number') unless value[:card_number].length != 13
                    end
                  end
                end
              end
            end

            if value.dig(:person, :addresses).is_a?(Array)
              value.dig(:person, :addresses).each_with_index do |value, index|
                key([:addresses, :kind, index]).failure(text: 'Kind cannot be blank') if value[:kind].to_s.empty?
                key([:addresses, :address_1, index]).failure(text: 'Address1 cannot be blank') if value[:address_1].to_s.empty?
                key([:addresses, :city, index]).failure(text: 'City cannot be blank') if value[:city].to_s.empty?
                key([:addresses, :state, index]).failure(text: 'State cannot be blank') if value[:state].to_s.empty?
                key([:addresses, :zip, index]).failure(text: 'Zip cannot be blank') if value[:zip].to_s.empty?
                if value[:zip].to_s.empty? && !/\A\d{5}(-\d{4})?\z/.match?(values[:zip])
                  key([:addresses, :zip, index]).failure(text: 'Zip should be in the form: 12345 or 12345-1234')
                end
              end
            end
          end
        end
      end

      rule(:households).each do |index:|
        if key?
          if value[:end_date] && value[:start_date]
            key([:households, :end_date, index]).failure('End on must be after start on date') unless value[:end_date] >= value[:start_date]
          end

          if value[:tax_households].is_a?(Array)
            value[:tax_households].each_with_index do |value, index|
              if value[:end_date] && value[:start_date]
                key([:tax_households, :end_date, index]).failure('End on must be after start on date') unless values[:end_date] >= values[:start_date]
              end
            end
          end

          if value[:hbx_enrollments].is_a?(Array)
            value[:hbx_enrollments].each_with_index do |value, index|
              if value[:terminated_on] && value[:effective_on]
                key([:hbx_enrollments, :terminated_on, index]).failure('must be on or after effective_on.') if value[:terminated_on] < value[:effective_on]
              end

              if value[:market_place_kind]
                case value[:market_place_kind]
                  when 'individual'
                    key([:hbx_enrollments, :market_place_kind, index]).failure(text: 'consumer_role field should be populated') if value[:consumer_role_reference].nil? || !value[:consumer_role_reference].is_a?(Hash)
                  when 'coverall'
                    key([:hbx_enrollments, :market_place_kind, index]).failure(text: 'resident_role_id field should be populated') if value[:resident_role_reference].nil? || !value[:resident_role_reference].is_a?(Hash)
                  when 'employer_sponsored', 'employer_sponsored_cobra'
                    # TODO
                end
              end

              if value[:enrollment_period_kind]
                case value[:enrollment_period_kind]
                  when 'special_enrollment'
                    key([:hbx_enrollments, :enrollment_period_kind, index]).failure(text: 'special_enrollment_period_id field should be populated') if value[:special_enrollment_period_reference].nil? || !value[:special_enrollment_period_reference].is_a?(Hash)
                  when 'open_enrollment'
                    # TODO
                end
              end

              if value[:product_kind]
                case value[:product_kind]
                  when 'health'
                    # TODO
                  when 'dental'
                    # TODO
                end
              end

              if value[:special_enrollment_period_reference].is_a?(Hash)
                value[:special_enrollment_period_reference].tap do |value|
                  if value[:end_on] && value[:start_on]
                    key([:special_enrollment_period_reference, :end_on, index]).failure('End on must be after start on date') if value[:end_on] < value[:start_on]
                  end
                end
              end

              if value[:benefit_coverage_period_reference].is_a?(Hash)
                value[:benefit_coverage_period_reference].tap do |value|
                  if value[:end_on] && value[:start_on]
                    key([:benefit_coverage_period_reference, :end_on, index]).failure('end on must be after start on date') if value[:end_on] < value[:start_on]
                  end

                  if value[:open_enrollment_end_on] && value[:open_enrollment_start_on]
                    key([:benefit_coverage_period_reference, :end_on, index]).failure('open enrollment_end_on must be after open_enrollment_start_on') if value[:open_enrollment_end_on] < value[:open_enrollment_start_on]
                  end
                end
              end

              if value[:hbx_enrollment_members].is_a?(Array)
                value[:hbx_enrollment_members].each_with_index do |value, index|
                  if value[:coverage_end_on] && value[:coverage_start_on]
                    key([:hbx_enrollment_members, :coverage_end_on, index]).failure('must be on or after coverage_start_on.')  if value[:coverage_end_on] < value[:coverage_start_on]
                  end
                end
              end
            end
          end
        end
      end
    end
  end
end
