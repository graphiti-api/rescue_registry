require_relative "spec_helper"
require "rescue_registry"

RSpec.describe RescueRegistry do
  describe ".context" do
    it "is visible to a fiber started within the block" do
      seen = :unset

      described_class.with_context("ctx") do
        Fiber.new { seen = described_class.context }.resume
      end

      expect(seen).to eq("ctx")
    end

    it "is restored after the block" do
      described_class.with_context("ctx") { }

      expect(described_class.context).to be_nil
    end
  end
end
