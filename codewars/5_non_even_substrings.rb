=begin

Problem:
Input: string (numbers)
Output: integer

Rules:
Find the number of substrings that when converted to intger, are odd

Implicit Rules:
Substrings will be consecutive

Data Structures:
array?
substrings / sub-arrays

Algorithm:
Find all substrings
  Initialize empty array
  Split string into array of chars
  Iterate through chars using index
    Append current char through current index to empty array
    Increase index
  Return nested array of sub-arrays

Select all substrings that are odd numbered
  Iterate through each subarray
    If the digits joined together & converted to integer is odd
      Select this subarray

Return amount of substrings that are odd numbered
  Find size of selected subarrays

=end

def find_all_substrings(str)
  substrings = []
  chars = str.chars
  chars.each_with_index do |char, start_idx|
    start_idx.upto(chars.size - 1) do |end_idx|
      substrings << chars[start_idx..end_idx]
    end
  end
  substrings
end

def solve(str)
  find_all_substrings(str).select { |subarray| subarray.join.to_i.odd? }.size
end

p solve("1341") == 7
p solve("1357") == 10
p solve("13471") == 12
p solve("134721") == 13
p solve("1347231") == 20
p solve("13472315") == 28
