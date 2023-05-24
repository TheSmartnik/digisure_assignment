RSpec.shared_examples "authentication header" do
  before do
    request.headers["X-API-TOKEN"] = user.api_token.token
  end
end
