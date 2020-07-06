defmodule Server.Email do
    @moduledoc """
    Basic Wrapper for Email

    Note currently MUST have enviromental variable for sendgrid called "SENDGRID_API_KEY" otherwise email will have undefined behavior
    """

    @from_email Application.fetch_env!(:email, :from_email)
    @subject Application.fetch_env!(:email, :subject)

    def sendMagicLink(email, link) do
        SendGrid.Email.build()
        |> SendGrid.Email.add_to(email)
        |> SendGrid.Email.put_from(@from_email)
        |> SendGrid.Email.put_subject(@subject)
        |> SendGrid.Email.put_text(link)
        |> SendGrid.Mailer.send()
    end
end
