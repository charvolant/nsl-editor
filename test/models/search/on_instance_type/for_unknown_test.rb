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
load "models/search/users.rb"

# Single instance model test.
class ForInstanceTypeUnknown < ActiveSupport::TestCase
  test "instance type search for unknown" do
    search = Search::Base
             .new(ActiveSupport::HashWithIndifferentAccess
                  .new(query_string: "type: [unknown]",
                       query_target: "Instance",
                       current_user: build_edit_user))
    assert_equal Instance::ActiveRecord_Relation,
                 search.executed_query.results.class,
                 "Results should be an Instance::ActiveRecord_Relation"
    assert search.executed_query.results.size.positive?,
           "At least one record expected."
  end
end