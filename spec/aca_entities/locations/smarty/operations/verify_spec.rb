# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Locations::Smarty::UsStreetAddresses::Verify do
  subject { described_class.new }

  let(:maine_counties) do
    %w[
      Androscoggin
      Aroostook
      Cumberland
      Franklin
      Hancock
      Kennebec
      Knox
      Lincoln
      Oxford
      Penobscot
      Piscataquis
      Sagadahoc
      Somerset
      Washington
      Waldo
      York
    ]
  end

  context 'Given an attribute-level clean address' do
    let(:input_id) { '12345' }
    let(:addressee) { 'IdeaCrew' }
    let(:street) { '1150 Connecticut Ave NW' }
    let(:street2) { '' }
    let(:secondary) { 'Suite 710' }
    let(:city) { 'Washington' }
    let(:state) { 'DC' }
    let(:zipcode) { '20036' }
    let(:lastline) { 'Brady' }
    let(:urbanization) { '' }
    let(:candidates) { 3 }
    let(:match) { 'strict' }

    let(:params) do
      {
        input_id: input_id,
        addressee: addressee,
        street: street,
        street2: street2,
        secondary: secondary,
        city: city,
        state: state,
        zipcode: zipcode,
        lastline: lastline,
        urbanization: urbanization,
        candidates: candidates,
        match: match
      }
    end

    context 'Given valid parameters' do
      it 'shouild return a single SmartyStreets::USStreet::Candidate instance' do
        result = subject.call(params)
        require 'pry'
        binding.pry
        expect(result.success?).to be_truthy
        expect(result.success.count).to eq 1
        expect(result.success.first).to be_a SmartyStreets::USStreet::Candidate
      end
    end
  end

  context 'Given a single line address with malformed zip code' do
    let(:verified_county) { 'Cumberland' }
    let(:verified_zip) { '04079' }
    let(:verified_last_line) { 'Harpswell ME 04079-3806' }

    let(:street) { '729 Harpswell Island Rd,,Harpswell,ME,4079' }
    let(:params) { { street: street } }

    it 'shouild return a single SmartyStreets::USStreet::Candidate instance' do
      result = subject.call(params)

      expect(result.success?).to be_truthy
      expect(result.success.count).to eq 1
      expect(result.success.first).to be_a SmartyStreets::USStreet::Candidate

      expect(result.success.first.metadata.county_name).to eq verified_county
      expect(result.success.first.components.zipcode).to eq verified_zip
      expect(result.success.first.last_line).to eq verified_last_line
    end
  end

  context 'Given a list of evil addresses' do
    let(:evil_addresses) do
      [
        '729 Harpswell Island Rd Harpswell ME 4079',
        '6 COTTAGE LN CAPE ELIZABETH ME 4107',
        '18 King St Sebago ME 4029',
        '8 Horizon Drive Dedham ME 4429 ',
        '12 Milbridge Road Cherryfield ME 4622 ',
        '31 Forest Rd Cape Elizabeth ME 4107',
        '6 Eastern Promenade Unit 3 Portland ME 4101',
        '10 Eaton Rd 0 Dexter ME 4930 ',
        '34 Morse Ln Cherryfield ME 4622 ',
        '33 Londonderry Ln Belfast ME 4915',
        '425 Montsweag Rd Woolwich ME 4579',
        '20 PENNELL AVE PORTLAND ME 4103',
        '66 WYMAN BOG RD WINSLOW ME 4902 ',
        '27 Lilac Ln Kennebunkport ME 4046',
        '111 Ryder Bluff Road Holden ME 4429 ',
        '14 Hobbs Hill Lane Harrison ME 4040 ',
        '1662 Main St Sandy River Plt ME 4970',
        '132 Cedar St Apt B Belfast ME 4915',
        '852 Airport Rd Dexter ME 4930 ',
        '64 Ridge Road Cherryfield ME 4622 ',
        '276 Mill St Rockport ME 4856',
        '9 Tilson Burke Rd Bethel ME 4217',
        '77 Falmouth Rd Falmouth ME 4105',
        '12 Warren Ave Lewiston ME 4240',
        '29 Bentley Ln Bangor ME 4401',
        '12 Warren Ave Lewiston ME 4240',
        '11 Church Road 0 Holden ME 4429 ',
        '774 West Plymouth Rd Etna ME 4404 ',
        '123 Main St Dexter ME 4930 ',
        'BOX 5950 NORTH STREET MECHANIC FALLS ME 0 ',
        '11A St. Francis Way Dedham ME 4429 ',
        '37 Colonial Circle Harrison ME 4040 ',
        '37 Colonial Cir Harrison ME 04040-3947 ',
        '22 Black Point Rd 4G Scarborough ME 4074',
        '12 Perkins Ave Old Town ME 4468',
        '350 North Main Street Cherryfield ME 4622 ',
        '111 CHARLSTON RD DEXTER ME 4930 ',
        '111 CHARLESTON ROAD DEXTER ME 4930 ',
        '131 Blacks Woods Road Cherryfield ME 4622 ',
        '336 Zions Hill Road Dexter ME 4930 ',
        '66 Bolster Mills Rd Harrison ME 4040 ',
        '16 Granite Hill Drive Gray ME 4039',
        '26 S. Lagrange Rd C/O: Laura & Dough Rouleau Lagrange ME 4452 ',
        'P.O. BOX 462 RANGE ROAD BLUE HILL ME 4615 ',
        '13 Sleepy Hollow Holden ME 4429 ',
        '32 Springfield Rd Winn ME 4495',
        '1583 US Route 1 Hancock ME 4604 ',
        '132 Downs Rd Sebec ME 4481',
        '39 Cindy Lane Dexter ME 4930 ',
        '9 Sterlingwood Dr Scarborough ME 4074',
        '221 Fisher Farm rd Sabattus ME 4208 ',
        '48 State St Apt 21 Portland ME 4101',
        '45 Nelligan Dr Holden ME 04429-7106 ',
        '8 Smith Street Harrison ME 4040 ',
        '187 milbridge Road Cherryfield ME 4622 ',
        '40 McFarland Street Lot 18 Dexter ME 4930 ',
        '103 Stillwater Road Cherryfield ME 4622 ',
        '141 Edes Falls Rd Harrison ME 4040 ',
        '471 Benton Rd Albion ME 10941 ',
        '4 Perry Lane Cherryfield ME 4622 ',
        '12 Twilight Drive Dexter ME 4930 ',
        '522 W Side Rd Cross Lake Twp ME 4779',
        '132 Temple Hill Road Harrison ME 4040 ',
        'Route 1 33 Freeport ME 4323 ',
        '338 River Rd St George ME 4857 ',
        '86 S Main St Brewer ME 4412',
        '3 stone st jay ME 4139 ',
        '66 North Birch St Greenville Jct ME 4442 ',
        '11 baker st Yarmouth ME 1834 ',
        '986A Edes Falls Rd Harrison ME 4040 ',
        '68 School Street Dexter ME 4930 ',
        '10 Old Colbath Road Exeter ME 4435',
        '131 Blacks Woods Road Cherryfield ME 4622 ',
        '6 Stovers Ocean Ave Harpswell ME 4709',
        '8 Smith Street Harrison ME 4040 ',
        'Dexter Health Care 64 Park St Dexter ME 4930 ',
        '616 LEVANSELOR RD HOLDEN ME 4429 ',
        '15 Gertrude Avenue rear apt" Portland ME 1403 ',
        '7 PERKINS LANE "Kennebunk  Maine" ME 3043 ',
        '99 Main Street Apt B Dexter ME 4930 ',
        '26 Park Street Apt 2 Dexter ME 4930 ',
        '136 Spring St Dexter ME 4930 ',
        '136 Spring St. Dexter ME 4930 ',
        '246 Bolsters Mills Rd Harrison ME 4040 ',
        '4 corinna Rd St Albans ME 5478 ',
        '106 Wainwright Circle W South Portland ME 40106 ',
        '21 Coolidge Ave South Portland ME 4106',
        '3 Wendy Ln Berwick ME 30901 ',
        '8 TWIN BRIDGE TERRACE HARRISON ME 4040 ',
        'Cape Memory Care 126 Scott Dyer Road Cape Elizabeth ME 3107 ',
        '862 GARLAND RD DEXTER ME 4930 ',
        '28 goose pt. rd kittery ME 3095 ',
        '43 Leander Harmon Road Harrison ME 4040 ',
        '43 Leander Harmon Rd harrison ME 4040 ',
        '299 Danforth St Portland ME 4102',
        '174 Free Street  Apt 3" Dexter ME 4930 ',
        '6  Gailey Farm Lane" Kittery Point ME 3801 ',
        '299 Danforth St Portland ME 4102',
        '57 Island View Drive Gouldsboro ME 5607 ',
        '63 FIELD POND RD HOLDEN ME 4429 ',
        'DHHS/OCFS 35 Anthony Avenue Augusta ME 43333 ',
        '397 Ohio Street Bangor ME 4641 ',
        '191 Lower Dedham Rd Holden ME 04429-7506 ',
        '423 NORTH VILLAGE RD OGUNQUIT ME 4907 ',
        '961 Garland Rd Dexter ME 4930 '
      ]
    end

    let(:verified_state_abbreviation) { 'ME' }

    it 'shouild return a single SmartyStreets::USStreet::Candidate instance' do
      failed_addresses = []
      evil_addresses.each do |evil_address|
        result = subject.call({ street: evil_address })

        if result.failure?
          failed_addresses << result.failure
          next evil_address
        end

        expect(result.success?).to be_truthy
        expect(result.success.count).to eq 1

        validated_address = result.success.first
        expect(validated_address).to be_a SmartyStreets::USStreet::Candidate
        expect(validated_address.components.state_abbreviation).to eq verified_state_abbreviation
        expect(validated_address.components.zipcode).not_to be_empty
        expect(maine_counties).to include validated_address.metadata.county_name
        binding.pry

        csv = CSV.new(valid_addresses)
        puts [
               '{',
               'address:',
               '{',
               'source_address:',
               "#{evil_address}",
               '}',
               'validated_address',
               '{',
               'line_1:',
               validated_address.delivery_line_1,
               'city:',
               validated_address.components.city_name,
               'state:',
               validated_address.components.state_abbreviation,
               'zipcode',
               validated_address.components.zipcode,
               'county_name:',
               validated_address.metadata.county_name,
               'county_fips_code:',
               validated_address.metadata.county_fips,
               '}',
               '}'
             ].join(' ')
      end
      puts "\n Failed Addresses:"
      failed_addresses.each { |addr| puts addr }
    end
  end

  context 'with parsed evil addresses parsed' do
    let(:state_abbreviation) { 'ME' }
    let(:enhanced_match) { 'enhanced' }

    let(:parsed_evil_street_addresses) do
      [
        # { street: 'R3 HIGH STREET', city: 'WEST GARDINER', zipcode: '0 ' },
        # { street: '485 Roundup Dr', city: ' Galloway', zipcode: '43119 ' },
        # { street: 'BOX 5950 NORTH STREET', city: ' HANIC FALLS', zipcode: '0' },
        # { street: 'Route 1 33', city: ' Freeport', zipcode: '4323' },
        # { street: 'DHHS/OCFS 35 Anthony Avenue', city: ' Augusta', zipcode: '43333 ' },
        { street: '1583 US Route 1', city: ' Hancock', zipcode: '4604' },
        { street: '8 Smith Street', city: ' Harrison', zipcode: '4040' },
        { street: '141 Edes Falls Rd', city: ' Harrison', zipcode: '4040' },
        { street: '66 North Birch St', city: ' Greenville Jct', zipcode: '4442' },
        { street: '8 Smith Street', city: ' Harrison', zipcode: '4040 ' },
        { street: 'Dexter Health Care 64 Park St', city: ' Dexter', zipcode: '4930' },
        { street: '7 PERKINS LANE', city: 'Kennebunk  Maine', zipcode: '3043 ' },
        { street: 'Cape Memory Care 126 Scott Dyer Road', city: ' Cape Elizabeth', zipcode: '3107' },
        { street: '28 goose pt. rd', city: ' kittery', zipcode: '3095' },
        { street: '63 FIELD POND RD', city: ' HOLDEN', zipcode: '4429' },
        { street: '423 NORTH VILLAGE RD', city: ' OGUNQUIT', zipcode: '4907' }
      ]
    end
    let(:matched_addresses) { %w[Y S D] }

    it 'shouild return a single SmartyStreets::USStreet::Candidate instance' do
      failed_parsed_addresses = []
      parsed_evil_street_addresses.each do |parsed_evil_address|
        result = subject.call(parsed_evil_address.merge({ state: state_abbreviation, match: enhanced_match }))

        if result.failure? || result.success == []
          failed_parsed_addresses << result.failure
          next parsed_evil_address
        end

        expect(result.success?).to be_truthy
        expect(result.success.first).to be_a SmartyStreets::USStreet::Candidate

        # expect(matched_addresses).to include result.success.analysis.dpv_match_code
        expect(result.success.first.components.zipcode).not_to be_nil
        expect(result.success.first.components.state_abbreviation).to eq state_abbreviation
        expect(maine_counties).to include result.success.first.metadata.county_name

        puts "#{parsed_evil_address} => " +
               [result.success.first.delivery_line_1, result.success.first.last_line].join(' ')
      end
      puts "\n Failed Parsed Addresses:"
      failed_parsed_addresses.each { |addr| puts addr }
    end
  end
end
