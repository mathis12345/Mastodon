# Mastodon

Zu beachtende Dinge:

1. Sie müssen dieses Script ausführen, aber davor noch diese Befehle ausführen:
- (Benutzername vom Server eingeben)
- (Passwort vom Server eingeben)
- sudo -i
- (Passwort vom Server eingeben)
- git clone https://github.com/mathis12345/Mastodon
- chmod 777 Mastodon/*
- cd Mastodon
- ./Mastodon.sh

2. Sie müssen, wenn das Script fertig ist, folgende Befehle manuell in das Terminal eingeben.

Befehle:
<Pre>
su - mastodon

cd live

RAILS_ENV=production bundle exec rake mastodon:setup
</Pre>

Nach dem dritten Befehl müssen Sie die angeforderten Daten angeben.
