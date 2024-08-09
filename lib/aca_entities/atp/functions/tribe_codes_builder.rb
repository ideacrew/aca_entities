# frozen_string_literal: true

module AcaEntities
  module Atp
    module Functions

      # build tribal codes based on tribal name
      class TribeCodesBuilder
        TRIBAL_CODES_MAPPING = {
          "Maliseet" => "HM",
          "Passamaquoddy" => "PD",
          "Penobscot" => "PE",
          "Micmac" => "AM"
        }.freeze

        def call(tribe_name)
          find_codes(tribe_name)
        end

        def find_codes(tribe_name)
          codes = []
          TRIBAL_CODES_MAPPING.each do |key, code|
            # Use a case-insensitive regex to match the key
            codes << code if tribe_name =~ /#{Regexp.escape(key)}/i
          end

          codes.present? ? codes : ["OT"]
        end
      end
    end
  end
end
