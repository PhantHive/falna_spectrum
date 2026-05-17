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

PRO GENERATE_DATA_TEST
	TOTAL_RUNS = 1000
	DATA_SEED = LONG(SYSTIME(1))
	BASE_TIME = 10 * 60 * 1000 ; 10 minutes in ms
	
	; DATA FOR CSV
	RUN_IDS = FLTARR(1000)
	FLOORS = FLTARR(1000)
	EXP_GAIN = FLTARR(1000)
	ENEMIES_KILLED = FLTARR(1000)
	TIMES_TAKEN = FLTARR(1000)
	FATIGUE_LVL = FLTARR(1000)
	TIMESTAMPS = FLTARR(1000)
	
	FLOORS[0] = 0 ; init 
	FATIGUE_LVL[0] = 1 ; init
	ENEMIES_KILLED[0] = 5 ; init
	TIMES_TAKEN[0] = BASE_TIME
	TIMESTAMPS[0] = BASE_TIME
	
	FOR I=1,999 DO BEGIN
		RUN_IDS[I] = I ; RUN ID
		
		; compute current data
		FATIGUE_LVL[I] = COMPUTE_FATIGUE(DATA_SEED, FLOORS[I-1], FATIGUE_LVL[I-1])
		FLOORS[I] = COMPUTE_FLOOR(DATA_SEED, FLOORS[I-1], FATIGUE_LVL[I])
		ENEMIES_KILLED[I] = CALC_NB_ENEMIES(FLOORS[I], ENEMIES_KILLED[I-1])
		TIMES_TAKEN[I] = CALC_TIME_TAKEN(BASE_TIME, FLOORS[I], FATIGUE_LVL[I], ENEMIES_KILLED[I])
		EXP_GAIN[I] = CALC_XP_EARNT(DATA_SEED, FLOORS[I])
		TIMESTAMPS[I] = TIMESTAMPS[I-1] + TIMES_TAKEN[I]
		
		; DATA TO CSV
		
	ENDFOR

END