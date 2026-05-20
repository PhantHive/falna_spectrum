PRO FALNA_ANALYSIS

	DATA = MRDFITS('E:\PROG\15-IDL\falna_spectrum\gen_data\dataset\bell_runs.fits', 1)
	
	PRINT, DATA[0:4].fatigue

END