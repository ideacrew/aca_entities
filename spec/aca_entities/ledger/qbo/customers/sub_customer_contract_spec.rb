# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Qbo::Customers::SubCustomerContract do

  let(:required_params)    { { "DisplayName": "Bill's Windsurf Shop", "ParentRef": {value:"123"} } }

  let(:customer) { 
     {
        "PrimaryEmailAddr": {
          "Address": "Surf@Intuit.com"
        },
        "PrimaryTaxIdentifier": "011010110",
        "Id": "12345",
        "SyncToken": "0", 
        "domain": "QBO", 
        "GivenName": "Bill", 
        "DisplayName": "Bill's Windsurf Shop", 
        "BillWithParent": false, 
        "FullyQualifiedName": "Bill's Windsurf Shop", 
        "CompanyName": "Bill's Windsurf Shop", 
        "FamilyName": "Lucchini", 
        "sparse": false, 
        "PrimaryPhone": {
          "FreeFormNumber": "(415) 444-6538"
        }, 
        "Active": true, 
        "Job": false, 
        "BalanceWithJobs": 85.0, 
        "BillAddr": {
          "City": "Half Moon Bay", 
          "Line1": "12 Ocean Dr.", 
          "PostalCode": "94213", 
          "Lat": "37.4307072", 
          "Long": "-122.4295234", 
          "CountrySubDivisionCode": "CA", 
          "Id": "3"
        }, 
        "PreferredDeliveryMethod": "Print", 
        "Taxable": false, 
        "PrintOnCheckName": "Bill's Windsurf Shop", 
        "Balance": 85, 
        "MetaData": {
          "CreateTime": "2014-09-11T16:49:28-07:00", 
          "LastUpdatedTime": "2014-09-18T12:56:01-07:00"
        }
      }
   }

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
      it { expect(subject.call(optional_params).error?(:"Id" && :"ParentRef")).to be_truthy }
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
