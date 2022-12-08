#!/bin/bash

cp /home/mastodon/live/dist/nginx.conf /etc/nginx/sites-available/mastodon

ln -s /etc/nginx/sites-available/mastodon /etc/nginx/sites-enabled/mastodon
