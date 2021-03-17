# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Qbo::Vendors::VendorContract do

  let(:display_name)    { { :"DisplayName" => "Books by Bessie"  } }

  let(:customer) { 
   {
      "PrimaryEmailAddr": {
        "Address": "Books@Intuit.com"
      }, 
      "Vendor1099": false, 
      "domain": "QBO", 
      "GivenName": "Bessie", 
      "BillAddr": {
        "City": "Palo Alto", 
        "Line1": "15 Main St.", 
        "PostalCode": "94303", 
        "Lat": "37.445013", 
        "Long": "-122.1391443", 
        "CountrySubDivisionCode": "CA", 
        "Id": "31"
      },
      "SyncToken": "0", 
      "PrintOnCheckName": "Books by Bessie", 
      "FamilyName": "Williams", 
      "PrimaryPhone": {
        "FreeFormNumber": "(650) 555-7745"
      }, 
      "AcctNum": "1345", 
      "CompanyName": "Books by Bessie", 
      "WebAddr": {
        "URI": "http://www.booksbybessie.co"
      }, 
      "sparse": false, 
      "Active": true, 
      "Balance": 0, 
      "MetaData": {
        "CreateTime": "2014-09-12T10:07:56-07:00", 
        "LastUpdatedTime": "2014-09-17T11:13:46-07:00"
      }
    }
  }

  let(:required_params)     { display_name }
  let(:optional_params)     { customer }
  let(:all_params)          { required_params.merge(optional_params) }

  context "Given invalid parameter scenarios" do
    context "with empty parameters" do
      it 'should list error for every required parameter' do
        result = subject.call({})

        expect(result.success?).to be_falsey
        expect(result.errors.to_h.keys).to match_array required_params.keys
      end
    end

    context "with optional parameters only" do
      it { expect(subject.call(optional_params).success?).to be_falsey }
      it { expect(subject.call(optional_params).error?(:"DisplayName")).to be_truthy }
    end
  end

  context "Given valid parameters" do

    context "and required parameters only" do
      it { expect(subject.call(required_params).success?).to be_truthy }
      it { expect(subject.call(required_params).to_h).to eq required_params }
    end

    context "and all required and optional parameters" do

      it "should pass validation" do
        result = subject.call(all_params)

        expect(result.success?).to be_truthy
        expect(result.to_h).to eq all_params
      end
    end
  end
end
