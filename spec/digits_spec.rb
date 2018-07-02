require "pry"

RSpec.describe BankOcrKata::Digits do


  # an unprocessed file for accounts
  let(:digit_file_contents) do
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

  # digits here are split on the blank line
  let (:digits_zeros) do
  " _  _  _  _  _  _  _  _  _ \n" +
  "| || || || || || || || || |\n" +
  "|_||_||_||_||_||_||_||_||_|"
  end

  let (:digits_through_ten) do
  "    _  _     _  _  _  _  _ \n" +
  "  | _| _||_||_ |_   ||_||_|\n" +
  "  ||_  _|  | _||_|  ||_| _|"
  end

  context "#read" do
    before do
      skip
      allow(File).to receive(:read).with("digit_file_contents.txt").and_return(digits)
    end

    subject(:parsed_digits) { BankOcrKata::Digits.read("digits.txt") }

    it { expect(parsed_digits.class).to be Array}
  end

  context ".account_number" do


    subject(:parsed_account) { BankOcrKata::Digits.account_number(digits_through_ten) }

    it { expect(parsed_account.class).to be Array }

    it { expect(parsed_account).to all( be_an(Integer) ) }

  end
end
