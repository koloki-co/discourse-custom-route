# frozen_string_literal: true
# SPDX-FileCopyrightText: 2026 Niclas Andersson and contributors
# SPDX-License-Identifier: MIT

# name: discourse-custom-route
# about: Serves the Discourse application shell at one configured path.
# version: 0.1.0
# authors: Niclas Andersson and contributors

enabled_site_setting :custom_route_enabled

module ::DiscourseCustomRoute
  PLUGIN_NAME = "discourse-custom-route"
end

after_initialize do
  require_relative "app/controllers/discourse_custom_route/page_controller"

  Discourse::Application.routes.append do
    custom_route = ->(request) do
      SiteSetting.custom_route_enabled && request.format.html? &&
        request.path_info.delete_suffix("/") == SiteSetting.custom_route_path
    end

    constraints(custom_route) do
      get "/:custom_route_slug" => "discourse_custom_route/page#show",
          format: false,
          constraints: { custom_route_slug: /[a-z][a-z0-9-]{0,62}/ }
    end
  end
end
