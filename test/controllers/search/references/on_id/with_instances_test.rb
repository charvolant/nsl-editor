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

# Single search controller test.
class SearchRefsOnIdWithInstancesTest < ActionController::TestCase
  tests SearchController

  test "search on reference id with instances" do
    ref = references(:bucket_reference_for_default_instances)
    get(:search,
        { query_target: "reference",
          query_string: "id: #{ref.id} show-instances:" },
        username: "fred",
        user_full_name: "Fred Jones",
        groups: [])
    assert_response :success
    assert_select "#search-results-summary",
                  /36 records\b/,
                  "Should find 36 records"
  end
end
