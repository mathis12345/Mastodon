# Mastodon

Zu beachtende Dinge:

1. Zuerst müssen sie als 'root - Benutzer' das Script "Mastodon_001.sh" ausführen, aber davor noch folgende Befehle manuell eingeben:

<Pre>
- (Benutzername vom Server eingeben)
- (Passwort vom Server eingeben)
- sudo -i
- (Passwort vom Server eingeben)
- apt install git
- git clone https://github.com/mathis12345/Mastodon
- chmod 777 Mastodon/*
- cd Mastodon
- ./Mastodon.sh
</Pre>
  
2. Sie müssen, wenn das Script fertig ist, folgende Befehle manuell in das Terminal eingeben.

Befehle:
<Pre>
su - mastodon

cd live

RAILS_ENV=production bundle exec rake mastodon:setup
</Pre>

Nach dem dritten Befehl müssen Sie die angeforderten Daten angeben.

Dann geben Sie folgende Befehle manuell ein:

<Pre>
exit

cd Mastodon

./Mastodon_002.sh
</Pre>

Dann geben Sie folgende Befehle wieder manuell ein:

<Pre>
cd

cd ..

cd etc

cd nginx

cd sites-available

nano mastodon
</Pre>

Nun müssen Sie in Zeile 19 und 28 das "exmample.com" mit Ihrer Domain austauschen, die Sie bei der Einrichtung von Mastodon festgelegt haben.

Außerdem müssen Sie noch in Zeile 37 und 38 das Zeichen "#" wegnehmen diese Zeilen wie folgt verändern:

Ursprünglich:
<Pre>
# ssl_certificate       /etc/letsencrypt/live/example.com/fullchain.pem;
# ssl_certificate_key   /etc/letsencrypt/live/example.com/privkey.pem;
</Pre>

Das erwünschte Ergebniss:
<Pre>
ssl_certificate       /etc/cert/example.crt;
ssl_certificate_key   /etc/cert/example.key;
</Pre>

Dann drücken Sie die Tastenkombination "Strg + x".
Dann drücken Sie die Taste "J".
Dann drücken Sie die Taste "Enter".

Dann geben Sie folgende Befehle manuell in das Terminal ein:

<Pre>
cd
  
cd Mastodon
  
./Mastodon_003.sh
</Pre>
