@fft.pro

PRO FALNA_ANALYSIS
	DATA = MRDFITS('E:\PROG\15-IDL\falna_spectrum\idl\gen_data\dataset\bell_runs.fits', 1)
	
	fatigue_amplitudes = AMPLITUDE(DATA.fatigue)
	floor_amplitudes = AMPLITUDE(DATA.floor)
	
	N = N_ELEMENTS(DATA.fatigue)
	X = INDGEN(N)
	
	;PLOT,X, fatigue_amplitudes[0:499]
	;PLOT,X, floor_amplitudes[0:499]
	
	; save fatigue FFT
    SET_PLOT, 'PS'
    DEVICE, FILENAME='E:\PROG\15-IDL\falna_spectrum\idl\fft_analysis\spectrum\fatigue_fft.ps', /COLOR, XSIZE=25, YSIZE=12, /LANDSCAPE
    PLOT, X[0:499], fatigue_amplitudes[0:499], $
    TITLE='Fatigue FFT Spectrum', $
    XTITLE='Frequency k', $
    YTITLE='Amplitude', $
    POSITION=[0.1, 0.15, 0.95, 0.90], $
    /NORMAL
    DEVICE, /CLOSE
    SET_PLOT, 'WIN'

    ; save floor FFT
    SET_PLOT, 'PS'
    DEVICE, FILENAME='E:\PROG\15-IDL\falna_spectrum\idl\fft_analysis\spectrum\floor_fft.ps', /COLOR, XSIZE=25, YSIZE=12, /LANDSCAPE
    PLOT, X[0:499], floor_amplitudes[0:499], $
    TITLE='Floor FFT Spectrum', $
    XTITLE='Frequency k', $
    YTITLE='Amplitude', $
    POSITION=[0.1, 0.15, 0.95, 0.90], $
    /NORMAL
    DEVICE, /CLOSE
    SET_PLOT, 'WIN'
END