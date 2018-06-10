# Method that returns a boolean indicating whether any two elements in the argument array sum to 0. two_sum_to_zero?([4, 2, 6]) => false. two_sum_to_zero?([-2, 5, 12, -3, 2]) => true
def two_sum_to_zero?(array)
    left_iter = 0
    while left_iter < array.length - 1
        right_iter = left_iter + 1
        while right_iter < array.length
            return true if array[left_iter] = -array[right_iter]
            right_iter += 1
        end
        left_iter += 1
    end
    return false
end

# Method that returns the integer remainder of its two arguments (i.e. what using the modulo operator would return).
def int_remainder(i_dividend, i_divisor)
	((i_dividend.to_f / i_divisor.to_f - i_dividend / i_divisor) * (i_divisor)).round
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

# Method that returns the one integer in an array that is even or odd while the rest are of opposite parity, e.g. oddball([1,2,3]) => 2, oddball([2,4,5,6] => 5)
def oddball(arr)
	counter = 1
	while counter < arr.length - 1
		return arr[counter - 1] if (arr[counter - 1] + arr[counter]).odd? && (arr[counter] + arr[counter + 1]).even?
		return arr[counter] if (arr[counter - 1] + arr[counter]).odd? && (arr[counter] + arr[counter + 1]).odd?
		return arr[counter + 1] if (arr[counter - 1] + arr[counter]).even? && (arr[counter] + arr[counter + 1]).odd?
		counter += 1
	end
	return "All elements have the same parity."
end

# Method that accepts an integer, n, as an argument and returns a string version of n, but with leading zeros such that the string is always 3 characters long. Assumes input is < 1000.
def three_digit_format(n)
	def digit_one(n)
		if (n/100 % 10 == 0)
			return 0
			else
			return (n/100 % 10)
		end
	end
	def digit_two(n)
		if (n/10 % 10 == 0)
			return 0
			else 
			return (n/10 % 10)
		end
	end
	def digit_three(n)
		if(n % 10 == 0) 
			return 0
			else 
			return (n % 10)
		end
	end
	a = digit_one(n).to_s
	b = digit_two(n).to_s
	c = digit_three(n).to_s
	return a << b << c
end

# Method that returns an array of the square numbers from 1 to n.
def square_number_filter(n)
	
	# make an an array of n elements with value 0
	switches_array = []
	num = 1
	while num <= n
		switches_array << 0
		num += 1
	end
		
	# loop inside a loop. inner loop flips an element odd to even or even to odd then jumps by a step idx wide, and idx grows by one each time inner loop runs
	idx = 1
	while idx <= n
		posit = idx
		while posit < n
			switches_array[posit] = switches_array[posit] + 1
			posit = posit + idx
		end
		idx += 1
	end
	
	# test each element for oddness, then store the position of odd elements in a new array, which will be the output
	r = 0
	output_array = []
	while r < n
		if switches_array[r].odd?
			output_array.push([r])
		end
		r += 1
	end
	
	output_array
end

# Method that accepts an array and a target sum (integer) as arguments and returns true if any two integers in the array sum to the target. Otherwise, it returns false. The array may only contain integers.
def two_sum(input_array, target_sum)
idx = 0
	while idx < input_array.length - 1
	n = idx + 1
		while n < input_array.length
		test_sum = input_array[idx] + input_array[n]
			if test_sum == target_sum
				return true
				else
				n +=1 
			end
		end
	idx +=1
	end
	return false
end

# Method that generates the first n Fibonacci numbers.
def fibs(n)
	fib_array = [0, 1]
	counter = 1
	while counter <= n - 2
		fib_array << fib_array[counter - 1] + fib_array[counter]
		counter += 1
	end
	fib_array
end

# Method that, given an array, returns another array of only the unique elements from the first. Does not use the uniq method. e.g. unique([5, 5, 5, 5]) => [5], unique([1, 2, 1, 3, 3]) => [1, 2, 3]
def unique(arr)
	def excluding?(int, array)
		bool = true
		iter = 0
		while iter < array.length
			bool = false if int == array[iter]
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

# Method that accepts two arguments: an array of integers and a target_product (an integer). Returns a boolean indicating whether any pair of elements in the array multiplied together equals that product. e.g. pair_product?([3, 1, 5], 15) => true
def pair_product?(arr, target_product)
	return false if arr.length == 0
	left_iter = 0
		while left_iter < arr.length - 1
			right_iter = left_iter + 1
			while right_iter < arr.length
				return true if arr[left_iter] * arr[right_iter] == target_product
				right_iter += 1
			end
			left_iter += 1
		end
		return false
end

# Method that takes an array of pairs (two-element arrays) and returns the pair with the greatest sum. e.g. largest_pair([[-4,0],[-2,-1],[-3,2]]) => [-3,2], largest_pair([[1,0]]) => [1,0]
def largest_pair(pairs_array)
	iter1 = 0
	sum_array = []
	while iter1 < pairs_array.length
		sum_array << pairs_array[iter1][0] + pairs_array[iter1][1]
		iter1 += 1
	end
	index_tag = 0
	iter2 = 0
	p sum_array
	while iter2 < sum_array.length - 1
		index_tag = iter2 + 1 if sum_array[iter2] < sum_array[iter2 + 1]
		iter2 += 1
	end
	pairs_array[index_tag]
end
