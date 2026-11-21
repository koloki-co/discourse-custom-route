# Discourse Custom Route

Serve the Discourse application shell at one unused URL so a theme component's client-side page can be opened directly, bookmarked or refreshed.

The plugin does not create the Ember route, render page content, redirect requests or fetch data. The theme component or other frontend code must register the matching path and provide the page. Normal site login requirements still apply.

## Install and configure

Install this repository as `plugins/discourse-custom-route` in a Discourse installation that supports custom plugins, then rebuild or restart Discourse as appropriate. This is a development version, not a published release.

1. Choose an unused one-segment path such as `/glossary`. Use a lowercase ASCII letter first, followed by up to 62 lowercase letters, digits or hyphens. Existing server routes and permalinks take precedence.
2. Set `custom_route_path` to that path, matching the Ember route map exactly, and enable `custom_route_enabled`. Both settings are server-side. The plugin defaults to disabled with no path; changing these settings does not require a rebuild.
3. Open the configured URL directly in a fresh tab. An HTTP 200 alone only confirms the shell loaded; check that the intended theme page renders.

Only HTML navigation is supported. A trailing slash and query string are accepted; nested paths and JSON endpoints are not.

## Development

With the repository installed or symlinked in a Discourse development checkout, run from the Discourse root:

```sh
bin/rspec plugins/discourse-custom-route/spec/requests/discourse_custom_route/page_controller_spec.rb
```

Keep changes limited to the server-side route. Frontend code, content and data belong in the consuming project.

## Licence

[MIT](LICENSE). Extracted from the original routing plugin by Niclas Andersson and contributors, with its attribution and Git history retained.
