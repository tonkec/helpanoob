require 'rails_helper'

RSpec.describe "post_attachments/show", type: :view do
  before(:each) do
    @post_attachment = assign(:post_attachment, PostAttachment.create!(
      :post_id => 1,
      :avatar => "Avatar"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/1/)
    expect(rendered).to match(/Avatar/)
  end
end
