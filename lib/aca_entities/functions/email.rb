# frozen_string_literal: true

module AcaEntities
  module Functions
    # build person email
    class Email
      def call(value)
        # require 'pry';binding.pry
      if value.resolve('family.family_members.is_primary_applicant').item == value.find(Regexp.new("attestations.members")).map(&:item).last
        [{ address: value.resolve('family.family_members.person.email.address').item, kind: 'home' }]
      end
      end
    end
  end
end

# add_key 'emails', function: lambda {|v|
#   # revisit if condition for emails and phone for dependents
#   if v.resolve('family.family_members.is_primary_applicant').item ==
#       v.find(Regexp.new("attestations.members")).map(&:item).last
#     [{ address: v.resolve('family.family_members.person.email.address').item, kind: 'home' }]
#   end
# }
