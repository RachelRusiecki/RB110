# Given the following data structure and without modifying the original array...
# Use the map method to return a new array identical in structure to the original but where the value of each integer is incremented by 1.

arr = [{a: 1}, {b: 2, c: 3}, {d: 4, e: 5, f: 6}]

new_arr = arr.map do |hash|
  new_hash = {}
  hash.each { |letter, num| new_hash[letter] = num + 1 }
  new_hash
end

# The return value from map should be the following array:

[{a: 2}, {b: 3, c: 4}, {d: 5, e: 6, f: 7}]

p arr
p new_arr
