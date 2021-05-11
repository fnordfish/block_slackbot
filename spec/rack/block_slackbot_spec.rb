RSpec.describe "Rack::BlockSlackbot" do
  let(:app) { Rack::BlockSlackbot.new(DummyApp.new) }

  describe "Slackbot Link Expanding" do
    let(:user_agent) { "Slackbot-LinkExpanding 1.0 (+https://api.slack.com/robots)" }
    it_behaves_like "blocking"
  end

  describe "Imgproxy" do
    let(:user_agent) { "Slack-ImgProxy 0.19 (+https://api.slack.com/robots)" }
    it_behaves_like "blocking"
  end

  describe "Slackbot" do
    let(:user_agent) { "Slackbot 1.0(+https://api.slack.com/robots)" }
    it_behaves_like "blocking"
  end

  describe "Slackbot with fixes spacing" do
    let(:user_agent) { "Slackbot 1.0 (+https://api.slack.com/robots)" }
    it_behaves_like "blocking"
  end

  describe "Browser" do
    let(:user_agent) do
      "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_11_6) "\
      "AppleWebKit/537.36 (KHTML, like Gecko) "\
      "Chrome/52.0.2743.116 Safari/537.36"
    end

    it_behaves_like "passing"
  end

  context "sounds like" do
    [
      "Slack", "Slack ", "Mozilla/5.0 (Slack; Intel Mac OS X 10_11_6) ",
      "Mozilla/5.0 (Slackbot; Intel Mac OS X 10_11_6) "
    ].each do |ua|
      describe "'#{ua}'" do
        let(:user_agent) { ua }
        it_behaves_like "passing"
      end
    end
  end

  describe "overwriting response" do
    before do
      expect(app).to receive(:block?).and_return(true)
    end

    let(:app) { Rack::BlockSlackbot.new(DummyApp.new, options) }

    let(:options) do
      {
        response: [
          302,
          {
            "Content-Type" => "text/plain",
            "Location" => "https://example.com"
          }.freeze,
          ["Go Away!"].freeze
        ]
      }
    end

    subject { get "/" }

    its(:status) { should eql 302 }
    its(:body) { should eql 'Go Away!' }
    its(:redirect?) { should eql true }
    its(:location) { should eql "https://example.com" }
  end
end
