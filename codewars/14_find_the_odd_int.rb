=begin

Problem:
Input: array of integers
Output: integer (element)

Rules:
Return element that appears odd # of times
There will always be 1 integer that occurs odd # of times

Data Structures:
Iteration

Algorithm:
Iterate through array
  Find count of each element
  If count is odd...
    return element

=end

def find_it(seq)
  seq.each { |num| return num if seq.count(num).odd? }
end

p find_it([20,1,-1,2,-2,3,3,5,5,1,2,4,20,4,-1,-2,5]) == 5
p find_it([1,1,2,-2,5,2,4,4,-1,-2,5]) == -1
p find_it([20,1,1,2,2,3,3,5,5,4,20,4,5]) == 5
p find_it([10]) == 10
p find_it([1,1,1,1,1,1,10,1,1,1,1]) == 10
