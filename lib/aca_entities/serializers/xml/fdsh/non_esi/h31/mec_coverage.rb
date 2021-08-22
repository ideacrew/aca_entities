# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module Fdsh
        module NonEsi
          module H31
            # Happymapper implementation for the root object of an Individual response.
            class MecCoverage
              include HappyMapper
              register_namespace 'vnem', 'http://vnem.ee.sim.dsh.cms.hhs.gov'
              register_namespace 'nc', 'http://niem.gov/niem/niem-core/2.0'

              tag 'MECCoverage'
              namespace 'vnem'

              element :LocationStateUSPostalServiceCode, String, tag: 'LocationStateUSPostalServiceCode', namespace: 'nc'
              element :MECVerificationCode, String, tag: 'MECVerificationCode', namespace: 'vnem'
              has_many :Insurances, Insurance

              def self.domain_to_mapper(mec_coverage)
                mapper = self.new
                mapper.LocationStateUSPostalServiceCode = mec_coverage.LocationStateUSPostalServiceCode
                mapper.MECVerificationCode = mec_coverage.MECVerificationCode
                mapper.Insurances = mec_coverage.Insurances.collect do |insurance|
                  Insurance.domain_to_mapper(insurance)
                end

                mapper
              end
            end
          end
        end
      end
    end
  end
end
