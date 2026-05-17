; JUMP DIFFUSION c'est le mélange de OU + un event rare (JUMP) 
; Dans le cas de mon moustique, à chaque mouvement, il a une probabilité de 2% de se poser au sol (z=0)
; C'est simplifié, sinon j'ai vu que le modèle de Hawkes réponds à cette problématique de fatigue qui varie en fonction du temps

PRO JUMP_DIFFUSION

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
THETA = 0.5

; MOSQUITO depart au sol :)
FOR I=1,49 DO BEGIN
JUMP = RANDOMU(Seed)
IF (JUMP LT 0.02) THEN BEGIN
MOSQUITO_MOV[I] = 0
ENDIF ELSE BEGIN
MOSQUITO_MOV[I] = MOSQUITO_MOV[I-1] + THETA*(MU - MOSQUITO_MOV[I-1]) + SIGMA * RANDOMN(Seed)
ENDELSE
MOSQUITO_IND[I] = I
ENDFOR

PLOT,MOSQUITO_IND,MOSQUITO_MOV

END