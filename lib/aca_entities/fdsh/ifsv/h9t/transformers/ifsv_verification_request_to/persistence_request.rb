# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Ifsv
      module H9t
        module Transformers
          module IfsvVerificationReqeustTo
            class PersistenceRequest < ::AcaEntities::Operations::Transforms::Transform
              include ::AcaEntities::Operations::Transforms::Transformer

              map "RequestID", 'request_id'
              namespace 'IFSVApplicants' do
                rewrap 'ifsv_applicants', type: :array do
                  rewrap '' do
                    namespace "Person" do
                      rewrap "person", type: :hash do
                        namespace "PersonName" do
                          rewrap "person_name", type: :hash do
                            map "PersonGivenName", "person_given_name"
                            map "PersonMiddleName", "person_middle_name"
                            map "PersonSurName", "person_sur_name"
                          end
                        end
                        namespace "PersonSSNIdentification" do
                          rewrap "person_ssn_identification", type: :hash do
                            map "IdentificationID", "identification_id"
                          end
                        end
                      end
                    end
                    map "TaxFilerCategoryCode", "tax_filer_category_code"
                  end
                end
              end
            end
          end
        end
      end
    end
  end
end