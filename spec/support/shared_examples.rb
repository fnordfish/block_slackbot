RSpec.shared_examples "blocking" do
  subject { get "/", {}, { "HTTP_USER_AGENT" => user_agent } }

  its(:status) { should eql 403 }
  its(:content_type) { should eql 'text/plain' }
  its(:body) { should eql 'Bad Robot' }
end

RSpec.shared_examples "passing" do
  subject { get "/", {}, { "HTTP_USER_AGENT" => user_agent } }

  its(:status) { should eql 200 }
  its(:body) { should eql 'Hello World!' }
end
