# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/call_center/types'
require 'aca_entities/call_center/phone_config'
require 'aca_entities/call_center/identity_info'
require 'aca_entities/call_center/user'

RSpec.describe AcaEntities::CallCenter::User do

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
      hierarchy_group_id: hierarchy_group_id
      # tags: tags,
    }
  end

  let(:all_params)          { required_params.merge(optional_params) }

  context "Validation with invalid input" do
    context "Given hash params are missing required attributes" do
      let(:error_hash)  { {} }

      it "should fail validation" do
        expect {described_class.new(optional_params)}.to raise_error Dry::Struct::Error
      end
    end
  end

  context "Validation with valid input" do
    context "Given hash params include only required attributes" do
      it "should pass validation" do
        expect(described_class.new(required_params)).to be_a AcaEntities::CallCenter::User
        expect(described_class.new(required_params).to_h).to eq required_params
      end
    end

    context "Given hash params include all required and optional attributes" do
      it "should pass validation" do
        expect(described_class.new(all_params)).to be_a AcaEntities::CallCenter::User
        expect(described_class.new(all_params).to_h).to eq all_params
      end
    end
  end

end
