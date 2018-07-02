require "bank_ocr_kata/version"

# Reads multicharacter digit representations.

module BankOcrKata
  module Digits

    # Lookup table for the 3x3 ascii encoded digit.
    # The digit hunks have rows swapped with columns and then joined.
    DIGITS = [" _ | ||_|",
              "     |  |",
              " _  _||_ ",
              " _  _| _|",
              "   |_|  |",
              " _ |_  _|",
              " _ |_ |_|",
              " _   |  |",
              " _ |_||_|",
              " _ |_| _|",]

    def self.read(path)
      contents = File.read(path)
    end

    # Takes in an individual account number of 9 digits in the ascii art
    # representation. There are 3 columns and 3 rows for each digit.
    def self.account_number(digit_string)
      digit_string
        .split("\n")
        .map {|e| e.split('') }
        .transpose
        .each_slice(3)
        .to_a
        .map{ |split_hunks| split_hunks.transpose.map {|arr| arr.join("") } }
        .map{ |hunks| lookup_digit(hunks) }
    end

    def self.lookup_digit(transposed_digit_hunks)
      key = transposed_digit_hunks.join
      DIGITS.find_index(key)
    end

  end
end
