# frozen_string_literal: true

require 'spec_helper'

RSpec.describe AcaEntities::Accounts::Oauth::OpenidConnectInfo do
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

  context 'Calling the contract with only optional params' do
    subject { described_class.call(optional_params) }

    it 'should fail validation' do
      expect { subject }.to raise_error(Dry::Struct::Error)
    end
  end

  context 'Calling the contract with required params' do
    subject { described_class.call(required_params) }

    it 'should pass validation' do
      expect(subject).to be_a described_class
      expect(subject.to_h).to eq required_params
    end
  end

  context 'Calling the contract with all params' do
    subject { described_class.call(all_params) }

    it 'should pass validation' do
      expect(subject).to be_a described_class
      expect(subject.to_h).to eq all_params
    end
  end

  context 'Calling the contract with Email key an nil value' do
    subject { described_class.call(all_params.merge(email: nil)) }

    it 'should pass validation' do
      expect(subject).to be_a described_class
      expect(subject.to_h).to eq all_params.merge(email: nil)
    end
  end
end
