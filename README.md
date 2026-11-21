# Discourse Custom Route

If a link to `/glossary` works inside Discourse but refreshing the page gives you a 404, the browser knows the route and the server doesn't. A theme component can register an Ember route, but it can't tell Rails what to do when someone opens that URL directly. This plugin tells Rails to serve the usual Discourse app at that path. Ember then hands the page to the theme component.

I wanted to keep the [dictionary](https://github.com/koloki-co/igkt-dictionary-theme-component) in a theme component without writing a separate plugin for the whole dictionary. The same setup works for other theme pages. This plugin adds no page content, redirects or data endpoints.

## Install and configure

You need a Discourse installation that allows custom plugins. On a `discourse_docker` install, add this line to the existing `hooks.after_code` command list that runs in `$home/plugins`:

```sh
git clone https://github.com/koloki-co/discourse-custom-route.git
```

Run `./launcher rebuild app` from the Discourse Docker directory. Use your container name if it isn't `app`.

1. Install and attach the theme component that registers the client route. For the Multilingual Dictionary, that route is `/dictionary`.
2. In **Admin → Settings**, search for `custom_route`. Add `/dictionary` to **Custom route paths**, then turn on **Custom route enabled**. To serve another theme page at `/resources`, add `/resources` as another entry. The paths must match the routes the themes actually register.
3. Open each URL directly in a new tab and refresh it. Check that you see the theme's page, not just the Discourse header.

Settings changes don't require a rebuild. Each path has one segment: a slash, a lowercase ASCII letter, then up to 62 lowercase ASCII letters, digits or hyphens. Existing routes and permalinks take precedence. The plugin leaves the site's login requirements in place. It serves HTML, including URLs with a trailing slash or query string, not JSON endpoints.

If you are upgrading from the single-path preview, add the previous path to **Custom route paths** after upgrading. The old setting is no longer used.

## Development

This is a development version; no minimum supported Discourse version has been established. Run the request specs from the Discourse root with the plugin installed:

```sh
bin/rspec plugins/discourse-custom-route/spec/requests/discourse_custom_route/page_controller_spec.rb
```

## Licence

Code: [MIT](https://github.com/koloki-co/discourse-custom-route/blob/main/LICENSE), Niclas Andersson and contributors. This README is [CC BY-SA 4.0](https://creativecommons.org/licenses/by-sa/4.0/). Source: [koloki-co/discourse-custom-route](https://github.com/koloki-co/discourse-custom-route).
