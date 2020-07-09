defmodule Server.Mailer do
    @moduledoc """
    Basic Wrapper for Email

    Note currently MUST have enviromental variable for sendgrid called "SENDGRID_API_KEY" otherwise email will have undefined behavior
    """
    use Bamboo.Mailer, otp_app: :server #We are loading config we set for server.
end
