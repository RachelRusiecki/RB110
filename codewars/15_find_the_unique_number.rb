=begin

Problem:
Input: array of numbers
Output: unique element

Rules:
Return the unique element (only 1), all other #s are the same
Array will have min 3 elements
***Remember performance

Implicit Rules:
Numbers can be floats as well as integers

Data Structures:
Arrays
Iteration?

Algorithm:
Initialize variable, set it equal to just the unique elements of array
Iterate through new array (2 elements)
  Find count each element in input array
  If count is 1
  Return element

=end

def find_uniq(arr)
  arr.each { |num| return num if arr.count(num) == 1 }
end

p find_uniq([1,1,1,1,0]) == 0
p find_uniq([ 1, 1, 1, 2, 1, 1 ]) == 2
p find_uniq([ 0, 0, 0.55, 0, 0 ]) == 0.55
