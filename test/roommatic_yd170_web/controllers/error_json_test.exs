defmodule RoommaticYd170Web.ErrorJSONTest do
  use RoommaticYd170Web.ConnCase, async: true

  test "renders 404" do
    assert RoommaticYd170Web.ErrorJSON.render("404.json", %{}) == %{errors: %{detail: "Not Found"}}
  end

  test "renders 500" do
    assert RoommaticYd170Web.ErrorJSON.render("500.json", %{}) ==
             %{errors: %{detail: "Internal Server Error"}}
  end
end
