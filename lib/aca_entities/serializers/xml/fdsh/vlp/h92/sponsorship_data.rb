# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module Fdsh
        module Vlp
          module H92
            # Happymapper implementation for the root object of an
            # SponsorshipData.
            class SponsorshipData
              include HappyMapper
              register_namespace 'vlp', 'http://vlp.ee.sim.dsh.cms.hhs.gov'

              tag 'SponsorshipData'
              namespace 'vlp'

              element :LastName, String, tag: "LastName", namespace: 'vlp'
              element :FirstName, String, tag: "FirstName", namespace: 'vlp'
              element :MiddleName, String, tag: "MiddleName", namespace: 'vlp'
              element :Addr1, String, tag: "Addr1", namespace: 'vlp'
              element :Addr2, String, tag: "Addr2", namespace: 'vlp'
              element :City, String, tag: "City", namespace: 'vlp'
              element :StateProvince, String, tag: "StateProvince", namespace: 'vlp'
              element :ZipPostalCode, String, tag: "ZipPostalCode", namespace: 'vlp'
              element :SSN, String, tag: "SSN", namespace: 'vlp'
              element :CountryCode, String, tag: "CountryCode", namespace: 'vlp'
              element :CountryName, String, tag: "CountryName", namespace: 'vlp'

              def self.domain_to_mapper(sponsorship_data)
                mapper = self.new
                mapper.LastName = sponsorship_data.LastName
                mapper.FirstName = sponsorship_data.FirstName
                mapper.MiddleName = sponsorship_data.MiddleName
                mapper.Addr1 = sponsorship_data.Addr1
                mapper.Addr2 = sponsorship_data.Addr2
                mapper.City = sponsorship_data.City
                mapper.StateProvince = sponsorship_data.StateProvince
                mapper.ZipPostalCode = sponsorship_data.ZipPostalCode
                mapper.SSN = sponsorship_data.SSN
                mapper.CountryCode = sponsorship_data.CountryCode
                mapper.CountryName = sponsorship_data.CountryName

                mapper
              end
            end
          end
        end
      end
    end
  end
end