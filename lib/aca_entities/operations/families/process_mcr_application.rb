# frozen_string_literal: true

module AcaEntities
  module Operations
    module Families
      # Open and read contents of a file
      class ProcessMcrApplication
        send(:include, Dry::Monads[:result, :do])
        send(:include, Dry::Monads[:try])

        attr_reader :worker_mode, :klass, :path

        def initialize(*args)
          handler = args.first
          @worker_mode = handler[:worker] || :batch
          @path = handler[:path] || nil
          @klass = handler[:klass] || default_klass
        end

        def call
          family_params = yield transform
          # family_params2 = yield validate(family_params.first)

          Success(family_params.first.success)
        end

        private

        def validate(family_params)
          result = family_params.is_a?(Hash)
          Success(result)
        rescue StandardError => _e
          Failure('no hash')
        end

        def file_path
          source_path = path || default_path
          Pathname.pwd.join(source_path)
        end

        def transform
          result = []
          klass.call(file_path, { transform_mode: worker_mode }) do |payload|
            record = klass.transform(payload)

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
