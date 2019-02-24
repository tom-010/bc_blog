defmodule Article do

    def slug(name) do
        if name == nil do
            ""
        else 
            String.downcase(name)
        end

    end
end 