---
title: Root Organizer
tags: [boardgame, gaming, wip]
created: 2020-04-08T03:41:13.753Z
modified: 2021-05-04T22:29:39.542Z
---

# Root Organizer

Organizing some 3d printed trays for [Root](https://boardgamegeek.com/boardgame/237182/root) to fit current expansions in the main box.

TODO: Use [this OpenSCAD library](https://github.com/IdoMagal/The-Boardgame-Insert-Toolkit/)!!!

### Measurements

Core box internals are 278x215mm, ~66mm depth. With the Otter card offer off on the long side of the box (sadly won't fit across a short edge, I'm totally considering trimming it a few mm), I can fit two rows of 95mm trays.

As to depth, faction boards/rules 20mm, single map 17mm, and 25mm-deep trays will actually fit everything inside.

### Tray Sizing

* Baseline 95mm long, 25mm deep, varying width as follows:
  * Cats - 60mm *
  * Birds - 40mm
  * Mice - 35mm
  * Vagabond - 40mm, better if bigger + has more dividers, also needs 8.5mm of cards
  * Lizard - 55mm
  * Otter - 35mm
  * Crow - 35mm
  * Mole - 55mm (or 70mm incl. cards, 27mm height) (5.5mm of cards)
  * Resin Clearing Markers - 90mm max
  * Exile Deck + Eyrie + Faction Overviews - 70mm
  * Dice
  * Shop Items
  * Tower/Raft
  * Tunnels - 102mm, awkward.
  * Alt. Exile Deck - 70mm
* Layout (275mm width x 2 rows of 95mm):
  * 275mm: Exile Deck, Cats, Birds, Mice, Otter, Crow
  * 270mm: Vagabond+Cards, Lizard, Mole, Clearing
    * Maybe could bump clearing another 5mm and squeeze in dice/shop around them? Also possible to flex on height? Still leaves tower/raft unaccounted for, and tunnels with nowhere to live.
    * Tunnels sideways need 30.2mm (so 31mm total height on trays) which would free up a lot of space restrictions. 35mm height would I think let us get clearing markers vertically. Yellow/red fit a 55mm tray but want a 45/50mm subdivision. Orange with a 35/60mm subdivision leaves plenty of room for dice/shop/tower/raft. That only bumps up overall width from current resin measure +20mm. Tunnels still an awkward item for inside a tray.

#### Round Two

Baseline 95mm long, 35mm deep, 2x 275mm rows

Overall 3x25, 3x35, 3x45 for factions+resin, 105, 70, 20? for remaining components. Still need to account for vagabond cards.

* Row 1, 270mm
  * Exile Deck + Eyrie + Faction Overviews - 70mm, could print 75mm and include shop items?
  * Cats - 45mm
  * Mole - 45mm
  * Birds - 35mm
  * Mice - 25mm
  * Otter - 25mm
  * Crow - 25mm
* Row 2, 255mm
  * Resin Clearing Markers - 45mm (!!!)
  * Lizard - 35mm
  * Vagabond - 25mm, but 35mm with a divider is better - 40mm for 9x figs, nesting trays for 12 ruin/16 start/16 influence (or maybe look into actual use, and one tray for 1 Vaga, with a lower tray for a 2 Vaga game?). Divider only needs to go part way, and then nesting tray can sit atop it.
  * Alt. Exile Deck - ~~70mm~~ 105mm TODO: Test this
    * Tunnels on top
    * Extra Dice in extra 35mm
  * Spare 20mm? TODO: Test this
    * Dice
    * Shop Items
    * Tower/Raft

### Round Three - Marauders and Hirelings

Need to account for two new factions, plus mercenaries. At this point worth considering deeper trays across two boxes. One box with factions (individual trays, plus all faction boards on top), speculating 25-26mm for faction boards gives 40mm tray depth (up from 35 in round two) _and_ not needing to account for clearings/decks/dice. Maybe swing hireling pieces, or trade extra height for clockwork player boards? Then the second box with both map boards, clearings, decks, dice, landmarks, etc. Keeping in mind that expansion boxes are not as deep as the main box. Push comes to shove maybe keep hirelings (and clockwork?) in the hireling box :)

### WIP TODOS

- Print alternate trays at 35mm height, re-measure factions? Also maybe consider switching from two rows @ 95mm to three rows at 65mm wide?
  - 10 total factions, warrior counts at 2x25, 3x20, 3x15, 2x10 - that's x155 total, box has capacity for 5.5mm per. Currently aiming to scale 3mm per, so cats would have 65mm by 75mm available. Slightly larger compared to Round 2's 45x95 (area 4875 vs 4275) and taller to boot.
    - 25 Cats/Lizards/(Duchy given lots of tokens)
    - 20 Birds/Rats
    - 15 Badgers/Crows/Otters
    - 10 Alliance/Vagabond
  - Also worth considering that Eyrie, Vagabond, Duchy, and Hundreds all have some cards - those plus Otter's card stand would be a nice-to-have to fit in the base box.
  - Finally, also consider the draft cards and mercenary mats - I don't think it's actually worth managing the space for distinct mercenary meeples (just repurpose the faction meeples), but unique mercenaries like the moose should be included. Maybe embiggen the Vagabond tray?
- Another idea: Splitting the box into a 3x3 grid makes each grid large enough to hold cards. This allows those that include cards (birds/rats/duchy/vagabond) to have their own cards in their tray, meeples and tokens on top; another tray for the actual deck + drafting cards, and a half-size tray for dice & global items
  - 10 factions + deck + dice/items implies splitting 3 fullsize trays to half size, might be easier to run 5x full size and 6x two-thirds size, 65x60.
  - And actually, looks like making one tray half-wide but double-tall (landscape) would be a good side for closed tunnels on the mountain map, while also holding other common components like dice, default items, etc.
- Figure out where subdivisions make sense inside trays, to separate the warriors/tokens.
- Measure up what impact we'd have putting the tunnel tokens alongside the edge of the box, beside the Otter's card holder, if we need to shrink tray lengths.


From various thinking above, best design currently looks like splitting the box area 3x3 to be individually big enough for the common card deck + drafting/setup cards, and factions that require cards to function, subdivided to appropriate sizes.

That would be Eyrie (leaders), Vagabond (vagabonds and quests), the Duchy (nobles), and Lord of Hundreds (moods), all of which have enough meeples and tokens to justify the large bin space.

That leaves the other 4 sections of primary subdivision to hold the remaining 6 factions, and common components (dice, landmarks, etc).

HOWEVER, there's no way we'll fit all the faction boards + maps in a single box anyway, so maybe it's better to just size factions as-needed, make sure we've got room in the core box for all the minis (incl. hirelings), and then leave an expansion box to manage the two maps and all the common components (hireling boards, resin clearing markers, both decks, etc).

### Component Measurements

Global
- 4 Dice
- 12 Items (sq)

Cards: 63x88mm

Lake/Mountain Maps
- 1 Ferry
- 1 Tower
- 6 Closed Paths

Buildings/Tokens 10.6/5mm thick
All factions: 1 VP token (18.3mm sq)

Marquise de Cat
- 25 Warriors (9mm, 16.7mm, 22mm)
- 27 Tokens: 18 buildings, 9 wood

Eyrie
- 20 Warriors (9mm, 18.1mm, 22mm)
- 7 Buildings
- 4 cards

Alliance
- 10 Warriors (9mm, 19.5mm, 19mm)
- 13 Tokens: 3 bases, 10 outrage

Vagabond
- 9 Meeples: 9 Vagabond Pawns (var.)
- 17 S items (sq)
- 8 R items (sq)
- 12 (14) Relationships (sq)
- 4 Ruins
- Many cards

Lizard Cult
- 25 Warriors (8.3mm, 17.5mm, 19.5mm)
- 16 Buildings

Riverfolk Company
- 15 Warriors (7.9mm, 16mm, 20mm)
- 9 Tokens
- 3 gems

Corvids
- 15 Warriors (9.2mm, 16.8mm, 19.2mm)
- 8 Tokens

The Duchy
- 29 Meeples: 20 warriors, 9 crowns
- 10 Tokens: 6 buildings, 3 tokens, 1 burrow (large)
- 9 cards

Keepers in Iron
- 15 Meeples: 15 warriors
- 21 Tokens: 12 relic, 3 caravan, 5 waystation, 1 mission

Lord of the Hundreds
- 21 Meeples: 20 warriors, 1 warlord
- 11 Tokens: 6 storage, 5 mob
- 8 cards
- 1 dice


