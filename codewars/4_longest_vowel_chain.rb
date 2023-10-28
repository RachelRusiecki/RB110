=begin

Problem:
Input: string
Output: integer

Rules:
Find longest substring of vowels
All strings are 1 word, lowercase

Data Structures:
sub-strings
sub-arrays?
iteration
index reference

Algorithm:
Find all substrings
  Initialize empty array to hold subarrays
  Split string into array of chars
  Iterate through each char of array w/ idx
    Iterate through idx to find range of substring
    Increase idx by 1
  will return array of sub_arrays

Find just the substrings that contain all vowels
  Select all of the sub-arrays where each letter is included in 'aeiou'

Return the size of the largest substring

=end

def find_all_substrings(str)
  sub_arrays = []
  chars_arr = str.chars
  chars_arr.each_with_index do |_, start_idx|
    (start_idx.upto(chars_arr.size - 1)) do |end_idx|
      sub_arrays << chars_arr[start_idx..end_idx]
    end
  end
  sub_arrays
end

def solve(str)
  sub_arrays = find_all_substrings(str)
  vowel_subs = sub_arrays.select do |sub_arr|
    sub_arr.all? { |letter| %w(a e i o u).include?(letter) }
  end
  vowel_subs.max_by { |sub_arr| sub_arr.size }.size
end

p solve("codewarriors") == 2
p solve("suoidea") == 3
p solve("iuuvgheaae") == 4
p solve("ultrarevolutionariees") == 3
p solve("strengthlessnesses") == 1
p solve("cuboideonavicuare") == 2
p solve("chrononhotonthuooaos") == 5
p solve("iiihoovaeaaaoougjyaw") == 8
