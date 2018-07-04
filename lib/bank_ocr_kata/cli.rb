require "ostruct"
require "optparse"

module BankOcrKata
  # Class for parsing command line opts for the filereader portion of the app.
  # Takes in a argv style list of options.
  class CLI
    attr_reader :argv

    def self.default_options(argv = [])
      options = OpenStruct.new
      options
    end

    def initialize(argv)
      @argv = argv || []
    end

    def call
      options, file_path = parse(argv)
      return -1 unless valid?(options, file_path)

      BankOcrKata::Digits.read(file_path).map do |account|
        account.print(options[:reconstruct_ambiguous])
      end

      0
    end

    # Convert argv into a set of options
    def parse(argv)
      options = CLI.default_options(argv)

      opt_parser = OptionParser.new do |opts|

        opts.banner = "Usage: bank_ocr_kata <account_number_file>"

        opts.separator ""

        opts.on("-a", "reconstruct ambiguous account numbers") do |a|
          options[:reconstruct_ambiguous] = a
        end

        opts.on_tail("-h", "--help", "Show this message") do |is_help|
          options.request_help = is_help
        end
      end

      remaining_args = opt_parser.parse!(argv)
      file_path = remaining_args.pop

      print_help(opt_parser, file_path) unless valid?(options, file_path)

      [options, file_path]
    end

    def valid?(options, file_path)
      return false if options.request_help

      return false if file_path.nil?
      true
    end

  private

    def print_help(opts, file_path)
      puts "Bank OCR Kata: Parse and validate account numbers encoded as ascii art.."
      puts "https://github.com/testdouble/contributing-tests/wiki/Bank-OCR-kata"

      puts opts
      if file_path.nil?
        puts ""
        puts "file_path argument is missing and that is required."
      end
    end
  end
end
