require './lib/multiple_calculators'

class Calculate < Thor
	include MultipleCalculators

	desc "polish equation (write in string, separate each number/operator by one space)", "write equation in a string. calculates equation written in Polish Reverse Notation. Separate each number in a string / operator by a space. ONLY operators - + * / , no powers, etc."
	def polish(equation=nil)
		puts MultipleCalculators::ReversePolishNotation.new(equation).calculate
	end
end