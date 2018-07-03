require "pry"

RSpec.describe BankOcrKata::Account do

  let (:use_cases1) do

    [
      " _  _  _  _  _  _  _  _  _ \n" +
      "| || || || || || || || || |\n" +
      "|_||_||_||_||_||_||_||_||_|",

      "                           \n" +
      "  |  |  |  |  |  |  |  |  |\n" +
      "  |  |  |  |  |  |  |  |  |",

      " _  _  _  _  _  _  _  _  _ \n" +
      " _| _| _| _| _| _| _| _| _|\n" +
      "|_ |_ |_ |_ |_ |_ |_ |_ |_ ",

      " _  _  _  _  _  _  _  _  _ \n" +
      " _| _| _| _| _| _| _| _| _|\n" +
      " _| _| _| _| _| _| _| _| _|",


      "                           \n" +
      "|_||_||_||_||_||_||_||_||_|\n" +
      "  |  |  |  |  |  |  |  |  |",

      " _  _  _  _  _  _  _  _  _ \n" +
      "|_ |_ |_ |_ |_ |_ |_ |_ |_ \n" +
      " _| _| _| _| _| _| _| _| _|",

      " _  _  _  _  _  _  _  _  _ \n" +
      "|_ |_ |_ |_ |_ |_ |_ |_ |_ \n" +
      "|_||_||_||_||_||_||_||_||_|",

      " _  _  _  _  _  _  _  _  _ \n" +
      "  |  |  |  |  |  |  |  |  |\n" +
      "  |  |  |  |  |  |  |  |  |",

      " _  _  _  _  _  _  _  _  _ \n" +
      "|_||_||_||_||_||_||_||_||_|\n" +
      "|_||_||_||_||_||_||_||_||_|",

      " _  _  _  _  _  _  _  _  _ \n" +
      "|_||_||_||_||_||_||_||_||_|\n" +
      " _| _| _| _| _| _| _| _| _|",

      "    _  _     _  _  _  _  _ \n" +
      "  | _| _||_||_ |_   ||_||_|\n" +
      "  ||_  _|  | _||_|  ||_| _|",
    ]
  end

  let(:use_cases2) do
    [
      "    _  _  _  _  _  _  _  _ \n" +
      "|_||_   ||_ | ||_|| || || |\n" +
      "  | _|  | _||_||_||_||_||_|",
    ]
    
  end

  let(:use_cases3) do
    [
    " _  _  _  _  _  _  _  _    \n" +
    "| || || || || || || ||_   |\n" +
    "|_||_||_||_||_||_||_| _|  |",

    "    _  _  _  _  _  _     _ \n" +
    "|_||_|| || ||_   |  |  | _ \n" +
    "  | _||_||_||_|  |  |  | _|",

    "    _  _     _  _  _  _  _ \n" +
    "  | _| _||_| _ |_   ||_||_|\n" +
    "  ||_  _|  | _||_|  ||_| _ ",
    ]

  end


  context "Accounts" do
    context "#account_number" do

      subject(:account_numbers) do
        use_cases1
          .map{ |digit_string| BankOcrKata::Account.new(digit_string) }
          .map{ |account| account.account_number }
      end

      it "should parse all the accounts in the usecases 1" do
        expect(account_numbers).to contain_exactly([0,0,0,0,0,0,0,0,0],
                                                   [1,1,1,1,1,1,1,1,1],
                                                   [2,2,2,2,2,2,2,2,2],
                                                   [3,3,3,3,3,3,3,3,3],
                                                   [4,4,4,4,4,4,4,4,4],
                                                   [5,5,5,5,5,5,5,5,5],
                                                   [6,6,6,6,6,6,6,6,6],
                                                   [7,7,7,7,7,7,7,7,7],
                                                   [8,8,8,8,8,8,8,8,8],
                                                   [9,9,9,9,9,9,9,9,9],
                                                   [1,2,3,4,5,6,7,8,9]
                                                  )
      end
    end

    context "#checksum_valid?" do
      subject(:account_checksums) do
        use_cases2
          .map{ |digit_string| BankOcrKata::Account.new(digit_string) }
          .map{ |account| account.checksum_valid? }
      end

      it { expect(account_checksums).to contain_exactly(true)}
    end

    context "validation_string" do
      subject(:account_validation_strings) do
        use_cases3
          .map{ |digit_string| BankOcrKata::Account.new(digit_string) }
          .map{ |account| account.validation_string }
      end

      it { expect(account_validation_strings).to contain_exactly("000000051",
                                                                 "49006771? ILL",
                                                                 "1234?678? ILL") }
    end


  end


end
