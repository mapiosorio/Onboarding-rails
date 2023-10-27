require 'rails_helper'

RSpec.describe CategoriesController, type: :controller do
  include Devise::Test::ControllerHelpers
  describe "GET #index" do
    it "allows access for authenticated users" do
      user = create(:user)
      sign_in user
      get :index
      expect(response).to render_template('index')
    end

    it "redirects unauthenticated users to the login page" do
      get :index
      expect(response).to redirect_to(new_user_session_path)
    end
  end

  describe 'GET #show' do
    let(:user) { create(:user) }
    let(:category) { create(:category) }
    let(:products) { create_list(:product, 5, category: category) }

    before do
      sign_in user
    end

    it 'assigns the user, category, and products, and renders the show template' do
      get :show, params: { id: category.id }

      expect(assigns(:user)).to eq(user)
      expect(assigns(:category)).to eq(category)
      expect(assigns(:products)).to eq(products)

      expect(response).to render_template('show')
    end
  end


  describe 'GET #order' do
    let(:user) { create(:user) }
    let(:category) { create(:category) }
    let!(:products) { create_list(:product, 5, category: category) }

    before do
      sign_in user
    end

    it 'assigns the user, category, products, and renders the show template' do
      get :order, params: { id: category.id, sort: 'price_asc' }

      expect(assigns(:user)).to eq(user)
      expect(assigns(:category)).to eq(category)


      expect(assigns(:products)).to eq(products.to_a.sort_by { |product| product.price })

      expect(response).to render_template('show')
    end
  end

  describe 'GET #filter' do
    let(:user) { create(:user) }
    let(:category) { create(:category) }

    before do
      sign_in user
    end

    it 'filters products' do

      get :filter, params: { id: category.id, sharing: true }

      expect(assigns(:user)).to eq(user)
      expect(assigns(:category)).to eq(category)
      expect(assigns(:products)).to be_a(ActiveRecord::Relation)


      filtered_products = category.products.where(sharing: true)

      expect(assigns(:products)).to match_array(filtered_products)

    end
  end
end
