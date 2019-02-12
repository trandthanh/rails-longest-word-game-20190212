require "application_system_test_case"

class GamesTest < ApplicationSystemTestCase
  test "Going to /new gives us a new random grid to play with" do
    visit new_url
    assert test: "New game"
    assert_selector "li", count: 10
  end

  test "Word cannot be built out of" do
    visit new_url
    fill_in "word", with: "Hello"
    click_on "Play"

    assert_text "can't be built out of"
  end

  test "Word not an english word" do
    visit new_url
    fill_in "word", with: "w"
    click_on "Play"

    assert_text "does not seem to be a valid English word..."
  end
end
