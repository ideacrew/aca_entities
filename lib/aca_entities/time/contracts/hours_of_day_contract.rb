# frozen_string_literal: true

# Encapsulates an address
module AcaEntities
  module Time
    module Contracts
      class HoursOfDayContract < Contract
        params do
          optional(:id).maybe(:string)

          required(:hour_0).value(:hash)
          required(:hour_1).value(:hash)
          required(:hour_2).value(:hash)
          required(:hour_3).value(:hash)
          required(:hour_4).value(:hash)
          required(:hour_5).value(:hash)
          required(:hour_6).value(:hash)
          required(:hour_7).value(:hash)
          required(:hour_8).value(:hash)
          required(:hour_9).value(:hash)
          required(:hour_10).value(:hash)
          required(:hour_11).value(:hash)
          required(:hour_12).value(:hash)
          required(:hour_13).value(:hash)
          required(:hour_14).value(:hash)
          required(:hour_15).value(:hash)
          required(:hour_16).value(:hash)
          required(:hour_17).value(:hash)
          required(:hour_18).value(:hash)
          required(:hour_19).value(:hash)
          required(:hour_20).value(:hash)
          required(:hour_21).value(:hash)
          required(:hour_22).value(:hash)
          required(:hour_23).value(:hash)

          optional(:timestamps).maybe(AcaEntities::Contracts::TimeStampContract.params)
        end
      end
    end
  end
end
