require "pry"

RSpec.describe BankOcrKata::Digits do
  let(:digits) do
  "    _  _     _  _  _  _  _ \n" +
  "  | _| _||_||_ |_   ||_||_|\n" +
  "  ||_  _|  | _||_|  ||_| _|\n" +
  "                           \n" +
  "    _  _     _  _  _  _  _ \n" +
  "  | _| _||_||_ |_   ||_||_|\n" +
  "  ||_  _|  | _||_|  ||_| _|\n" +
  "                           \n" +
  " _  _  _  _  _  _  _  _  _ \n" +
  "| || || || || || || || || |\n" +
  "|_||_||_||_||_||_||_||_||_|\n" + 
  "                           "

  end

  context "#read" do
    before do
      allow(File).to receive(:read).with("digits.txt").and_return(digits)
    end

    subject(:parsed_digits) { BankOcrKata::Digits.read("digits.txt") }

    it { expect(parsed_digits.class).to be Array}
  end
end
