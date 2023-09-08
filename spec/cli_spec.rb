require 'spec_helper'

# frozen_string_literal: true

describe CLI do
  describe "#get_input" do
    it "gets user input" do
      allow($stdin).to receive(:gets) { "p" }
      # must input 'p'
      expect(CLI.get_input).to eq 'p'
    end
  end
end
