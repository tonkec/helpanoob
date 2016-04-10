require 'rails_helper'

RSpec.describe "post_attachments/index", type: :view do
  before(:each) do
    assign(:post_attachments, [
      PostAttachment.create!(
        :post => nil,
        :title => "Title",
        :description => "Description",
        :attachemnts => "MyText"
      ),
      PostAttachment.create!(
        :post => nil,
        :title => "Title",
        :description => "Description",
        :attachemnts => "MyText"
      )
    ])
  end

  it "renders a list of post_attachments" do
    render
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => "Title".to_s, :count => 2
    assert_select "tr>td", :text => "Description".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
  end
end
