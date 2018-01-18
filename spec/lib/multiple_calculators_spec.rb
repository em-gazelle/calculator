require 'spec_helper'
require 'multiple_calculators'

RSpec.describe MultipleCalculators::ReversePolishNotation do
	let(:calculator) { MultipleCalculators::ReversePolishNotation }
    
    describe "calculate" do
        context 'when valid input' do
            it 'returns empty string when given no or empty input' do
            	expect(calculator.new(nil).calculate).to eq("")
            	expect(calculator.new("").calculate).to eq("")
            end
            it 'calculates correct total' do
            	expect(calculator.new("1 2 44 + -").calculate).to eq(-45.0)
            end
            it 'calculates correct total using order of operations' do
				expect(calculator.new("3 10 2 * - 3 2 * +").calculate).to eq(-11.0)
            end
            it 'handles numbers with decimals' do
				expect(calculator.new(".3 .5 .1 * +").calculate).to eq(0.35)
            end
            it 'handles negative numbers' do
				expect(calculator.new("1.5 -4 -3 -6 -2 / * + +").calculate).to eq(-11.5)
            end
        end
        context 'when invalid input type' do
            it 'returns error if it finds a non-numeric or non-operator  (+-*/.) in input string' do
				expect(calculator.new("4 1 @ 2 3 + - ").calculate).to eq("Invalid input -- please ensure all characters are numbers or operators (+, -, *, /)")
            end
            it 'returns error if user asks to divide by zero' do
				expect(calculator.new("3 0 5 * /").calculate).to eq("Invalid input -- cannot divide by zero")
            end
            it 'returns error if quantity of operators does not match expected quantity of numbers' do
				expect(calculator.new("8 1 3 4 + -").calculate).to eq("Invalid input -- quantity of operators do not match expected quantity of numbers")
				expect(calculator.new("3 4 * -2.5 / 8 * 2 / /").calculate).to eq("Invalid input -- quantity of operators do not match expected quantity of numbers")
            end
        end	
    end    
end
