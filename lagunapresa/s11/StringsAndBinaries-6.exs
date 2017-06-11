defmodule MyString do
  @delimiter ". "
  def capitalize_sentences(src), do: src
      |> String.split(@delimiter)
      |> Enum.map(&String.capitalize/1)
      |> Enum.join(@delimiter)
end

# iex(1)> MyString.capitalize_sentences("oh. a DOG. woof. ")
# "Oh. A dog. Woof. "
