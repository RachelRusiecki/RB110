# Create a hash that expresses the frequency with which each letter occurs in this string:

statement = 'The Flintstones Rock'
frequency = {}
index = 0

loop do
  break if index == statement.size
  frequency[statement[index]] = statement.count(statement[index])
  index += 1
end

p frequency
