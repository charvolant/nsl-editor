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
class Tree::Workspace::Placement < ActiveType::Object
  include WorkspaceParentNameResolvable
  attribute :instance_id, :integer
  attribute :parent_element_link, :string
  attribute :excluded, :boolean
  attribute :username, :string

  validates :instance_id, presence: true
  validates :parent_element_link, presence: true
  validates :username, presence: true

  def place

    url = build_url
    payload = {instanceUri: instance_url,
               parentElementUri: parent_element_link,
               excluded: excluded}
    logger.info "Calling #{url} with #{payload}"
    raise errors.full_messages.first unless valid?
    RestClient.put(url, payload.to_json,
                   {content_type: :json, accept: :json})
  rescue RestClient::ExceptionWithResponse => e
    Rails.logger.error("Tree::Workspace::Placement error: #{e}")
    raise
  rescue => e
    Rails.logger.error("Tree::Workspace::Placement other error: #{e}")
    raise
  end


  def build_url
    Tree::AsServices.placement_url(username)
  end

  def instance_url
    url = Tree::AsServices.preferred_link_url(instance_id)
    Rails.logger.info "calling #{url}"
    response = RestClient.get(url, {content_type: :json, accept: :json})
    json = JSON.parse(response.body, object_class: OpenStruct)
    json.link
  rescue => e
    Rails.logger.error("Tree::Workspace::Placement error: #{e}")
    raise

  end

end
