# Add sc0ty/subsync to linuxserver/bazarr

This script installs [sc0ty/subsync](https://github.com/sc0ty/subsync) into the [linuxserver/bazarr](https://hub.docker.com/r/linuxserver/bazarr) container on container startup, utilising the [linuxserver custom scripts](https://www.linuxserver.io/blog/2019-09-14-customizing-our-containers) function. If the [sc0ty/subsync](https://github.com/sc0ty/subsync) command is already installed, the installation portion of the script is ignored.

Using [sc0ty/subsync](https://github.com/sc0ty/subsync) v0.17.0.

## Usage

1. Set up the Docker container according to [linuxserver/bazarr](https://hub.docker.com/r/linuxserver/bazarr)'s instructions.
2. Download the `subsync.sh` script and place it into a directory. Ensure the script is executable using `chmod +x /path/to/script/directory/subsync.sh`.
3. Add `-v /path/to/script/directory:/custom-cont-init.d` if using Docker CLI **_OR_** `- /path/to/script/directory:/custom-cont-init.d:ro` if using compose.
4. Enter a [sc0ty/subsync](https://github.com/sc0ty/subsync) CLI command in bazarr -> Settings -> Subtitles -> Custom Post-Processing -> Command.
5. (Optional) Turn on Score Threshold to ensure the command only runs if the subtitle score is below a certain threshold. I recommend following the [TRaSH Guides](https://trash-guides.info/Bazarr/Tips/Bazarr-suggested-scoring/) if you wish to utilise this feature.

## Example

This is an example [sc0ty/subsync](https://github.com/sc0ty/subsync) CLI command that I use. This changes the name of the subtitle downloaded by bazarr to end in `.original.srt`. If the command is successful, then only the synced subtitle remains, with a naming format that bazarr will recognise. If, for whatever reason, [sc0ty/subsync](https://github.com/sc0ty/subsync) is unable to sync the subtitle, then the subtitle will keep the `.original.srt` extension. I personally blacklist these "unsyncable" subtitles and then delete them.

`mv '{{subtitles}}' '{{subtitles}}'.original.srt && subsync --cli --verbose 0 sync --ref-lang '{{episode_language_code3}}' --sub-file '{{subtitles}}'.original.srt --ref-file '{{episode}}' --out '{{directory}}'/'{{subtitles_language_code2_dot}}'.srt && rm '{{subtitles}}'.original.srt && mv '{{directory}}'/'{{subtitles_language_code2_dot}}'.srt '{{directory}}'/'{{episode_name}}'.'{{subtitles_language_code2_dot}}'.srt`

## Credits

[morpheus65535](https://github.com/morpheus65535/bazarr) \
[sc0ty](https://github.com/sc0ty/subsync) \
[linuxserver](https://hub.docker.com/r/linuxserver/bazarr) \
[michpas](https://github.com/michpas/bazarr-mod-subsync) \
[TRaSH-](https://github.com/TRaSH-/Guides)
