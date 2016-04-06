# == Schema Information
#
# Table name: posts
#
#  id                      :integer          not null, primary key
#  description             :text
#  user_id                 :integer
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#  title                   :string
#  image                   :string
#  cached_votes_total      :integer          default(0)
#  cached_votes_score      :integer          default(0)
#  cached_votes_up         :integer          default(0)
#  cached_votes_down       :integer          default(0)
#  cached_weighted_score   :integer          default(0)
#  cached_weighted_total   :integer          default(0)
#  cached_weighted_average :float            default(0.0)
#  comments_count          :integer          default(0)
#

require 'rails_helper'
require 'spec_helper'

RSpec.describe PostsController, type: :controller do
 #create #edit #update #delete već imaš u post_spec

  describe "Posts creation for non signed in users" do
    it "redirects to login page" do
      visit posts_path
      expect(page).to have_current_path(new_user_session_path, only_path: true)
      expect(page).to have_content("You need to sign in or sign up before continuing.")
    end
  end

end
