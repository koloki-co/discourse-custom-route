# frozen_string_literal: true
# SPDX-FileCopyrightText: 2026 Niclas Andersson and contributors
# SPDX-License-Identifier: MIT

RSpec.describe DiscourseCustomRoute::PageController do
  describe "#show" do
    before do
      SiteSetting.custom_route_enabled = true
      SiteSetting.custom_route_path = "/sample-glossary"
    end

    it "serves the app shell on the configured path" do
      get "/sample-glossary/?q=example"

      expect(response).to have_http_status(:ok)
      expect(response.body).to include('id="main-outlet"')
    end

    it "leaves other and disabled paths to normal routing" do
      get "/another-glossary"
      expect(response).to have_http_status(:not_found)

      SiteSetting.custom_route_enabled = false
      get "/sample-glossary"
      expect(response).to have_http_status(:not_found)
    end

    it "only serves HTML" do
      get "/sample-glossary", headers: { "Accept" => "application/json" }
      expect(response).to have_http_status(:not_found)

      get "/sample-glossary.json"
      expect(response).to have_http_status(:not_found)
    end

    it "leaves existing permalinks in place" do
      Permalink.create!(url: "sample-glossary", external_url: "https://example.com/glossary")

      get "/sample-glossary"

      expect(response).to redirect_to("https://example.com/glossary")
    end

    it "respects the site's login requirement" do
      SiteSetting.login_required = true

      get "/sample-glossary"

      expect(response).to redirect_to("/login")
    end
  end
end
