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

class OnParentIdTest < ActiveSupport::TestCase

  test "on parent ID" do
    results, rejected_pairings,is_limited,focus_anchor_id,info = Name::AsSearchEngine.search("parent-id: #{names(:a_genus).id}")
    assert_equal results.class, Name::ActiveRecord_Relation, "Results should be a Name::ActiveRecord_Relation."
    assert_equal 7, results.size, "Expected 7 names."
  end

end


