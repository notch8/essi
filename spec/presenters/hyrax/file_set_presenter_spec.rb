require 'rails_helper'

RSpec.describe Hyrax::FileSetPresenter do
  subject { described_class.new(double, double) }

  before do
    sets = ['The Collection', 'Another Collection']
    @snake = 'the_collection'
    @title = 'The Title'
    @url = 'http://university.edu'
    work = double('WorkType', admin_set: sets)
    allow(subject).to receive(:parent).and_return(work)
    @campus_logos = ESSI.config[:essi][:campus_logos]
  end

  context 'When initialized' do
    it '.collection is available' do
      expect(subject).to respond_to(:collection)
    end
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

  context 'When admin_set matches configuration' do
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
