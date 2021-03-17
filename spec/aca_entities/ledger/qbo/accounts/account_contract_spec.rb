# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Qbo::Accounts::AccountContract do

  let(:name)    { { 
    :"Name" => 'MyJobs' 
    } }

  let(:account) { {
    :"SyncToken" => '0', 
    :"Id" => '94', 
    :"FullyQualifiedName" => 'MyJobs', 
    :domain => 'QBO', 
    :"Classification" => 'Asset', 
    :"AccountSubType" => 'AccountsReceivable', 
    :"CurrencyRef" => {
      :"name" => 'United States Dollar', 
      :"value" => 'USD'
    }, 
    :"CurrentBalanceWithSubAccounts" => 0, 
    :sparse => false, 
    :"MetaData" => {
      :"CreateTime" => '2014-12-31T09:29:05-08:00', 
      :"LastUpdatedTime" => '2014-12-31T09:29:05-08:00'
    }, 
    :"AccountType" => 'Accounts Receivable', 
    :"CurrentBalance" => 0, 
    :"Active" => true, 
    :"SubAccount" => false
    } }

  let(:required_params)     { name }
  let(:optional_params)     { account }
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
      it { expect(subject.call(optional_params).error?(:"Name")).to be_truthy }
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
