require 'rails_helper'

RSpec.describe 'Posts', type: :request do
  describe 'GET /index' do
    before(:example) { get '/users/:user_id/posts' } # get(:index)
    it 'is a success' do
      expect(response).to have_http_status(:ok)
    end
    it "renders 'index' template" do
      expect(response).to render_template(:index)
    end
    it 'Includes the correct placeholder text' do
      expect(response.body).to include('Here is a list of all the posts from this user')
    end
  end
  describe 'GET /show' do
    before(:example) { get '/users/:user_id/posts/:post_id' }

    it 'is a success' do
      expect(response).to have_http_status(:ok)
    end
    it "renders 'index' template" do
      expect(response).to render_template(:show)
    end
    it 'Includes the correct placeholder text' do
      expect(response.body).to include('Here is the details about this post from this user')
    end
  end
end
