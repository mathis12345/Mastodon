#!/bin/bash

cp /home/mastodon/live/dist/mastodon-web.service /etc/systemd/system/

cp /home/mastodon/live/dist/mastodon-sidekiq.service /etc/systemd/system/

cp /home/mastodon/live/dist/mastodon-streaming.service /etc/systemd/system/

systemctl start mastodon-web

systemctl start mastodon-sidekiq

systemctl start mastodon-streaming

systemctl enable mastodon-web

systemctl enable mastodon-sidekiq

systemctl enable mastodon-streaming

systemctl status mastodon-web mastodon-sidekiq mastodon-streaming

systemctl start nginx

systemctl restart nginx

systemctl reload nginx

systemctl status nginx
