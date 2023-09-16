require "spec_helper"

# frozen_string_literal: true

describe CLI do
  describe "#get_input" do
    it "gets user input" do
      allow($stdin).to receive(:gets) { "p" }
      # must input 'p'
      expect(CLI.get_input).to eq "P"
    end
  end

  describe "#clear" do
    it "clears the terminal" do
      allow($stdin).to receive(:gets) { "p" }
      expect(CLI.clear).to eq true
    end
  end
end
