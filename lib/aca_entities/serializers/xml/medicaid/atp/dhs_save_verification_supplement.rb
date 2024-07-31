# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module Medicaid
        module Atp
          # A verification supplement provided by the Department of Homeland Security (DHS)
          # Systematic Alien Verification for Entitlements (SAVE) program.
          class DhsSaveVerificationSupplement
            include HappyMapper

            tag 'DHS-SAVEVerificationSupplement'
            namespace 'hix-core'

            # A step in the Department of Homeland Security (DHS) Systematic Alien Verification for Entitlements (SAVE) process.
            element :step_id, String, tag: 'StepID'

            # A status of a verification of lawful presence.
            element :lawful_presence_verification_code, String, tag: 'LawfulPresenceVerificationCode'

            # A status of a verification that an individual is barred from services for five years.
            element :five_year_bar_verification_code, String, tag: 'FiveYearBarVerificationCode'

            # A status of a verification that a person is a qualified non-citizen.
            element :qualified_non_citizen_verification_code, String, tag: 'QualifiedNonCitizenVerificationCode'

            # A status for a verification that a person previously subject to a five-year bar from services has completed the period of the bar.
            element :five_year_bar_met_verification_code, String, tag: 'FiveYearBarMetVerificationCode'

            # A status for a verification that a person is a U.S. citizen.
            element :us_citizenship_verification_code, String, tag: 'USCitizenshipVerificationCode'

            # A date a person's asylum, parolee, refugee or lawful permanent resident status was granted.
            # has_many :immigration_status_grant_dates, Date, tag: 'ImmigrationStatusGrantDate'

            def self.domain_to_mapper(dhs_save_data)
              mapper = self.new
              mapper.step_id = dhs_save_data.step_id if dhs_save_data.step_id.present?
              if dhs_save_data.lawful_presence_verification_code.present?
                mapper.lawful_presence_verification_code = dhs_save_data.lawful_presence_verification_code
              end
              if dhs_save_data.five_year_bar_verification_code.present?
                mapper.five_year_bar_verification_code = dhs_save_data.five_year_bar_verification_code
              end
              if dhs_save_data.qualified_non_citizen_verification_code.present?
                mapper.qualified_non_citizen_verification_code = dhs_save_data.qualified_non_citizen_verification_code
              end
              if dhs_save_data.five_year_bar_met_verification_code.present?
                mapper.five_year_bar_met_verification_code = dhs_save_data.five_year_bar_met_verification_code
              end
              if dhs_save_data.us_citizenship_verification_code.present?
                mapper.us_citizenship_verification_code = dhs_save_data.us_citizenship_verification_code
              end
              mapper
            end
          end
        end
      end
    end
  end
end
