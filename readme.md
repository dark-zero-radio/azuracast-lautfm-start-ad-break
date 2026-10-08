## No START_AD_BREAK Playlist Required

A separate START_AD_BREAK playlist is **not required**.

The required MP3 file is already included in this GitHub repository:

`START_AD_BREAK.mp3`

The file is provided as part of this project and can be used as the Commercial Break audio for the automatic START_AD_BREAK trigger.

For **DARK ZERO RADIO**, this file is used as a short **Commercial Break** teaser.

We created the Commercial Break as an approximately **1 second long** audio teaser.

The purpose of the short Commercial Break teaser is to provide an audible transition when the `START_AD_BREAK` is triggered and to avoid the short audio gap that can otherwise occur during the transition.

At the current stage of development, the Commercial Break teaser is triggered **after the advertising break** rather than before it.

This is a known point for further development.

The intended behavior is for the Commercial Break teaser to be played **before the actual advertising block**, so that the listener hears the Commercial Break indication before the advertising starts.

Other stations can use their own **station teaser** or their own short Commercial Break audio for this purpose.

For use with the included Liquidsoap configuration, the file should be named exactly:

`start_ad_break.mp3`

The filename is required because it is referenced directly by the Liquidsoap configuration.

The MP3 file only needs to be placed once in the media directory of the corresponding AzuraCast station.

There is no need to create or maintain a separate START_AD_BREAK playlist.

In simple terms:

**The required Commercial Break MP3 is already included in this repository → place it in the AzuraCast station media directory → configure Liquidsoap → restart broadcasting → done.**

The automation then runs automatically in the background.
