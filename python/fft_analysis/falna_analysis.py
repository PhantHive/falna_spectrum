import numpy as np
from astropy.io import fits
import matplotlib.pyplot as plt
from python.fft_analysis.fft import amplitude


def falna_analysis() -> None:
    data = fits.open(r'E:\PROG\\15-IDL\\falna_spectrum\\python\\gen_data\\dataset\\bell_runs-py.fits')
    table = data[1].data # to access bin table

    N: int = len(table.fatigue)
    X = np.arange(N)

    fatigue_amplitudes = amplitude(table.fatigue, N)
    floor_amplitudes = amplitude(table.floor, N)

    # plot save
    output_dir = r'E:\PROG\15-IDL\falna_spectrum\python\fft_analysis\spectrum'
    fig, ax = plt.subplots(figsize=(25, 12))
    ax.plot(X[:500], fatigue_amplitudes[:500])
    ax.set_title('Fatigue FFT Spectrum')
    ax.set_xlabel('Frequency k')
    ax.set_ylabel('Amplitude')
    fig.savefig(f'{output_dir}\\fatigue_fft-py.png', bbox_inches='tight')
    plt.close()

    fig, ax = plt.subplots(figsize=(25, 12))
    ax.plot(X[:500], floor_amplitudes[:500])
    ax.set_title('Floor FFT Spectrum')
    ax.set_xlabel('Frequency k')
    ax.set_ylabel('Amplitude')
    fig.savefig(f'{output_dir}\\floor_fft-py.png', bbox_inches='tight')
    plt.close()

falna_analysis()