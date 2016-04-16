require 'rails_helper'

RSpec.describe "post_attachments/show", type: :view do
  before(:each) do
    @post_attachment = assign(:post_attachment, PostAttachment.create!(
      :post => nil,
      :title => "Title",
      :description => "Description",
      :attachemnts => "MyText"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(/Title/)
    expect(rendered).to match(/Description/)
    expect(rendered).to match(/MyText/)
  end
end
