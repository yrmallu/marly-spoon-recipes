require 'rails_helper'

RSpec.describe Contentful::Recipe do
  describe '.entry' do
    let(:access_token) { ENV['CONTENTFUL_TOKEN'] }
    let(:space) { ENV['CONTENTFUL_SPACE'] }
    let(:environment) { ENV['CONTENTFUL_ENVIRONMENT'] }
    let(:client) { instance_double(Contentful::Client) }
    let(:entry) { instance_double(Contentful::Entry) }
    let(:recipe_id) { "4dT8tcb6ukGSIg2YyuGEOm" }

    let(:recipe) do
      OpenStruct.new(
        title: 'Italian Pizza',
        photo_url: 'recipe URL',
        tags: ['vegan'],
        description: 'Try it',
        chef_name: 'Me'
      )
    end    

    before do
      allow(Contentful::Client).to receive(:new).with(access_token: access_token, space: space, environment: environment).and_return(client)
      allow(client).to receive(:entry).with(recipe_id).and_return(entry)
    end

    context 'with valid recipe id' do
      it 'calls Contentful API and returns valid recipe' do
        allow(Contentful::Recipe).to receive(:entry).with(recipe_id).and_return(recipe)
        service_call = described_class.entry(recipe_id)

        expect(service_call).to eq recipe
      end
    end

    context 'with valid recipe id' do
      it 'calls Contentful API and returns valid recipe' do

        expect { described_class.entry("2") }.to raise_error(Contentful::Recipe::RecipeNotFound)
      end
    end    
  end
end
