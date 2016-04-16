require 'rails_helper'

RSpec.describe "post_attachments/edit", type: :view do
  before(:each) do
    @post_attachment = assign(:post_attachment, PostAttachment.create!(
      :post => nil,
      :title => "MyString",
      :description => "MyString",
      :attachemnts => "MyText"
    ))
  end

  it "renders the edit post_attachment form" do
    render

    assert_select "form[action=?][method=?]", post_attachment_path(@post_attachment), "post" do

      assert_select "input#post_attachment_post_id[name=?]", "post_attachment[post_id]"

      assert_select "input#post_attachment_title[name=?]", "post_attachment[title]"

      assert_select "input#post_attachment_description[name=?]", "post_attachment[description]"

      assert_select "textarea#post_attachment_attachemnts[name=?]", "post_attachment[attachemnts]"
    end
  end
end
