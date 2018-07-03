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

  let (:digits_through_nine) do
  "    _  _     _  _  _  _  _ \n" +
  "  | _| _||_||_ |_   ||_||_|\n" +
  "  ||_  _|  | _||_|  ||_| _|"
  end

  let (:all_digits) do
  " _     _  _     _  _  _  _  _ \n" +
  "| |  | _| _||_||_ |_   ||_||_|\n" +
  "|_|  ||_  _|  | _||_|  ||_| _|"
  end

  context "#read" do
    before do
      allow(File).to receive(:read).with("digit_file_contents.txt").and_return(digit_file_contents)
    end

    subject(:parsed_digits) do
      BankOcrKata::Digits.read("digit_file_contents.txt")
        .map{|account| account.account_number }
    end

    it { expect(parsed_digits.class).to be Array}
    it { expect(parsed_digits.length).to be 3}

    it "should parse a mockup of the reference file" do
      expect(parsed_digits).to contain_exactly([1,2,3,4,5,6,7,8,9],
                                               [1,2,3,4,5,6,7,8,9],
                                               [0,0,0,0,0,0,0,0,0])
    end
  end

  context ".parse" do


    subject(:parsed_digits) { BankOcrKata::Digits.parse(all_digits) }

    it { expect(parsed_digits.class).to be Array }

    it { expect(parsed_digits).to all( be_an(Integer) ) }

  end
end
