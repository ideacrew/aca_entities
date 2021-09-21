# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module Fdsh
        module Rrv
          module Ifsv
            # Happymapper implementation for the root object of an Request.
            class CompletePersonName
              include HappyMapper
              register_namespace 'irs', 'urn:us:gov:treasury:irs:common'

              tag 'CompletePersonName'
              namespace 'irs'

              element :PersonFirstName, String, tag: 'PersonFirstName', namespace: 'irs'
              element :PersonMiddleName, String, tag: 'PersonMiddleName', namespace: 'irs'
              element :PersonLastName, String, tag: 'PersonLastName', namespace: 'irs'
              element :SuffixName, String, tag: 'SuffixName', namespace: 'irs'

              def self.domain_to_mapper(persone_name)
                mapper = self.new
                mapper.PersonFirstName = persone_name.PersonFirstName
                mapper.PersonMiddleName = persone_name.PersonMiddleName
                mapper.PersonLastName = persone_name.PersonLastName
                mapper.SuffixName = persone_name.SuffixName

                mapper
              end
            end
          end
        end
      end
    end
  end
end
