require 'rails_helper'

RSpec.describe Contentful::Recipes do
  describe '#entries' do
    let(:access_token) { ENV['CONTENTFUL_TOKEN'] }
    let(:space) { ENV['CONTENTFUL_SPACE'] }
    let(:environment) { ENV['CONTENTFUL_ENVIRONMENT'] }
    let(:client) { instance_double(Contentful::Client) }
    let(:entries) { instance_double(Contentful::Array) }
    let(:recipe_id) { "4dT8tcb6ukGSIg2YyuGEOm" }
    let(:default_arguments) do
      {
        content_type: 'recipe',
        include: 1,
        limit: 3,
        skip: 0
      }
    end

    before do
      allow(Contentful::Client).to receive(:new).with(access_token: access_token, space: space, environment: environment).and_return(client)
      allow(client).to receive(:entries).with(default_arguments).and_return(entries)
    end

    context 'with recipe content_type' do
      it 'calls Contentful API and returns all recipes' do
        service_call = described_class.new('1').entries

        expect(service_call).to eq entries
      end
    end
  end
end
