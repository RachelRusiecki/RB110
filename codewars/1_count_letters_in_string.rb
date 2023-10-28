=begin

Problem:
Input: string
Output: hash

Rules:
Find lowercase letters in string
Return count in hash
  Letter will be the key as a symbol
  Count will be value

Implicit Rules:
Hash should be in alphabetical order
Assume all strings are lowercase

Data Structures:
Hash
symbols
integers

Algorithm:
Initialize return hash
Initialize array of all letters
Iterate through letters
  Find the count of each letter w/in string
  If count is greater than 0...
    Assign the current letter to hash key (symbol), assign count as value
Return hash

=end

def letter_count(str)
  hash = {}
  letters = %w(a b c d e f g h i j k l m n o p q r s t u v w x y z)
  letters.each do |letter|
    hash[letter.to_sym] = str.count(letter) if str.count(letter) > 0
  end
  hash
end

p letter_count('codewars') == {:a=>1, :c=>1, :d=>1, :e=>1, :o=>1, :r=>1, :s=>1, :w=>1}
p letter_count('activity') == {:a=>1, :c=>1, :i=>2, :t=>2, :v=>1, :y=>1}
p letter_count('arithmetics') == {:a=>1, :c=>1, :e=>1, :h=>1, :i=>2, :m=>1, :r=>1, :s=>1, :t=>2}
