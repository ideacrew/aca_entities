# frozen_string_literal: true

require 'spec_helper'

RSpec.describe ::AcaEntities::Atp::Operations::Family, dbclean: :after_each do
  let(:input_xml) {File.read(Pathname.pwd.join('spec/support/atp_sample_payloads/sample.xml'))}

  describe 'with valid xml' do
    before do
      @result = described_class.new(worker_mode: 'single', path: input_xml).call
    end

    it 'should return transformed hash' do
    end
  end
end
