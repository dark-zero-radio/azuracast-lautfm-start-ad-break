# AzuraCast laut.fm START_AD_BREAK

Automatic laut.fm START_AD_BREAK trigger for live DJ broadcasts and AutoDJ using AzuraCast and Liquidsoap.

## About

This project provides an automated solution for triggering the laut.fm `START_AD_BREAK` during live DJ broadcasts and AutoDJ operation.

The solution was developed and tested for **DARK ZERO RADIO** by **Paul Paradoxx**.

It is designed for radio stations using **AzuraCast** with **Liquidsoap** and is intended to automate the laut.fm advertising trigger without requiring the live DJ to manually trigger the break.

The automation runs directly on the **AzuraCast / Liquidsoap** side.

The live DJ can continue broadcasting normally while the START_AD_BREAK trigger is handled automatically in the background.

## What's New in This Version

- **No more cuts in the middle of a song.** When a break is due, it is started at the **next track change** – exactly between two songs.
- **Preloading.** As soon as the break is due, the `start_ad_break.mp3` is **preloaded** into the queue. When the track changes, it starts immediately without a delay or audio gap.
- **Live DJ and AutoDJ.** Track changes are detected in both modes (AutoDJ via `on_track`, live DJ via `on_metadata`).
- **Only one trigger per break.** A break cannot be triggered twice.
- **No duplicate titles after the break.** The switch uses `replay_metadata=false`, so the current title is not sent a second time after the break.
- **New default interval: 35 minutes (2100 seconds).**

## Why This Project?

During a live DJ broadcast, the laut.fm advertising trigger needs to be triggered correctly.

In practice, a DJ may forget to trigger the advertising break manually, or the DJ software being used may not provide a suitable way to automate the required laut.fm trigger.

At **DARK ZERO RADIO**, some DJs and moderators were also partially overwhelmed by having to manually trigger the advertising break during their live broadcasts.

A live DJ should be able to concentrate on the music, moderation and broadcast instead of having to remember an additional technical trigger.

This project moves the automation to the **AzuraCast / Liquidsoap** side.

The live DJ can continue broadcasting normally without having to reconnect the stream.

The solution is independent of the DJ software being used.

## Features

- Automatic laut.fm `START_AD_BREAK` triggering
- Break starts **at the next track change** – never in the middle of a song
- `start_ad_break.mp3` is **preloaded** as soon as the break is due (no gap, no delay)
- Works during LIVE DJ operation
- Works during AUTODJ operation
- Only **one** trigger per break (no double triggering)
- **No duplicate titles** after the break (`replay_metadata=false`)
- Automatic trigger at a configurable interval (default: 35 minutes)
- Designed for AzuraCast and Liquidsoap
- Independent of the DJ software being used
- No DJ stream reconnection required
- No manual START_AD_BREAK triggering required
- No separate START_AD_BREAK playlist required
- Uses a single `start_ad_break.mp3` file
- Uses a native Liquidsoap request queue
- Tested in the live operation of DARK ZERO RADIO

## How It Works

1. **Timer:** A small timer checks every second whether the configured interval has passed since the last break.
2. **Break due → preload:** When the interval has passed, the break is marked as *due* and `start_ad_break.mp3` is immediately pushed into a native Liquidsoap request queue. The file is now preloaded and ready.
3. **Wait for the next track change:** The script watches the track changes:
   - AutoDJ: via `on_track`
   - Live DJ: via `on_metadata`
   
   Only a **new** title counts (artist – title is compared with the previous one), so repeated metadata does not trigger anything.
4. **Track change → break starts:** At the next new title, the break is released. A `switch` changes to the ad break queue – but only if the file is fully loaded.
5. **Break running → reset:** When the `start_ad_break.mp3` starts, the timer is reset and the break is no longer due.
6. **Back to the program:** When the file has been played, the queue is empty and the switch automatically returns to the normal program (live DJ or AutoDJ).

Because the switch uses `track_sensitive=false` together with the release at the track change, the break starts exactly between two songs and does not cut into a song.

Because the switch uses `replay_metadata=false`, the current title is not sent again after the break, so there are no duplicate title entries.

## No START_AD_BREAK Playlist Required

A separate START_AD_BREAK playlist is **not required**.

The station only needs one MP3 file:

`start_ad_break.mp3`

The required Commercial Break MP3 has been included in this GitHub repository by **Paul Paradoxx / DARK ZERO RADIO**.

For **DARK ZERO RADIO**, this file is used as a short **Commercial Break** teaser.

We created the Commercial Break as an approximately **1 second long** audio teaser.

The purpose of the short Commercial Break teaser is to provide an audible transition when the `START_AD_BREAK` is triggered and to avoid the short audio gap that can otherwise occur during the transition.

At the current stage of development, the Commercial Break teaser is triggered **after the advertising break** rather than before it.

This is a known point for further development.

The intended behavior is for the Commercial Break teaser to be played **before the actual advertising block**, so that the listener hears the Commercial Break indication before the advertising starts.

Other stations can use their own **station teaser** or their own short Commercial Break audio for this purpose.

However, the file must be named exactly:

`start_ad_break.mp3`

This filename is required because it is referenced directly by the Liquidsoap configuration.

The Commercial Break MP3 included in this repository can be renamed to:

`start_ad_break.mp3`

before it is placed on the AzuraCast server.

The file is placed once on the AzuraCast server in the media directory of the corresponding station.

In simple terms:

**The Commercial Break MP3 is already included in this GitHub project → place it on your AzuraCast station → configure Liquidsoap → restart broadcasting → done.**

## LIVE and AUTODJ

The solution works in both operating modes:

- LIVE DJ
- AUTODJ

Track changes are detected in both modes:

- AutoDJ: `on_track` of the main program
- Live DJ: `on_metadata` of the live input

When a break is due, it is started at the next new title – no matter whether this title comes from the live DJ or from AutoDJ.

No separate configuration is required for LIVE and AUTODJ.

## DJ Software Independence

It does not matter which compatible broadcasting software the DJ uses.

For example:

- Mixxx
- VirtualDJ
- RadioBOSS
- Liquidsoap
- another compatible DJ or broadcasting application

For live DJs, the break is started at the next title change sent by the DJ software. The DJ software should therefore send title metadata (artist / title) to AzuraCast, which most broadcasting applications do by default.

## No Additional Work for DJs

The DJ does not need to:

- manually trigger START_AD_BREAK
- restart the DJ software
- reconnect the stream
- use a specific DJ application
- manage a START_AD_BREAK playlist
- remember the advertising interval during the live broadcast

The DJ can concentrate on:

- music
- moderation
- the live broadcast
- interaction with listeners

## Requirements

- AzuraCast
- Liquidsoap 2.4.x (developed and tested with 2.4.5)
- A working AzuraCast station
- A `start_ad_break.mp3` file available to the station
- laut.fm integration
- The DJ software should send title metadata (for the break in live operation)

Only **one `start_ad_break.mp3` file** is required.

A separate START_AD_BREAK playlist is **not required**.

## The Code (Public Version)

Replace **every** `YOUR_STATION` / `your_station` with your own station before use (see below).

```liquidsoap
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
```

The same code is also included in this repository as `dark_zero_start_ad_break.liq`.

## Installation

The code is intended to be added to the station's custom Liquidsoap configuration in AzuraCast:

**Station → Broadcasting → Edit Liquidsoap Configuration**

Insert the code in a custom section where both the `radio` source and the `live` input already exist (after the live input has been combined with the program and before the outputs / broadcasts).

### IMPORTANT: YOUR OWN RADIO STATION

Before using the code, replace:

`YOUR_STATION`

with the **name / identifier of your own AzuraCast radio station**.

`YOUR_STATION` is only a placeholder used in the public configuration.

It is **not** the station name of DARK ZERO RADIO and it is not a fixed value.

In simple terms:

**YOUR_STATION = YOUR OWN RADIO STATION**

The public configuration uses:

`/var/azuracast/stations/YOUR_STATION/media/start_ad_break.mp3`

You must replace `YOUR_STATION` with the identifier of **your own radio station**, for example:

`/var/azuracast/stations/my_radio/media/start_ad_break.mp3`

The exact identifier (short name) depends on your own AzuraCast installation.

The variable names (`your_station_...`), the IDs (`your_station_ad_break_queue`, `your_station_ad_break_switch`) and the log label (`YOUR_STATION_AD_BREAK`) can also be renamed to your own station name. They only have to be unique within your configuration.

### Basic Setup

1. Download or use the included `START_AD_BREAK.mp3` file from this repository.
2. Rename it to `start_ad_break.mp3` if necessary.
3. Place `start_ad_break.mp3` in the media directory of **your own AzuraCast station**.
4. Replace `YOUR_STATION` with the correct identifier of **your own radio station**.
5. Add the Liquidsoap code to the station's custom Liquidsoap configuration.
6. Save the configuration.
7. Restart the station's broadcasting / Liquidsoap process.
8. The automation runs automatically.

### Important

Do **not** leave `YOUR_STATION` unchanged.

AzuraCast installations can use different station names, paths and configurations.

Always check the paths used by your own installation before starting Liquidsoap.

## Configuration

The default interval is:

**2100 seconds = 35 minutes**

```liquidsoap
your_station_break_interval = 2100. # 35 Minuten (in Sekunden)
```

Examples:

- 5 minutes = 300 seconds
- 10 minutes = 600 seconds
- 15 minutes = 900 seconds
- 20 minutes = 1200 seconds
- 25 minutes = 1500 seconds
- 30 minutes = 1800 seconds
- 35 minutes = 2100 seconds
- 39 minutes = 2340 seconds

Only the interval needs to be changed when a different timing is required.

Please note: the interval defines when a break becomes **due**. The break itself starts at the next track change, so the actual time between two breaks is the interval plus the remaining time of the song that is playing at that moment.

For testing purposes, a shorter interval can be used temporarily.

## Log Messages

In the Liquidsoap log (label `YOUR_STATION_AD_BREAK`) you can follow the process:

- `Break fällig - Werbung vorgeladen, wartet auf Titelwechsel` – the break is due and the file has been preloaded
- `Titelwechsel (AutoDJ) - START_AD_BREAK wird gestartet` / `Titelwechsel (Live) - …` – the break is started at the track change
- `START_AD_BREAK läuft jetzt` – the file is playing, the timer has been reset

## laut.fm Integration

This project is specifically designed around the laut.fm `START_AD_BREAK` trigger.

The project does not replace laut.fm and does not modify the laut.fm service itself.

It provides an automation layer for the radio station's AzuraCast/Liquidsoap setup.

## Development and Testing

The project was originally developed for **DARK ZERO RADIO**.

Testing was performed during actual radio operation.

Particular attention was given to:

- starting the break exactly at the track change (no cut in the middle of a song)
- preloading the file (no gap, no delay)
- only one trigger per break
- no duplicate titles after the break
- live DJ and AutoDJ operation
- operation without reconnecting the DJ stream
- operation without a START_AD_BREAK playlist

The current public configuration uses a **35-minute interval**.

## Project

**Project:** DARK ZERO RADIO  
**Developer:** Paul Paradoxx  
**Year:** 2026

The project was developed for the DARK ZERO RADIO broadcasting environment and is being published as a reference implementation for AzuraCast/Liquidsoap users.

## Copyright and Usage

**© 2026 Paul Paradoxx / DARK ZERO RADIO**

This project and its code were created by **Paul Paradoxx**.

**Use, modification, redistribution or publication of this project or its source code is only permitted with prior explicit permission from the author.**

Redistribution or publication as your own project is not permitted without permission.

Removal of the copyright or author information is not permitted without permission.

The included Commercial Break audio file is also part of this project and is provided by **Paul Paradoxx / DARK ZERO RADIO**.

The audio file may not be redistributed, modified, published or used in another project without prior explicit permission from the author.

## Disclaimer

This project is provided for testing and use at the user's own responsibility.

The author is not responsible for problems caused by differences in AzuraCast configurations, Liquidsoap versions, server environments, station configurations or changes to the laut.fm service.

Always create a backup of your AzuraCast configuration before making changes to Liquidsoap.

## Credits

**DARK ZERO RADIO**  
**Paul Paradoxx**  
**2026**

AzuraCast and Liquidsoap are separate open-source projects and remain the property of their respective authors and projects.

This project is an independent contribution and is not an official AzuraCast or laut.fm project.
