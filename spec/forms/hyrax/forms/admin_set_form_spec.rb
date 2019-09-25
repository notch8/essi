require 'rails_helper'
RSpec.describe Hyrax::Forms::AdminSetForm do
  let(:ability) { Ability.new(create(:user)) }
  let(:repository) { double }
  let(:form) { described_class.new(model, ability, repository) }

  describe "#metadata_context" do
    let(:model) { build(:admin_set, description: ['one']) }

    it "calls metadata_context on the admin_set" do
      expect(model).to receive(:metadata_context)
      form.metadata_context
    end
  end
end
