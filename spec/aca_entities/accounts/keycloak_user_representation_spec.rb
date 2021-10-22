# frozen_string_literal: true

require 'spec_helper'

RSpec.describe AcaEntities::Accounts::KeycloakUserRepresentation do
  subject { described_class }

  it 'with no arguments it should create a new instance' do
    result = subject.new

    expect(result).to be_a AcaEntities::Accounts::KeycloakUserRepresentation
    expect(result.to_h).to eq Hash.new
  end
end
