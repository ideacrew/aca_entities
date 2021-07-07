# frozen_string_literal: true

require 'dry/monads'
require 'dry/monads/do'

module AcaEntities
  module Atp
    module Operations
      # Family Operations for atp payloads
      class Family
        include Dry::Monads[:result, :do, :try]

        attr_reader :worker_mode, :path, :source_hash

        def initialize(*args)
          handler = args.first
          @worker_mode = handler[:worker_mode] || :batch
          @path = handler[:path] || nil
          @source_hash = handler[:source_hash] || nil
        end

        def call
          # valid_params = yield validate_atp(source_hash)
          params = yield xml_transform
          #   params = yield batch_json_transform if @worker_mode == :batch # (app_params)
          yield single_json_transform(params) if worker_mode == :single

          Success(true)
        end

        private

        def validate_atp(params)
        end

        def input_xml
          return nil if source_hash
          source_path = path || default_xml_path
          path = Pathname.pwd.join(source_path)
          File.read(path)
        end

        def xml_transform
          result = AcaEntities::Serializers::Xml::Medicaid::Atp::AccountTransferRequest.parse(input_xml)
          Success(result.to_hash(identifier: true))
        end

        def single_json_transform(params)
          record = ::AcaEntities::Atp::Transformers::Cv::Family.transform(params)
          Success(record)
        end

        # TODO: (app_params)
        def transform_batch
          result = []
          input = file_path || source_hash # (app_params)

          ::AcaEntities::Atp::Transformers::Cv::Family.call(input, { transform_mode: worker_mode }) do |payload|
            record = worker_mode == :batch ? klass.transform(payload) : payload
            # TODO: broken
            result << ::AcaEntities::Ffe::Operations::McrTo::Family.new.call(record: record[:family])
          end

          Success(result)
        end

        def default_xml_path
          'spec/support/atp_sample_payloads/sample.xml'
        end
      end
    end
  end
end
