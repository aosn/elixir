defmodule MyString do
    def center(list) do
        Enum.each(_center(list), &(IO.puts(&1)))
    end
    defp _center(list) do
        max_len = String.length(Enum.max_by(list, &String.length/1))
        Enum.map(list, fn e ->
            len = String.length e
            total_pad = max_len - len
            lpad = div(total_pad, 2)
            rpad = total_pad - lpad
            String.ljust(String.rjust(e, len + lpad), len + lpad + rpad)
        end)
    end
end

# iex(1)> MyString.center(["cat", "zebra", "elephant"])
#   cat   
#  zebra  
# elephant
# :ok

# iex(2)> MyString.center(["cat", "zebra∂", "elephant∂"])
#    cat   
#  zebra∂  
# elephant∂
# :ok