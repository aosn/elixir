defmodule MyString do
    def calculate(expr) do
        {lhs, tail} = _number_digits(_lstrip(expr), 0)
        [op | tail] = _lstrip(tail)
        {rhs, tail} = (_number_digits(_lstrip(tail), 0))
        _completed(tail)
        _calculate(lhs, op, rhs)
    end

    defp _calculate(lhs, ?+, rhs), do: lhs + rhs
    defp _calculate(lhs, ?-, rhs), do: lhs - rhs
    defp _calculate(lhs, ?*, rhs), do: lhs * rhs
    defp _calculate(lhs, ?/, rhs), do: lhs / rhs
    defp _calculate(_, op, _), do: raise "Unknown operator #{[op]}"

    ##
    ## accept one of the following:
    ##  * termination character(nil)
    ##  * termination whitespace
    ##
    defp _completed(nil),         do: :ok
    defp _completed(list),        do: _completed_helper(_lstrip(list))
    defp _completed_helper([]),   do: :ok
    defp _completed_helper(expr), do: raise "bad expression #{expr}"

    ##
    ## skip whitespace
    ##
    defp _lstrip([whitespace | tail])
    when whitespace in ' \t\r\n' do
        _lstrip(tail)
    end
    defp _lstrip(list), do: list

    ##
    ## number parser
    ## 
    ##  number  = digits, [".", digits, ["e" | "E", ["+" | "-"], digits]];
    ##  digits  = digit | digits digit
    ##  digit   = "0" | 1" | "2" | "3" | "4" | "5" | "6" | "7" | "8" | "9";
    ## 

    # integer parser
    defp _number_digits([], value) do
        {value, nil}
    end
    defp _number_digits([digit | tail], value)
    when digit in '0123456789' do
        _number_digits(tail, value*10 + digit - ?0)
    end
    defp _number_digits([?. | tail], value)
    do
        _number_after_point(tail, value, -1)
    end
    defp _number_digits([non_digit | tail], value) do
        {value, [non_digit | tail]}
    end

    # float parser
    defp _number_after_point([], value, _) do
        {value, nil}
    end
    defp _number_after_point([digit | tail], value, pow_minus)
    when digit in '0123456789' do
        _number_after_point(tail, value + (digit - ?0)*:math.pow(10,pow_minus), pow_minus-1)
    end
    defp _number_after_point([exp | tail], value, _)
    when exp in 'eE' do
        _number_after_exponent(tail, value, 0)
    end
    defp _number_after_point([non_digit | tail], value, _) do
        {value, [non_digit | tail]}
    end

    # float has exponent
    defp _number_after_exponent([], _value, _exp) do
        raise "syntax error after: E"
    end
    defp _number_after_exponent([?+ | tail], value, exp) do
        _number_after_exponent(tail, value, exp, 1)
    end
    defp _number_after_exponent([?- | tail], value, exp) do
        _number_after_exponent(tail, value, exp, -1)
    end
    defp _number_after_exponent([digit | tail], value, exp)
    when digit in '0123456789' do
        _number_after_exponent(tail, value, exp*10 + digit - ?0, 1)
    end
    defp _number_after_exponent([_non_digit | _tail], _value, _exp) do
        raise "syntax error after: E"
    end

    # float has exponent after sign
    defp _number_after_exponent([], value, exp, sign) do
        {value * :math.pow(10, exp*sign), nil}
    end
    defp _number_after_exponent([digit | tail], value, exp, sign)
    when digit in '0123456789' do
        _number_after_exponent(tail, value, exp*10 + digit - ?0, sign)
    end
    defp _number_after_exponent([non_digit | tail], value, exp, sign) do
        {value * :math.pow(10, exp*sign), [non_digit | tail]}
    end
end

# iex(1)> MyString.calculate('123 + 27')
# 150
# iex(2)> MyString.calculate('123 - 27')
# 96
# iex(3)> MyString.calculate('123 * 27')
# 3321
# iex(4)> MyString.calculate('123 / 27')
# 4.555555555555555
# iex(5)> MyString.calculate('123.0 / 2.7E1')
# 4.555555555555555
# iex(6)> MyString.calculate('123.0 / 2.7E+1')
# 4.555555555555555
# iex(7)> MyString.calculate('123.0 / 270.0E-1')
# 4.555555555555555
# iex(8)> MyString.calculate('  123+27    ')
# 150
# iex(9)> MyString.calculate('123.0 / 270E-1')
# ** (RuntimeError) bad expression E-1
#     StringsAndBinaries-4.exs:20: MyString.completed/1
#     StringsAndBinaries-4.exs:6: MyString.calculate/1
