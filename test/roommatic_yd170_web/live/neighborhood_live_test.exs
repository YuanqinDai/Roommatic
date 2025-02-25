defmodule RoommaticYd170Web.NeighborhoodLiveTest do
  use RoommaticYd170Web.ConnCase

  import Phoenix.LiveViewTest
  import RoommaticYd170.GeographyFixtures

  @create_attrs %{name: "some name"}
  @update_attrs %{name: "some updated name"}
  @invalid_attrs %{name: nil}

  defp create_neighborhood(_) do
    neighborhood = neighborhood_fixture()
    %{neighborhood: neighborhood}
  end

  describe "Index" do
    setup [:create_neighborhood]

    test "lists all neighborhoods", %{conn: conn, neighborhood: neighborhood} do
      {:ok, _index_live, html} = live(conn, ~p"/neighborhoods")

      assert html =~ "Listing Neighborhoods"
      assert html =~ neighborhood.name
    end

    test "saves new neighborhood", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/neighborhoods")

      assert index_live |> element("a", "New Neighborhood") |> render_click() =~
               "New Neighborhood"

      assert_patch(index_live, ~p"/neighborhoods/new")

      assert index_live
             |> form("#neighborhood-form", neighborhood: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#neighborhood-form", neighborhood: @create_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/neighborhoods")

      html = render(index_live)
      assert html =~ "Neighborhood created successfully"
      assert html =~ "some name"
    end

    test "updates neighborhood in listing", %{conn: conn, neighborhood: neighborhood} do
      {:ok, index_live, _html} = live(conn, ~p"/neighborhoods")

      assert index_live |> element("#neighborhoods-#{neighborhood.id} a", "Edit") |> render_click() =~
               "Edit Neighborhood"

      assert_patch(index_live, ~p"/neighborhoods/#{neighborhood}/edit")

      assert index_live
             |> form("#neighborhood-form", neighborhood: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#neighborhood-form", neighborhood: @update_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/neighborhoods")

      html = render(index_live)
      assert html =~ "Neighborhood updated successfully"
      assert html =~ "some updated name"
    end

    test "deletes neighborhood in listing", %{conn: conn, neighborhood: neighborhood} do
      {:ok, index_live, _html} = live(conn, ~p"/neighborhoods")

      assert index_live |> element("#neighborhoods-#{neighborhood.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#neighborhoods-#{neighborhood.id}")
    end
  end

  describe "Show" do
    setup [:create_neighborhood]

    test "displays neighborhood", %{conn: conn, neighborhood: neighborhood} do
      {:ok, _show_live, html} = live(conn, ~p"/neighborhoods/#{neighborhood}")

      assert html =~ "Show Neighborhood"
      assert html =~ neighborhood.name
    end

    test "updates neighborhood within modal", %{conn: conn, neighborhood: neighborhood} do
      {:ok, show_live, _html} = live(conn, ~p"/neighborhoods/#{neighborhood}")

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Neighborhood"

      assert_patch(show_live, ~p"/neighborhoods/#{neighborhood}/show/edit")

      assert show_live
             |> form("#neighborhood-form", neighborhood: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert show_live
             |> form("#neighborhood-form", neighborhood: @update_attrs)
             |> render_submit()

      assert_patch(show_live, ~p"/neighborhoods/#{neighborhood}")

      html = render(show_live)
      assert html =~ "Neighborhood updated successfully"
      assert html =~ "some updated name"
    end
  end
end
