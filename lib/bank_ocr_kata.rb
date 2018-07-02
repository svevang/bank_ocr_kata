require "bank_ocr_kata/version"

# Reads multicharacter digit representations.

module BankOcrKata
  module Digits
    def self.read(path)
      contents = File.read(path)
    end

    # Takes in an individual account number of 9 digits in the ascii art
    # representation. There are 3 columns and 3 rows for each digit.
    def self.account_number(digit_string)
      digit_string.split("\n")
    end

  end
end
