module MultipleCalculators
	class ReversePolishNotation
		
		def initialize(expression=nil)
			if expression.nil? || expression.empty? 
				@answer = ""
			elsif expression.match(/[^[0-9|+|\-|*|\/|.|0| ]]/)
				@answer = "Invalid input -- please ensure all characters are numbers or operators (+, -, *, /)"
			else
				@expression = expression.split(" ")
			end
		end

		def calculate
			@first_operator ||= find_first_operator
			handle_operator_and_prior_two_numbers
			@first_operator = (operator?(@expression[@first_operator-1]) ? (@first_operator-1) : nil) unless @answer
			calculate unless @answer
			@answer
		end


		private

		def operator?(element)
			(element == "+") || (element == "-") || (element == "*") || (element == "/")
		end

		def handle_operator_and_prior_two_numbers
			unless @answer
				if (@expression[@first_operator] == "/") && (@expression[@first_operator-1].to_f == 0.0)
					@answer = "Invalid input -- cannot divide by zero"
				elsif (@first_operator-2) < 0
					@answer = "Invalid input -- quantity of operators do not match expected quantity of numbers"
				else
					evaluation_of_prior_two_nums_and_operator = @expression[@first_operator-2].to_f.method(@expression[@first_operator]).(@expression[@first_operator-1].to_f)
					beginning_index = (@first_operator-3)
					@expression = (beginning_index >= 0 ? @expression[0..beginning_index] : []) + [evaluation_of_prior_two_nums_and_operator] + (@expression[(@first_operator+1)..-1] || [])
				end
			end
		end

		def find_first_operator
			unless @answer
				@first_operator = @expression.index{|element| operator?(element)}
				if @first_operator.nil?
					if @expression.size == 1
						@answer = @expression.first
					else
						@answer = "Invalid input -- quantity of operators do not match expected quantity of numbers"
					end
				else
					if @expression[0..@first_operator].size >= 3
						@first_operator
					else
						@answer = "Invalid input -- quantity of operators do not match expected quantity of numbers"
					end
				end
			end
		end
	end
end