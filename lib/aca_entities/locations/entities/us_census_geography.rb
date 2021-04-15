# frozen_string_literal: true

require 'csv'

module AcaEntities
  module Locations

    # Representtion of Census Bureau all geocodes file
    # State, County, County Subdivision, Place and Consolidated City Codes are FIPS Codes
    # Code values are coerced from strings to integer values during import for improved performance
    class UsCensusGeography < ActiveRecord::Base
      # include Mongoid::Document
      # include Mongoid::Timestamps

      FILE_METADATA_VINTAGE_ROW = 0
      FILE_METADATA_DATE_ROW    = 2
      FILE_METADATA_ROW_SIZE    = 5

      RECORD_SIZE               = 43_847
      STATES_SUMMARY_LEVEL      = 40
      COUNTIES_SUMMARY_LEVEL    = 50

      FIELD_LENGTHS = { summary_level: 3,
                        state_code: 2,
                        county_code: 3,
                        county_subdv_code: 5,
                        place_code: 5,
                        city_code: 5 }.freeze

      FILE_HEADER = { summary_level: { length: 3 } }.freeze
      HEADERS = [:summary_level, :state_code, :county_code, :county_subdivision_code, :place_code, :consolidated_city_code, :area_name].freeze

      has_many :county_statistics, foreign_key: :location_id

      # field :summary_level,           type: Integer
      # field :state_code,              type: Integer
      # field :county_code,             type: Integer
      # field :county_subdivision_code, type: Integer
      # field :place_code,              type: Integer
      # field :consolidated_city_code,  type: Integer
      # field :area_name,               type: String

      # field :postal_code,             type: String #, default: ->{ Locations::UsSate::NameIds.detect(area_name) }

      # field :row_created_at,          type: DateTime
      # field :row_updated_at,          type: DateTime

      # field :row_created_at,          type: DateTime
      # field :row_updated_at,          type: DateTime

      # index({ area_name:      1 })
      # index({ postal_code:    1 }, { sparse: true })

      # index({ summary_level:  1,
      #         state_code:     1,
      #         county_code:    1,
      #         },
      #       { name: "summary_states_and_counties" }
      #       )

      # index({ state_code:     1,
      #         county_code:    1,
      #         },
      #       { name: "states_and_counties" }
      #       )

      scope :us_states,               -> {where(summary_level: STATES_SUMMARY_LEVEL) }
      scope :us_counties,             -> {where(summary_level: COUNTIES_SUMMARY_LEVEL) }
      scope :state_by_state_code,     ->(state_code) { where(summary_level: STATES_SUMMARY_LEVEL, state_code: state_code) }
      scope :counties_by_state_code,  ->(state_code) { where(summary_level: COUNTIES_SUMMARY_LEVEL, state_code: state_code) }
      scope :state_by_postal_code,    ->(postal_code) { where(postal_code: postal_code) }

      def self.find_by_fips(fips)
        state_code = fips.first(-3).to_i
        county_code = fips.last(3).to_i
        where(state_code: state_code, county_code: county_code)
      end

      def self.state_pair_for(fips)
        state_code = fips.to_i
        Locations::UsState::NAME_IDS.detect { |state_pair| state_pair.last == state_code }
      end

      def self.strip_lead_zeros(numeric_string)
        numeric_string.sub!(/^0*/, '').to_i || 0
      end

      # Expects US Census Bureau File in CSV format
      def self.load_file(file_name)
        lambda { |field, _|
          return unless field.present?
          field.numeric? ? self.strip_lead_zeros(field) : field
        }
        puts "Starting import"
        count = 0
        CSV.foreach(file_name, headers: HEADERS).with_index do |row, i|
          next if i < FILE_METADATA_ROW_SIZE
          case row[:summary_level].to_i
          when STATES_SUMMARY_LEVEL
            puts "Writing State: #{row[:area_name]}"
            state_pair = state_pair_for(row[:state_code])
            new_record = (row.to_h).merge!({ postal_code: state_pair[1], state: state_pair.first, state_abbr: state_pair.second })
          when COUNTIES_SUMMARY_LEVEL
            puts "  writing County: #{row[:area_name]}"
            state_pair = state_pair_for(row[:state_code])
            new_record = row.to_h.merge!(state: state_pair.first, state_abbr: state_pair.second)
          else
            next
          end
          self.create!(new_record)
          count = i + 1
        end
        puts "Loaded #{count} rows from #{file_name}"
        count
      end

      def fips
        "#{padded_state_code}#{padded_county_code}"
      end

      def padded_state_code
        format("%02d", state_code)
      end

      def padded_county_code
        format("%03d", county_code)
      end
    end
  end
end
