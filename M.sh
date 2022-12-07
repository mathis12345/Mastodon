systemctl start mastodon-web
systemctl start mastodon-sidekiq
systemctl start mastodon-streaming
systemctl enable mastodon-web
systemctl enable mastodon-sidekiq
systemctl enable mastodon-streaming
