# frozen_string_literal: true

module Domain # :nodoc:
  class OperationGenerator < Rails::Generators::NamedBase # :nodoc:
    source_root File.expand_path('templates', __dir__)

    desc 'Create Domain Operation file'

    check_class_collision

    def initialize(*args)
      @local_args = args[0]
      super
      @indentation = 2
      @class_indent = [class_path.size, 0].max
      @local_class_name = class_name.to_s.split('::').last
    end

    def create_operation_file
      template 'operation.rb', File.join('app/operations', class_path, "#{file_name}.rb")
    end

    hook_for :test_framework, in: :rspec, as: :operation

    private

    def content
      <<~RUBY.chomp
        send(:include, Dry::Monads[:result, :do])
        send(:include, EventSource::Command)

        # @param [Hash] params the input parameters for {#{class_name}} operation
        # @option params [String] :description (optional)
        # @return [Dry::Monads::Result::Success] if operation was successful
        # @return [Dry::Monads::Result::Failure] if operation errored
        def call(params)
          # values = yield validate(params)
          # result = yield command(values)
          # event = yield publish_event(result)

          # Success(event)
        end

        private

        # Schema-validate the passed parameters.  This step is typically done when
        # parameters are first enter the Domain model
        # def validate(params)
        # end

        # Execute the command for this operation
        # def command(values)
        # end

        # Publish an event with the command output as the payload.
        # The event name usually is the operation/command name in past tense form
        # def publish_event(result)
        # end
      RUBY
    end
  end
end
