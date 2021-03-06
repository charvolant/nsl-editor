# frozen_string_literal: true
#   Copyright 2015 Australian National Botanic Gardens
#
#   This file is part of the NSL Editor.
#
#   Licensed under the Apache License, Version 2.0 (the "License");
#   you may not use this file except in compliance with the License.
#   You may obtain a copy of the License at
#
#   http://www.apache.org/licenses/LICENSE-2.0
#
#   Unless required by applicable law or agreed to in writing, software
#   distributed under the License is distributed on an "AS IS" BASIS,
#   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#   See the License for the specific language governing permissions and
#   limitations under the License.
#
require "test_helper"

# Single controller test.
class InstanceTabsNotesTest < ActionController::TestCase
  tests InstancesController
  setup do
    @triodia_in_brassard = instances(:triodia_in_brassard)
  end
  test "apc tab simple" do
    @request.headers["Accept"] = "application/javascript"
    get(:show,
        { id: @triodia_in_brassard.id,
          tab: "tab_apc_placement",
          "row-type" => "instance_as_part_of_concept_record" },
        username: "fred",
        user_full_name: "Fred Jones",
        groups: %w(APC edit))
    assert_response :success
    assert_select "h5", "Add Note", "Needs correct heading."
    assert_select "form#new_instance_note", true, "Needs insert form."
    assert_select "form#new_instance_note" do
      assert_select "select.instance-note-key-id-select", true, "Needs select."
      assert_select "option", 3, "Needs 3 options."
      assert_select "option", /\AAPC Comment\z/i, "Needs APC Comment option."
      assert_select "option", /\AAPC Dist.\z/i, "Needs APC Dist. option."
      assert_select "input#instance-note-create-btn", 1, "Needs create button."
    end
    assert_select "textarea.instance-note-value-text-area", true, "Needs text."
  end
end
