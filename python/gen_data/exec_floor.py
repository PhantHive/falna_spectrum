import numpy as np
from numpy.random import Generator

def calc_xp_earnt(rng: Generator, cur_floor: int) -> float:
    xp_max = 999
    xp = xp_max * np.log(cur_floor + 1) / np.log(51)

    jump_chance = 0.02
    rand = rng.uniform()

    if rand < jump_chance:
        xp *= 1.2

    return xp

def calc_nb_enemies(cur_floor: int, prev_enemies: int) -> float:
    max_enemies = 1000
    floor_enemies = prev_enemies + np.log(cur_floor * 5) / 4

    if floor_enemies > max_enemies:
        return max_enemies

    return floor_enemies

def calc_time_taken(base_time: float, cur_floor: int, fatigue: float, enemies: int) -> float:
    time = base_time * np.log(cur_floor + 1) * (1 + fatigue / 10) * (enemies / 5)
    return time