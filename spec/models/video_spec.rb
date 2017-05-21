require 'rails_helper'

RSpec.describe Video do
  before { allow_any_instance_of(described_class).to receive(:trim_video) }
  
  describe 'validations' do
    subject { described_class.new }

    context 'status' do
      %w(done failed scheduled processing).each do |status|
        it "should be valid with status #{status}" do
           subject.status = status
           subject.valid?
           expect(subject.errors[:status].size).to eq 0
        end
      end

      it 'should not be valid with wrong status' do
         subject.status = 'wrong'
         subject.valid?
         expect(subject.errors[:status].size).to eq 1
      end
    end

    it 'should not be valid without user' do
      subject.valid?
      expect(subject.errors[:user].size).to eq 1
    end

    it 'should not be valid without video' do
      subject.valid?
      expect(subject.errors[:video].size).to eq 1
    end

    context 'start_time' do
      it 'should not be greater than end_time' do
        subject.assign_attributes(start_time: 20, end_time: 10)
        subject.valid?
        expect(subject.errors[:start_time].size).to eq 1
      end

      it 'should not be negative' do
        subject.assign_attributes(start_time: -20)
        subject.valid?
        expect(subject.errors[:start_time].size).to eq 1
      end

      it 'should present' do
        subject.valid?
        expect(subject.errors[:start_time].size).to eq 1
      end
    end

    context 'end_time' do
      it 'should present' do
        subject.valid?
        expect(subject.errors[:end_time].size).to eq 1
      end
    end
  end

  describe '#url' do
    context 'returns correct url' do
      let(:done_video) { create :video, :done }
      let(:failed_video) { create :video, :failed }

      it 'for done video' do
        expect(done_video.url).to match /_trimmed/
      end

      it 'for failed video' do
        expect(failed_video.url).to_not match /_trimmed/
      end
    end
  end
end
