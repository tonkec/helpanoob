require 'rails_helper'

RSpec.describe "post_attachments/edit", type: :view do
  before(:each) do
    @post_attachment = assign(:post_attachment, PostAttachment.create!(
      :post_id => 1,
      :avatar => "MyString"
    ))
  end

  it "renders the edit post_attachment form" do
    render

    assert_select "form[action=?][method=?]", post_attachment_path(@post_attachment), "post" do

      assert_select "input#post_attachment_post_id[name=?]", "post_attachment[post_id]"

      assert_select "input#post_attachment_avatar[name=?]", "post_attachment[avatar]"
    end
  end
end
