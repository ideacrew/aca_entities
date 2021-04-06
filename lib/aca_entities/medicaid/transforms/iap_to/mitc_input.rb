# This file defines the maps
module Medicaid
  module Transforms
    module IapTo
      class MitcInput < ::Operations::Transform
        include ::Transform::Transformer

        record_delimiter 'applications.identifier.result' # TODO: support wild card ex. applications.*.result (prefer Regex)

        # map "dateofBirth", "Age", 'age_on' #-> { age_on('1/1/2000') }

        # define! do
        #   map_array do
        #     symbolize_keys
        #     rename_keys user_name: :name
        #     nest :address, [:city, :street, :zipcode]
        #   end
        # end

        # define! do
        #   map_array do
        #     symbolize_keys
        #     rename_keys 'coverageYear': 'families.household.hbx_enrollment.plan_year'
        #     nest :address, [:city, :street, :zipcode]
        #     change_value
        #   end
        # end

        # map "coverageYear", "plan_year", :rename_keys
        # map "coverageYear", "families.household.hbx_enrollment.plan_year", [:rename_keys, :nest]
        # map "applicationCreationDateTime", "families.household.hbx_enrollment.applicationCreationDateTime", [:nest]

        # map "lastUpdateMetadata", "lastUpdateMetadataNew", [:rename_keys]
        # map "lastUpdateMetadata.sourceSystemName", "lastUpdateMetadataNew.sourceSystemNameNew", [:nest]


        # map "coverageYear": "families.household.hbx_enrollment.plan_year", :age_on
        # map "coverageYear": "families.household.hbx_enrollment.plan_year", :datetime
        # map "coverageYear": "families.household.hbx_enrollment.plan_year", :datetime


        # map "covered_individual.coverageYear": "hbx_enrollment.plan_year"
        # map "covered_individual.attribute": "hbx_enrollment.plan_year"
        # map "covered_individual.value": "hbx_enrollment.value"

        # approach A:
        # collecting all our mapping statements
        # we can construct dry transform using their dsl
        # once the record is create we can run it through transform

        # apporach B:

        # collecting all our mapping statements
        # we can construct dry transform using their dsl
        # when key value is parsed....construct a hash object with the key value pair
        # run it against the dry transform

        # nest :hbx_enrollment, [:plan_year]
        # nest :household, [:hbx_enrollment]
        # nest :families, [:household]
        # map_function :age_on, -> { Date.today }
        # map "coverageYear", "families.household.hbx_enrollment.plan_year", :rename_nested_key

        # map "coverageYear", "hbx_enrollment.coverageYear", [:nest]
        # map "insuranceApplicationIdentifier", "hbx_enrollment.insuranceApplicationIdentifier", [:nest]
        # map "hbx_enrollment", "household", [:nest]
        # map "household", "families", [:nest]

        # map "coverageYear", "families.household.hbx_enrollment.coverageYear", [:nest]
        # map "insuranceApplicationIdentifier", "families.household.hbx_enrollment.insuranceApplicationIdentifier", [:nest]

        # map "lastUpdateMetadata", "lastUpdateData", [:rename_keys]
        # map "lastUpdateMetadata.sourceSystemName", "lastUpdateData.sourceName", :rename_nested_keys
        # map "lastUpdateMetadata.sourceSystemName", "lastUpdateData.sourceName", :rename_nested_keys

        # namespace "lastUpdateMetadata", "lastUpdateData" do
        #   map "sourceSystemName", "sourceName"
        # end

        # namespace "attestations.application", "records.record" do
        #     map "legalAttestations", "attestations"
        #     map "applicationSignatures", "signatures"
        #     map "contactMemberIdentifier", "attestations" # , add_key: ["members", "computed.variableDeterminations.memberVariableDeterminations"]

        #    	rewrap 'family.verifications.consumer_role' do
        #   		map "comments", "user_comments"
        #   		map "contactInformation", "contact"
        #   		map "applicationAssistors", "applicationAssistors"
        #   	end
        # end

        # namespace "attestations" do
        #   namespace "application" do
        #   	rewrap 'new_key.test'do
        #       map "applicationSignatures", "signatures"
        #     end
        #   end
        # end

        # namespace "lastUpdateMetadata" do
        #   rewrap "lastUpdateData" do
        #     map "sourceSystemName", "sourceName"
        #   end
        # end

        # namespace "lastUpdateMetadata" do
        #   map "sourceSystemName", "sourceName"
        # end

        # namespace "lastUpdateMetadata" => "lastUpdateData" do
        #   map "sourceSystemName", "sourceName"
        # end

        # namespace "attestations", "verifications" do
        #   namespace "application", "consumer_role" do
        #     map "comments", "user_comments"
        #     map "contactInformation", "contact"
        #   end
        # end

        # namespace "attestations.application" do
        #   rewrap "person.family.household" do
        #     map "legalAttestations", "user_comments", :stringify, :camelcase
        #     map "applicationSignatures", "signatures", :date
        #   end
        # end

        # namespace "attestations" do
        #   namespace "application" do
        #     rewrap "attestations" do
        #       map "legalAttestations", "user_comments"
        #       map "applicationSignatures", "signatures"
        #     end
        #   end
        # end

        # map "", "hbx_id", Types::IdGenerator(:family)

        # map "renewEligibilityYearQuantity", "renewal_consent_through_year", -> {|year| year + value_of("attestations.application.applicationSignatures")}

        # namespace "attestations.application.members", "family_members" do

        #   group ''
        #   rewrap 'identifiers.identifier' do
        #     map "", "source_system_key", literal: 'ffm'
        #     map "*", "identifiers.ids"
        #   end

        #   # rewrap do
        #   map "legalAttestations", "user_comments"
        #   map "applicationSignatures", "signatures"
        #   # end
        # end

        # map "attestations", "verifications", [:rename_keys]
        # map "attestations.application", "verifications.consumer_role", [:rename_nested_keys]
        # map "attestations.application.comments", "verifications.consumer_role.user_comments", [:rename_nested_keys]
        # map "attestations.application.contactInformation", "verifications.consumer_role.contact", [:rename_nested_keys]



        # map "lastUpdateMetadata.roleId", "lastUpdateData.role", :rename_nested_keys

        # map "attestations", "verifications", [:rename_keys]
        # map "attestations.application", "verifications.consumer_role", [:rename_nested_keys]
        # map "attestations.application.comments", "verifications.consumer_role.user_comments", [:rename_nested_keys]
        # map "attestations.application.contactInformation", "verifications.consumer_role.contact", [:rename_nested_keys]

        # map "computed.application.bestSEP", "computed.seps.bestSEP", [:rewrap_keys]
        # map "attestations.application.applicationSignatures", "verifications.consumer_role.signatures", [:rename_nested_keys]



        # "applicationSignatures"=>[{"applicationSignatureText"=>"Roslyn dshab"}, {"applicationSignatureType"=>"APPLICANT"}, {"applicationSignatureDate"=>"2019-01-04"}],


        # unwrap ['computed', 'application'], ['bestSEP']
        # unwrap ["computed"], ['bestSEP']

        # nest "seps", ['bestSEP']
        # nest "computed", ['seps']

        # map "computed.application.bestSEP", "computed.bestSEP", [:rewrap_keys]

        # unwrap "computed.application", ['bestSEP']
        # unwrap "computed", ['bestSEP']
        # nest "computed", ['bestSEP']

        # map "computed.application.bestSEP", "bestSEP", [:rewrap_keys]

        # unwrap "computed.application", ['bestSEP']
        # unwrap "computed", ['bestSEP']


        # map "verifications.legalAttestations", "verificastions.consumer_attestations.legalAttestations", [:nest]
        # map "coverageYear", "families.household.hbx_enrollment.plan_year", :age_on
        # map "coverageYear", "families.household.hbx_enrollment.plan_year", :camelize

        # map_value "families.household.hbx_enrollment.plan_year", :age_on
        # map 'coverageYear',  {destination: ,}

        # map "insuranceApplicationIdentifier", "families.household.hbx_enrollment.insuranceApplicationIdentifier"


        # def switch_keys
        #   symbolize_keys
        #   rename_key "insuranceApplicationIdentifier", "families.household.hbx_enrollment.insuranceApplicationIdentifier"
        # end

        #    map "applicationVersionNumber"
        # map "applicationSubmissionDateTime", "families.household.hbx_enrollment.applicationSubmissionDateTime", -> {|value| DateTime.new(value) }
        # map "applicationCreationDateTime", "families.household.hbx_enrollment.applicationCreationDateTime"

        # group "coveredInsuredMembers" do
        #   map "subscriberIndicator", "isSubscriber"
        #   group "memberInfo" do
        #     map "birthDate", "dob"
        #   end
        # end

        # group :coveredInsuredMembers do
        #   group :memberInfo do
        #     map :birthDate, :dob
        #   end
        #   map :memberinfo, :applicantinfo
        # end

        # def call
        #   yield
        # end

        # Mapper.new(source_key: , destination_key: )
        # @mappings = []

        # def mapping_for(key)
        #   @container[key]
        # end


      end
    end
  end
end

# module Functions
#   # ...

#   def self.age_on(dob:, on_date: Date.today)


#   end

#   def self.load_json(v)
#     JSON.load(v)
#   end
# end

# Funcations.register(:age_on)

# support record_delimiter under transform operation
# implement mappings dsl
# register mappings using Dry Container
# execute mappings from Dry Container while parsing data under Transform
# create IO stream with parsed & mapped records
# persiste IO stream records to output file

# pass block to exeute end of each record, to yield back to executing program
#   - record counter
