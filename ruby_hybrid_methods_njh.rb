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
