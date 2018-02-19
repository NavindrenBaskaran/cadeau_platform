defmodule CadeauPlatformWeb.UserControllerTest do
  use CadeauPlatformWeb.ConnCase

  alias CadeauPlatform.Accounts

  describe "create" do

    test "Sucessfully signs up user and, assigns the user_id into session", %{conn: conn} do
      params = %{"user" => %{"email" => "navin25@gmail.com", "name" => "Navindren", "password" => "123",
                 "password_confirmation" => "123"} }

      response = conn
                 |> put_private(:plug_skip_csrf_protection, true)
                 |> post(user_path(conn, :create, params))

      assert get_session(response, :current_user_id) != nil
    end

    test "Invalid password confirmation, returns error", %{conn: conn} do
      params = %{"user" => %{"email" => "navin25@gmail.com", "name" => "Navindren", "password" => "12",
                 "password_confirmation" => "123"} }

      response = conn
                 |> put_private(:plug_skip_csrf_protection, true)
                 |> post(user_path(conn, :create, params))

      assert get_flash(response, :error) == "Error"
      assert get_session(response, :current_user_id) == nil
    end

    test "Already existing email, returns error", %{conn: conn} do
      params = %{"user" => %{"email" => "navin25@gmail.com", "name" => "Navindren", "password" => "123",
                 "password_confirmation" => "123"} }

     params2 = %{"user" => %{"email" => "navin25@gmail.com", "name" => "Nivan", "password" => "1234",
                "password_confirmation" => "1234"} }

       conn
       |> put_private(:plug_skip_csrf_protection, true)
       |> post(user_path(conn, :create, params))

      response = conn
                 |> put_private(:plug_skip_csrf_protection, true)
                 |> post(user_path(conn, :create, params2))

      assert get_flash(response, :error) == "Error"
      assert get_session(response, :current_user_id) == nil
    end

    test "Empty params, missing password", %{conn: conn} do
      params = %{"user" => %{"email" => "navin25@gmail.com", "name" => "Navindren", "password" => "",
                 "password_confirmation" => ""} }

      response = conn
                 |> put_private(:plug_skip_csrf_protection, true)
                 |> post(user_path(conn, :create, params))

      assert get_flash(response, :error) == "Error"
      assert get_session(response, :current_user_id) == nil
    end

    test "Empty params, missing email", %{conn: conn} do
      params = %{"user" => %{"email" => "", "name" => "Navindren", "password" => "123",
                 "password_confirmation" => "123"} }

      response = conn
                 |> put_private(:plug_skip_csrf_protection, true)
                 |> post(user_path(conn, :create, params))

      assert get_flash(response, :error) == "Error"
      assert get_session(response, :current_user_id) == nil
    end

    test "Empty params, missing name", %{conn: conn} do
      params = %{"user" => %{"email" => "navin25@gmail.com", "name" => "", "password" => "123",
                 "password_confirmation" => "123"} }

      response = conn
                 |> put_private(:plug_skip_csrf_protection, true)
                 |> post(user_path(conn, :create, params))

      assert get_flash(response, :error) == "Error"
      assert get_session(response, :current_user_id) == nil
    end
  end

end
