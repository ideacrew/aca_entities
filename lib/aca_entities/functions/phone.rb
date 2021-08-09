# frozen_string_literal: true

module AcaEntities
  module Functions
    # build person phone
    class Phone
      def call(value)
        # require 'pry';binding.pry
        phones = []
        if value.resolve('family.family_members.is_primary_applicant').item == value.find(/attestations.members.(\w+)$/).map(&:item).last
          phones << { extension: value.resolve('family.family_members.person.phone.ext').item,
                      kind: value.resolve('family.family_members.person.phone.type').item.to_s.downcase,
                      area_code: value.resolve('family.family_members.person.phone.number').item[0..2],
                      number: value.resolve('family.family_members.person.phone.number').item[3..9],
                      primary: true,
                      full_phone_number: value.resolve('family.family_members.person.phone.number').item,
                      start_on: nil,
                      end_on: nil }
          if value.resolve('family.family_members.person.second.phone.number').item
            secondary = { extension: value.resolve('family.family_members.person.second.phone.ext').item,
                          kind: value.resolve('family.family_members.person.second.phone.type').item.to_s.downcase,
                          area_code: value.resolve('family.family_members.person.second.phone.number').item[0..2],
                          number: value.resolve('family.family_members.person.second.phone.number').item[3..9],
                          primary: false,
                          full_phone_number: value.resolve('family.family_members.person.second.phone.number').item,
                          start_on: nil,
                          end_on: nil }
            phones << secondary
          end
        end
        phones
      end
    end
  end
end

# add_key 'phones', function: lambda {|v|
#   # revisit if condition for emails and phone for dependents
#   # if v.resolve('family.family_members.is_primary_applicant').item ==
#   #     v.find(Regexp.new("attestations.members")).map(&:item).last
#
#   if v.resolve('family.family_members.is_primary_applicant').item == v.find(/attestations.members.(\w+)$/).map(&:item).last
#     phones = []
#     phones << { extension: v.resolve('family.family_members.person.phone.ext').item,
#                 kind: v.resolve('family.family_members.person.phone.type').item.to_s.downcase,
#                 area_code: v.resolve('family.family_members.person.phone.number').item[0..2],
#                 number: v.resolve('family.family_members.person.phone.number').item[3..9],
#                 primary: true,
#                 full_phone_number: v.resolve('family.family_members.person.phone.number').item,
#                 start_on: nil,
#                 end_on: nil }
#     if v.resolve('family.family_members.person.second.phone.number').item
#       secondary = { extension: v.resolve('family.family_members.person.second.phone.ext').item,
#                   kind: v.resolve('family.family_members.person.second.phone.type').item.to_s.downcase,
#                   area_code: v.resolve('family.family_members.person.second.phone.number').item[0..2],
#                   number: v.resolve('family.family_members.person.second.phone.number').item[3..9],
#                   primary: false,
#                   full_phone_number: v.resolve('family.family_members.person.second.phone.number').item,
#                   start_on: nil,
#                     end_on: nil }
#       phones << secondary
#     end
#     phones
#   end
# }
