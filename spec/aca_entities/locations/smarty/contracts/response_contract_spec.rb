# frozen_string_literal: true

require 'spec_helper'

RSpec.describe ::Locations::Smarty::Contracts::ResponseContract do
  subject { described_class.new }

  let(:sample_response) do
    {
      'input_id' => nil,
      'input_index' => 0,
      'candidate_index' => 0,
      'addressee' => nil,
      'delivery_line_1' => '729 Harpswell Islands Rd',
      'delivery_line_2' => nil,
      'last_line' => 'Harpswell ME 04079-3806',
      'delivery_point_barcode' => '040793806292',
      'components' => {
        'urbanization' => nil,
        'primary_number' => '729',
        'street_name' => 'Harpswell Islands',
        'street_predirection' => nil,
        'street_postdirection' => nil,
        'street_suffix' => 'Rd',
        'secondary_number' => nil,
        'secondary_designator' => nil,
        'extra_secondary_number' => nil,
        'extra_secondary_designator' => nil,
        'pmb_designator' => nil,
        'pmb_number' => nil,
        'city_name' => 'Harpswell',
        'default_city_name' => 'Harpswell',
        'state_abbreviation' => 'ME',
        'zipcode' => '04079',
        'plus4_code' => '3806',
        'delivery_point' => '29',
        'delivery_point_check_digit' => '2'
      },
      'metadata' => {
        'record_type' => 'S',
        'zip_type' => 'Standard',
        'county_fips' => '23005',
        'county_name' => 'Cumberland',
        'carrier_route' => 'R004',
        'congressional_district' => '01',
        'building_default_indicator' => nil,
        'rdi' => 'Residential',
        'elot_sequence' => '0114',
        'elot_sort' => 'D',
        'latitude' => 43.81193,
        'longitude' => -69.92816,
        'precision' => 'Zip9',
        'time_zone' => 'Eastern',
        'utc_offset' => -5,
        'obeys_dst' => true,
        'is_an_ews_match' => nil
      },
      'analysis' => {
        'dpv_match_code' => 'Y',
        'dpv_footnotes' => 'AABB',
        'cmra' => 'N',
        'vacant' => 'N',
        'no_stat' => 'N',
        'active' => 'Y',
        'is_ews_match' => nil,
        'footnotes' => 'N#',
        'lacs_link_code' => nil,
        'lacs_link_indicator' => nil,
        'is_suite_link_match' => nil,
        'enhanced_match' => nil
      }
    }
  end

  context 'A sample_response with all valid params' do
    it 'should pass vaidation' do
      result = subject.call(sample_response)

      expect(result.success?).to be_truthy
      expect(result.to_h).to eq sample_response.deep_symbolize_keys
    end
  end
end
