require 'station'

describe Station do

  let(:name) {"Liverpool Street"}
  let(:zone) {1}

  it 'Each station has a zone' do
    station = Station.new(name, zone)
    expect(station.zone).to eq zone
  end

  it 'Each station has a name' do
    station = Station.new(name, zone)
    expect(station.name).to eq name
  end
end