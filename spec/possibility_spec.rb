require 'possibility'
# Confirms the behaviour of a Possibility
RSpec.describe Possibility do
  subject(:certain) { described_class.new(weight: 1) }
  subject(:impossible) { described_class.new(weight: 0) }

  let(:equally_likely) { described_class.new(weight: 0.5) }

  let(:possibility_1) { described_class.new(weight: 0.2) }
  let(:possibility_2) { described_class.new(weight: 0.4) }
  let(:possibility_3) { described_class.new(weight: 0.1) }
  let(:possibility_4) { described_class.new(weight: 0.3) }

  it "does not accept weights greater than #{described_class::NORMALIZED_WEIGHT}" do
    expect { described_class.new(weight: 1.1) }.to raise_error 'Not permitted'
  end

  it "does not accept weights less than 0" do
    expect { described_class.new(weight: -0.1) }.to raise_error 'Not permitted'
  end

  describe '&' do
    it 'gives the likelihood of both possibilities occurring' do
      expect(certain & impossible).to eq impossible
      expect(certain & certain).to eq certain
    end
  end

  describe '|' do
    it 'gives the likelihood of either possibility occurring' do
      expect(certain | impossible).to eq certain
    end
  end

  describe '~@' do
    it 'gives the likelihood of a possibility not occurring' do
      expect(~ certain).to eq impossible
    end
  end

  describe '#max' do
    it 'returns the only possibility if provided empty array' do
      expect(certain.max([])).to eq certain
    end

    it 'returns the most likely of two if provided one item in an array' do
      expect(certain.max([impossible])).to eq certain
      expect(impossible.max([equally_likely])).to eq equally_likely
    end

    it 'returns the most likely of a list of possibility' do
      expect(certain.max([impossible, possibility_3])).to eq certain
      expect(possibility_1.max([possibility_2, possibility_3, possibility_4])).to eq possibility_2
    end

    it 'handles edge case of equal possibilities' do
      expect(impossible.max([possibility_2, possibility_2])).to eq possibility_2
    end
  end
end