# What happens when we modify an array while we are iterating over it? What would be output by this code?

numbers = [1, 2, 3, 4]
numbers.each do |number|
  p number
  numbers.shift(1)
end

# 1, 3 would be output because when the shift method is called, it deletes the first element and so the second element for the second iteration is now 3. There is now third element after that.

# What would be output by this code?

numbers = [1, 2, 3, 4]
numbers.each do |number|
  p number
  numbers.pop(1)
end

# 1, 2 because it would print the first 2 elements on the first 2 iterations while also deleting the last 2 elements. After that, there are no more numbers to print.
