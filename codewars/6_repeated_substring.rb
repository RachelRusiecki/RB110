=begin

Problem:
Input: string
Output: array [substring, integer]

Rules:
Find min substring of chars
Find max # where substring * number = string
All lowercase letters

Data Structure:
Arrays
Iteration
Substrings

Algorithm:
Find all substrings
  Initialize empty return array
  Split string into array of chars
  Iterate through array w/ index
    Iterate through numbers starting from the current index to the size of the array minus 1
      Append range of array starting at index through the ending index to new array
  Return array of subarrays

Iterate through all subarrays
Check if substrings are equal
Convert all subarrays to substrings
  If the count of the current substring is > 1
    Check if substring times the length of the string divided by length of substring returns the string
  If there are no equal subtrings that meet the above conditions return original string and 1
Return array of substring  and length of the string divided by length of substring

=end

def find_all_substrings(str)
  return_array = []
  str.chars.each_with_index do |char, start_idx|
    start_idx.upto(str.size - 1) do |end_idx|
      return_array << str[start_idx..end_idx]
    end
  end
  return_array
end

def f(str)
  substrings = find_all_substrings(str)
  substrings.each do |substring|
    num = (str.size / substring.size)
    return [substring, num] if substring * num == str
  end
end

p f("ababab") == ["ab", 3]
p f("abcde") == ["abcde", 1]
