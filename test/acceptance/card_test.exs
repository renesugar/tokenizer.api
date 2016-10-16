defmodule Tokenizer.Controllers.CardTest do
  use EView.AcceptanceCase,
    async: true,
    otp_app: :tokenizer_api,
    endpoint: Tokenizer.HTTP.Endpoint,
    repo: Tokenizer.DB.Repo

  alias Tokenizer.DB.Models.SenderCard

  @token_prefix "token"

  @card %SenderCard{
    number: "5591587543706253",
    expiration_month: "01",
    expiration_year: "2020",
    cvv: "160"
  }

  test "create card tokens" do
    assert %{
      "meta" => %{
        "code" => 201
      },
      "data" => %{
        "type" => "card",
        "token" => @token_prefix <> _,
        "token_expires_at" => _
      }
    } = "cards"
    |> post!(@card)
    |> get_body
  end
end
