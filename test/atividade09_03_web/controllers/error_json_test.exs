defmodule Atividade0903Web.ErrorJSONTest do
  use Atividade0903Web.ConnCase, async: true

  test "renders 404" do
    assert Atividade0903Web.ErrorJSON.render("404.json", %{}) == %{errors: %{detail: "Not Found"}}
  end

  test "renders 500" do
    assert Atividade0903Web.ErrorJSON.render("500.json", %{}) ==
             %{errors: %{detail: "Internal Server Error"}}
  end
end
