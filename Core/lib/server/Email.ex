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


//README

1) Please add mix ecto.create for deploy script
2) Please redeploy
3.5) Please syncrhonize script from SHIRA0 to Repo/Core
3) Please make sure email can be sent
4) Please make sure script runs on boot
5) Finish rest of system