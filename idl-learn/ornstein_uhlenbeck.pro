PRO ORNSTEIN_UHLENBECK

; mosquito random fly
MOSQUITO_MOV = FLTARR(50)
MOSQUITO_IND = FLTARR(50)
Seed = LONG(SYSTIME(1))

; sigma = amplitude du bruit (volume)
; mu = moyenne cible vers ou tendre
; theta = force de rappel
; bruit = distribution gaussienne intervalle standard en SET: 68% (-1*sigma ; +1*sigma) ou 95% (-2sigma; +2sigma) ou 99.7% (-3sigma; +3sigma)

SIGMA = 0.5 ; low amplitude
MU = 3 ; 3 meters of altitude mean
THETA = 1

; MOSQUITO depart au sol :)
FOR I=1,49 DO BEGIN
MOSQUITO_MOV[I] = MOSQUITO_MOV[I-1] + THETA*(MU - MOSQUITO_MOV[I-1]) + SIGMA * RANDOMN(Seed)
MOSQUITO_IND[I] = I
ENDFOR

PLOT,MOSQUITO_IND,MOSQUITO_MOV

END