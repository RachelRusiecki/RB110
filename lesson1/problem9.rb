# Write your own version of the rails titleize implementation.

def titleize(str)
  str.split.map { |word| word.capitalize }.join(' ')
end

p titleize('the flintstones rock')
