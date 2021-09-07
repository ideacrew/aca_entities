# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module Fdsh
        module Ifsv
          module H9t
            # Happymapper implementation for the root object of an Request.
            class IFSVApplicant
              include HappyMapper
              register_namespace 'ext', 'http://ifsv.dsh.cms.gov/extension/1.0'

              tag 'IFSVApplicant'
              namespace 'ext'

              has_one :Person, IFSVApplicant
              element :TaxFilerCategoryCode, String, tag: 'TaxFilerCategoryCode', namespace: "ext"

              def self.domain_to_mapper(request)
                mapper = self.new
                mapper.Person = Person.domain_to_mapper(request.Person)
                mapper.TaxFilerCategoryCode = request.TaxFilerCategoryCode
                mapper
              end
            end
          end
        end
      end
    end
  end
end