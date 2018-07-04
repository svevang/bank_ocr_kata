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

    def ensure_valid_account_number(reconstruct_ambiguous)
      status = nil
      alternatives = []
      acc = account_number

      if acc.any?(&:nil?)
        status = "ILL"
      end

      if reconstruct_ambiguous

        if self.checksum_invalid?
          status = "ILL"
        end

        unless status.nil?
          alternatives = BankOcrKata::Digits::reconstruct_ambiguous(@digit_string)
            .select{|digit_list| self.checksum_valid?(digit_list) }
        end

        if self.checksum_invalid? &&
           alternatives.length == 1 &&
           checksum_valid?(alternatives[0])
          acc = alternatives[0]
          alternatives = []
          status = nil
        end

      end

      if alternatives.length > 0
        status = "AMB"
      end

      [acc, alternatives, status]

    end

    def validation_string(reconstruct_ambiguous=false)

      acc, alternatives, status = ensure_valid_account_number(reconstruct_ambiguous)

      formatted_acc = acc
        .map do |n|
          if n.nil?
            '?'
          else
            n.to_s
          end
      end
        .join

      formatted_acc = "#{formatted_acc} #{status} #{alternatives.inspect if alternatives.length > 0}".strip

      formatted_acc
    end

    def print(reconstruct_ambiguous=false)
      puts validation_string(reconstruct_ambiguous)
    end

    def checksum_valid?(acct=account_number)
      return false if acct.any?(&:nil?)
      acct
        .reverse
        .map.with_index { |digit, i| digit * (i+1) }
        .reduce(:+) % 11 == 0
    end

    def checksum_invalid?
      !checksum_valid?
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

      # split the string and parse out digits
      # take the 4 lines and discard the delimeter
      contents
        .split("\n")
        .each_slice(4)
        .map{ |hunk_string| hunk_string[0..2] }
        .map{ |hunk_string| hunk_string.join("\n") }
        .map{ |digit_string| Account.new(digit_string) }
        .map{ |account| account }
    end

    def self.rotate(digit_string)
      res = digit_string
        .split("\n")
        .map {|e| e.split('') }
        .transpose
        .each_slice(3)
        .to_a
        .map{ |split_hunks| split_hunks.transpose.map {|arr| arr.join("") } }
    end

    # Takes in an individual account number of 9 digits in the ascii art
    # representation. There are 3 columns and 3 rows for each digit.
    def self.parse(digit_string)
      rotate(digit_string)
        .map{ |hunks| lookup_digit(hunks.join) }
    end

    def self.reconstruct_ambiguous(digit_string)
      transposed_digit = rotate(digit_string)

      try_char = ["_", "|", " "]

      res = []

      transposed_digit.each_with_index do |digit_frags, i|
        digit_frags.each_with_index do |frag, j|
          (0..(frag.length - 1)).each do |frag_index|
            try_char.each do |try_char|
              # deep copy the nested lists
              trans_attempt = Marshal.load(Marshal.dump(transposed_digit))

              trans_attempt[i][j][frag_index] = try_char

              digit_value = trans_attempt.map {|hunks| lookup_digit(hunks.join) }
              res.push(digit_value) unless digit_value.any?(&:nil?)
            end
          end
        end
      end

      res
    end

    def self.lookup_digit(transposed_digit)
      ind = DIGITS.find_index(transposed_digit)
    end

  end
end
