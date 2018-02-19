defmodule CadeauPlatform.AccountsTest do
  use CadeauPlatform.DataCase

  alias CadeauPlatform.Accounts

  describe "users" do
    alias CadeauPlatform.Accounts.User

    test "create_user/1 with valid data creates a user" do
      attrs = %{"email" => "hey123@gmail.com", "name" => "Hello", "password" => "123", "password_confirmation" => "123"}
      assert {:ok, %User{} = user} = Accounts.create_user(attrs)
    end

    test "create_user/1 with invalid password confirmation returns error changeset" do
      attrs = %{"email" => "hey123@gmail.com", "name" => "Hello", "password" => "123", "password_confirmation" => "12"}
      assert {:error, %Ecto.Changeset{}} = Accounts.create_user(attrs)
    end

    test "create_user/1 with invalid password returns error changeset" do
      attrs = %{"email" => "hey123@gmail.com", "name" => "Hello", "password" => "12", "password_confirmation" => "123"}
      assert {:error, %Ecto.Changeset{}} = Accounts.create_user(attrs)
    end

    test "create_user/1 with invalid email format returns error changeset" do
      attrs = %{"email" => "hey123gmail.com", "name" => "Hello", "password" => "12", "password_confirmation" => "123"}
      assert {:error, %Ecto.Changeset{}} = Accounts.create_user(attrs)
    end

    test "create_user/1 with missing name format returns error changeset" do
      attrs = %{"email" => "hey123gmail.com", "name" => "", "password" => "12", "password_confirmation" => "123"}
      assert {:error, %Ecto.Changeset{}} = Accounts.create_user(attrs)
    end

    test "authenticate_user/1 with valid credentials returns true" do
      user = insert(:user)
      user_id = user.id
      attrs = %{"email" => "smith@gmail.com", "password" => "test"}
      assert {true, user_id} = Accounts.authenticate_user(attrs)
    end

    test "authenticate_user/1 with invalid credentials returns false" do
      user = insert(:user)
      user_id = user.id
      attrs = %{"email" => "smith@gmail.com", "password" => "test1"}
      assert {false, user_id} = Accounts.authenticate_user(attrs)
    end

    test "authenticate_user/1 with non existing user credentials in db, returns false" do
      attrs = %{"email" => "smith@gmail.com", "password" => "test1"}
      assert false == Accounts.authenticate_user(attrs)
    end
  end
end
