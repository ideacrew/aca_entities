# frozen_string_literal: true
require 'pry'
# rubocop:disable  Lint/DuplicateBranch, Naming/PredicateName, Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity, Metrics/MethodLength, Layout/LineLength, Metrics/AbcSize, Metrics/ClassLength
module AcaEntities
  module Functions
    # build application and applicants
    class BuildApplication
      def call(context)
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
          family_reference: { hbx_id: @memoized_data.resolve('family.hbx_id').item.to_s }
        }
      end
    end
  end
end
# rubocop:enable  Lint/DuplicateBranch, Naming/PredicateName, Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity, Metrics/MethodLength, Layout/LineLength, Metrics/AbcSize, Metrics/ClassLength
