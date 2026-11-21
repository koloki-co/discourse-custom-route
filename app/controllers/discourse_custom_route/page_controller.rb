# frozen_string_literal: true
# SPDX-FileCopyrightText: 2026 Niclas Andersson and contributors
# SPDX-License-Identifier: MIT

module DiscourseCustomRoute
  class PageController < ::ApplicationController
    requires_plugin PLUGIN_NAME
    skip_before_action :check_xhr, only: :show

    def show
      render "default/empty"
    end
  end
end
