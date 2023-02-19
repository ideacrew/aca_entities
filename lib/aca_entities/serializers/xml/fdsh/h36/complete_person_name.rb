# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module Fdsh
        module H36
          # Happymapper implementation for the root object of an CompletePersonName.
          class CompletePersonName
            include HappyMapper

            tag 'CompletePersonName'

            element :PersonFirstName, String, tag: "PersonFirstName"
            element :PersonMiddleName, String, tag: "PersonMiddleName"
            element :PersonLastName, String, tag: "PersonLastName"
            element :SuffixName, String, tag: "SuffixName"

            def self.domain_to_mapper(request)
              mapper = self.new
              mapper.PersonFirstName = request.PersonFirstName
              mapper.PersonMiddleName = request.PersonMiddleName if request.PersonMiddleName
              mapper.PersonLastName = request.PersonLastName if request.PersonLastName
              mapper.SuffixName = request.SuffixName if request.SuffixName

              mapper
            end
          end
        end
      end
    end
  end
end