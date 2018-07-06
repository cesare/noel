defmodule Noel.SlackToken do
  use Ecto.Schema
  import Ecto.Changeset
  alias Noel.SlackToken

  schema "slack_tokens" do
    field :name,               :string
    field :token,              :string, virtual: true
    field :encrypted_token,    :string
    field :encrypted_token_iv, :string
    field :description,        :string

    timestamps type: :utc_datetime, updated_at: false
  end

  @required_fields ~w(name token)a
  @optional_fields ~w(description)a
  def changeset(%SlackToken{} = slack_token, attrs) do
    slack_token
    |> cast(attrs, @required_fields ++ @optional_fields)
    |> validate_required(@required_fields)
    |> set_encrypted_token()
  end

  defp set_encrypted_token(changeset) do
    cleartext_token = get_field(changeset, :token)
    [encrypted_token, iv] = encrypt_token(cleartext_token)

    changeset
    |> put_change(:encrypted_token, encrypted_token)
    |> put_change(:encrypted_token_iv, iv)
  end

  defp encrypt_token(cleartext_token) do
    key = encryption_key()
    {:ok, {iv_bytes, encrypted_token_bytes}} = ExCrypto.encrypt(key, cleartext_token)

    iv = Base.url_encode64(iv_bytes)
    encrypted_token = Base.url_encode64(encrypted_token_bytes)
    [encrypted_token, iv]
  end

  defp encryption_key do
    base64_encryption_key = Application.get_env(:noel, :slack_token_encryption_key)
    {:ok, key} = Base.url_decode64(base64_encryption_key)
    key
  end
end
