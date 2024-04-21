require 'rails_helper'

RSpec.describe PostsController, type: :controller do
  include Devise::Test::ControllerHelpers

  let(:user) { create(:user) }
  let(:category) { create(:category) }
  let(:post) { create(:post) }

  before do
    sign_in user
  end

  describe 'GET #index' do
    it 'assigns @posts' do
      get :index
      expect(assigns(:posts)).to match_array([post])
    end

    it 'assigns @highlights' do
      highlighted_post = create(:post, user: user, category: category)
      get :index
      expect(assigns(:highlights)).to match_array([highlighted_post])
    end
  end

  describe 'GET #show' do
    it 'assigns @post' do
      get :show, params: { id: post.id }
      expect(assigns(:post)).to eq(post)
    end
  end

  describe 'GET #new' do
    it 'assigns a new post as @post' do
      get :new
      expect(assigns(:post)).to be_a_new(Post)
    end
  end
end
