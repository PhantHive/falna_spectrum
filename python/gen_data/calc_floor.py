from numpy.random import Generator

def compute_floor(rng: Generator, prev_floor: int, fatigue: float) -> int:
    fatigue_bias = fatigue / 10
    rand = rng.uniform()

    if rand <= fatigue_bias:
        if prev_floor == 0:
            return prev_floor
        return prev_floor-1

    if prev_floor == 50:
        return prev_floor

    return prev_floor+1