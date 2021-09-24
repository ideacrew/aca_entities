# frozen_string_literal: true

module AcaEntities
  module Functions
    # build application and applicants
    class BuildApplication
      def call(context)
        return [] unless context.resolve('is_applying_for_assistance').item
        @memoized_data = context
        @primary_applicant_identifier = @memoized_data.resolve('family.family_members.is_primary_applicant').item
        applicants = @memoized_data.find('computed.members').each_with_object([]) do |member, collector|
          collector << AcaEntities::Functions::ApplicantBuilder.new.call(context, member)
          collector
        end

        [application_hash.merge!(applicants: applicants)]
      end

      private

      def application_hash
        {
          hbx_id: '1234', # default value
          us_state: 'ME', # default value
          assistance_year: @memoized_data.resolve('assistance_year').item,
          parent_living_out_of_home_terms: @memoized_data.resolve('parent_living_out_of_home_terms').item,
          report_change_terms: @memoized_data.resolve('report_change_terms').item,
          medicaid_terms: @memoized_data.resolve('medicaid_terms').item,
          is_renewal_authorized: @memoized_data.resolve('is_renewal_authorized').item,
          years_to_renew: @memoized_data.resolve('years_to_renew').item,
          family_reference: { hbx_id: @memoized_data.resolve('family.hbx_id').item.to_s },
          # default values
          aptc_effective_date: Date.new(2021, 1, 1),
          oe_start_on: Date.new(2020, 11, 1),
          notice_options: { send_eligibility_notices: false, send_open_enrollment_notices: true }
        }
      end
    end
  end
end
