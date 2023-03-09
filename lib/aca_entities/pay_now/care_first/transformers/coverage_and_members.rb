# frozen_string_literal: true

module AcaEntities
  module PayNow
    module CareFirst
      module Transformers
        # Transformer for PayNow CareFirst custom XML
        class CoverageAndMembers < ::AcaEntities::Operations::Transforms::Transform
          include ::AcaEntities::Operations::Transforms::Transformer

          namespace 'coverage_and_members' do
            rewrap 'pay_now_transfer_payload', type: :hash do

              map 'hbx_enrollment.product_kind', 'coverage_kind', function: lambda { |v|
                "urn:openhbx:terms:v1:qhp_benefit_coverage##{v}"
              }

              # TODO: primary

              # TODO: members
              namespace 'members' do
                rewrap 'members', type: :array do
                  rewrap '', type: :hash do
                    # namespace 'member' do
                      # rewrap 'member', type: :hash do


                        # map 'hbx_id', 'hbx_id', memoize: true, visible: false
                        # add_key 'exchange_assigned_member_id', function: lambda {|v|
                        #   binding.irb
                        #   v.find('hbx_id').first.item }
                        map 'hbx_id', 'member.exchange_assigned_member_id'
                        map 'person_name.first_name', 'member.member_name.person_given_name'
                        map 'person_name.middle_name', 'member.member_name.person_middle_name'
                        map 'person_name.last_name', 'member.member_name.person_surname'
                        map 'person_name.full_name', 'member.member_name.person_full_name'
                        map 'person_name.name_pfx', 'member.member_name.person_name_prefix_text'
                        map 'person_name.name_sfx', 'member.member_name.person_name_suffix_text'
                        map 'person_name.alternate_name', 'member.member_name.person_alternate_name'
                        
                        map 'person_demographics.dob', 'member.birth_date', function: lambda {|birth_date|
                          binding.irb
                        }
                      # end
                    # end
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
