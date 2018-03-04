require 'rails_helper'
require 'test_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to specify the controller code that
# was generated by Rails when you ran the scaffold generator.

RSpec.describe SystemAccessRequestsController, type: :controller do

    describe 'GET #external_action' do

        it 'returns sar not found' do
            get :external_action, params: { sar_id: 123456, sar_action: 'approved', authorization_code: 'kjkk' }
            body = JSON.parse(response.body).symbolize_keys
            expect(body[:failure]).to eq("System Access Request doesn't exist.")
        end

        it 'returns auth code not found' do
            get :external_action, params: { sar_id: 123456, sar_action: 'not_approved', authorization_code: 'kjkk' }
            body = JSON.parse(response.body).symbolize_keys
            expect(body[:failure]).to eq("System Access Request doesn't exist.")

        end

        it 'returns action is not allow' do

        end

        it 'returns auth code is already used' do

        end

        it 'returns sar is approved' do

        end

        it 'returns sar is rejected' do

        end
    end
end