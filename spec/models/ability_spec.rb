require 'rails_helper'

RSpec.describe Ability do
  let(:user) { create :user }
  let(:options) { {} }
  let(:ability) { described_class.new(user, options) }
  let(:authorized_groups) { ['Test group'] }

  describe '#user_groups' do
    context 'when no authorized ldap groups are configured' do
      before(:each) do
        allow(ESSI.config[:authorized_ldap_groups]).to receive(:blank?).and_return(true)
      end
      context 'when a user is persisted' do
        it 'considers the user registered' do
          expect(ability.user_groups).to include('registered')
        end
      end
      context 'when a user is not persisted' do
        let(:user) { build :user }
        it 'considers the user unregistered' do
          expect(ability.user_groups).not_to include('registered')
        end
      end
    end
    context 'when authorized ldap groups are configured' do
      before(:each) do
        ESSI.config[:authorized_ldap_groups] = authorized_groups
      end
      context 'when the user has authorized group membership' do
        before(:each) do
          allow(user).to receive(:authorized_patron?).and_return(true)
        end
        it 'considers the user registered' do
          expect(ability.user_groups).to include('registered')
        end
      end
      context 'when the user lacks authorized group membership' do
        before(:each) do
          allow(user).to receive(:authorized_patron?).and_return(false)
        end
        it 'considers the user unregistered' do
          expect(ability.user_groups).not_to include('registered')
        end
        context 'when the user is an admin' do
          before(:each) do
            allow(user).to receive(:admin?).and_return(true)
          end
          it 'considers the user registered' do
            expect(ability.user_groups).to include('registered')
          end
        end
      end
    end
  end

  describe '#m3_profile_abilities' do
    let(:m3_profile) { create :m3_profile }
    context 'when the user is not an admin' do

      it "should not be manageable" do
        expect(ability.can?(:manage, m3_profile)).to be_falsey
      end
    end

    context 'when the user is an admin' do
      let(:user) { create :user, :admin }

      it "should be manageable" do
        expect(ability.can?(:manage, m3_profile)).to be_truthy
      end
    end
  end
end
