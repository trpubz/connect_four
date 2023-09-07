require 'spec_helper'

# frozen_string_literal: true

describe Player do
  before(:each) do
    @plyr1 = Player.new("tp", "X")
    @plyr2 = Player.new("HAL", "O")
  end
  describe "#initialize" do
    it "exists" do
      expect(@plyr1).to be_a Player
    end

    it 'has @attributes' do
      expect(@plyr2.name).to eq "HAL"
      expect(@plyr1.token).to eq "X"
    end
  end
end
