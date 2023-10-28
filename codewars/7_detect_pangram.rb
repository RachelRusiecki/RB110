=begin

A pangram is a sentence that contains every single letter of the alphabet at least once.  

For example: the sentence "The quick brown fox jumps over the lazy dog" is a pangram, 
because it uses the letters A-Z at least once (case is irrelevant).

Given a string, detect whether or not it is a pangram. Return True if it is, False if not. Ignore numbers and punctuation.

Problem:
Input: string
Output: boolean

Rules:
Return TRUE if all letters are used in string
False otherwise
Case insensitive
Ignore #s and puntuation

Data Structures:
Iteration
  Array

Algorithm:
Initialize array of all lowercase letters
  Use range or write out

Verify each letter is included in string
  Iterate through array
    If letter is included in the string, next iteration
    If not included in string, return FALSE
  Return TRUE
=end

def is_pangram(str)
  alphabet = ('a'..'z').to_a
  p alphabet
  alphabet.each { |letter| return false unless str.include?(letter) }
  true
end

p is_pangram('The quick brown fox jumps over the lazy dog.') == true
p is_pangram('This is not a pangram.') == false
