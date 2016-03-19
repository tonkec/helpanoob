require 'spec_helper'

describe 'posts/show.html.erb' do
  let(:post) {FactoryGirl.create(:post)}
  it 'displays details correctly' do
    puts "#{post.id}"

    render

    rendered.should contain('Shirt')
    rendered.should contain('50.0')
  end
end