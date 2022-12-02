# frozen_string_literal: true

module AcaEntities
  module Locations
    module Addresses
      module Smarty
        module Contracts
          # Schema and validation rules for {AcaEntities::Locations::Smarty::Response}
          class ResponseContract < Contract
            # @!method call(opts)
            # @param [Hash] opts the parameters to validate using this contract
            # @option opts [String] :input_id optional
            # @option opts [Integer] :input_index optional
            # @option opts [Integer] :candidate_index optional
            # @option opts [String] :addressee optional
            # @option opts [String] :delivery_line_1 optional
            # @option opts [String] :delivery_line_2 optional
            # @option opts [String] :last_line optional
            # @option opts [String] :delivery_point_barcode optional

            # @option opts [Hash] :components optional
            # @option opts [Hash] :metadata optional
            # @option opts [Hash] :analysis optional
            # @option opts [Locations::Smarty::Types::AddressMatchKind] :match optional
            # @return [Dry::Monads::Result]
            json do
              optional(:input_id).maybe(:string)
              optional(:input_index).maybe(:integer)
              optional(:candidate_index).maybe(:integer)
              optional(:addressee).maybe(:string)
              optional(:delivery_line_1).maybe(:string)
              optional(:delivery_line_2).maybe(:string)
              optional(:last_line).maybe(:string)
              optional(:delivery_point_barcode).maybe(:string)

              optional(:components).hash do
                optional(:urbanization).maybe(:string)
                optional(:primary_number).maybe(:string)
                optional(:street_name).maybe(:string)
                optional(:street_predirection).maybe(:string)
                optional(:street_postdirection).maybe(:string)
                optional(:street_suffix).maybe(:string)
                optional(:secondary_number).maybe(:string)
                optional(:secondary_designator).maybe(:string)
                optional(:extra_secondary_number).maybe(:string)
                optional(:extra_secondary_designator).maybe(:string)
                optional(:pmb_designator).maybe(:string)
                optional(:pmb_number).maybe(:string)
                optional(:city_name).maybe(:string)
                optional(:default_city_name).maybe(:string)
                optional(:state_abbreviation).maybe(:string)
                optional(:zipcode).maybe(:string)
                optional(:plus4_code).maybe(:string)
                optional(:delivery_point).maybe(:string)
                optional(:delivery_point_check_digit).maybe(:string)
              end

              optional(:metadata).hash do
                optional(:record_type).maybe(:string)
                optional(:zip_type).maybe(:string)
                optional(:county_fips).maybe(:string)
                optional(:county_name).maybe(:string)
                optional(:carrier_route).maybe(:string)
                optional(:congressional_district).maybe(:string)
                optional(:building_default_indicator).maybe(:string)
                optional(:rdi).maybe(:string)
                optional(:elot_sequence).maybe(:string)
                optional(:elot_sort).maybe(:string)
                optional(:latitude).maybe(:float)
                optional(:longitude).maybe(:float)
                optional(:precision).maybe(:string)
                optional(:time_zone).maybe(:string)
                optional(:utc_offset).maybe(:integer)
                optional(:obeys_dst).maybe(:bool)
                optional(:is_an_ews_match).maybe(:string)
              end

              optional(:analysis).hash do
                optional(:dpv_match_code).maybe(:string)
                optional(:dpv_footnotes).maybe(:string)
                optional(:cmra).maybe(:string)
                optional(:vacant).maybe(:string)
                optional(:no_stat).maybe(:string)
                optional(:active).maybe(:string)
                optional(:is_ews_match).maybe(:string)
                optional(:footnotes).maybe(:string)
                optional(:lacs_link_code).maybe(:string)
                optional(:lacs_link_indicator).maybe(:string)
                optional(:is_suite_link_match).maybe(:string)
                optional(:enhanced_match).maybe(:string)
              end
            end
          end
        end
      end
    end
  end
end
