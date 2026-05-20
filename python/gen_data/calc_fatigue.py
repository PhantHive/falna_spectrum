from numpy.random import Generator

def compute_fatigue(rng: Generator, prev_floor: int, prev_fatigue: float) -> float:
    theta = 0.5
    mu = compute_mean_fatigue(prev_floor)
    sigma = 1.2

    fatigue = prev_fatigue + theta * (mu - prev_fatigue) + sigma * rng.normal()
    fatigue = max(fatigue, 0)

    return fatigue

def compute_mean_fatigue(prev_floor: float) -> int:
    mu = 1
    if 20 > prev_floor >= 10:
        mu = 2
    elif 30 > prev_floor >= 20:
        mu = 3
    elif 40 > prev_floor >= 30:
        mu = 4
    elif 50 > prev_floor >= 40:
        mu = 5

    return mu