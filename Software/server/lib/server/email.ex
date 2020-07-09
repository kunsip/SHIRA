defmodule Server.Email do
    import Bamboo.Email

    def welcome_email do

        new_email
        |> to("pmierau@posteo.net")
        |> from("magiclink@sapphirepack.org")
        |> subject("Welcome!!!")
        |> html_body("HTML HELLO")
        |> text_body("TEXT HELLO")
    end
end

