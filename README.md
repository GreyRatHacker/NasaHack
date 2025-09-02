# NASA-Hacking 🚀
Mit einer offiziellen Backdoor, der API!

Keinen Bock mehr auf deinen langweiligen Desktop? Dieses Skript hackt sich (legal!) in die NASA, zieht sich jeden Tag das "Astronomy Picture of the Day" und knallt es dir als Desktophintergrund rein. Vollautomatisch. Einmal einrichten, für immer staunen.

![2025-09-02 - The Horsehead and Flame Nebulas](https://github.com/user-attachments/assets/7c34eba7-6971-4248-a804-3cb45a42c6af)

Was das Ding tut:
Kontaktiert die NASA-API: Holt sich die Infos zum aktuellen Bild des Tages.

Lädt das Bild herunter: Speichert eine HD-Version in einem Ordner auf deinem Desktop.

Setzt das Wallpaper: Macht das neue Bild zu deinem Desktophintergrund.

Läuft automatisch: Einmal eingerichtet, läuft es jeden Tag von selbst.

# So richtest du es ein (in 5 Minuten)
Folge diesen Schritten und dein Desktop wird nie wieder derselbe sein.

# Schritt 1: Besorg dir den Zugangsschlüssel zur NASA
Wir brauchen einen API-Schlüssel. Das ist quasi deine persönliche ID-Karte für die NASA-Datenbank. Keine Sorge, das ist kostenlos und dauert eine Minute.

Geh auf die offizielle NASA API-Website. https://api.nasa.gov/

Fülle die paar Felder aus (Name, E-Mail) und klicke auf "Signup".

Du bekommst sofort einen API-Schlüssel angezeigt und auch per E-Mail zugeschickt. Kopier dir diesen Schlüssel, du brauchst ihn gleich.

<img width="1142" height="728" alt="image" src="https://github.com/user-attachments/assets/eab8bb50-00e3-4f91-b850-2f8d304834f1" />


# Schritt 2: Skript herunterladen & anpassen
Lade die Datei skript.ps1 aus diesem Repository herunter.

Erstelle einen Ordner, wo das Skript für immer leben soll. Zum Beispiel direkt auf deinem Desktop unter C:\Users\DEIN_BENUTZERNAME\Desktop\NasaBilder.

Verschiebe die skript.ps1-Datei in diesen neuen Ordner.

Öffne die skript.ps1-Datei mit einem beliebigen Texteditor (z.B. VS Code oder der normale Windows Editor).

Finde die Zeile $apiKey = "DEIN SCHLÜSSEL HIER" und ersetze DEIN_API_SCHLUESSEL_HIER mit dem Schlüssel, den du von der NASA bekommen hast. Speichern nicht vergessen!

<img width="915" height="221" alt="image" src="https://github.com/user-attachments/assets/de214519-37dc-4035-ba2c-2d9c3840256a" />


# Schritt 3: PowerShell die Erlaubnis geben (Einmalige Sache)
Windows ist von Natur aus misstrauisch und blockiert das Ausführen von Skripten. Das heben wir jetzt auf.

Öffne das Windows-Startmenü, tippe PowerShell ein.

Klicke mit der rechten Maustaste auf "Windows PowerShell" und wähle "Als Administrator ausführen".

Gib den folgenden Befehl ein und drücke Enter:

Set-ExecutionPolicy RemoteSigned

Bestätige die Frage mit J und drücke erneut Enter. Du kannst das Admin-Fenster jetzt schließen.

# Schritt 4: Der erste Testlauf
Jetzt testen wir, ob alles klappt.

Öffne eine normale PowerShell (nicht als Admin).

Navigiere zu dem Ordner, in dem dein Skript liegt. Beispiel:

cd Desktop\NasaBilder

Führe das Skript mit folgendem Befehl aus:

.\skript.ps1

Wenn alles geklappt hat, solltest du jetzt ein brandneues Weltraum-Wallpaper auf deinem Desktop sehen!

# Die Automagie: Tägliche Ausführung einrichten
Jetzt bringen wir dem PC bei, das jeden Tag von selbst zu tun.

Öffne die Windows Aufgabenplanung (einfach im Startmenü suchen).

Klicke rechts auf "Einfache Aufgabe erstellen...".

Name: Gib ihr einen coolen Namen, z.B. Nasa Wallpaper Updater.

Trigger: Wähle "Täglich" und lege eine Uhrzeit fest (z.B. morgens um 08:00).

Aktion: Wähle "Programm starten".

Bei "Programm/Skript" trägst du powershell.exe ein.

Bei "Argumente hinzufügen" kommt der wichtigste Teil rein. Gib hier den kompletten Pfad zu deiner Skript-Datei an, inklusive des -File Parameters. Beispiel:

-File "C:\Users\DeinName\Desktop\NasaBilder\skript.ps1"

<img width="449" height="277" alt="image" src="https://github.com/user-attachments/assets/d2f07e68-061c-4aff-87fc-200c4a5abf45" />

