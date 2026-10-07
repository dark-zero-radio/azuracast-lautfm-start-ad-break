# ============================================================
# YOUR_STATION
# PAUL PARADOXX 2026
# laut.fm START_AD_BREAK Schalter
# Liquidsoap 2.4.5
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
# ersetzen.
#
# ------------------------------------------------------------
# BETRIEB
# ------------------------------------------------------------
# - START_AD_BREAK alle 25 Minuten
# - sofortiger START_AD_BREAK bei LIVE <-> AUTODJ Wechsel
# - die vorhandene START_AD_BREAK Playlist wird nicht benötigt
#
# ============================================================


# ------------------------------------------------------------
# 1. Native Request-Queue definieren
# ------------------------------------------------------------

your_station_ad_break_queue =
    request.queue(id="your_station_ad_break_queue")


# ------------------------------------------------------------
# START_AD_BREAK Datei
# ------------------------------------------------------------

your_station_ad_break_file =
    "/var/azuracast/stations/YOUR_STATION/media/start_ad_break.mp3"


# ------------------------------------------------------------
# Zustand
# ------------------------------------------------------------

your_station_last_mode = ref("")
your_station_timer = ref(0.)


# ------------------------------------------------------------
# START_AD_BREAK auslösen
# ------------------------------------------------------------

def your_station_trigger_ad_break(mode) =

    your_station_ad_break_queue.push.uri(
        your_station_ad_break_file
    )

    log(
        level=2,
        label="YOUR_STATION_AD_BREAK",
        "START_AD_BREAK ausgelöst - Modus: #{mode}"
    )

end


# ------------------------------------------------------------
# Überwachung
# ------------------------------------------------------------

thread.run(
    every=1.,
    {

        if azuracast.live_enabled() then

            if your_station_last_mode() != "LIVE" then

                your_station_trigger_ad_break("LIVE")

                log(
                    level=2,
                    label="YOUR_STATION_AD_BREAK",
                    "START_AD_BREAK - LIVE"
                )

                your_station_last_mode := "LIVE"
                your_station_timer := 1500.

            elsif your_station_timer() <= 0. then

                your_station_trigger_ad_break("LIVE")

                log(
                    level=2,
                    label="YOUR_STATION_AD_BREAK",
                    "START_AD_BREAK TIMER - LIVE"
                )

                your_station_timer := 1500.

            else

                your_station_timer := your_station_timer() - 1.

            end

        else

            if your_station_last_mode() != "AUTODJ" then

                your_station_trigger_ad_break("AUTODJ")

                log(
                    level=2,
                    label="YOUR_STATION_AD_BREAK",
                    "START_AD_BREAK - AUTODJ"
                )

                your_station_last_mode := "AUTODJ"
                your_station_timer := 1500.

            elsif your_station_timer() <= 0. then

                your_station_trigger_ad_break("AUTODJ")

                log(
                    level=2,
                    label="YOUR_STATION_AD_BREAK",
                    "START_AD_BREAK TIMER - AUTODJ"
                )

                your_station_timer := 1500.

            else

                your_station_timer := your_station_timer() - 1.

            end
        end
    }
)


# ------------------------------------------------------------
# START_AD_BREAK vor Radio setzen
# ------------------------------------------------------------

radio = fallback(
    id="your_station_live_ad_break",
    track_sensitive=false,
    [
        your_station_ad_break_queue,
        radio
    ]
)


# ============================================================
# ENDE
# DARK ZERO RADIO
# PAUL PARADOXX 2026
# ============================================================
