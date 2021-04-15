# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/call_center/types'
require 'aca_entities/call_center/contracts/users/user_contract'

RSpec.describe AcaEntities::CallCenter::Contracts::Users::UserContract do

  let(:username)              { "daniel_craig" }
  let(:password)              { "best_bond_ever" }
  let(:identity_info)         { { first_name: "Dem", last_name:  "Onstration", email: "demo@me.com" } }
  let(:phone_config)          { { phone_type: "SOFT_PHONE", auto_accept: true, after_contact_work_time_limit: 1, desk_phone_number: "+12025551212" } }
  let(:directory_user_id)     { "DirectoryUserId" }
  let(:security_profile_ids)  { ["SecurityProfileId"] }
  let(:routing_profile_id)    { "RoutingProfileId" }
  let(:hierarchy_group_id)    { "HierarchyGroupId" }
  let(:instance_id)           { "InstanceId" }
  let(:tags)                  { { "TagKey" => "TagValue" } }

  let(:required_params)     do
    {
      instance_id: instance_id,
      username: username,
      security_profile_ids: security_profile_ids,
      routing_profile_id: routing_profile_id,
      phone_config: phone_config
    }
  end

  let(:optional_params)     do
    {
      password: password,
      identity_info: identity_info,
      directory_user_id: directory_user_id,
      hierarchy_group_id: hierarchy_group_id,
      tags: tags
    }
  end

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
      it { expect(subject.call(optional_params).error?(:instance_id)).to be_truthy }
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
