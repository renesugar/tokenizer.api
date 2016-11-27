defmodule API.Repo.Schemas.Card do
  @moduledoc """
  Schema for sender cards.
  """
  use API.Web, :schema

  @primary_key false
  embedded_schema do
    field :type, :string, default: "card"
    field :number, :string
    field :expiration_month, :string
    field :expiration_year, :string
    field :cvv, :string
  end

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:number, :expiration_month, :expiration_year, :cvv])
    |> validate_required([:number, :expiration_month, :expiration_year, :cvv])
    |> validate_card_number(:number)
    |> validate_format(:cvv, ~r/^[0-9]{3,4}$/)
    |> validate_format(:expiration_month, ~r/^0[1-9]|1[0-2]$/)
    |> validate_format(:expiration_year, ~r/^20[12][0-9]$/)
  end
end
