# frozen_string_literal: true

RSpec.shared_context 'keycloak oidc examples' do
  let(:auth_response) do
    { "provider" => "openid_connect",
      "uid" => "8323557f-4430-4a9a-81e9-da3aab221ede",
      "info" => { "name" => "guest guest", "email" => "guest@guest.com", "email_verified" => false, "nickname" => "guest", "first_name" => "guest",
                  "last_name" => "guest", "gender" => nil, "image" => nil, "phone" => nil, "urls" => { "website" => nil } },
      "credentials" =>
  { "id_token" =>
    "eyJhbGciOiJSUzI1NiIsInR5cCIgOiAiSldUIiwia2lkIiA6ICJUTmNRNHNuRy1oUEpEdGtzRUxQdDdqV25UQWJBclpQb01tejNUbW5lSGlnIn0.eyJleHAiOjE3MTM5NzgzMTUsImlhdCI6MTcxMzk3ODAxNSwiYXV0aF90aW1lIjoxNzEzOTc3NjM4LCJqdGkiOiJmOTE2NWM1My1mN2VhLTQwOGItOTRhMy02YmQyYmMzOTA0NWIiLCJpc3MiOiJodHRwOi8vMC4wLjAuMDo4MTgwL3JlYWxtcy9pZGVhY3JldyIsImF1ZCI6InNibS1zZXJ2aWNlIiwic3ViIjoiODMyMzU1N2YtNDQzMC00YTlhLTgxZTktZGEzYWFiMjIxZWRlIiwidHlwIjoiSUQiLCJhenAiOiJzYm0tc2VydmljZSIsIm5vbmNlIjoiZjExM2MzOTljZmUzOTE3NWIzMGNjMmU4ZTFiNGQ0NWEiLCJzZXNzaW9uX3N0YXRlIjoiYzEyMDM3MWYtY2U2ZC00YTlkLWJiNTEtOWJjOWQzMTI1ZGQ2IiwiYXRfaGFzaCI6IlFneldzeGp6MWZHcFBXWnVRZ3o1Q3ciLCJhY3IiOiIwIiwic2lkIjoiYzEyMDM3MWYtY2U2ZC00YTlkLWJiNTEtOWJjOWQzMTI1ZGQ2IiwiZW1haWxfdmVyaWZpZWQiOmZhbHNlLCJuYW1lIjoiZ3Vlc3QgZ3Vlc3QiLCJwcmVmZXJyZWRfdXNlcm5hbWUiOiJndWVzdCIsImdpdmVuX25hbWUiOiJndWVzdCIsImZhbWlseV9uYW1lIjoiZ3Vlc3QiLCJlbWFpbCI6Imd1ZXN0QGd1ZXN0LmNvbSJ9.CPwKaChhunxTvhhk1wiWRK4qWLBsSeOHA78HIccwQbbYvPwMGbKlRqPGbiu-BpBILvTXuR9JfeEZn5TVP173kvjlaP77YJn6WqMgJDZP_Z-jb8RfNyodggKTJWHTtG06dCU3eGkuvZO7xZAC-0PesvVzjnTkX_FOglZW5RkFMzttYuHWn4zVG8utCZdSUmF1CNhr7QRk40zsFQEsVJKdHeSyh8UK0PLhNJQ92M1MRr8Az4ocZkhZKhTlntDn6-1af6xjGh90KEutDOPrXHRgxFBZqD4ipdoR-2KyNmNWXoTjrg9fasymrl8c8YIvWFF5pK3_TFFc1QTM7Mmlwpx53A",
    "token" =>
    "eyJhbGciOiJSUzI1NiIsInR5cCIgOiAiSldUIiwia2lkIiA6ICJUTmNRNHNuRy1oUEpEdGtzRUxQdDdqV25UQWJBclpQb01tejNUbW5lSGlnIn0.eyJleHAiOjE3MTM5NzgzMTUsImlhdCI6MTcxMzk3ODAxNSwiYXV0aF90aW1lIjoxNzEzOTc3NjM4LCJqdGkiOiJhNDAyOGY2NS1iNGM4LTRkM2UtYTc3Yy01M2MwZTFkYTczZWUiLCJpc3MiOiJodHRwOi8vMC4wLjAuMDo4MTgwL3JlYWxtcy9pZGVhY3JldyIsImF1ZCI6ImFjY291bnQiLCJzdWIiOiI4MzIzNTU3Zi00NDMwLTRhOWEtODFlOS1kYTNhYWIyMjFlZGUiLCJ0eXAiOiJCZWFyZXIiLCJhenAiOiJzYm0tc2VydmljZSIsIm5vbmNlIjoiZjExM2MzOTljZmUzOTE3NWIzMGNjMmU4ZTFiNGQ0NWEiLCJzZXNzaW9uX3N0YXRlIjoiYzEyMDM3MWYtY2U2ZC00YTlkLWJiNTEtOWJjOWQzMTI1ZGQ2IiwiYWNyIjoiMCIsImFsbG93ZWQtb3JpZ2lucyI6WyJodHRwczovL3d3dy5rZXljbG9hay5vcmciXSwicmVhbG1fYWNjZXNzIjp7InJvbGVzIjpbIm9mZmxpbmVfYWNjZXNzIiwidW1hX2F1dGhvcml6YXRpb24iLCJkZWZhdWx0LXJvbGVzLWlkZWFjcmV3Il19LCJyZXNvdXJjZV9hY2Nlc3MiOnsiYWNjb3VudCI6eyJyb2xlcyI6WyJtYW5hZ2UtYWNjb3VudCIsIm1hbmFnZS1hY2NvdW50LWxpbmtzIiwidmlldy1wcm9maWxlIl19fSwic2NvcGUiOiJvcGVuaWQgcHJvZmlsZSBlbWFpbCIsInNpZCI6ImMxMjAzNzFmLWNlNmQtNGE5ZC1iYjUxLTliYzlkMzEyNWRkNiIsImVtYWlsX3ZlcmlmaWVkIjpmYWxzZSwibmFtZSI6Imd1ZXN0IGd1ZXN0IiwicHJlZmVycmVkX3VzZXJuYW1lIjoiZ3Vlc3QiLCJnaXZlbl9uYW1lIjoiZ3Vlc3QiLCJmYW1pbHlfbmFtZSI6Imd1ZXN0IiwiZW1haWwiOiJndWVzdEBndWVzdC5jb20ifQ.Fn6hGZPmMIZwcuoOox8qdKqkncw9RjDfH-AOhffBMMvf9V4NIC3cw8ssTfijpHkPTDl11zCpcBomQcj03wct17f0zXW_8g_v4Y5PX3qVtWIagKoR36DJ04GJQr_ulIS2EaNzM2Ut1jAF6ejwvtCvBmbH16sWGNMAzJTAz9mlRbm-5_E2fhKcVVeIs0lr5JtJ4qi_zBggpdmp5rBmvE3hJcdUZiaSHsOzhQrIx8kf8sut491BpHVwNFyghduiwFjDxa0ptEpVK5Am1r98NNv5eQIC4hKNz6Dx-VE1JBojT0GAITJAEBlPHKNMYko9LZOfxwIZrNsFj6mznZ9kRVhvjw",
    "refresh_token" =>
    "eyJhbGciOiJIUzUxMiIsInR5cCIgOiAiSldUIiwia2lkIiA6ICI0OWM4MDc1NC1mNjhkLTRhODQtOWVmOS05N2QyMjg3YWQ1OTkifQ.eyJleHAiOjE3MTM5Nzk4MTUsImlhdCI6MTcxMzk3ODAxNSwianRpIjoiNTgyZTZiODktNTJjYy00YmQ0LTkyZjctNWM3ZmRkZDU0ZmFhIiwiaXNzIjoiaHR0cDovLzAuMC4wLjA6ODE4MC9yZWFsbXMvaWRlYWNyZXciLCJhdWQiOiJodHRwOi8vMC4wLjAuMDo4MTgwL3JlYWxtcy9pZGVhY3JldyIsInN1YiI6IjgzMjM1NTdmLTQ0MzAtNGE5YS04MWU5LWRhM2FhYjIyMWVkZSIsInR5cCI6IlJlZnJlc2giLCJhenAiOiJzYm0tc2VydmljZSIsIm5vbmNlIjoiZjExM2MzOTljZmUzOTE3NWIzMGNjMmU4ZTFiNGQ0NWEiLCJzZXNzaW9uX3N0YXRlIjoiYzEyMDM3MWYtY2U2ZC00YTlkLWJiNTEtOWJjOWQzMTI1ZGQ2Iiwic2NvcGUiOiJvcGVuaWQgcHJvZmlsZSBlbWFpbCIsInNpZCI6ImMxMjAzNzFmLWNlNmQtNGE5ZC1iYjUxLTliYzlkMzEyNWRkNiJ9.Y8q1_we_sqDrFCneTNLXPHYFKRvLxomga0GiaZKtXq3J5BmQRixtJ3oMRu3oQqChv9tBPjVTfWSkftiAYDnPuA",
    "expires_in" => 300,
    "scope" => "openid profile email" },
      "extra" =>
  { "raw_info" =>
    { "sub" => "8323557f-4430-4a9a-81e9-da3aab221ede",
      "email_verified" => false,
      "name" => "guest guest",
      "preferred_username" => "guest",
      "given_name" => "guest",
      "family_name" => "guest",
      "email" => "guest@guest.com",
      "exp" => 1_713_978_315,
      "iat" => 1_713_978_015,
      "auth_time" => 1_713_977_638,
      "jti" => "f9165c53-f7ea-408b-94a3-6bd2bc39045b",
      "iss" => "http://0.0.0.0:8180/realms/ideacrew",
      "aud" => "sbm-service",
      "typ" => "ID",
      "azp" => "sbm-service",
      "nonce" => "f113c399cfe39175b30cc2e8e1b4d45a",
      "session_state" => "c120371f-ce6d-4a9d-bb51-9bc9d3125dd6",
      "at_hash" => "QgzWsxjz1fGpPWZuQgz5Cw",
      "acr" => "0",
      "sid" => "c120371f-ce6d-4a9d-bb51-9bc9d3125dd6" } } }
  end
end