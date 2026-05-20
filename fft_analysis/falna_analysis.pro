@fft.pro

PRO FALNA_ANALYSIS

	DATA = MRDFITS('E:\PROG\15-IDL\falna_spectrum\gen_data\dataset\bell_runs.fits', 1)
	
	fatigue_amplitudes = AMPLITUDE(DATA.fatigue)
	
	N = N_ELEMENTS(DATA.fatigue)
	X = INDGEN(N)
	
	PLOT,X, fatigue_amplitudes[0:499]
	
	floor_amplitudes = AMPLITUDE(DATA.floor)
	;PLOT,X, floor_amplitudes[0:499]

END