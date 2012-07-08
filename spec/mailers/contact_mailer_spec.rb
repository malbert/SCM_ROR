require "spec_helper"

describe ContactMailer do
  describe "name" do
    let(:mail) { ContactMailer.name }

    it "renders the headers" do
      mail.subject.should eq("Name")
      mail.to.should eq(["to@example.org"])
      mail.from.should eq(["from@example.com"])
    end

    it "renders the body" do
      mail.body.encoded.should match("Hi")
    end
  end

  describe "mail" do
    let(:mail) { ContactMailer.mail }

    it "renders the headers" do
      mail.subject.should eq("Mail")
      mail.to.should eq(["to@example.org"])
      mail.from.should eq(["from@example.com"])
    end

    it "renders the body" do
      mail.body.encoded.should match("Hi")
    end
  end

  describe "message" do
    let(:mail) { ContactMailer.message }

    it "renders the headers" do
      mail.subject.should eq("Message")
      mail.to.should eq(["to@example.org"])
      mail.from.should eq(["from@example.com"])
    end

    it "renders the body" do
      mail.body.encoded.should match("Hi")
    end
  end

end
