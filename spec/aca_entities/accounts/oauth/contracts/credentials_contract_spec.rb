# frozen_string_literal: true

require 'spec_helper'
require_relative "../support/shared_examples/keycloak_oidc_examples"

RSpec.describe AcaEntities::Accounts::Oauth::Contracts::CredentialsContract, type: :contract do
  subject { described_class.new }
  include_context 'keycloak oidc examples'

  let(:id_token) do
    'eyJhbGciOiJSUzI1NiIsInR5cCIgOiAiSldUIiwia2lkIiA6ICJUTmNRNHNuRy1oUEpEdGtzRUxQdDdqV25UQWJBclpQb01tejNUbW5lSGlnIn0.eyJleHAiOjE3MTM5NzgzMTUsImlhdCI6MTcxMzk3ODAxNSwiYXV0aF90aW1lIjoxNzEzOTc3NjM4LCJqdGkiOiJmOTE2NWM1My1mN2VhLTQwOGItOTRhMy02YmQyYmMzOTA0NWIiLCJpc3MiOiJodHRwOi8vMC4wLjAuMDo4MTgwL3JlYWxtcy9pZGVhY3JldyIsImF1ZCI6InNibS1zZXJ2aWNlIiwic3ViIjoiODMyMzU1N2YtNDQzMC00YTlhLTgxZTktZGEzYWFiMjIxZWRlIiwidHlwIjoiSUQiLCJhenAiOiJzYm0tc2VydmljZSIsIm5vbmNlIjoiZjExM2MzOTljZmUzOTE3NWIzMGNjMmU4ZTFiNGQ0NWEiLCJzZXNzaW9uX3N0YXRlIjoiYzEyMDM3MWYtY2U2ZC00YTlkLWJiNTEtOWJjOWQzMTI1ZGQ2IiwiYXRfaGFzaCI6IlFneldzeGp6MWZHcFBXWnVRZ3o1Q3ciLCJhY3IiOiIwIiwic2lkIjoiYzEyMDM3MWYtY2U2ZC00YTlkLWJiNTEtOWJjOWQzMTI1ZGQ2IiwiZW1haWxfdmVyaWZpZWQiOmZhbHNlLCJuYW1lIjoiZ3Vlc3QgZ3Vlc3QiLCJwcmVmZXJyZWRfdXNlcm5hbWUiOiJndWVzdCIsImdpdmVuX25hbWUiOiJndWVzdCIsImZhbWlseV9uYW1lIjoiZ3Vlc3QiLCJlbWFpbCI6Imd1ZXN0QGd1ZXN0LmNvbSJ9.CPwKaChhunxTvhhk1wiWRK4qWLBsSeOHA78HIccwQbbYvPwMGbKlRqPGbiu-BpBILvTXuR9JfeEZn5TVP173kvjlaP77YJn6WqMgJDZP_Z-jb8RfNyodggKTJWHTtG06dCU3eGkuvZO7xZAC-0PesvVzjnTkX_FOglZW5RkFMzttYuHWn4zVG8utCZdSUmF1CNhr7QRk40zsFQEsVJKdHeSyh8UK0PLhNJQ92M1MRr8Az4ocZkhZKhTlntDn6-1af6xjGh90KEutDOPrXHRgxFBZqD4ipdoR-2KyNmNWXoTjrg9fasymrl8c8YIvWFF5pK3_TFFc1QTM7Mmlwpx53A'
  end
  let(:token) do
    'eyJhbGciOiJSUzI1NiIsInR5cCIgOiAiSldUIiwia2lkIiA6ICJUTmNRNHNuRy1oUEpEdGtzRUxQdDdqV25UQWJBclpQb01tejNUbW5lSGlnIn0.eyJleHAiOjE3MTM5NzgzMTUsImlhdCI6MTcxMzk3ODAxNSwiYXV0aF90aW1lIjoxNzEzOTc3NjM4LCJqdGkiOiJhNDAyOGY2NS1iNGM4LTRkM2UtYTc3Yy01M2MwZTFkYTczZWUiLCJpc3MiOiJodHRwOi8vMC4wLjAuMDo4MTgwL3JlYWxtcy9pZGVhY3JldyIsImF1ZCI6ImFjY291bnQiLCJzdWIiOiI4MzIzNTU3Zi00NDMwLTRhOWEtODFlOS1kYTNhYWIyMjFlZGUiLCJ0eXAiOiJCZWFyZXIiLCJhenAiOiJzYm0tc2VydmljZSIsIm5vbmNlIjoiZjExM2MzOTljZmUzOTE3NWIzMGNjMmU4ZTFiNGQ0NWEiLCJzZXNzaW9uX3N0YXRlIjoiYzEyMDM3MWYtY2U2ZC00YTlkLWJiNTEtOWJjOWQzMTI1ZGQ2IiwiYWNyIjoiMCIsImFsbG93ZWQtb3JpZ2lucyI6WyJodHRwczovL3d3dy5rZXljbG9hay5vcmciXSwicmVhbG1fYWNjZXNzIjp7InJvbGVzIjpbIm9mZmxpbmVfYWNjZXNzIiwidW1hX2F1dGhvcml6YXRpb24iLCJkZWZhdWx0LXJvbGVzLWlkZWFjcmV3Il19LCJyZXNvdXJjZV9hY2Nlc3MiOnsiYWNjb3VudCI6eyJyb2xlcyI6WyJtYW5hZ2UtYWNjb3VudCIsIm1hbmFnZS1hY2NvdW50LWxpbmtzIiwidmlldy1wcm9maWxlIl19fSwic2NvcGUiOiJvcGVuaWQgcHJvZmlsZSBlbWFpbCIsInNpZCI6ImMxMjAzNzFmLWNlNmQtNGE5ZC1iYjUxLTliYzlkMzEyNWRkNiIsImVtYWlsX3ZlcmlmaWVkIjpmYWxzZSwibmFtZSI6Imd1ZXN0IGd1ZXN0IiwicHJlZmVycmVkX3VzZXJuYW1lIjoiZ3Vlc3QiLCJnaXZlbl9uYW1lIjoiZ3Vlc3QiLCJmYW1pbHlfbmFtZSI6Imd1ZXN0IiwiZW1haWwiOiJndWVzdEBndWVzdC5jb20ifQ.Fn6hGZPmMIZwcuoOox8qdKqkncw9RjDfH-AOhffBMMvf9V4NIC3cw8ssTfijpHkPTDl11zCpcBomQcj03wct17f0zXW_8g_v4Y5PX3qVtWIagKoR36DJ04GJQr_ulIS2EaNzM2Ut1jAF6ejwvtCvBmbH16sWGNMAzJTAz9mlRbm-5_E2fhKcVVeIs0lr5JtJ4qi_zBggpdmp5rBmvE3hJcdUZiaSHsOzhQrIx8kf8sut491BpHVwNFyghduiwFjDxa0ptEpVK5Am1r98NNv5eQIC4hKNz6Dx-VE1JBojT0GAITJAEBlPHKNMYko9LZOfxwIZrNsFj6mznZ9kRVhvjw'
  end
  let(:refresh_token) do
    'eyJhbGciOiJIUzUxMiIsInR5cCIgOiAiSldUIiwia2lkIiA6ICI0OWM4MDc1NC1mNjhkLTRhODQtOWVmOS05N2QyMjg3YWQ1OTkifQ.eyJleHAiOjE3MTM5Nzk4MTUsImlhdCI6MTcxMzk3ODAxNSwianRpIjoiNTgyZTZiODktNTJjYy00YmQ0LTkyZjctNWM3ZmRkZDU0ZmFhIiwiaXNzIjoiaHR0cDovLzAuMC4wLjA6ODE4MC9yZWFsbXMvaWRlYWNyZXciLCJhdWQiOiJodHRwOi8vMC4wLjAuMDo4MTgwL3JlYWxtcy9pZGVhY3JldyIsInN1YiI6IjgzMjM1NTdmLTQ0MzAtNGE5YS04MWU5LWRhM2FhYjIyMWVkZSIsInR5cCI6IlJlZnJlc2giLCJhenAiOiJzYm0tc2VydmljZSIsIm5vbmNlIjoiZjExM2MzOTljZmUzOTE3NWIzMGNjMmU4ZTFiNGQ0NWEiLCJzZXNzaW9uX3N0YXRlIjoiYzEyMDM3MWYtY2U2ZC00YTlkLWJiNTEtOWJjOWQzMTI1ZGQ2Iiwic2NvcGUiOiJvcGVuaWQgcHJvZmlsZSBlbWFpbCIsInNpZCI6ImMxMjAzNzFmLWNlNmQtNGE5ZC1iYjUxLTliYzlkMzEyNWRkNiJ9.Y8q1_we_sqDrFCneTNLXPHYFKRvLxomga0GiaZKtXq3J5BmQRixtJ3oMRu3oQqChv9tBPjVTfWSkftiAYDnPuA'
  end
  let(:secret) { 'C639A572E14D5075C526FDDD43E4ECF6B095EA17783D32EF3D2710AF9F359DD4' }
  let(:scope) { 'openid profile email' }
  let(:expires_in) { 300 }

  let(:required_params) { {} }
  let(:optional_params) do
    {
      id_token: id_token,
      token: token,
      refresh_token: refresh_token,
      secret: secret,
      scope: scope,
      expires_in: expires_in
    }
  end

  let(:all_params) { required_params.merge(optional_params) }

  context 'Calling the contract with optional params only' do
    it 'should pass validation' do
      result = described_class.new.call(optional_params)
      expect(result.success?).to be_truthy
    end
  end

  context 'Calling the contract with required params' do
    it 'should pass validation' do
      result = described_class.new.call(required_params)
      expect(result.success?).to be_truthy
      expect(result.to_h).to eq required_params
    end
  end

  context 'Calling the contract with all params' do
    it 'should pass validation' do
      result = described_class.new.call(all_params)
      expect(result.success?).to be_truthy
      expect(result.to_h).to eq all_params
    end
  end

  context 'Calling the contract with an example json payload' do
    subject { described_class.new.call(credentials) }
    let(:credentials) { auth_response['credentials'] }

    it 'should pass validation' do
      expect(subject.success?).to be_truthy
    end

    it 'all input params should have matching attribute' do
      expect(subject.to_h).to eq credentials.deep_symbolize_keys
    end
  end

end
