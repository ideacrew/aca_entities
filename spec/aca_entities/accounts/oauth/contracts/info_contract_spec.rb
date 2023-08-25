# frozen_string_literal: true

require 'spec_helper'

RSpec.describe AcaEntities::Accounts::Oauth::Contracts::InfoContract do
  subject { described_class.new }

  let(:name) { 'George Jetson' }
  let(:email) { 'george.jetson@example.com' }
  let(:nickname) { 'Georgy' }
  let(:first_name) { 'George' }
  let(:last_name) { 'Jetson' }
  let(:location) { 'New Columbia' }
  let(:description) { "George likes cloud surfing and observing Saturn's Rings" }
  let(:image) { 'https://example.com/images/george_jetson.jpeg' }
  let(:phone) { '4105551212' }
  let(:urls) { { blog: 'https://example.com/blogs/george_jetson' } }

  let(:required_params) { { name: name } }
  let(:optional_params) do
    {
      email: email,
      nickname: nickname,
      first_name: first_name,
      last_name: last_name,
      location: location,
      description: description,
      image: image,
      phone: phone,
      urls: urls
    }
  end

  let(:all_params) { required_params.merge(optional_params) }

  context 'Calling the contract with optional params' do
    it 'should fail validation' do
      result = described_class.new.call(optional_params)
      expect(result.failure?).to be_truthy
    end
  end

  context 'Calling the contract with required params' do
    it 'should pass validation' do
      result = described_class.new.call(required_params)
      expect(result.success?).to be_truthy
      expect(result.to_h).to eq required_params
    end
  end

  context 'Calling the contract with all params' do
    it 'should pass validation' do
      result = described_class.new.call(all_params)
      expect(result.success?).to be_truthy
      expect(result.to_h).to eq all_params
    end
  end
end
