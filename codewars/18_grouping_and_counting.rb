=begin

Problem:
Input: array
Output: hash

Rules:
Returns hash where...
  keys are array elements
  values are counts of elements in array
If array is empty, return nil (not empty hash)
Cannot use count or length methods

Data Structures:
Arrays
Hashes
Iteration

Algorithm:
Return nil if arr is empty
Initialize empty return hash
Iterate through array
  if current element is already a key in hash
    increase key's value by 1
  If new key is found
    Assign current element to hash key, w/ value of 1
Return hash

=end

def group_and_count(input)
  return nil if input.empty?
  hash = {}
  input.each do |num|
    if hash.key?(num)
      hash[num] += 1
    else
      hash[num] = 1
    end
  end
  hash
end

p group_and_count([0,1,1,0]) == {0=>2, 1=>2}
p group_and_count([1,1,2,2,2,3]) == {1=>2, 2=>3, 3=>1}
