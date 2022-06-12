require 'rails_helper'

RSpec.describe 'GET /recipe/:id' do
  let(:path) { recipe_url(params) }
  let(:params) { { id: "1" } }
  let(:invalid_params) { { id: "2" } }

  let(:recipe) do
    OpenStruct.new(
      title: 'Italian Pizza',
      photo_url: 'recipe URL',
      tags: ['vegan'],
      description: 'Try it',
      chef_name: 'Me'
    )
  end

  context 'with valid params' do
    it 'returns the recipe' do
      allow(Contentful::Recipe).to receive(:entry).with(params[:id]).and_return(recipe)
      get path

      expect(response.status).to be(200)
    end
  end

  context 'with invalid params' do
    it do
      expect { Contentful::Recipe.entry(invalid_params[:id]) }.to raise_error(Contentful::Recipe::RecipeNotFound)
    end
  end  
end
