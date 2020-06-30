defmodule Server.Accounts.SecureLinkGeneration do
    @moduledoc """
    Securely Generate a random string that is probablitistily unlikely to have been generated before.

    Note uses the MIT libraru.
    """
    use Puid, total: 1.0e100, risk: 10.0e100
    
end