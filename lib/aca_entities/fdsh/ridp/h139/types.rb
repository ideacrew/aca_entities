# frozen_string_literal: true

require 'dry-types'

module AcaEntities
  module Fdsh
    module Ridp
      module H139
        # Extend DryTypes to include Ridp
        module Types
          include Dry.Types
          include Dry::Logic

          LevelOfProofingCodeKind =
            Types::Coercible::String.enum(
              'LevelTwo',
              'LevelThree',
              'OptionThree'
            ).freeze

          PersonLanguagePreference =
            Types::Coercible::String.default('eng').enum('eng', 'spa').freeze

          PayPeriodFrequencyCodeSimplekind =
            Types::Coercible::String.enum(
              'Annual',
              'SemiAnnual',
              'Monthly',
              'SemiMonthly',
              'BiWeekly',
              'Weekly',
              'Daily'
            ).freeze

          PayFrequencyCodeSimpleKind =
            Types::Coercible::String.enum(
              'Annual',
              'SemiAnnual',
              'Monthly',
              'SemiMonthly',
              'BiWeekly',
              'Weekly',
              'Daily',
              'Hourly',
              '13 Times/Year',
              'Commission Only',
              '10 Times/Year',
              'Guaranteed Income',
              '11 Times/Year',
              'Owner Base Pay',
              'Hourly w/o Commission',
              'Hourly + Commission',
              'Quarterly',
              'Monthly Pension',
              'Monthly - 2x Jan; no pay Dec',
              'Hourly or Commission'
            ).freeze

          UsStateCodeMap = {
            AK: 'ALASKA',
            ME: 'MAINE',
            NJ: 'NEW JERSEY',
            WA: 'WASHINGTON',
            AP: 'Armed Forces Pacific',
            NY: 'NEW YORK',
            IA: 'IOWA',
            MO: 'MISSOURI',
            CT: 'CONNECTICUT',
            AS: 'AMERICAN SAMOA',
            AA: 'Armed Forces Americas (except Canada)',
            WY: 'WYOMING',
            VI: 'VIRGIN ISLANDS',
            GU: 'GUAM',
            PR: 'PUERTO RICO',
            FM: 'FEDERATED STATES OF MICRONESIA',
            OK: 'OKLAHOMA',
            OH: 'OHIO',
            MN: 'MINNESOTA',
            FL: 'FLORIDA',
            MD: 'MARYLAND',
            VA: 'VIRGINIA',
            GA: 'GEORGIA',
            CO: 'COLORADO',
            IN: 'INDIANA',
            SD: 'SOUTH DAKOTA',
            UT: 'UTAH',
            MI: 'MICHIGAN',
            PW: 'PALAU',
            KY: 'KENTUCKY',
            DE: 'DELAWARE',
            CA: 'CALIFORNIA',
            HI: 'HAWAII',
            MA: 'MASSACHUSETTS',
            NM: 'NEW MEXICO',
            RI: 'RHODE ISLAND',
            AL: 'ALABAMA',
            DC: 'DISTRICT OF COLUMBIA',
            OR: 'OREGON',
            TX: 'TEXAS',
            LA: 'LOUISIANA',
            TN: 'TENNESSEE',
            NE: 'NEBRASKA',
            NC: 'NORTH CAROLINA',
            AZ: 'ARIZONA',
            NH: 'NEW HAMPSHIRE',
            WV: 'WEST VIRGINIA',
            IL: 'ILLINOIS',
            AR: 'ARKANSAS',
            MT: 'MONTANA',
            VT: 'VERMONT',
            MS: 'MISSISSIPPI',
            SC: 'SOUTH CAROLINA',
            KS: 'KANSAS',
            NV: 'NEVADA',
            MP: 'NORTHERN MARIANA ISLANDS',
            MH: 'MARSHALL ISLANDS',
            AE: 'Armed Forces Africa, Canada, Europe, Middle East',
            ND: 'NORTH DAKOTA',
            ID: 'IDAHO',
            PA: 'PENNSYLVANIA',
            WI: 'WISCONSIN'
          }.freeze

          ALLOWED_SURNAMES = Types::String.constrained(
            format: /\A([a-zA-Z \-'\s]*\S[a-zA-Z \-'\s]*)\z/,
            min_size: 1,
            max_size: 50
          )
        end
      end
    end
  end
end
