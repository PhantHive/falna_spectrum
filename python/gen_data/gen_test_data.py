# THIS FILE GENERATE TEST DATA FOR BELL DUNJEONS RUNS
# DATA:
# run_id: higher is more recent
# floor: 1-50 (50 hardest stage)
# exp_gain: 1-999 (similar to Danmashi I to S stat) rarely xp can go up to 1300
# enemies_killed
# time_taken (in seconds)
# fatigue_lvl: 1-10 (10 most fatigued)
# timestamp: when the run was completed
import time
import numpy as np
from astropy.io import fits

def gen_test_data() -> None:

    total_runs: int = 1000
    data_seed: float = time.time()
    base_time: int = 10 * 60 * 1000 # 10 min in ms

    # DATA FOR CSV
    run_ids = np.zeros(1000, dtype=np.int64)
    floors = np.zeros(1000, dtype=np.int16)
    exp_gain = np.zeros(1000, dtype=np.float32)
    enemies_killed = np.zeros(1000, dtype=np.int64)
    times_taken = np.zeros(1000, dtype=np.float64)
    fatigue_lvl = np.zeros(1000, dtype=np.float32)
    timestamps = np.zeros(1000, dtype=np.float64)

    # variable init
    floors[0] = 0
    fatigue_lvl[0] = 1
    enemies_killed[0] = 5
    times_taken[0] = base_time
    timestamps[0] = base_time

    for i in range(1, total_runs):
        # have to create compute_fatigue, compute_floor, calc_xp_earnt, calc_nb_enemies and calc_time_taken
        pass

    # I => int16, K => int64, E=> float32, D => float64
    # Personal note: below is the low-level code to make the table. An easiest implementation exists with astropy.table
    cols = fits.ColDefs([
        fits.Column(name='run_id', format='K', array=run_ids),
        fits.Column(name='floor', format='I', array=floors),
        fits.Column(name='exp_gain', format='E', array=exp_gain),
        fits.Column(name='enemies', format='K', array=enemies_killed),
        fits.Column(name='times_taken', format='D', array=times_taken),
        fits.Column(name='fatigue_lvl', format='E', array=fatigue_lvl),
        fits.Column(name='timestamps', format='D', array=timestamps)
    ])

    hdu = fits.BinTableHDU.from_columns(cols)
    hdu.header['PROJECT'] = 'Falna Spectrum',
    hdu.header['FAMILY'] = 'Hestia'
    hdu.writeto('dataset/bell_runs.fits', overwrite=True)


