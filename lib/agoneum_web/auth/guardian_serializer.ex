defmodule AgoneumWeb.GuardianSerializer do
  @moduledoc """
  Handles conversion to and from JWT
  """

  @behaviour Guardian.Serializer

  alias Agoneum.Account.User
  alias Agoneum.Repo

  @spec for_token(any()) :: {:ok, String.t} | {:error, String.t}
  def for_token(%User{} = user), do: {:ok, "User:#{user.id}"}
  def for_token(_), do: {:error, "Unknown resource type"}

  @spec from_token(String.t) :: {:ok, String.t} | {:error, String.t}
  def from_token("User:" <> id), do: {:ok, Repo.get(User, id)}
  def from_token(_), do: {:error, "Unknown resource type"}
end
