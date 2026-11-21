# Discourse Custom Route

Give a theme component's custom page a URL that visitors can open directly, bookmark or refresh. Discourse Custom Route serves the Discourse app shell at one configured path; the theme component still owns the page.

For example, a theme component might already open `/glossary` from a header link, but a fresh tab at the same URL gets a 404. This plugin bridges that gap. It doesn't add an Ember route, page content, redirects or data access.

**Status:** development preview, tested on a local Discourse checkout. No minimum supported Discourse version has been established.

## Install and configure

You need a Discourse installation that supports custom plugins and a theme component that already registers the matching Ember route. For `discourse_docker`, add this command to the existing `hooks.after_code` plugin install list in `containers/app.yml` (the list that runs in `$home/plugins`):

```sh
git clone https://github.com/koloki-co/discourse-custom-route.git
```

Rebuild with `./launcher rebuild app` from the Discourse Docker directory (use your container name if it isn't `app`). If the repository is private, the build also needs read access to it.

1. Choose an unused one-segment path such as `/glossary`. Use a lowercase ASCII letter first, followed by up to 62 lowercase letters, digits or hyphens. Existing server routes and permalinks take precedence.
2. Set `custom_route_path` to that path, matching the Ember route map exactly, and enable `custom_route_enabled`. Both settings are server-side. The plugin defaults to disabled with no path; changing these settings does not require a rebuild.
3. Open the configured URL directly in a fresh tab. An HTTP 200 alone only confirms the shell loaded; check that the intended theme page renders.

Only HTML navigation is supported. A trailing slash and query string are accepted; nested paths and JSON endpoints are not. Existing server routes and permalinks win, and the site's normal login requirements still apply.

## Development

With the repository installed or symlinked in a Discourse development checkout, run from the Discourse root:

```sh
bin/rspec plugins/discourse-custom-route/spec/requests/discourse_custom_route/page_controller_spec.rb
```

Keep changes limited to the server-side route. Frontend code, content and data belong in the consuming project.

## Licence

Code: [MIT](https://github.com/koloki-co/discourse-custom-route/blob/main/LICENSE), Niclas Andersson and contributors. This README is [CC BY-SA 4.0](https://creativecommons.org/licenses/by-sa/4.0/). Source: [koloki-co/discourse-custom-route](https://github.com/koloki-co/discourse-custom-route).
