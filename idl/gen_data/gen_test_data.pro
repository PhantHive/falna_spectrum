; THIS FILE GENERATE TEST DATA FOR BELL DUNJEONS RUNS
; DATA:
; run_id: higher is more recent
; floor: 1-50 (50 hardest stage)
; exp_gain: 1-999 (similar to Danmashi I to S stat) rarely xp can go up to 1300
; enemies_killed
; time_taken (in seconds)
; fatigue_lvl: 1-10 (10 most fatigued)
; timestamp: when the run was completed

;imports
@calc_fatigue.pro
@calc_floor.pro
@exec_floor.pro

PRO GEN_TEST_DATA
	TOTAL_RUNS = 1000
	DATA_SEED = 50
	BASE_TIME = 10 * 60 * 1000 ; 10 minutes in ms
	
	; DATA FOR CSV
	RUN_IDS = LONARR(1000)
	FLOORS = INTARR(1000)
	EXP_GAIN = FLTARR(1000)
	ENEMIES_KILLED = LONARR(1000)
	TIMES_TAKEN = DBLARR(1000)
	FATIGUE_LVL = FLTARR(1000)
	TIMESTAMPS = DBLARR(1000)
	
	FLOORS[0] = 0 ; init 
	FATIGUE_LVL[0] = 1 ; init
	ENEMIES_KILLED[0] = 5 ; init
	TIMES_TAKEN[0] = BASE_TIME
	TIMESTAMPS[0] = BASE_TIME
	
	; Struct IDL to prepare FITS
	; 0S => INT 16-bits, 0L => LONG 32-bit, 0.0 => FLOAT 32-bit, 0.0D => DOUBLE 64 BIT
	DATA_TO_FITS = REPLICATE({bell_runs, $
	    run_id:    0L,   $
	    floor:     0S,   $
	    exp_gain:  0.0,  $
	    enemies:   0L,   $
	    time_taken: 0.0D, $
	    fatigue:   0.0,  $
	    timestamp: 0.0D  $
	}, 1000)
	DATA_TO_FITS[0] = {bell_runs, run_id: RUN_IDS[0], floor: FLOORS[0], exp_gain: EXP_GAIN[0], enemies: ENEMIES_KILLED[0], time_taken: TIMES_TAKEN[0], fatigue: FATIGUE_LVL[0], timestamp: TIMESTAMPS[0]}
	
	FOR I=1,999 DO BEGIN
		RUN_IDS[I] = I ; RUN ID
		
		; compute current data
		FATIGUE_LVL[I] = COMPUTE_FATIGUE(DATA_SEED, FLOORS[I-1], FATIGUE_LVL[I-1])
		FLOORS[I] = COMPUTE_FLOOR(DATA_SEED, FLOORS[I-1], FATIGUE_LVL[I])
		EXP_GAIN[I] = CALC_XP_EARNT(DATA_SEED, FLOORS[I])
		ENEMIES_KILLED[I] = CALC_NB_ENEMIES(FLOORS[I], ENEMIES_KILLED[I-1])
		TIMES_TAKEN[I] = CALC_TIME_TAKEN(BASE_TIME, FLOORS[I], FATIGUE_LVL[I], ENEMIES_KILLED[I])
		TIMESTAMPS[I] = TIMESTAMPS[I-1] + TIMES_TAKEN[I] + 86400000
		
		DATA_TO_FITS[I] = {bell_runs, run_id: RUN_IDS[I], floor: FLOORS[I], exp_gain: EXP_GAIN[I], enemies: ENEMIES_KILLED[I], time_taken: TIMES_TAKEN[I], fatigue: FATIGUE_LVL[I], timestamp: TIMESTAMPS[I]}
	ENDFOR
	
	; DATA TO FITS
	HELP, DATA_TO_FITS[1]
	MWRFITS, DATA_TO_FITS, 'E:\PROG\15-IDL\falna_spectrum\gen_data\dataset\bell_runs.fits', /CREATE
	
	; DATA TO CSV
	;OPENW, LUN, 'E:\PROG\15-IDL\falna_spectrum\gen_data\dataset\bell_runs.csv', /GET_LUN
	;	PRINTF, LUN, 'run_id,floor,exp_gain,enemies,time_taken,fatigue,timestamp' ; header
	;	FOR I=0,999 DO BEGIN
	;		PRINTF, LUN, RUN_IDS[I], FLOORS[I], EXP_GAIN[I], ENEMIES_KILLED[I], TIMES_TAKEN[I], FATIGUE_LVL[I], TIMESTAMPS[I], FORMAT='(I0, ",", I0, ",", F0, ",", I0, ",", F0, ",", I0, ",", F0)'
	;	ENDFOR
	;CLOSE, LUN
	;FREE_LUN, LUN
END