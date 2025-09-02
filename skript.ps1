# --- TEIL 1: VORBEREITUNG ---
# Hier definieren wir alle Variablen und stellen sicher, dass unser Zielordner existiert.

# Definiert den Ordner, in dem die Bilder gespeichert werden sollen.
# "$env:USERPROFILE" ist eine Systemvariable, die automatisch zum Ordner des aktuellen Benutzers führt (z.B. C:\Users\DeinName).
# Das macht das Skript für jeden Benutzer lauffähig.
$zielOrdner = "$env:USERPROFILE\Desktop\NasaBilder"

# Dein persönlicher API-Schlüssel von der NASA. Der Demo-Schlüssel hat Limits.
$apiKey = "DEIN SCHLÜSSEL HIER"

# Die vollständige URL, die wir anfragen. Sie besteht aus dem NASA-Endpunkt und unserem API-Schlüssel.
$apiUrl = "https://api.nasa.gov/planetary/apod?api_key=$apiKey"

# Überprüft, ob der Zielordner bereits existiert.
# Das "-not" kehrt das Ergebnis um. Die Bedingung ist also wahr, wenn der Pfad NICHT existiert.
if (-not (Test-Path $zielOrdner)) {
    # Wenn der Ordner nicht existiert, wird er hier erstellt.
    New-Item -ItemType Directory -Path $zielOrdner
}

# --- TEIL 2: DATENABRUF UND VERARBEITUNG ---
# Ein try-catch-Block fängt mögliche Fehler ab (z.B. keine Internetverbindung).
# Wenn ein Fehler im 'try'-Teil auftritt, springt das Skript zum 'catch'-Teil.
try {
    # Sendet die Anfrage an die NASA-API.
    # "Invoke-RestMethod" ist der PowerShell-Befehl, um mit APIs zu sprechen.
    # Er wandelt die JSON-Antwort der NASA automatisch in ein PowerShell-Objekt um, auf das wir leicht zugreifen können.
    $antwort = Invoke-RestMethod -Uri $apiUrl

    # Die NASA postet manchmal Videos. Wir wollen nur Bilder.
    # Hier prüfen wir, ob der "media_type" in der Antwort NICHT ("-ne") "image" ist.
    if ($antwort.media_type -ne "image") {
        # Wenn es kein Bild ist, wird das Skript mit "exit" sofort beendet.
        exit
    }

    # Bereinigt den Titel des Bildes, um ihn als Dateinamen verwenden zu können.
    # Dateinamen dürfen bestimmte Sonderzeichen nicht enthalten. "-replace" entfernt diese.
    $titel = $antwort.title -replace '[\\/:*?"<>|]', ''

    # Erstellt einen einzigartigen und sortierbaren Dateinamen aus dem aktuellen Datum und dem bereinigten Titel.
    # Format: "JJJJ-MM-TT - Titel des Bildes.jpg"
    $dateiname = "$(Get-Date -Format 'yyyy-MM-dd') - $titel.jpg"

    # Setzt den vollständigen Pfad inklusive Dateinamen für das neue Bild zusammen.
    $bildPfad = Join-Path -Path $zielOrdner -ChildPath $dateiname
    
    # Lädt das Bild von der in der API-Antwort enthaltenen HD-URL herunter.
    # "-Uri" ist die Quelle (das Bild im Internet).
    # "-OutFile" ist das Ziel (unsere erstellte Datei auf dem PC).
    Invoke-WebRequest -Uri $antwort.hdurl -OutFile $bildPfad

    
    # --- TEIL 3: HINTERGRUNDBILD SETZEN ---
    # Dieser Teil ist etwas komplexer, da PowerShell keinen direkten Befehl zum Ändern des Desktops hat.
    # Wir nutzen einen Trick und definieren eine kleine Funktion in der Programmiersprache C#.

    # Dieser String enthält den C#-Code. Das '@"..."@' erlaubt mehrzeilige Strings.
    $code = @"
    // Importiert notwendige Funktionen aus dem Windows-System.
    using System.Runtime.InteropServices;
    public class Wallpaper {
        // "SystemParametersInfo" ist eine alte Windows-Funktion, die Systemeinstellungen ändern kann, u.a. das Hintergrundbild.
        [DllImport("user32.dll", CharSet=CharSet.Auto)]
        private static extern int SystemParametersInfo (int uAction, int uParam, string lpvParam, int fuWinIni);
        
        // Unsere eigene, einfachere Funktion "Set", die nur den Bildpfad benötigt.
        public static void Set(string path) {
            // Ruft die Windows-Funktion mit den richtigen Parametern auf, um das Wallpaper zu setzen.
            // Die Zahl 20 steht für "SPI_SETDESKWALLPAPER".
            SystemParametersInfo(20, 0, path, 0x01 | 0x02);
        }
    }
"@
    # "Add-Type" kompiliert den C#-Code und macht ihn im weiteren Skriptverlauf nutzbar.
    Add-Type -TypeDefinition $code

    # Jetzt können wir unsere selbst erstellte "Wallpaper.Set"-Funktion aufrufen und ihr den Pfad zu unserem heruntergeladenen Bild übergeben.
    [Wallpaper]::Set($bildPfad)

} catch {
    # Wenn im 'try'-Block irgendein Fehler auftritt (z.B. API nicht erreichbar),
    # landet das Skript hier. In dieser Version wird der Fehler einfach ignoriert
    # und das Skript beendet sich stillschweigend.
}

