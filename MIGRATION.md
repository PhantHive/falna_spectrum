# Migration Steps
## 1. Local Backup
A local archive has been made out of the repo falna_spectrum/

## 2. Migration step by step
### `gen_test_data.pro` to `gen_test_data.py`

> Noticed architecture difference in the way to create FITS data

| IDL/GDL                                       | Python                                          |
|-----------------------------------------------|-------------------------------------------------|
| Structure REPLICATE → MWRFITS mandatory       | Numpy arrays → astropy ColDefs                  |
| FITS schema is defined by structures          | FITS schema is implicitly defined by the arrays |
| Types indicated at structure level (0L, 0.0D) | Types defined from numpy arrays                 |

## Function Equivalences

| IDL/GDL | Python | Notes                                                   |
|---------|--------|---------------------------------------------------------|
| `SYSTIME(1)` | `time.time()` | Unix timestamp en secondes                              |
| `RANDOMU(seed)` | `np.random.uniform()` |                                                         |
| `RANDOMN(seed)` | `np.random.normal()` |                                                         |
| `ALOG()` | `np.log()` | Log naturel                                             |
| `ALOG10()` | `np.log10()` |                                                         |
| `FLTARR(n)` | `np.zeros(n)` | Float 64-bit numpy array by default (vs float32 in IDL) |
| `N_ELEMENTS()` | `len()` |                                                         |
| `INDGEN(n)` | `np.arange(n)` |                                                         |
| `FFT()` | `np.fft.fft()` |                                                         |
| `ABS()` | `np.abs()` |                                                         |
| `MAX()` | `np.max()` |                                                         |
| `MEAN()` | `np.mean()` |                                                         |
| `MRDFITS()` | `astropy.io.fits.open()` |                                                         |
| `MWRFITS()` | `BinTableHDU.from_columns().writeto()` |                                                         |
| `PLOT()` | `plt.plot()` |                                                         |
| `OPLOT()` | `plt.plot()` | Reset not required with python                          |


## Known Migration Pitfalls

| Pitfall | IDL/GDL | Python |
|---------|---------|--------|
| Random seed | Modified in-place by GDL, shared across calls | `np.random.seed()` set once globally or use `rng = np.random.default_rng(seed)` |
| Integer division | Must force `/10.0` explicitly | Use `//` for int division, `/` always returns float |
| FOR loop bounds | `FOR I=0,24` → 25 iterations (inclusive) | `range(0, 25)` → 25 iterations (exclusive end) |