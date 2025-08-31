from math import ceil

# craft_count, craft_ticks = 603, 127  # superdense inf
# craft_count, craft_ticks = 301, 127  # superdense tr
craft_count, craft_ticks = 200, 200  # eternal singularity

spacetime_cycles = 3

ticks_left = 100 * 20
additional_ticks = spacetime_cycles * 30 * 20
total_crafts = 0
for ticks, mult in [(50, 1), (20, 2), (0, 4)]:
    if ticks == 0:
        ticks_left = additional_ticks
    crafts = ceil((ticks_left - ticks * 20) / craft_ticks)
    ticks_left -= crafts * craft_ticks
    if ticks_left in [50 * 20, 20 * 20]:
        # in case of recipe is starts right after mult mode change
        crafts += 1
        ticks_left -= craft_ticks
    total_crafts += crafts * mult
total = total_crafts * craft_count
print(f"{total=}")