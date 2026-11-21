# Discourse Custom Route

If a link to `/glossary` works inside Discourse but refreshing the page gives you a 404, the browser knows the route and the server doesn't. A theme component can register an Ember route, but it can't tell Rails what to do when someone opens that URL directly. This plugin tells Rails to serve the usual Discourse app at that path. Ember then hands the page to the theme component.

I wanted to keep the [dictionary](https://github.com/koloki-co/igkt-dictionary-theme-component) in a theme component without writing a separate plugin for the whole dictionary. The same setup works for other theme pages. This plugin adds no page content, redirects or data endpoints.

## Install and configure

You need a Discourse installation that allows custom server plugins. If your host manages plugin installation, ask them to install it. An admin cannot install this plugin through the theme importer.

1. On a `discourse_docker` install, open `containers/app.yml` in your Discourse Docker directory. In the `hooks` → `after_code` block, find the `exec` that runs in `$home/plugins`. Add this line to its `cmd` list, alongside the other plugin commands:

   ```yaml
   - git clone https://github.com/koloki-co/discourse-custom-route.git
   ```

2. From the Discourse Docker directory, run `./launcher rebuild app`. Use your container name if it isn't `app`.
3. Install and attach the theme component to the theme your visitors use. Find the path it registers. For [Multilingual Dictionary](https://github.com/koloki-co/igkt-dictionary-theme-component), it's `/dictionary`.
4. In **Admin → Settings**, search for `custom_route`. Add `/dictionary` to **Custom route paths**, then turn on **Custom route enabled**. To serve another theme page at `/resources`, add `/resources` as a separate entry. Add only paths that your theme components already register.
5. Open each URL directly in a new tab and refresh. If the page is public, try it signed out too. A 404 on a fresh visit usually means the server path isn't active. If Discourse opens but the expected page is missing, check that the component is attached to the active theme and that its client route matches the configured path.

Settings changes don't require a rebuild. Each path has one segment: a slash, a lowercase ASCII letter, then up to 62 lowercase ASCII letters, digits or hyphens. Existing routes and permalinks take precedence. The plugin leaves the site's login requirements in place. It serves HTML, including URLs with a trailing slash or query string, not JSON endpoints.

If you are upgrading from the single-path preview, add the previous path to **Custom route paths** after upgrading. The old setting is no longer used.

## Development

Version `v0.2.0` was tested on Discourse `2026.11.0-latest` (`9c72f9d3e93`), with the Resources example below and [Multilingual Dictionary `v0.4.0`](https://github.com/koloki-co/igkt-dictionary-theme-component/tree/v0.4.0). This is not a minimum-version claim. Run the request specs from the Discourse root with the plugin installed:

```sh
bin/rspec plugins/discourse-custom-route/spec/requests/discourse_custom_route/page_controller_spec.rb
```

## Try it without the dictionary

Use an isolated development forum where `/resources` is unused. From this repository, run `tar -czf /tmp/resources-theme.tar.gz -C examples/resources-theme .`. Upload that archive through **Themes and components → Install → From your device**, then attach **Resources route example** to the theme you're using.

1. Leave `/resources` out of **Custom route paths**. Open the forum home page and click **Resources** in the header. The page opens in the app. Refresh it and Discourse returns a 404.
2. Add `/resources` to **Custom route paths** and make sure **Custom route enabled** is on. Open `/resources` directly and refresh. You should see the Resources heading and the text from the theme component both times.
3. Remove `/resources` from the list and detach the example when finished. Leave any other configured paths in place.

## Licence

Code: [MIT](https://github.com/koloki-co/discourse-custom-route/blob/main/LICENSE), Niclas Andersson and contributors. This README is [CC BY-SA 4.0](https://creativecommons.org/licenses/by-sa/4.0/). Source: [koloki-co/discourse-custom-route](https://github.com/koloki-co/discourse-custom-route).
