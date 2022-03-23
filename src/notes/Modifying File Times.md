---
title: Modifying File Times
created: '2021-11-14T00:24:56.673Z'
modified: '2021-11-14T02:43:59.762Z'
---

# Modifying File Times

I'm doing some format conversions on old home media, and want to (a) keep file timestamps on converted video, and (b) pull photo timestamps from the Exif data.

These commands may be MacOS-specific.

## Timestamps from File

- Read file timestamp: `GetFileInfo -d $file` (formatted `MM/DD/YYYY hh:mm:ss`)
- Write Created timestamp: `SetFile -d 'MM/DD/YYYY hh:mm:ss' $file` (`-m` for Modified date)
- Write Created+Modified timestamp: `touch -t [YY]YYMMDDhhmm[.ss] $file` (note: century and seconds optional)

Sample timestamp-modifier after bulk converting some video:

```bash
cd $SRCPATH
for file in *;
  do SetFile -d "$(GetFileInfo -d $file)" $DEST_PATH/$(echo $file | sed 's/.AVI/.mp4/');
done
```

Not 100% sure how it'll handle files with spaces, but quoting the last argument breaks any shell globs like `~` or `*`.

## Timestamps from EXIF

It's hard to find a tool to do this, the best I can glue together (`brew install exif`, `xpath` already exists on my system):

- Read photo EXIF timestamp: `exif -x $file | xpath -q -e "string(//Date_and_Time__Original_)"`

However, the formatting is weird (maybe an artifact of old EXIF?), looks like `YYYY:MM:DD hh:mm:ss`. So there's some more sed magic needed to format it compatible with SetFile (also, recursively looping subdirectories, and logging a little):

```bash
for dir in *; do
  cd $dir &&
  for file in *.{jpg,JPG}; do
    echo $dir/$file
    SetFile -d "$(exif -x $file | xpath -q -e "string(//Date_and_Time__Original_)" | sed -E "s/([0-9]+):([0-9:]+)/\2\/\1/" | sed "s/:/\//")" $file;
  done &&
  cd ..
done
```

