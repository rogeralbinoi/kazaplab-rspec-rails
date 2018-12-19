require 'rails_helper'

RSpec.describe HomeController, type: :controller do
    before { sign_in create(:user) }

    describe 'GET #index' do
        it 'render template home' do
            get :index
            expect(response).to render_template :index
        end
    end
end
