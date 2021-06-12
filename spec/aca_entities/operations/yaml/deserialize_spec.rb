# frozen_string_literal: true
require 'spec_helper'
RSpec.describe AcaEntities::Operations::Yaml::Deserialize do
  # include RegistryDataSeed
  subject { described_class.new.call(yaml: input) }

  context 'When valid file IO passed' do
    let(:file_path) do
      Pathname.pwd.join('spec', 'support', 'seedfiles', 'async_api_example.yml')
    end
    let(:input) { IO.read(file_path) }
    let(:async_api_params) do
      {
        'asyncapi' => '2.0.0',
        'id' => 'https://github.com/ideacrew/event_source-server',
        'info' => {
          'title' => 'CRM Gateway Service',
          'version' => '1.0.0',
          'description' =>
            'This service provides accesss to third-party Customer Relationship Mangement systems',
          'contact' => {
            'name' => 'IdeaCrew',
            'url' => 'https://ideacrew.com',
            'email' => 'info@ideacrew.com'
          },
          'license' => {
            'name' => 'MIT',
            'url' => 'https://opensource.org/licenses/MIT'
          }
        },
        'servers' => {
          'production' => {
            'url' => 'amqp://test.example.org',
            'protocol' => 'amqp',
            'description' => 'Test AMQP broker'
          }
        },
        'channels' => {
          'sugar_crm.contacts.contact_created' => {
            'publish' => {
              'operationId' => 'sugarcrm_contacts_contact_created',
              'description' => 'SugarCRM Contact Created',
              'message' => {
                '$ref' => '#/components/messages/contract_created_message',
                'payload' => {
                  'type' => 'object'
                }
              }
            },
            'subscribe' => {
              'operationId' => 'on_sugarcrm_contacts_contact_created',
              'description' => 'On SugarCRM Contact Created',
              'message' => {
                '$ref' => '#/components/messages/contract_created_message',
                'payload' => {
                  'type' => 'object'
                }
              }
            }
          }
        },
        'components' => {
          'messages' => {
            'contract_created_message' => {
              'title' => 'CRM Contact created event',
              'summary' =>
                'Inform about a new Contact registration in the system',
              'contentType' => 'application/json',
              'payload' => {
                '$ref' => '#/components/schemas/userSignedUpPayload'
              }
            }
          },
          'schemas' => {
            'userSignedUpPayload' => {
              'type' => 'object',
              'properties' => {
                'firstName' => {
                  'type' => 'string',
                  'description' => 'foo'
                },
                'lastName' => {
                  'type' => 'string',
                  'description' => 'bar'
                },
                'email' => {
                  'type' => 'string',
                  'format' => 'email',
                  'description' => 'baz'
                },
                'createdAt' => {
                  'type' => 'string',
                  'format' => 'date-time',
                  'description' => 'foo'
                }
              }
            }
          }
        },
        'tags' => [
          {
            'name' => 'linter_tag',
            'description' => 'placeholder that satisfies the linter'
          }
        ]
      }
    end

    it 'should return success with hash output' do
      expect(subject).to be_a Dry::Monads::Result::Success
      expect(subject.value!).to be_a Hash
    end

    it 'should return options hash' do
      expect(subject.value!).to eq async_api_params
    end
  end
end