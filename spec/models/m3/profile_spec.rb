require 'rails_helper'

RSpec.describe M3::Profile, type: :model do
  let(:profile) { FactoryBot.build(:m3_profile) }

  it 'is valid' do
    expect(profile).to be_valid
  end
  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:profile_version) }
    it { should validate_presence_of(:responsibility) }
  end
  describe 'associations' do
    it { should have_many(:dynamic_schemas).class_name('M3::DynamicSchema') }
    it { should have_many(:m3_contexts).class_name('M3::Context') }
    it { should have_many(:classes).class_name('M3::ProfileClass') }
    it { should have_many(:contexts).class_name('M3::ProfileContext') }
    it { should have_many(:properties).class_name('M3::ProfileProperty') }
  end
  describe 'serializations' do
    it { should serialize(:profile) }
  end
  describe 'methods' do
    before do
      profile.add_date_modified
      profile.set_profile_data
    end

    it '#available_classes returns an array of Classes' do
      expect(profile.available_classes).to eq(
        %w[Image BibRecord PagedResource Scientific]
      )
    end
    it '#profile is set' do
      expect(profile.profile).to eq('m3_version' => nil,
                                    'profile' => {
                                      'responsibility' => 'http://iu.edu',
                                      'date_modified' => '2019-09-23',
                                      'version' => 6.0
                                    },
                                    'classes' => {
                                      'FlexibleWork' => {
                                        'display_label' => 'Flexible Work',
                                        'contexts' => ['flexible_context']
                                      }
                                    },
                                    'contexts' => {
                                      'flexible_context' => {
                                        'display_label' => 'Flexible Context'
                                      }
                                    },
                                    'properties' => {
                                      'title' => {
                                        'display_label' => {
                                          'default' => 'Title'
                                        },
                                        'available_on' => {
                                          'class' => ['FlexibleWork'],
                                          'context' => ['flexible_context']
                                        },
                                        'cardinality' => {
                                          'minimum' => 0,
                                          'maximum' => 100
                                        },
                                        'indexing' => ['stored_searchable']
                                      }
                                    })
    end
    it '#available_text_names returns an array of values' do
      expect(profile.available_text_names).to eq(
        [['Display Label', 'display_label']]
      )
    end
    it '#date_modified to be set' do
      expect(profile.date_modified).to_not be_empty
    end
  end
end
