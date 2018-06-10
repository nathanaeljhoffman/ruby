# Method that returns the longest word in its argument.
def longest_word(input_string)
    word_array = input_string.split(" ")
    current_champ = ""
    iter = 0
    while iter < word_array.length
        current_champ = word_array[iter] if word_array[iter].length > current_champ.length
        iter += 1
    end
    current_champ
end

# Method that capitalizes each word of its argument and returns the resulting string.
def capitalize_each_word(str)
    word_array = str.split(" ")
    word_array.each do |word|
        word[0] = word[0].upcase
    end
    word_array.join(" ")
end

# Method that is functionally equivalent to the rotate(offset) method of arrays.
# FIRST SOLUTION
def my_rotate1(arr, offset=1)
	def shift_left(input_array)
			n = 0
			place_holder = input_array[0]
			while n < input_array.length
				input_array[n] = input_array[n + 1]
				n += 1
			end
			input_array[-1] = place_holder
			return input_array
	end
	def shift_right(input_array)
		n = input_array.length
		place_holder = input_array[-1]
		while n > 0
			input_array[n] = input_array[n - 1]
			n -= 1
		end
		input_array[0] = place_holder
		input_array.pop
		return input_array
	end

	times = offset.abs
	if offset > 0
		iter = 0
		while iter < times
			shift_left(arr)
			iter += 1
		end
		return arr
	end
	
	if offset < 0
		iter = 0
		while iter < times
			shift_right(arr)
			iter += 1
		end
		return arr
	end
	if offset == 0
		return arr
	end
	return "Your number of shifts needs to be an integer."
end

#SECOND SOLUTION
def my_rotate2(arr, offset=1)
	(offset % arr.length).times {arr.push(arr[0]).shift} if offset > 0
	(offset.abs % arr.length).times {arr.unshift(arr[-1]).pop} if offset < 0
	return arr
end

# FINAL SOLUTION
def my_rotate3(arr, offset=1)
	return arr.drop(offset % arr.length) + arr.take(offset % arr.length) if offset > 0
	return arr.drop(arr.length - (offset.abs % arr.length)) + arr.take(arr.length - (offset.abs % arr.length))
end

# Method that takes a string as an input, then finds which letters in the string that, if you split using that letter, will leave you with an array where all the elements are the same length.
def even_splitters(string)
	split_index = 0
	output_array = []
	while split_index < string.length
		flag = true
		string_array = string.split(string[split_index])
		string_array.shift if string_array[0] == ""
		left_iter = 0
		while left_iter < string_array.length - 1
			right_iter = left_iter + 1
			while right_iter < string_array.length
				if string_array[left_iter].length != string_array[right_iter].length
					flag = false
					break
					else
					right_iter += 1
				end
			end
			left_iter += 1
		end 
		output_array.push(string[split_index]) if flag == true && !output_array.include?(string[split_index])
		split_index += 1
	end
	output_array
end

# Method that, given an array, returns another array of only the unique elements from the first. Does not use the uniq method. e.g. unique([5, 5, 5, 5]) => [5], unique([1, 2, 1, 3, 3]) => [1, 2, 3]

def unique(arr)
	def excluding?(arg, array)
		bool = true
		iter = 0
		while iter < array.length
			bool = false if arg == array[iter]
			iter += 1
		end
		bool
	end
	output_array = []
	return output_array if arr.length == 0
	output_array[0] = arr[0]
	arr.each do |el|
		output_array << el if excluding?(el, output_array)
	end
	output_array
end

# Method that receives two arrays as arguments and returns a new array of arguments unique among both arrays (but not necessarily within the array it occurs). Maintains original (intra- and inter-array) order. e.g. all_uniqs([1, 1, 3, 6], [2, 3, 6]) => [1, 2] all_uniqs([1, 2, 3], [1, 2, 3]) => []
def all_uniqs(arr1, arr2)
	output_array = []
	return output_array if arr1.length == 0 && arr2.length == 0
	arr1.each do |el|
		output_array << el if excluding?(el, output_array) && excluding?(el, arr2)
	end
	arr2.each do |el|
		output_array << el if excluding?(el, output_array) && excluding?(el, arr1)
	end
	output_array
end

# Method that accepts a string as an argument and returns the slice of the word between the first and last vowels of that word. Returns an empty string if the word has less than 2 vowels. e.g. slice_between_vowels("serendipity") => "rendip", slice_between_vowels("train") => "", slice_between_vowels("dog") => ""
def slice_between_vowels(word)
	word_array = word.split("")
	iter1 = 0
	vowel_count = 0
	while iter1 < word_array.length
		vowel_count += 1 if word_array[iter1].downcase == "a" || word_array[iter1] == "e" || word_array[iter1] == "i" || word_array[iter1] == "o" || word_array[iter1] == "u"
		iter1 += 1
	end
	return "" if vowel_count == 0 || vowel_count == 1 or vowel_count == 2
	iter2 = 0
	while iter2 < word_array.length
		current_letter = word_array.shift
		break if current_letter.downcase == "a" || current_letter.downcase == "e" || current_letter.downcase == "i" || current_letter.downcase == "o" || current_letter.downcase == "u"
		iter2 += 1
	end
	iter3 = 0
	while iter3 < word_array.length
		current_letter = word_array.pop
		break if current_letter.downcase == "a" || current_letter.downcase == "e" || current_letter.downcase == "i" || current_letter.downcase == "o" || current_letter.downcase == "u"
		iter3 += 1
	end
	word_array.join
end

# Method that substitutes all five-letter words in its argument with "#####" and returns the result. Does not consider punctuation. e.g. redact_five_letter_words("long longer longest longy") => "long longer longest #####"
def redact_five_letter_words(str)
	def word_count(word)
	iter = 0
	letter_count = 0
		while iter < word.length
			letter_count += 1 if word[iter].downcase == "a" || word[iter].downcase == "b" || word[iter].downcase == "c" || word[iter].downcase == "d" || word[iter].downcase == "e" || word[iter].downcase == "f" || word[iter].downcase == "g" || word[iter].downcase == "h" || word[iter].downcase == "i" || word[iter].downcase == "j" || word[iter].downcase == "k" || word[iter].downcase == "l" || word[iter].downcase == "m" || word[iter].downcase == "n" || word[iter].downcase == "o" || word[iter].downcase == "p" || word[iter].downcase == "q" || word[iter].downcase == "r" || word[iter].downcase == "s" || word[iter].downcase == "t" || word[iter].downcase == "u" || word[iter].downcase == "v" || word[iter].downcase == "w" || word[iter].downcase == "x" || word[iter].downcase == "y" || word[iter].downcase == "z" || word[iter] == " "
			iter += 1
		end
	letter_count
	end
	word_array = str.split(" ")
	iter = 0
	while iter < word_array.length
		word_array[iter] = "#####" if word_count(word_array[iter]) == 5
		iter += 1
	end
	word_array.join(" ")
end
