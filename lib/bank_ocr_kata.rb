require "bank_ocr_kata/cli"
require "bank_ocr_kata/version"

# Reads multicharacter digit representations.

module BankOcrKata

  class Account
    def initialize(digit_string)
      @digit_string = digit_string
    end

    def parse(digit_string)
      BankOcrKata::Digits::parse(digit_string)
    end

    def account_number
      parse(@digit_string)
    end


    def print
      puts account_number
        .map{|n| n.to_s }
        .join
    end
  end


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
      delim = (" " * 27)
      contents = File.read(path)

      # normalize the delimiter and remove the trailing whitespace
      # split the string and parse out digits
      contents
        .gsub("\n" + delim + "\n", delim)
        .gsub("\n" + delim, "")
        .split(delim)
        .map{ |hunk_string| Account.new(hunk_string) }
        .map{ |account| account }
    end

    # Takes in an individual account number of 9 digits in the ascii art
    # representation. There are 3 columns and 3 rows for each digit.
    def self.parse(digit_string)
      digit_string
        .split("\n")
        .map {|e| e.split('') }
        .transpose
        .each_slice(3)
        .to_a
        .map{ |split_hunks| split_hunks.transpose.map {|arr| arr.join("") } }
        .map{ |hunks| lookup_digit(hunks.join) }
    end

    def self.lookup_digit(transposed_digit)
      DIGITS.find_index(transposed_digit)
    end

  end
end
