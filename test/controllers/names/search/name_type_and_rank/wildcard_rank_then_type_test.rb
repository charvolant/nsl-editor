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

class NameSearchForNameTypeAndRankWildcardRankThenTypeTest < ActionController::TestCase
  tests NewSearchController
  
  test "editor search for name type and rank wildcard rank then type test" do
    get(:search,{"search_from"=>"string", "query_string"=>"nr:* nt:*", "controller"=>"new_search", "action"=>"search"},
        {username: 'fred', user_full_name: 'Fred Jones', groups: ['edit']})
    assert_response :success
    assert_select "span#includes-common-cultivar-notice", true, "Should include common and cultivar"
    assert_select "div#search-summary-row", /100 names shown/, "Should find records"
  end

end

