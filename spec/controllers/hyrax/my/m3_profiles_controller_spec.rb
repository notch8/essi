require 'rails_helper'

RSpec.describe Hyrax::My::M3ProfilesController, type: :controller do
  let(:user) { create(:user) }

  before { sign_in user }

  describe "#index" do
  end
end
