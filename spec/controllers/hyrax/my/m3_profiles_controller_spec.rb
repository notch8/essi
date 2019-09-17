require 'rails_helper'

RSpec.describe Hyrax::My::M3ProfilesController, type: :controller do
  routes { Hyrax::Engine.routes }

  context "when user is unauthenticated" do
    describe "GET #index" do
      it "redirects to sign-in page" do
        get :index
        expect(response).to be_redirect
        expect(flash[:alert]).to eq("You need to sign in or sign up before continuing.")
      end
    end
  end

  context "when logged in as an admin user" do
    let(:user) { create(:user, :admin) }
    let!(:m3_profile) { create(:m3_profile) }
    let(:valid_session) { {} }

    before { sign_in user }

    describe 'GET #index' do
      it 'returns a success response' do
        get :index, params: {}, session: valid_session
        expect(response).to be_successful
      end

      xit "shows breadcrumbs" do
        expect(controller).to receive(:add_breadcrumb).with('Home', root_path(locale: 'en'))
        expect(controller).to receive(:add_breadcrumb).with('Dashboard', dashboard_path(locale: 'en'))
        expect(controller).to receive(:add_breadcrumb).with('Flexible Metadata Profiles', my_m3_profiles_path(locale: 'en'))
      end
    end
  end
end
