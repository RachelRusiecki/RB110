=begin

# Write a method that takes an array of integers and returns the
# two numbers that are closest together in value.

Problem:
Input: array of integers
Output: array

Rules:
Return 2 element array containing 2 elements from input array that are closest in value
Subarrays are not necessarily contigious

Data Structures:
Arrays
Subarrays
Iteration

Algorithm:
Find all 2 didgit subarrays
  Initialize empty array to hold subarrays
  Iterate through array w/ index
    Iterate through the current idx through last idx
      Append 2 digit subarrays where current element is 1st index. 2nd element uses idex reference

Return the subarray w/ lowest difference
  Find minimum diffrerence
  Substract 1st element from 2nd
  Find the absolute value

=end

def find_all_substrings(arr)
  subarrays = []
  arr.each_with_index do |num, idx1|
    (idx1 + 1).upto(arr.size - 1) do |idx2|
      subarrays << [num, arr[idx2]]
    end
  end
  subarrays
end

def closest_numbers(arr)
  subarrays = find_all_substrings(arr)
  subarrays.min_by do |subarray|
    (subarray[0] - subarray[1]).abs
  end
end

p closest_numbers([5, 25, 15, 11, 20]) == [15, 11]
p closest_numbers([19, 25, 32, 4, 27, 16]) == [25, 27]
p closest_numbers([12, 7, 17]) == [12, 7]
