# frozen_string_literal: true

require 'spec_helper'

RSpec.describe AcaEntities::Identities::Keycloak::UserRepresentation do
  subject { described_class }

  it 'with no arguments it should create a new instance' do
    result = subject.new

    expect(result).to be_a AcaEntities::Identities::Keycloak::UserRepresentation
    expect(result.to_h).to eq Hash.new
  end
end
