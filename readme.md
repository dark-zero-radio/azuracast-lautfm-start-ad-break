# AzuraCast laut.fm START_AD_BREAK

Automatic laut.fm START_AD_BREAK trigger for live DJ broadcasts using AzuraCast and Liquidsoap.

## About

This project provides an automated solution for triggering the laut.fm `START_AD_BREAK` during live DJ broadcasts.

The solution was developed and tested for **DARK ZERO RADIO** by **Paul Paradoxx**.

It is designed for radio stations using **AzuraCast** with **Liquidsoap** and is intended to automate the laut.fm advertising trigger without requiring the live DJ to manually trigger the break.

The automation runs directly on the **AzuraCast / Liquidsoap** side.

The live DJ can continue broadcasting normally while the START_AD_BREAK trigger is handled automatically in the background.

## Why This Project?

During a live DJ broadcast, the laut.fm advertising trigger needs to be triggered correctly.

In practice, a DJ may forget to trigger the advertising break manually, or the DJ software being used may not provide a suitable way to automate the required laut.fm trigger.

At **DARK ZERO RADIO**, some DJs and moderators were also partially overwhelmed by having to manually trigger the advertising break during their live broadcasts.

A live DJ should be able to concentrate on the music, moderation and broadcast instead of having to remember an additional technical trigger.

This project moves the automation to the **AzuraCast / Liquidsoap** side.

The live DJ can continue broadcasting normally without having to reconnect the stream.

The solution is independent of the DJ software being used.

## Features

* Automatic laut.fm `START_AD_BREAK` triggering
* Designed for live DJ broadcasts
* Designed for AzuraCast and Liquidsoap
* Independent of the DJ software being used
* No DJ stream reconnection required
* No manual START_AD_BREAK triggering required
* No separate START_AD_BREAK playlist required
* Uses a single `start_ad_break.mp3` file
* Automatic trigger at a configurable interval
* Immediate trigger when switching between LIVE and AUTODJ
* Works during LIVE operation
* Works during AUTODJ operation
* Uses a native Liquidsoap request queue
* Tested in the live operation of DARK ZERO RADIO

## How It Works

The Liquidsoap extension monitors the current AzuraCast broadcast mode.

It detects whether the station is currently operating in:

* LIVE DJ mode
* AUTODJ mode

A `START_AD_BREAK` is triggered automatically when the mode changes.

In addition, the trigger is automatically repeated at the configured interval.

The default public version uses an interval of:

**25 minutes / 1500 seconds**

The interval can be changed to suit the requirements of the individual station.

The automation runs in the background and does not require the DJ to manually trigger the advertising break.

## No START_AD_BREAK Playlist Required

A separate START_AD_BREAK playlist is **not required**.

The station only needs one MP3 file:

`start_ad_break.mp3`

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

The file is placed once on the AzuraCast server in the media directory of the corresponding station.

After the file has been placed on the server and the Liquidsoap configuration has been installed, the automation handles the START_AD_BREAK automatically.

There is no need to create or maintain a separate START_AD_BREAK playlist.

In simple terms:

**Place the MP3 on the server → configure Liquidsoap → restart broadcasting → done.**

The automation then runs automatically in the background.

## LIVE and AUTODJ

The solution works in both operating modes:

* LIVE DJ
* AUTODJ

The automation also handles changes between:

* LIVE → AUTODJ
* AUTODJ → LIVE

When the operating mode changes, a `START_AD_BREAK` is automatically triggered.

No separate configuration is required for LIVE and AUTODJ.

## DJ Software Independence

It does not matter which compatible broadcasting software the DJ uses.

For example:

* Mixxx
* VirtualDJ
* RadioBOSS
* Liquidsoap
* another compatible DJ or broadcasting application

The START_AD_BREAK automation is handled on the **AzuraCast / Liquidsoap** side.

The DJ therefore does not need to use a specific DJ application.

The automation works independently of the software used for the actual DJ broadcast.

## No Additional Work for DJs

The main purpose of the automation is to remove the additional technical task from the DJ.

The DJ does not need to:

* manually trigger START_AD_BREAK
* restart the DJ software
* reconnect the stream
* use a specific DJ application
* manage a START_AD_BREAK playlist
* remember the advertising interval during the live broadcast

The automation runs in the background.

The DJ can concentrate on:

* music
* moderation
* the live broadcast
* interaction with listeners

## Requirements

* AzuraCast
* Liquidsoap 2.4.5 or compatible version
* A working AzuraCast station
* A `start_ad_break.mp3` file available to the station
* laut.fm integration

Only **one `start_ad_break.mp3` file** is required.

A separate START_AD_BREAK playlist is **not required**.

## Installation

The code is intended to be added to the station's custom Liquidsoap configuration in AzuraCast.

Before using the code, replace:

`YOUR_STATION`

with the actual station identifier used by the AzuraCast installation.

The path to the `start_ad_break.mp3` file must also exist on the station.

The public configuration uses:

`/var/azuracast/stations/YOUR_STATION/media/start_ad_break.mp3`

The `start_ad_break.mp3` file must be placed in the corresponding station media directory.

### Basic Setup

1. Place `start_ad_break.mp3` on the AzuraCast server.
2. Place it in the media directory of the appropriate station.
3. Replace `YOUR_STATION` with the correct station identifier.
4. Add the Liquidsoap code to the station's custom Liquidsoap configuration.
5. Save the configuration.
6. Restart the station's broadcasting / Liquidsoap process.
7. The automation runs automatically.

### Important

AzuraCast installations can use different station names, paths and configurations.

Always check the paths used by your own installation before starting Liquidsoap.

## Configuration

The default interval is:

**1500 seconds = 25 minutes**

Examples:

* 5 minutes = 300 seconds
* 10 minutes = 600 seconds
* 15 minutes = 900 seconds
* 20 minutes = 1200 seconds
* 25 minutes = 1500 seconds
* 30 minutes = 1800 seconds
* 35 minutes = 2100 seconds
* 39 minutes = 2340 seconds

Only the interval needs to be changed when a different timing is required.

For testing purposes, a shorter interval can be used temporarily.

The public version uses:

`1500.`

which corresponds to:

**25 minutes.**

## laut.fm Integration

This project is specifically designed around the laut.fm `START_AD_BREAK` trigger.

The purpose of the Liquidsoap automation is to provide a reliable way of initiating the trigger from the AzuraCast/Liquidsoap side while a live DJ is connected.

The project does not replace laut.fm and does not modify the laut.fm service itself.

It provides an automation layer for the radio station's AzuraCast/Liquidsoap setup.

## Live DJ Operation

The live DJ remains connected to AzuraCast while the automation is running.

The trigger is handled by Liquidsoap in the background.

The DJ therefore does not need to:

* reconnect the stream
* restart the DJ software
* manually trigger every advertising break
* use a specific DJ application
* manage a START_AD_BREAK playlist

The solution is intended to work independently of whether the DJ uses software such as Mixxx, RadioBOSS, VirtualDJ or another compatible broadcasting application.

The DJ can concentrate on the actual broadcast.

## Development and Testing

The project was originally developed for **DARK ZERO RADIO**.

Different trigger intervals were used during development and testing to verify the behavior of the automation.

Testing was performed during actual radio operation.

Particular attention was given to:

* reliable trigger execution
* live DJ connectivity
* LIVE/AUTODJ mode changes
* automatic interval triggering
* operation without reconnecting the DJ stream
* operation without a START_AD_BREAK playlist
* automatic operation using only the `start_ad_break.mp3` file

The current public configuration uses a **25-minute interval**.

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
