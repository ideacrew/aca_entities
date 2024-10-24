# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/medicaid/atp/date'
require 'aca_entities/medicaid/atp/start_date'

RSpec.describe ::AcaEntities::Medicaid::Atp::StartDate,  dbclean: :around_each do

  it 'should inherit from Date class' do
    expect(described_class).to be < ::AcaEntities::Medicaid::Atp::Date
  end
end

