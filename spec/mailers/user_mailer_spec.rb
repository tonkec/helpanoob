require "rails_helper"
require 'spec_helper'

RSpec.describe UserMailer do
  describe 'instructions' do
    let(:user) { FactoryGirl.create(:user) }
    let(:mail) { user.send_confirmation_instructions }

    it 'renders the subject' do
      expect(mail.subject).to eql('Confirmation instructions')
    end

    it 'renders the receiver email' do
      expect(mail.to).to eql([user.email])
    end

    it 'renders the sender email' do
      expect(mail.from).to eql(["noreply@helpanoob.com"])
    end

    it 'assigns @name' do
      expect(mail.body.encoded).to match(user.email)
    end

    it 'assigns @confirmation_url' do
      expect(mail.body.encoded)
        .to match("http://localhost:3000/users/confirmation?confirmation_token=#{user.confirmation_token}")
    end
  end
end
