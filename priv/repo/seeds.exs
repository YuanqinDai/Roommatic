# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     RoommaticYd170.Repo.insert!(%RoommaticYd170.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias RoommaticYd170.Geography.City
RoommaticYd170.Repo.insert!(%City{name: "Seattle", country: "USA"})
