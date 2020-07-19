defmodule Server.Email do
  @moduledoc """
  Email module responsible for sending messages from SapphirePack
  """

  import Bamboo.Email

  def welcome_email(email, magic_link) do
    new_email
    |> to(email)
    |> from("magiclink@sapphirepack.org")
    |> subject("Your Magic Link")
    |> text_body(magic_link)
  end
end

