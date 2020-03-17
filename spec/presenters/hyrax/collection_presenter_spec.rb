require 'rails_helper'

RSpec.describe Hyrax::CollectionPresenter do
  subject { described_class.new(double, double) }

  before do
    name = 'The Collection'
    @snake = 'the_collection'
    @title = 'The Title'
    @url = 'http://university.edu'
    collection = double('CollectionType', title: name)
    allow(subject).to receive(:collection_type).and_return(collection)
    @campus_logos = ESSI.config[:essi][:campus_logos]
  end

  context 'When initialized' do
    it '.campus_logo is available' do
      expect(subject).to respond_to(:campus_logo)
    end
  end

  context 'When campus_logos is not configured' do
    it '.campus_logo returns false' do
      ESSI.config[:essi][:campus_logos] = nil
      expect(subject.campus_logo).to be false
    end
  end

  context 'When collection matches configuration' do
    it '.campus_logo returns configured values' do
      ESSI.config[:essi][:campus_logos][@snake] = { title: @title, url: @url }
      expect(subject.campus_logo).to include(@title)
      expect(subject.campus_logo).to include(@url)
    end
  end

  after do
    ESSI.config[:essi][:campus_logos] = @campus_logos
  end

end
