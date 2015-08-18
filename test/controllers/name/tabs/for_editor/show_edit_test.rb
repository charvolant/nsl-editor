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
require 'test_helper'

class ShowEditTest < ActionController::TestCase
  tests NamesController
  setup do
    @name = names(:a_species)
  end

  test "should show edit tab if editor requests edit tab" do
    @request.headers["Accept"] = "application/javascript"
    get(:show,{id: @name.id,tab: 'tab_edit'},{username: 'fred', user_full_name: 'Fred Jones', groups: ['edit']})
    assert_response :success
    assert_select 'a#name-edit-tab', 'Edit', "Should show 'Edit' tab."
    assert_select 'form'
    assert_select 'select#name_name_type_id'
    assert_select 'select#name_name_status_id'
    assert_select 'select#name_name_rank_id'
    assert_select 'input#name_author_id'
    assert_select 'input#name_base_author_id'
    assert_select 'input#name_ex_base_author_id'
    assert_select 'input#name_ex_author_id'
    assert_select 'input#name_sanctioning_author_id'
  end

end

