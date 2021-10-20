---
title: PNP Tabletop Simulator
created: '2021-05-20T03:45:38.747Z'
modified: '2021-05-21T06:21:21.479Z'
---

# PNP Tabletop Simulator

A workflow for converting PDF print-and-play board game materials to something suitable for import to Tabletop Simulator.

### On Formats

If available, prefer to work with files created via [PnP Orc](https://github.com/waldeinburg/pnp-orc). The conceit for PnP Orc is print single sided, apply glue to the back of a page and fold in half, and that gives you a more card-like paper thickness. For our purposes, it means we get backs and fronts co-located on the same page, in an obvious order (no worries about reading card fronts left-to-right and matching backs right-to-left), and also it gives cards plenty of whitespace for easier auto-cropping.

On the Tabletop Simulator side, the only noteworthy mentions are decks and dice. For decks, the image format is a grid of cards in a 10x7 or smaller arrangement. As this image is piped directly into the game engine as a texture, it's got a limit of 4096x4096px, so a practical limit on card size is 409 by 585 if you want to support a full card deck - and it turns out that this is a reasonably good image quality regardless. For dice, there are templates provided in `\Steam\steamapps\common\Tabletop Simulator\Modding\Dice Templates` for supported sizes, just align and go.

### On Tools

I tend to do some trial and error with processing, so I like to run my ImageMagick tools via `convert`, but if you're feeling bold (or building up a script to re-run from original sources) `mogrifgy` does the same thing but writes back to the source file directly.

### Rule Boooks

I'm using a slightly modified version of [shrinkpdf](http://www.alfredklomp.com/programming/shrinkpdf) to compress print-quality documents. 300dpi has been good enough for me to keep very readable both on desktop and once imported to TS, and typically reduces file size by 95-99%.

### Decks

Prep work, pull up PDFs in Preview (MacOS) and do an initial pass rotating pages from there. Then, split the PDF into multiple JPEGs with imagemagick (note that imagemagick has order-sensitive options):

```bash
convert -quality 100 -density 300 -colorspace sRGB \
  "document.pdf" \
  "document-%02d.jpg"
```

Then, a pass with the real MVP: [multicrop](http://www.fmwconcepts.com/imagemagick/multicrop/) by Fred Weinhaus. This was a lifesaver when I was doing card scans myself (as it would also auto-rotate) but the  ORCPNP files I've been seeing go around recently just come out clean and beautiful. It only operates on one file at a time, so loops away:

```bash
for file in ted-sto-*.jpg; do \
  multicrop -d 20 $file $file
  rm $file
done
```

The `-d` flag will discard images smaller than the listed value (in either dimension), this is small enough that it will avoid picking up things like fold lines. By default multicrop will add an ordinal suffix, so it trucks along just fine. I work back identifying images based on the original PDF, so I clean up the jpeg pages as I go.

Next up is bucketing cards (either renaming, or foldering) - for cards with a common back it's one "deck" per cardback. Double-sided cards need two files in matching order. Cards with an irrelevant backing can just be grouped by size.

> A note on naming: There's tradeoffs on naming schemes - if your cards are numbered or you're mixing multiple sources in one deck (say, a base game + expansions), I usually just run with the naming that comes out of multicrop, as it's easier to split the initial deck on import into Tabletop Simulator. On the other hand, if you're dealing with multiples (say, resource cards) it can make sense to delete duplicates here and copy/paste to get the correct amount in TS and save some filesize in the raw image file.

If you've got crop (cut) marks and bleed to trim down, that's a straightforward pass through imagemagick again. Just figure out what size a proper crop is from any old image editor and adjust the following - recommend doing it from inside a folder, and using parent/sibling as a destination:

```bash
for file in *.jpg; do \
  convert $file -gravity Center -crop 800x800+0+0 ../$file
done
```

Composing cards for Tabletop Simulator is a two-step process. Firstly, downscaling to a standard size, and then assembling cards into a grid.

To downscale, we're going to use ImageMagick's shrink flag, with some nice round numbers that won't overflow the texture size even if we use it all. This will preserve aspect ratios and so is good for any size or shape of card (although if you've got landscape cards you'll want to add a `-rotate 90` and check the "Sideways" button when importing so they'll show up correctly in a player's hand).

(Again, I'm doing this in a folder, and pushing new files up a level.)

```bash
for file in *.jpg; do \
  convert $file -resize "400x575\^" ../$file
done
```

To actually assemble a file is a one-liner montage:

```bash
montage source-*.jpg -geometry +0+0 dest.jpg
```

ImageMagick is pretty good at laying things out, but if you've got a quirky number of images you can force the grid by adding `-tile 10x7` before the `-geometry` flag - just be aware of the size of image sheet you're importing. The `+0+0` business is to tell montage to not add any borders between images, as we want to let Tabletop Simulator pluck them out precisely (this helps avoid things like white edging on otherwise dark card images).

### Dice

Grab the appropriate templates from `\Steam\steamapps\common\Tabletop Simulator\Modding\Dice Templates` and use your favourite image editor to fill in the gaps. Note that if you want a solid bleed around the die edges you'll want to cover the full extent of the black outlines in the templates.

### Tiles & Tokens

Tabletop Simulator tokens and tiles are very similar, in that they can create objects with a bit of depth to them for various uses.

Tiles are double-sided and come in a fixed shape (rectangle, hex, circle), and can optionally stack.

Tokens have their art mirrored front-to-back, respect transparency, and can be imported standing up - great for standees or meeples. They can also optionally stack.

In both cases, we're looking for single file images: see if multicrop (above) will get you where you need to be, or manually crop them in an image editor. Pixel counts roughly match imported card decks: a 400px token will import roughly the same size as a 400px card. Dropping resolution on the image will save space, and you can always adjust object size once in-game.

TODO: Do smaller images actually import smaller objects? That's a good question.















