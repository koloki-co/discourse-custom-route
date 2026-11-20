# IGKT dictionary route

Minimal Discourse plugin that serves the Ember application for `GET /dictionary`.

The word list and the dictionary page stay in the theme component at the root of this repository. This plugin does not fetch, store or bundle dictionary entries. Install steps are in the repository [README](../../README.md).

`required_version` in `plugin.rb` is Discourse 3.4.0. That is the version the theme JavaScript needs. The plugin will not start on an older forum.

`PATH` in `plugin.rb` and the theme file `javascripts/discourse/dictionary-route-map.js` must use the same path. Theme route maps are literal strings, so the path is not a site setting.
