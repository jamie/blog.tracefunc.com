---
title: Subnautica Bases
created: 2021-06-03T17:09:10.116Z
modified: 2021-06-04T04:04:55.050Z
---

# Subnautica Bases

## Hull Integrity

Bases start at 10 integrity, and gain/lose based on construction.

- Foundation (2xT, 2xPB) grants +2, placed on sea floor.
- Reinforcement (3xT, 1xLI) grants +7, placed on a hull edge (blocks window, connectors)

Regular compartments, hatch, and window cost -1; glass compartments cost -2; vertical connectors cost -0.5.

- Multipurpose Room -1.25
- Observatory -3
- Moonpool -5
- Scanner Room -1
- Water Filtration Machine -1

## Power Generation

External power (solar, thermal) can transmit ~20m to a base, otherwise need to use Power Transmitters to hop connections, which have a 100m range. Internal power (bio, nuclear) is built in the centre of a multipurpose room. A power source can only power one base, but a base can be powered by more than one source.

Generation/use comparisons are in Energy Per Minute.

- Solar (2xQZ, 2xT, 1xCU): Stores 75 energy, generates based on time of day + depth. 15.3 EPM at peak (daylight, 0m depth), approx 200 energy/day. Drops to 12 EPM at 45m, 9 at 100m, 6 at 150m, and 3 at 200m. A day is 15 minutes, night is 5 minutes, and power collection is reduced around dawn/dusk.
- Thermal (5xT, 2xMag, 1xAGel): Stores 250 energy, generates based on water temperature, 1.32 EPM per degree above 25C. That is: 10 EPM at 33 degrees, 20 EPM at 40, 40 EPM at 55, 60 EPM at 71.
- Bioreactor (3xT, 1xWireKit, 1xLub): Stores 500 energy, generates 50 EPM while supplied with organic matter. Some good choices (high density, or easy collection - small items can fit 4) for energy are:
  - Acid Mushroom (210, small)
  - Creepvine Sample (210)
  - Bulbo Tree Sample (420) - farmed for 72 food + 90 water/tree
  - Marblemelon (420) - farmed for 36 food + 42 water/four plants
  - Small Marblemelon (280, small) - farmed for 33 food + 21 water/four plants
  - Bladderfish (210, small) - farmed for 20 water
  - Reginald (490, small) - farmed for 44 food
  - Oculus (630, small) - farmed for 30 food

- Nuclear (3xPB, 1xAdvWireKit, 1xPlasIngot): Stores 2500 energy, generates 250 EPM while supplied with Reactor Rods. A single reactor rod (1xT, 1xPB, 1xGlass, 3xUran) provides 20k energy.

## Power Draw

- Fabricator: 5 energy per use
- Battery Charger: 9 EPM per battery (up to 4), to battery capacity of 100 energy
- Power Cell Charger: 30 EPM per power cell (up to 2), to power cell capacity of 200 energy
- Modification Station: ? energy per use
- Water Filtration Machine: 51 EPM, requires 1600 energy going from empty to full
- Spotlight: 12 EPM
- Floodlight: 12 EPM
- Scanner Room: 30 EPM while scanning
  - Camera Drones: recharge at ?

## Useful Small Bases

### Shallow Waystation

Aiming for 100m or shallower, to still have efficient power. Can be deeper near a spire or something, with power relays.

Expected cost 19xT, 3xQZ, 3xCU, 1xAU, 1xTableCoral, additional storage at 2xT

- Multipurpose Room with Hatch
- Solar panel
- Fabricator
- Radio
- Interior Growbed, 4x Bulbo Trees or 16 Marblemelon
- Wall Storage
- Beacon

### Deep Waystation

As above, except:
- \- Solar Panels
- \+ Multipurpose Room (additional, for the power to not crowd out growbeds)
- \+ Bioreactor
- optional: a third multipurpose room + alien containment for breeding Oculus, as you can place 4 at a go for 2500 energy

### Recharger

Both the battery charger and power cell charger can suck up 400 energy on a charge, a 300 energy buffer ought to be sufficient for one duty cycle, but beyond that consider a full 400 for each charger.

- Solar Panel (2xT, 2xQZ, 1xCU)
- Battery Charger (1xT, 2xCU, 2xAG)
- Power Cell Charger (2xT, 3xAU, 2xAG, 2xRuby)

### Scanning Station

- Scanner Room (5xT, 2xCU, 1xAU, 1xTableCoral)

### Vehicle Bay

- Moonpool (10xT, 2xPB, 1xCreepvinePod)
- Depending on other modules, may need additional Foundation/Reinforcement

### Science Lab

I know I'll need one eventually. Multiple alien containment rooms, probably.



