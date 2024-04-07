=begin

Problem:
Input: array of intgers & single integer
Output: 2 element subarray

Rules:
Find first 2 elements that when added together, equal the 2nd input number
Return 2 elements in array
If multiple pairs are correct, return pair where 2nd element has lower index
Return nil if no 2 elements meet criteria

Implicit Rules:
Return value cannot be single element array
Return array should keep same order from input array

Data Structures:
Arrays
Subarrays
Iteration

Algorithm:
Initialize hash to keep track of index
  Initialize empty hash
  Assign each num to keys
  Assign index to values
  If there are repeating nums, the higher index value will replace the old

Find all 2 element subarrays
  Initialize empty array to hold subarrays
  Iterate through array w/ index
    Append current element to new array & element at next index to new array
    Increase index by 1

Delete any subarrays that when added together do not equal intger input

Return subarray if only 1

If more than 1 subarray...
Compare index of 2nd element using hash value (representing idx)  
  Return the subarray w/ lower hash value (index) of 2nd element

=end

# def initialize_idx_hash(arr)
#   hash = {}
#   arr.each_with_index { |ele, idx| hash[ele] = idx }
#   hash
# end

# def find_all_subarrays(arr)
#   subarrays = []
#   arr.each_with_index do |ele, idx1|
#     (idx1 + 1).upto(arr.size - 1) { |idx2| subarrays << [ele, arr[idx2]] }
#   end
#   subarrays
# end

# def sum_pairs(ints, s)
#   hash = initialize_idx_hash(ints)
#   subarrays = find_all_subarrays(ints)
#   subarrays.delete_if { |subarray| subarray.sum != s }
#   subarrays.min_by { |subarray| hash[subarray[1]] }
# end

def sum_pairs(ints, s)
  hash = {}
  ints.each_with_index { |ele, idx| hash[ele] = idx }
  subarrays = []
  ints.each_with_index do |ele, idx1|
    (idx1 + 1).upto(ints.size - 1) { |idx2| subarrays << [ele, ints[idx2]] }
  end
  subarrays.delete_if { |subarray| subarray.sum != s }
  subarrays.min_by { |subarray| hash[subarray[1]] }
end

p sum_pairs([1, 4, 8, 7, 3, 15], 8) == [1, 7]
p sum_pairs([1, -2, 3, 0, -6, 1], -6) == [0, -6]
p sum_pairs([20, -13, 40], -7) == nil
p sum_pairs([1, 2, 3, 4, 1, 0], 2) == [1, 1]
p sum_pairs([10, 5, 2, 3, 7, 5, 7], 10) == [3, 7]
p sum_pairs([4, -2, 3, 3, 4], 8) == [4, 4]
p sum_pairs([0, 2, 0], 0) == [0, 0]
p sum_pairs([5, 9, 13, -3], 10) == [13, -3]
