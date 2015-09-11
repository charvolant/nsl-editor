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

class NameQueryAppendToQueryFieldNameTagOptionsTradeTest < ActionController::TestCase
  tests SearchController # nonetheless, we are testing name features
  test "should have a trade option" do
    get(:index,{},{username: 'fred', user_full_name: 'Fred Jones', groups: ['edit']})
    assert_response :success
    assert_select 'ul.dropdown-menu.append-to-query-field' do
      assert_select "li a.append-to-query-field[data-value=Trade]",/\ATrade\z/, "Should have a capitalized Trade value"
    end
  end

end