# frozen_string_literal: true

module AcaEntities
  module Operations
    module Files
      # Open and read contents of a file
      class Read
        send(:include, Dry::Monads[:result, :do])

        # @param [String] params Full file pathname
        # @return [String] File contents wrapped in Dry::Monads::Result
        def call(params)
          contents = yield load(params)
          Success(contents)
        end

        private

        def load(params)
          Success(::File.read(params.to_s))
        rescue Errno::ENOENT
          Failure['No such file or directory', params: params]
        end
      end
    end
  end
end
