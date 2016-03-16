require 'rails_helper'

RSpec.describe User, type: :model do
  subject {FactoryGirl.create(:user)}

  it 'sends an email' do
    puts subject.confirmation_token
    puts Devise.mailer.deliveries.count
    expect { subject.send_confirmation_instructions }
    .to change { Devise.mailer.deliveries.count }.by(1)
    puts Devise.mailer.deliveries.count
  end
end
