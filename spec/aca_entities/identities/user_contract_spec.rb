# frozen_string_literal: true

require 'spec_helper'

RSpec.describe AcaEntities::Accounts::User do
  subject { described_class }

  it 'with no arguments it should create a new instance' do
    result = subject.new

    expect(result).to be_a AcaEntities::Accounts::User
    expect(result.to_h).to eq Hash.new
  end
end
