=begin

Problem:
Input: array of integers
Output: integer, representing idx

Rules:
Return idx where sum of elements to the left & right side are equal
If no idx fits parameters, return -1
Empty array sum is 0 and sides can be empty
Assume array is b/t 0 & 1000 elements in size
Integers can be positive or negative
Multiple correct answers possible so return lowest idx

Data Structures:
Iteration

Algorithm:
Iterate through array w/ idx
  If current idx is 0
    Check if sum of idx (1 - last) is 0, if it is return idx 0
  If sum of indices idx (0 - current idx -1) is equal to (current idx + 1) - last
    Return current idx
  If current idx is last (size -1)
    Check if sum of idx (0 - (-2)) is 0, if it is return last idx
Return -1

=end

def find_even_index(arr)
  arr.each_with_index do |_, idx|
    if idx == 0
      return idx if arr[1..].sum == 0
    elsif idx == arr.size - 1
      return idx if arr[0..-2].sum == 0
    else
      return idx if arr[0..(idx - 1)].sum == arr[(idx + 1)..-1].sum
    end
  end
  -1
end

p find_even_index([1,2,3,4,3,2,1]) == 3
p find_even_index([1,100,50,-51,1,1]) == 1
p find_even_index([1,2,3,4,5,6]) == -1
p find_even_index([20,10,30,10,10,15,35]) == 3
p find_even_index([20,10,-80,10,10,15,35]) == 0
p find_even_index([10,-80,10,10,15,35,20]) == 6
p find_even_index(Array(1..100)) == -1
p find_even_index([0,0,0,0,0]) == 0 #"Should pick the first index if more cases are valid"
p find_even_index([-1,-2,-3,-4,-3,-2,-1]) == 3
p find_even_index(Array(-100..-1)) == -1
