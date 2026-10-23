# ============================================================
# YOUR_STATION – START_AD_BREAK
# PAUL PARADOXX 2026
# laut.fm START_AD_BREAK Schalter
# Liquidsoap 2.4.x / AzuraCast
#
# ÖFFENTLICHE VERSION
#
# ------------------------------------------------------------
# URHEBERRECHT / NUTZUNG
# ------------------------------------------------------------
# © 2026 Paul Paradoxx / DARK ZERO RADIO
#
# Dieses Projekt wurde von Paul Paradoxx entwickelt.
#
# Nutzung, Weitergabe, Veränderung oder Veröffentlichung
# dieses Codes ist nur mit vorheriger ausdrücklicher
# Genehmigung des Erstellers gestattet.
#
# Eine Veröffentlichung oder Weitergabe als eigenes Projekt
# sowie die Entfernung des Urheberhinweises ist ohne
# Genehmigung nicht gestattet.
#
# ------------------------------------------------------------
# STATION
# ------------------------------------------------------------
# YOUR_STATION durch den eigenen AzuraCast-Stationsnamen
# (Kurzname der Station, z. B. im Medien-Pfad) ersetzen.
#
# ------------------------------------------------------------
# BETRIEB
# ------------------------------------------------------------
# - START_AD_BREAK alle 35 Minuten fällig (Intervall einstellbar)
# - die Werbung wird VORGELADEN, sobald der Break fällig ist
# - der Break startet erst beim NÄCHSTEN TITELWECHSEL
#   -> schneidet nicht mehr mitten in einen Song
# - funktioniert bei Live-DJ UND AutoDJ
# - nur EINE Auslösung pro Break (keine doppelte Auslösung)
# - keine doppelten Titel nach dem Break (replay_metadata=false)
# - keine START_AD_BREAK Playlist nötig
#
# ============================================================

your_station_ad_break_file  = "/var/azuracast/stations/YOUR_STATION/media/start_ad_break.mp3"
your_station_break_interval = 2100. # 35 Minuten (in Sekunden)

your_station_last_break = ref(time())
your_station_break_due  = ref(false)
your_station_play_now   = ref(false)
your_station_last_title = ref("")

your_station_ad_break_queue = request.queue(id="your_station_ad_break_queue")

your_station_main = radio

# Break startet: Zähler neu starten
your_station_ad_break_queue.on_track(
  synchronous=true,
  fun (_) -> begin
    your_station_break_due  := false
    your_station_last_break := time()
    log(level=2, label="YOUR_STATION_AD_BREAK", "START_AD_BREAK läuft jetzt")
  end
)

# Timer: Break fällig -> Werbung SOFORT VORLADEN (nicht erst beim Abspielen)
thread.run(
  every=1.,
  {
    if not your_station_break_due() and (time() - your_station_last_break()) >= your_station_break_interval then
      your_station_break_due := true
      your_station_play_now  := false
      your_station_ad_break_queue.push.uri(your_station_ad_break_file)
      log(level=2, label="YOUR_STATION_AD_BREAK", "Break fällig - Werbung vorgeladen, wartet auf Titelwechsel")
    end
  }
)

# Nur bei NEUEM Titel, nur EINMAL pro Break
def your_station_try_break(quelle, m) =
  titel = m["artist"] ^ " - " ^ m["title"]
  if titel != " - " and titel != your_station_last_title() then
    your_station_last_title := titel
    if your_station_break_due() and not your_station_play_now() then
      your_station_play_now := true
      log(level=2, label="YOUR_STATION_AD_BREAK", "Titelwechsel (#{quelle}) - START_AD_BREAK wird gestartet")
    end
  end
end

your_station_main.on_track(
  synchronous=true,
  fun (m) -> your_station_try_break("AutoDJ", m)
)

live.on_metadata(
  synchronous=true,
  fun (m) -> your_station_try_break("Live", m)
)

# Umschalten nur, wenn freigegeben UND Werbung fertig geladen ist.
# Ist die Werbung durch, ist die Queue leer -> automatisch zurück.
radio = switch(
  id="your_station_ad_break_switch",
  track_sensitive=false,
  replay_metadata=false,
  [
    ({your_station_play_now() and your_station_ad_break_queue.is_ready()}, your_station_ad_break_queue),
    ({true}, radio)
  ]
)

# ============================================================
# ENDE
# DARK ZERO RADIO
# PAUL PARADOXX 2026
# ============================================================
