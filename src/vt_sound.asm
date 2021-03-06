SECTION BANK_14

EXTERN VT_START

DEFC VT_INIT = VT_START + 3
DEFC VT_PLAY = VT_START + 5
DEFC VT_MUTE = VT_START + 8
DEFC VT_SETUP_BYTE = VT_START + 10
DEFC VT_CUR_POS_WORD = VT_START + 11

PUBLIC _vt_get_setup
PUBLIC _vt_init
PUBLIC _vt_play
PUBLIC _vt_play_isr
PUBLIC _vt_set_play_isr_enabled
PUBLIC _vt_mute
PUBLIC _vt_get_cur_pos

_vt_get_setup:
    ld hl,VT_SETUP_BYTE
    ret

_vt_init:
    ; hl contains module address
    di
    push af
    push bc
    push de
    push hl
    push ix
    call VT_INIT
    pop ix
    pop hl
    pop de
    pop bc
    pop af
    ei
    ret

DEFC _vt_play = VT_PLAY

_vt_play_isr:
    di
    push af
    push bc
    push de
    push hl
    ex af,af'
    exx
    push af
    push bc
    push de
    push hl
    push ix
    push iy

play:
    call VT_PLAY

end:
    pop iy
    pop ix
    pop hl
    pop de
    pop bc
    pop af
    exx
    ex af,af'
    pop hl
    pop de
    pop bc
    pop af
    ei
    reti

_vt_set_play_isr_enabled:
    ; l contains enablement/disablement parameter
    ld a,l
    ld (_vt_play_isr_enabled),a
    ret

_vt_mute:
    di
    call VT_MUTE
    ei
    ret

_vt_get_cur_pos:
    ld hl,VT_CUR_POS_WORD
    ret

_vt_play_isr_enabled:
    DEFB 1

_frame_counter:
    DEFB 0
