# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/serializers/xml/fdsh/ridp'
require 'open3'

RSpec.describe AcaEntities::Serializers::Xml::Fdsh::Ridp::PrimaryRequest do

  let(:file) do
    loc = File.join(File.dirname(__FILE__), "..", "..", "..", "..", "..", "reference", "xml", "ridp", "RIDPPrimaryRequest.xml")
    File.expand_path(loc)
  end

  let(:payload) do
    {"Request"=>{"xmlns:exch"=>"http://ridp.dsh.cms.gov/exchange/1.0", "xmlns:ext"=>"http://ridp.dsh.cms.gov/extension/1.0", "xmlns:i"=>"http://niem.gov/niem/appinfo/2.0", "xmlns:niem_xsd"=>"http://niem.gov/niem/proxy/xsd/2.0", "xmlns:s"=>"http://niem.gov/niem/structures/2.0", "xmlns:nc"=>"http://niem.gov/niem/niem-core/2.0", "xmlns:usps"=>"http://niem.gov/niem/usps_states/2.0", "xmlns:ns0"=>"http://niem.gov/niem/appinfo/2.1", "xmlns:xsi"=>"http://www.w3.org/2001/XMLSchema-instance", "xsi:schemaLocation"=>"http://ridp.dsh.cms.gov/exchange/1.0 ../XMLschemas/constraint/XMLschemas/exchange/ExchangeModel.xsd", "PrimaryRequest"=>{"Person"=>{"PersonBirthDate"=>{"Date"=>"2006-05-04"}, "PersonName"=>{"PersonGivenName"=>"FirstName", "PersonMiddleName"=>"MiddleName", "PersonSurName"=>"SurName", "PersonNameSuffixText"=>"SR"}, "PersonSSNIdentification"=>"123-45-6789"}, "CurrentAddress"=>{"LocationAddress"=>{"StructuredAddress"=>{"LocationStreet"=>{"StreetName"=>"StreetName0"}, "LocationCityName"=>" ", "LocationStateUSPostalServiceCode"=>"AK", "LocationPostalCode"=>"00000", "LocationPostalExtensionCode"=>"0000"}}}, "ContactInformation"=>{"ContactTelephoneNumber"=>{"FullTelephoneNumber"=>"(410)888-8888"}}, "SubscriberNumber"=>["1234567", "1234567"]}}}
  end

  before do
    # result = File.read(file)
    binding.pry
    described_class.domain_to_mapper(payload.to_xml)
  end

  it "" do
    
  end
  
end