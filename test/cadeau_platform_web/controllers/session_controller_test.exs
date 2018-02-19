defmodule CadeauPlatformWeb.SessionControllerTest do
  use CadeauPlatformWeb.ConnCase

  alias CadeauPlatform.Accounts
  describe "create" do

    test "user login with correct email but wrong password, returns invalid credentials", %{conn: conn} do
      user = insert(:user)
      params = %{"session" => %{"email" => "smith@gmail.com", "password" => "test1"} }

      response = conn
                 |> put_private(:plug_skip_csrf_protection, true)
                 |> post(session_path(conn, :create), params)

      assert get_flash(response, :error) == "Invalid Credentials"
    end

    test "user login with correct password but wrong email, returns invalid credentials", %{conn: conn} do
      user = insert(:user)
      params = %{"session" => %{"email" => "smith1@gmail.com", "password" => "test"} }

      response = conn
                 |> put_private(:plug_skip_csrf_protection, true)
                 |> post(session_path(conn, :create), params)

      assert get_flash(response, :error) == "Invalid Credentials"
    end

    test "user login with correct email and correct password, redirects to home page and has no errors", %{conn: conn} do
      user = insert(:user)
      params = %{"session" => %{"email" => "smith@gmail.com", "password" => "test"} }

      response = conn
                 |> put_private(:plug_skip_csrf_protection, true)
                 |> post(session_path(conn, :create), params)

      assert get_flash(response, :error) == nil
    end
  end

end
