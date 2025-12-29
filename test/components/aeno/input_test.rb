# frozen_string_literal: true

require "test_helper"

class Aeno::InputTest < ViewComponent::TestCase
  test "select renders options from block" do
    render_inline(Aeno::Input::Component.new(
      type: :select,
      name: "option",
      label: "Select Option"
    )) do |select|
      select.with_option(value: "1", label: "Option 1")
      select.with_option(value: "2", label: "Option 2")
      select.with_option(value: "3", label: "Option 3")
    end

    assert_selector "select[name='option']"
    assert_selector "option[value='1']", text: "Option 1"
    assert_selector "option[value='2']", text: "Option 2"
    assert_selector "option[value='3']", text: "Option 3"
  end

  test "checkbox_collection renders options from block" do
    render_inline(Aeno::Input::Component.new(
      type: :checkbox_collection,
      name: "options",
      label: "Select Options"
    )) do |checkboxes|
      checkboxes.with_option(value: "1", label: "Option 1")
      checkboxes.with_option(value: "2", label: "Option 2")
      checkboxes.with_option(value: "3", label: "Option 3")
    end

    assert_selector "input[type='checkbox'][value='1']"
    assert_selector "input[type='checkbox'][value='2']"
    assert_selector "input[type='checkbox'][value='3']"
    assert_selector "label", text: "Option 1"
    assert_selector "label", text: "Option 2"
    assert_selector "label", text: "Option 3"
  end

  test "toggle renders switch component" do
    render_inline(Aeno::Input::Component.new(
      type: :toggle,
      name: "enabled",
      label: "Enable Feature"
    ))

    assert_selector "input[type='checkbox'][name='enabled']"
    assert_selector "div.group.relative.inline-flex"
  end

  test "number renders with constraints" do
    render_inline(Aeno::Input::Component.new(
      type: :number,
      name: "quantity",
      label: "Quantity",
      value: 5
    ))

    assert_selector "input[type='number'][name='quantity'][value='5']"
  end

  test "otp renders boxes for digits" do
    render_inline(Aeno::Input::Component.new(
      type: :otp,
      name: "code",
      label: "Verification Code"
    ))

    assert_selector "div[data-controller='aeno--input--otp']"
    assert_selector "div[data-aeno--input--otp-target='box']", count: 6
    assert_selector "input[autocomplete='one-time-code']"
  end

  test "datepicker renders with controller" do
    render_inline(Aeno::Input::Component.new(
      type: :datepicker,
      name: "birth_date",
      label: "Birth Date"
    ))

    assert_selector "input[type='text'][name='birth_date']"
    assert_selector "input[data-controller='aeno--input--datepicker']"
  end

  test "phone renders with controller" do
    render_inline(Aeno::Input::Component.new(
      type: :phone,
      name: "phone",
      label: "Phone Number"
    ))

    assert_selector "input[type='tel'][name='phone']"
    assert_selector "input[data-controller='aeno--input--phone']"
  end
end
