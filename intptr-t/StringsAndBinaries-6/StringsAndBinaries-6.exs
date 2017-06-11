defmodule MyString do
    def capitalize_sentences(str) do
        Enum.join(Enum.map(String.split(str,". "), &String.capitalize/1), ". ")
    end
end

# iex(1)> MyString.capitalize_sentences("Oh. a DOG. woof. ")
# "Oh. A dog. Woof. "