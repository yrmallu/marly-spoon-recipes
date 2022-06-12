require 'rails_helper'

RSpec.describe 'GET /recipes' do
  let(:path) { recipes_url }
  let(:params) { { page: 1 } }

  context 'with valid params' do
    it 'spawns the referral event creation job' do
      get path, params: params

      expect(response.status).to be(200)
    end
  end
end
