# BankOcrKata

This implements Bank OCR kata challange found over here:
https://github.com/testdouble/contributing-tests/wiki/Bank-OCR-kata

## Quickstart

To see this in action, either run the test suite

```
 $ bundle exec rspec
```

or run the associated bin on the example text file:

```
±  |master ✗| → bundle exec bin/bank_ocr_account_reader example_digits.txt 
111111111
777777777
200000000
333333333
888888888
555555555
666666666
999999999
490067715
?23456789 ILL
0?0000051 ILL
49086771? ILL
```

Note that the `-a` flag will try to recreate ambiguous account numbers:

```
±  |master ✗| → bundle exec bin/bank_ocr_account_reader -a example_digits.txt 
711111111
777777177
200800000
333393333
888888888 AMB [[8, 8, 8, 8, 8, 6, 8, 8, 8], [8, 8, 8, 8, 8, 8, 9, 8, 8],
[8, 8, 8, 8, 8, 8, 8, 8, 0]]
555555555 AMB [[5, 5, 9, 5, 5, 5, 5, 5, 5], [5, 5, 5, 6, 5, 5, 5, 5, 5]]
666666666 AMB [[6, 8, 6, 6, 6, 6, 6, 6, 6], [6, 6, 6, 5, 6, 6, 6, 6, 6]]
999999999 AMB [[8, 9, 9, 9, 9, 9, 9, 9, 9], [9, 9, 3, 9, 9, 9, 9, 9, 9],
[9, 9, 9, 9, 5, 9, 9, 9, 9]]
490067715 AMB [[4, 9, 0, 8, 6, 7, 7, 1, 5], [4, 9, 0, 0, 6, 7, 1, 1, 5],
[4, 9, 0, 0, 6, 7, 7, 1, 9]]
123456789
000000051
490867715
```

## Introduction to the code:

Most of the code is in
[lib/bank_ocr_kata.rb](https://github.com/svevang/bank_ocr_kata/blob/master/lib/bank_ocr_kata.rb). There you can find an `Account` class and a `Digits` module.

Accounts: keeps the relevant info for the account and calulates
validation strings.

Digits: A collection of utility methods, the "OCR" part of the code.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the BankOcrKata project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/bank_ocr_kata/blob/master/CODE_OF_CONDUCT.md).
