# frozen_string_literal: true

module Entities
  class TimeStamp < Dry::Struct

    attribute :submitted_at,                        Types::Date.optional.meta(omittable: true)
    attribute :created_at,                          Types::Date.optional.meta(omittable: true)
    attribute :modified_at,                         Types::Date.optional.meta(omittable: true)
  end
end

# families
# - family.rb
# - family_ref.rb
# - family_member.rb
# - family_member_ref.rb
#
# households
# - household_ref.rb
# - coverage_household_ref.rb
#
# organizations
# - profile_ref.rb
#
# people
# - person.rb
# - consumer_role.rb
# - consumer_role_ref.rb
# - emplyee_role_ref.rb
#
# enrollments
# - hbx_enrollment.rb
# - hbx_enrollment_member.rb
# - hbx_enrollment_ref.rb
#
# enrollment_periods
# - special_enrollment_period.rb
# - open_enrollment_period.rb
#
# qulaifying_life_events
# - qulaifying_life_event.rb
#
# benefit_catalogs
# - benefit_coverage_perid.rb
# - benefit_package.rb
#
# products
# - product_ref.rb