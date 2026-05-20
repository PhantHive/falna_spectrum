import numpy as np
from numpy.typing import NDArray

def to_fft(arr: NDArray[np.floating], N: int) -> NDArray[np.floating]:
    arr_detrend = arr - np.mean(arr)
    signal = np.fft.fft(arr_detrend) / N
    return signal

def amplitude(arr: NDArray[np.floating], N) -> NDArray[np.floating]:
    complex_signal = to_fft(arr, N)
    return np.abs(complex_signal)