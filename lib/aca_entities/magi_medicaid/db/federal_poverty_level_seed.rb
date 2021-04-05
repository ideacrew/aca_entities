module AcaEntities
  module MagiMedicaid
    module Db
      # Note: these seed values are valid for Lower 48.  AK and HI have difference factors
      FederalPovertyLevelSeed = [
        {
          medicaid_year: 2013,
          annual_poverty_guideline: 11_490,
          annual_per_person_amount: 4_020
        },
        {
          medicaid_year: 2014,
          annual_poverty_guideline: 11_670,
          annual_per_person_amount: 4_060
        },
        {
          medicaid_year: 2015,
          annual_poverty_guideline: 11_770,
          annual_per_person_amount: 4_160
        },
        {
          medicaid_year: 2016,
          annual_poverty_guideline: 11_880,
          annual_per_person_amount: 4_160
        },
        {
          medicaid_year: 2017,
          annual_poverty_guideline: 12_060,
          annual_per_person_amount: 4_180
        },
        {
          medicaid_year: 2018,
          annual_poverty_guideline: 12_140,
          annual_per_person_amount: 4_320
        },
        {
          medicaid_year: 2019,
          annual_poverty_guideline: 12_490,
          annual_per_person_amount: 4_420
        },
        {
          medicaid_year: 2020,
          annual_poverty_guideline: 12_760,
          annual_per_person_amount: 4_480
        },
        {
          medicaid_year: 2021,
          annual_poverty_guideline: 12_880,
          annual_per_person_amount: 4_540
        }
      ]

      # TODO: Set state_code values using configuration setting
      FederalPovertyLevels =
        %w[ME DC].reduce([]) do |states, state_code|
          states << FederalPovertyLevelSeed.reduce([]) do |years, fpl_year|
            # Load values for household size of one as the others can be calculated
            household_size = 1
            fpl_year.merge!(
              { state_code: state_code, household_size: household_size }
            )

            year =
              AcaEntities::Operations::MagiMedicaid::CreateFederalPovertyLevel
                .new.call(fpl_year)

            if year.success?
              years << year.value!
            else
              # TODO: Raise initilization error
              # log error
            end
          end
        end.flatten
    end
  end
end
