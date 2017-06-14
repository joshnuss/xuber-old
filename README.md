# XUber

A uber-like app that uses [Phoenix Channels](http://www.phoenixframework.org/docs/channels) integrated with the browser's [Geolocation API](https://developer.mozilla.org/en-US/docs/Web/API/Geolocation).

When a browser connects to the channel, it can share it's position (latitude/longitude) with all other connected clients. When the position changes, all clients are notified. This is the basis for ridesharing and delivery tracking apps.

Caveat: in this demo, all clients connect to one coordinating process. In the real world, that won't scale. You'd need coordinators to work in a grid, each responsible for a specific region (like cell towers).

  * Install dependencies with `mix deps.get`
  * Install Node.js dependencies with `npm install`
  * Start Phoenix endpoint with `mix phoenix.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](http://www.phoenixframework.org/docs/deployment).

## Learn more

  * Official website: http://www.phoenixframework.org/
  * Guides: http://phoenixframework.org/docs/overview
  * Docs: https://hexdocs.pm/phoenix
  * Mailing list: http://groups.google.com/group/phoenix-talk
  * Source: https://github.com/phoenixframework/phoenix
