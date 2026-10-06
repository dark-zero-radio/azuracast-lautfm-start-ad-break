# AzuraCast laut.fm START_AD_BREAK

Automatic laut.fm START_AD_BREAK trigger for live DJ broadcasts using AzuraCast and Liquidsoap.

## About

This project provides an automated solution for triggering the laut.fm `START_AD_BREAK` during live DJ broadcasts.

The solution was developed and tested for **DARK ZERO RADIO** by **Paul Paradoxx**.

It is designed for radio stations using **AzuraCast** with **Liquidsoap** and is intended to automate the laut.fm advertising trigger without requiring the live DJ to manually trigger the break.

## Why This Project?

During a live DJ broadcast, the laut.fm advertising trigger needs to be triggered correctly.

In practice, a DJ may forget to trigger the advertising break manually, or the DJ software being used may not provide a suitable way to automate the required laut.fm trigger.

This project moves the automation to the **AzuraCast / Liquidsoap** side.

The live DJ can continue broadcasting normally without having to reconnect the stream.

The solution is independent of the DJ software being used.

## Features

- Automatic laut.fm `START_AD_BREAK` triggering
- Designed for live DJ broadcasts
- Designed for AzuraCast and Liquidsoap
- Independent of the DJ software being used
- No DJ stream reconnection required
- Automatic trigger at a configurable interval
- Immediate trigger when switching between LIVE and AUTODJ
- Uses a native Liquidsoap request queue
- Tested in the live operation of DARK ZERO RADIO

## How It Works

The Liquidsoap extension monitors the current AzuraCast broadcast mode.

It detects whether the station is currently operating in:

- LIVE DJ mode
- AUTODJ mode

A `START_AD_BREAK` is triggered automatically when the mode changes.

In addition, the trigger is automatically repeated at the configured interval.

The default public version uses an interval of:

**25 minutes / 1500 seconds**

The interval can be changed to suit the requirements of the individual station.

## Requirements

- AzuraCast
- Liquidsoap 2.4.5 or compatible version
- A working AzuraCast station
- A `start_ad_break.mp3` file available to the station
- laut.fm integration

## Installation

The code is intended to be added to the station's custom Liquidsoap configuration in AzuraCast.

Before using the code, replace:

`YOUR_STATION`

with the actual station identifier used by the AzuraCast installation.

The path to the `start_ad_break.mp3` file must also exist on the station.

### Important

AzuraCast installations can use different station names, paths and configurations.

Always check the paths used by your own installation before starting Liquidsoap.

## Configuration

The default interval is:

**1500 seconds = 25 minutes**

Examples:

- 10 minutes = 600 seconds
- 15 minutes = 900 seconds
- 20 minutes = 1200 seconds
- 25 minutes = 1500 seconds
- 30 minutes = 1800 seconds
- 35 minutes = 2100 seconds
- 39 minutes = 2340 seconds

Only the interval needs to be changed when a different timing is required.

## laut.fm Integration

This project is specifically designed around the laut.fm `START_AD_BREAK` trigger.

The purpose of the Liquidsoap automation is to provide a reliable way of initiating the trigger from the AzuraCast/Liquidsoap side while a live DJ is connected.

The project does not replace laut.fm and does not modify the laut.fm service itself.

It provides an automation layer for the radio station's AzuraCast/Liquidsoap setup.

## Live DJ Operation

The live DJ remains connected to AzuraCast while the automation is running.

The trigger is handled by Liquidsoap in the background.

The DJ therefore does not need to:

- reconnect the stream
- restart the DJ software
- manually trigger every advertising break
- use a specific DJ application

The solution is intended to work independently of whether the DJ uses software such as Mixxx, RadioBOSS, VirtualDJ or another compatible broadcasting application.

## Development and Testing

The project was originally developed for **DARK ZERO RADIO**.

Different trigger intervals were used during development and testing to verify the behavior of the automation.

Testing was performed during actual radio operation.

Particular attention was given to:

- reliable trigger execution
- live DJ connectivity
- LIVE/AUTODJ mode changes
- automatic interval triggering
- operation without reconnecting the DJ stream

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
