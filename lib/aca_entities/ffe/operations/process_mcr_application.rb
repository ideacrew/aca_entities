# frozen_string_literal: true

module AcaEntities
  module Ffe
    module Operations
      # Open and read contents of a file
      class ProcessMcrApplication
        send(:include, Dry::Monads[:result, :do])
        send(:include, Dry::Monads[:try])

        attr_reader :worker_mode, :klass, :path, :source_hash

        def initialize(*args)
          handler = args.first
          @worker_mode = handler[:worker] || :batch
          @path = handler[:path] || nil
          @source_hash = handler[:source_hash]
          @klass = handler[:klass] || default_klass
        end

        def call
          # app_params = yield validate_mcr(source_hash)
          params = yield transform_batch if @worker_mode == :batch # (app_params)
          params = yield transform_single if @worker_mode == :single
          # family_params2 = yield validate(family_params.first)

          Success(params)
        end

        private

        def validate(family_params)
          result = family_params.is_a?(Hash)
          Success(result)
        rescue StandardError => _e
          Failure('no hash')
        end

        def file_path
          return nil if source_hash
          source_path = path || default_path
          Pathname.pwd.join(source_path)
        end

        def transform_single
          record = klass.transform(@source_hash)
          _result = AcaEntities::Ffe::Operations::McrTo::Family.new.call(record: record[:family])
        end

        # (app_params)
        def transform_batch
          result = []
          input = file_path || source_hash # (app_params)

          klass.call(input, { transform_mode: worker_mode }) do |payload|
            record = worker_mode == :batch ? klass.transform(payload) : payload
            # TODO: broken
            result << ::AcaEntities::Ffe::Operations::McrTo::Family.new.call(record: record[:family])
          end

          Success(result)
        end

        def default_klass
          ::AcaEntities::Ffe::Transformers::McrTo::Family
        end

        def default_path
          'spec/support/transform_example_payloads/application.json'
        end
      end
    end
  end
end
