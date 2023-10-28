=begin

Problem:
Input: array of integers
Output: integer (# of pairs)

Rules:
Return count of pairs
If array is less than 2 elements, return 0
Pairs are grouped in 2 ONLY (4 digits = 2 pairs)
Max array length is 1000
Elements are b/t 0 - 1000

Implicit Rules:
Any extra digits are not paired

Data Structures:
Arrays
Sub-arrays
counter variable

Algorithm:
Initialize counter variable, set to 0
Initialize array of unique values
Iterate through unique elements of array
  Find count of current element in original array
  Increase counter variable by half the count
Return counter

=end

def pairs(arr)
  counter = 0
  arr.uniq.each { |num| counter += (arr.count(num)) / 2 }
  counter
end

p pairs([1, 2, 5, 6, 5, 2]) == 2
p pairs([1, 2, 2, 20, 6, 20, 2, 6, 2]) == 4
p pairs([0, 0, 0, 0, 0, 0, 0]) == 3
p pairs([1000, 1000]) == 1
p pairs([]) == 0
p pairs([54]) == 0
