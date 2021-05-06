require 'journey'

describe Journey do
  let(:station) { double('station') }

  context 'when initialised' do
    it 'journey is not complete' do
      expect(subject).not_to be_complete
    end

    it "has a default penalty fare of #{Journey::DEFAULT_PENALTY_FARE}" do
      expect(subject.fare).to eq(Journey::DEFAULT_PENALTY_FARE)
    end
  end

  context 'when given an entry station' do
    let(:journey) { described_class.new(station) }

    it 'journey is not complete' do
      expect(journey).not_to be_complete
    end

    it 'has an entry station' do
      expect(journey.entry_station).to eq(station)
    end

    it '#fare returns the penalty fare when no exit station given' do
      expect(journey.fare).to eq(Journey::DEFAULT_PENALTY_FARE)
    end

    context 'when given an exit station' do
      let(:exit_station) { double('station') }
      before { journey.finish(exit_station) }

      it 'completes the journey' do
        expect(journey).to be_complete
      end

      it 'calculates a fare if an entry station was given' do
        expect(journey.fare).to eq(1)
      end

      it 'has an exit station' do
        expect(journey.exit_station).to eq(exit_station)
      end
    end
  end

  context 'when given an exit station but no entry station' do
    let(:journey) { described_class.new }
    let(:exit_station) { double('station') }
    before { journey.finish(exit_station) }
    it '#fare returns the penalty fare' do
      expect(journey.fare).to eq(6)
    end
  end
end
