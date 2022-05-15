	.text
	.file	"ld-temp.o"
	.section	.text.__zero_bss,"ax",@progbits
	.globl	__zero_bss
	.type	__zero_bss,@function
__zero_bss:
	lda	#mos16lo(__bss_end)
	ldx	#mos16lo(__bss_begin)
	stx	mos8(__rc2)
	stx	mos8(__rc4)
	ldx	#mos16hi(__bss_begin)
	stx	mos8(__rc3)
	stx	mos8(__rc5)
	sec
	sbc	mos8(__rc4)
	tax
	lda	#mos16hi(__bss_end)
	sbc	mos8(__rc5)
	sta	mos8(__rc4)
	lda	#0
	jsr	__memset
	rts
.Lfunc_end0:
	.size	__zero_bss, .Lfunc_end0-__zero_bss

	.section	.text.__udivqi3,"ax",@progbits
	.globl	__udivqi3
	.type	__udivqi3,@function
__udivqi3:
	stx	mos8(__rc4)
	ldx	#0
	stx	mos8(__rc6)
	ldx	mos8(__rc4)
	bne	.LBB1_1
	jmp	.LBB1_27
.LBB1_1:
	ldx	mos8(__rc4)
	stx	mos8(__rc2)
	cmp	mos8(__rc4)
	bcs	.LBB1_2
	jmp	.LBB1_27
.LBB1_2:
	sta	mos8(__rc5)
	ldy	#0
	ldx	mos8(__rc4)
	stx	mos8(__rc3)
	asl	mos8(__rc3)
	lda	#0
	rol
	sta	mos8(__rc2)
	ldx	mos8(__rc4)
	stx	mos8(__rc7)
	lda	mos8(__rc4)
	and	#-128
	ldx	#0
	cpy	mos8(__rc2)
	bne	.LBB1_9
	ldy	mos8(__rc5)
	cpy	mos8(__rc3)
	bcs	.LBB1_5
.LBB1_4:
	ldx	#1
.LBB1_5:
	ldy	#1
	cmp	#0
	bne	.LBB1_7
	txa
	tay
.LBB1_7:
	tya
	beq	.LBB1_10
	ldx	#1
	stx	mos8(__rc6)
	jmp	.LBB1_27
.LBB1_9:
	cpy	mos8(__rc2)
	bcc	.LBB1_4
	jmp	.LBB1_5
.LBB1_10:
	ldx	#1
	stx	mos8(__rc6)
	dex
	stx	mos8(__rc9)
	ldy	#0
	jmp	.LBB1_14
.LBB1_11:
	cmp	mos8(__rc4)
	bcc	.LBB1_16
	jmp	.LBB1_17
.LBB1_12:
	clv
.LBB1_13:
	ldy	mos8(__rc8)
	dey
	bvs	.LBB1_21
.LBB1_14:
	sty	mos8(__rc8)
	ldy	mos8(__rc7)
	ldx	mos8(__rc3)
	stx	mos8(__rc2)
	lda	mos8(__rc3)
	and	#-2
	sta	mos8(__rc7)
	sta	mos8(__rc3)
	asl	mos8(__rc3)
	lda	#0
	rol
	sta	mos8(__rc4)
	ldx	#0
	lda	#0
	cmp	mos8(__rc4)
	bne	.LBB1_11
	lda	mos8(__rc5)
	cmp	mos8(__rc3)
	bcs	.LBB1_17
.LBB1_16:
	ldx	#1
.LBB1_17:
	bit	__set_v
	lda	mos8(__rc9)
	bne	.LBB1_13
	tya
	and	#64
	bit	__set_v
	tay
	bne	.LBB1_13
	txa
	beq	.LBB1_12
	bit	__set_v
	jmp	.LBB1_13
.LBB1_21:
	tya
	beq	.LBB1_27
	ldx	#1
	stx	mos8(__rc6)
	sec
	lda	mos8(__rc5)
	sbc	mos8(__rc2)
	sta	mos8(__rc3)
	jmp	.LBB1_25
.LBB1_23:
	sty	mos8(__rc4)
	ora	#1
	sta	mos8(__rc6)
	sec
	lda	mos8(__rc4)
	sbc	mos8(__rc2)
	sta	mos8(__rc3)
.LBB1_24:
	clc
	txa
	adc	#1
	tay
	bcs	.LBB1_27
.LBB1_25:
	tya
	tax
	lsr	mos8(__rc2)
	lda	mos8(__rc6)
	asl
	ldy	mos8(__rc3)
	cpy	mos8(__rc2)
	bcs	.LBB1_23
	sta	mos8(__rc6)
	jmp	.LBB1_24
.LBB1_27:
	lda	mos8(__rc6)
	rts
.Lfunc_end1:
	.size	__udivqi3, .Lfunc_end1-__udivqi3

	.section	.text.__udivhi3,"ax",@progbits
	.globl	__udivhi3
	.type	__udivhi3,@function
__udivhi3:
	cpx	mos8(__rc3)
	bne	.LBB2_3
	stx	mos8(__rc7)
	sta	mos8(__rc6)
	cmp	mos8(__rc2)
	bcc	.LBB2_4
.LBB2_2:
	lda	#0
	jmp	.LBB2_5
.LBB2_3:
	sta	mos8(__rc6)
	stx	mos8(__rc7)
	cpx	mos8(__rc3)
	bcs	.LBB2_2
.LBB2_4:
	lda	#1
.LBB2_5:
	ldx	mos8(__rc3)
	bne	.LBB2_7
	ldx	#1
	ldy	mos8(__rc2)
	beq	.LBB2_8
.LBB2_7:
	tax
.LBB2_8:
	txa
	beq	.LBB2_10
	ldx	#0
	jmp	.LBB2_27
.LBB2_10:
	lda	mos8(__rc3)
	bpl	.LBB2_11
	jmp	.LBB2_26
.LBB2_11:
	ldx	#1
	stx	mos8(__rc9)
	dex
	stx	mos8(__rc8)
	ldx	#0
	ldy	mos8(__rc2)
	sty	mos8(__rc4)
	ldy	mos8(__rc3)
	sty	mos8(__rc5)
	lda	mos8(__rc7)
.LBB2_12:
	asl	mos8(__rc4)
	rol	mos8(__rc5)
	cmp	mos8(__rc5)
	bne	.LBB2_14
	ldy	mos8(__rc6)
	cpy	mos8(__rc4)
	bcc	.LBB2_16
	jmp	.LBB2_15
.LBB2_14:
	cmp	mos8(__rc5)
	bcc	.LBB2_16
.LBB2_15:
	inx
	ldy	mos8(__rc4)
	sty	mos8(__rc2)
	ldy	mos8(__rc5)
	sty	mos8(__rc3)
	bpl	.LBB2_12
	jmp	.LBB2_17
.LBB2_16:
	ldy	mos8(__rc2)
	sty	mos8(__rc4)
	ldy	mos8(__rc3)
	sty	mos8(__rc5)
.LBB2_17:
	cpx	#0
	bne	.LBB2_18
	jmp	.LBB2_28
.LBB2_18:
	ldy	#0
	sty	mos8(__rc8)
	sec
	tay
	lda	mos8(__rc6)
	sbc	mos8(__rc4)
	sta	mos8(__rc2)
	tya
	sbc	mos8(__rc5)
	ldy	#1
	sty	mos8(__rc9)
.LBB2_19:
	lsr	mos8(__rc5)
	ror	mos8(__rc4)
	asl	mos8(__rc9)
	ldy	#1
	bcs	.LBB2_21
	ldy	#0
.LBB2_21:
	sty	mos8(__rc3)
	cmp	mos8(__rc5)
	bne	.LBB2_25
	ldy	mos8(__rc2)
	cpy	mos8(__rc4)
	bcc	.LBB2_24
.LBB2_23:
	tay
	lda	mos8(__rc9)
	ora	#1
	sta	mos8(__rc9)
	sec
	lda	mos8(__rc2)
	sbc	mos8(__rc4)
	sta	mos8(__rc2)
	tya
	sbc	mos8(__rc5)
.LBB2_24:
	ldy	mos8(__rc3)
	cpy	#1
	rol	mos8(__rc8)
	dex
	bne	.LBB2_19
	jmp	.LBB2_28
.LBB2_25:
	cmp	mos8(__rc5)
	bcs	.LBB2_23
	jmp	.LBB2_24
.LBB2_26:
	ldx	#1
.LBB2_27:
	stx	mos8(__rc9)
	ldx	#0
	stx	mos8(__rc8)
.LBB2_28:
	ldx	mos8(__rc8)
	lda	mos8(__rc9)
	rts
.Lfunc_end2:
	.size	__udivhi3, .Lfunc_end2-__udivhi3

	.section	.text.__udivsi3,"ax",@progbits
	.globl	__udivsi3
	.type	__udivsi3,@function
__udivsi3:
	sta	mos8(__rc13)
	lda	mos8(__rc2)
	ldy	mos8(__rc3)
	stx	mos8(__rc10)
	sta	mos8(__rc11)
	sty	mos8(__rc12)
	cpy	mos8(__rc7)
	bne	.LBB3_4
	cmp	mos8(__rc6)
	bne	.LBB3_6
	cpx	mos8(__rc5)
	beq	.LBB3_3
	jmp	.LBB3_41
.LBB3_3:
	ldx	mos8(__rc13)
	cpx	mos8(__rc4)
	bcs	.LBB3_5
	jmp	.LBB3_7
.LBB3_4:
	cpy	mos8(__rc7)
	bcc	.LBB3_7
.LBB3_5:
	ldy	#0
	jmp	.LBB3_8
.LBB3_6:
	cmp	mos8(__rc6)
	bcs	.LBB3_5
.LBB3_7:
	ldy	#1
.LBB3_8:
	lda	mos8(__rc7)
	bne	.LBB3_12
	lda	mos8(__rc6)
	bne	.LBB3_12
	lda	mos8(__rc5)
	bne	.LBB3_12
	ldx	#1
	lda	mos8(__rc4)
	beq	.LBB3_13
.LBB3_12:
	tya
	tax
.LBB3_13:
	lda	#0
	cpx	#0
	beq	.LBB3_15
	ldx	#0
	stx	mos8(__rc14)
	jmp	.LBB3_25
.LBB3_15:
	ldx	#1
	stx	mos8(__rc14)
	ldx	mos8(__rc7)
	bpl	.LBB3_16
	jmp	.LBB3_25
.LBB3_16:
	ldx	#0
	ldy	mos8(__rc4)
	sty	mos8(__rc15)
	ldy	mos8(__rc5)
	sty	mos8(__rc18)
	ldy	mos8(__rc6)
	sty	mos8(__rc8)
	ldy	mos8(__rc7)
	sty	mos8(__rc9)
	ldy	mos8(__rc10)
	sty	mos8(__rc2)
.LBB3_17:
	asl	mos8(__rc15)
	rol	mos8(__rc18)
	rol	mos8(__rc8)
	rol	mos8(__rc9)
	ldy	mos8(__rc12)
	cpy	mos8(__rc9)
	bne	.LBB3_21
	ldy	mos8(__rc11)
	cpy	mos8(__rc8)
	bne	.LBB3_22
	ldy	mos8(__rc2)
	cpy	mos8(__rc18)
	bne	.LBB3_23
	ldy	mos8(__rc13)
	cpy	mos8(__rc15)
	ldy	mos8(__rc10)
	sty	mos8(__rc2)
	bcc	.LBB3_27
	jmp	.LBB3_24
.LBB3_21:
	cpy	mos8(__rc9)
	bcc	.LBB3_27
	jmp	.LBB3_24
.LBB3_22:
	cpy	mos8(__rc8)
	bcc	.LBB3_27
	jmp	.LBB3_24
.LBB3_23:
	cpy	mos8(__rc18)
	bcc	.LBB3_27
.LBB3_24:
	inx
	ldy	mos8(__rc15)
	sty	mos8(__rc4)
	ldy	mos8(__rc18)
	sty	mos8(__rc5)
	ldy	mos8(__rc8)
	sty	mos8(__rc6)
	ldy	mos8(__rc9)
	sty	mos8(__rc7)
	bpl	.LBB3_17
	jmp	.LBB3_28
.LBB3_25:
	ldx	#0
	stx	mos8(__rc2)
	ldx	#0
	stx	mos8(__rc3)
.LBB3_26:
	tax
	lda	mos8(__rc14)
	rts
.LBB3_27:
	ldy	mos8(__rc4)
	sty	mos8(__rc15)
	ldy	mos8(__rc5)
	sty	mos8(__rc18)
	ldy	mos8(__rc6)
	sty	mos8(__rc8)
	ldy	mos8(__rc7)
	sty	mos8(__rc9)
.LBB3_28:
	ldy	#0
	sty	mos8(__rc2)
	ldy	#0
	sty	mos8(__rc3)
	cpx	#0
	beq	.LBB3_26
	sec
	lda	mos8(__rc13)
	sbc	mos8(__rc15)
	sta	mos8(__rc4)
	lda	mos8(__rc10)
	sbc	mos8(__rc18)
	sta	mos8(__rc10)
	lda	mos8(__rc11)
	sbc	mos8(__rc8)
	sta	mos8(__rc5)
	lda	mos8(__rc12)
	sbc	mos8(__rc9)
	sta	mos8(__rc6)
	lda	#0
	ldy	#1
	sty	mos8(__rc14)
	dey
	sty	mos8(__rc2)
	ldy	#0
	sty	mos8(__rc3)
.LBB3_30:
	lsr	mos8(__rc9)
	ror	mos8(__rc8)
	ror	mos8(__rc18)
	ror	mos8(__rc15)
	asl	mos8(__rc14)
	ldy	#1
	bcs	.LBB3_32
	ldy	#0
.LBB3_32:
	sty	mos8(__rc11)
	ldy	mos8(__rc6)
	cpy	mos8(__rc9)
	bne	.LBB3_36
	ldy	mos8(__rc5)
	cpy	mos8(__rc8)
	bne	.LBB3_39
	ldy	mos8(__rc10)
	cpy	mos8(__rc18)
	bne	.LBB3_40
	ldy	mos8(__rc4)
	cpy	mos8(__rc15)
	bcs	.LBB3_37
	jmp	.LBB3_38
.LBB3_36:
	cpy	mos8(__rc9)
	bcc	.LBB3_38
.LBB3_37:
	sta	mos8(__rc7)
	ldy	mos8(__rc10)
	sec
	lda	mos8(__rc4)
	sbc	mos8(__rc15)
	sta	mos8(__rc4)
	tya
	sbc	mos8(__rc18)
	sta	mos8(__rc10)
	lda	mos8(__rc5)
	sbc	mos8(__rc8)
	sta	mos8(__rc5)
	lda	mos8(__rc6)
	sbc	mos8(__rc9)
	sta	mos8(__rc6)
	lda	mos8(__rc14)
	ora	#1
	sta	mos8(__rc14)
	lda	mos8(__rc7)
.LBB3_38:
	ldy	mos8(__rc11)
	cpy	#1
	rol
	rol	mos8(__rc2)
	rol	mos8(__rc3)
	dex
	beq	.LBB3_42
	jmp	.LBB3_30
.LBB3_42:
	jmp	.LBB3_26
.LBB3_39:
	cpy	mos8(__rc8)
	bcs	.LBB3_37
	jmp	.LBB3_38
.LBB3_40:
	cpy	mos8(__rc18)
	bcs	.LBB3_37
	jmp	.LBB3_38
.LBB3_41:
	cpx	mos8(__rc5)
	bcc	.LBB3_43
	jmp	.LBB3_5
.LBB3_43:
	jmp	.LBB3_7
.Lfunc_end3:
	.size	__udivsi3, .Lfunc_end3-__udivsi3

	.section	.text.__udivdi3,"ax",@progbits
	.globl	__udivdi3
	.type	__udivdi3,@function
__udivdi3:
	sta	mos8(__rc16)
	lda	mos8(__rc20)
	pha
	lda	mos8(__rc21)
	pha
	lda	mos8(__rc22)
	pha
	lda	mos8(__rc23)
	pha
	lda	mos8(__rc16)
	ldy	mos8(__rc24)
	sty	.L____udivdi3_sstk
	ldy	mos8(__rc25)
	sty	.L____udivdi3_sstk+1
	ldy	mos8(__rc26)
	sty	.L____udivdi3_sstk+2
	ldy	mos8(__rc27)
	sty	.L____udivdi3_sstk+3
	ldy	mos8(__rc28)
	sty	.L____udivdi3_sstk+4
	ldy	mos8(__rc29)
	sty	.L____udivdi3_sstk+5
	ldy	mos8(__rc30)
	sty	.L____udivdi3_sstk+6
	ldy	mos8(__rc31)
	sty	.L____udivdi3_sstk+7
	sta	mos8(__rc26)
	ldy	mos8(__rc6)
	lda	mos8(__rc7)
	stx	mos8(__rc20)
	ldx	mos8(__rc2)
	stx	mos8(__rc21)
	ldx	mos8(__rc3)
	stx	mos8(__rc22)
	sty	mos8(__rc25)
	cmp	mos8(__rc15)
	bne	.LBB4_8
	cpy	mos8(__rc14)
	bne	.LBB4_10
	ldx	mos8(__rc5)
	cpx	mos8(__rc13)
	beq	.LBB4_3
	jmp	.LBB4_36
.LBB4_3:
	ldx	mos8(__rc4)
	cpx	mos8(__rc12)
	beq	.LBB4_4
	jmp	.LBB4_37
.LBB4_4:
	ldx	mos8(__rc3)
	cpx	mos8(__rc11)
	beq	.LBB4_5
	jmp	.LBB4_43
.LBB4_5:
	ldx	mos8(__rc21)
	cpx	mos8(__rc10)
	beq	.LBB4_6
	jmp	.LBB4_45
.LBB4_6:
	ldx	mos8(__rc20)
	cpx	mos8(__rc9)
	beq	.LBB4_7
	jmp	.LBB4_48
.LBB4_7:
	ldx	mos8(__rc26)
	cpx	mos8(__rc8)
	bcs	.LBB4_9
	jmp	.LBB4_11
.LBB4_8:
	cmp	mos8(__rc15)
	bcc	.LBB4_11
.LBB4_9:
	ldy	#0
	jmp	.LBB4_12
.LBB4_10:
	cpy	mos8(__rc14)
	bcs	.LBB4_9
.LBB4_11:
	ldy	#1
.LBB4_12:
	ldx	mos8(__rc15)
	bne	.LBB4_20
	ldx	mos8(__rc14)
	bne	.LBB4_20
	ldx	mos8(__rc13)
	bne	.LBB4_20
	ldx	mos8(__rc12)
	bne	.LBB4_20
	ldx	mos8(__rc11)
	bne	.LBB4_20
	ldx	mos8(__rc10)
	bne	.LBB4_20
	ldx	mos8(__rc9)
	bne	.LBB4_20
	ldx	#1
	inc	mos8(__rc8)
	dec	mos8(__rc8)
	beq	.LBB4_21
.LBB4_20:
	pha
	tya
	tax
	pla
.LBB4_21:
	ldy	#0
	sty	mos8(__rc27)
	cpx	#0
	beq	.LBB4_23
	ldx	#0
	stx	mos8(__rc28)
	jmp	.LBB4_34
.LBB4_23:
	ldx	#1
	stx	mos8(__rc28)
	ldx	mos8(__rc15)
	bpl	.LBB4_24
	jmp	.LBB4_34
.LBB4_24:
	ldx	#0
	pha
	ldy	mos8(__rc8)
	sty	mos8(__rc29)
	ldy	mos8(__rc9)
	sty	mos8(__rc30)
	ldy	mos8(__rc10)
	sty	mos8(__rc23)
	ldy	mos8(__rc11)
	sty	mos8(__rc24)
	ldy	mos8(__rc12)
	sty	mos8(__rc31)
	ldy	mos8(__rc13)
	sty	mos8(__rc7)
	ldy	mos8(__rc14)
	sty	mos8(__rc18)
	ldy	mos8(__rc15)
	sty	mos8(__rc19)
	ldy	mos8(__rc20)
	lda	mos8(__rc4)
	sta	mos8(__rc3)
	pla
.LBB4_25:
	asl	mos8(__rc29)
	rol	mos8(__rc30)
	rol	mos8(__rc23)
	rol	mos8(__rc24)
	rol	mos8(__rc31)
	rol	mos8(__rc7)
	rol	mos8(__rc18)
	rol	mos8(__rc19)
	cmp	mos8(__rc19)
	bne	.LBB4_29
	sty	mos8(__rc2)
	ldy	mos8(__rc25)
	cpy	mos8(__rc18)
	bne	.LBB4_30
	ldy	mos8(__rc5)
	cpy	mos8(__rc7)
	bne	.LBB4_31
	ldy	mos8(__rc3)
	cpy	mos8(__rc31)
	beq	.LBB4_73
	jmp	.LBB4_42
.LBB4_73:
	jmp	.LBB4_38
.LBB4_29:
	cmp	mos8(__rc19)
	bcs	.LBB4_33
	jmp	.LBB4_51
.LBB4_30:
	cpy	mos8(__rc18)
	jmp	.LBB4_32
.LBB4_31:
	cpy	mos8(__rc7)
.LBB4_32:
	ldy	mos8(__rc2)
	bcs	.LBB4_33
	jmp	.LBB4_51
.LBB4_33:
	inx
	sty	mos8(__rc17)
	ldy	mos8(__rc29)
	sty	mos8(__rc8)
	ldy	mos8(__rc30)
	sty	mos8(__rc9)
	ldy	mos8(__rc23)
	sty	mos8(__rc10)
	ldy	mos8(__rc24)
	sty	mos8(__rc11)
	ldy	mos8(__rc31)
	sty	mos8(__rc12)
	ldy	mos8(__rc7)
	sty	mos8(__rc13)
	ldy	mos8(__rc18)
	sty	mos8(__rc14)
	ldy	mos8(__rc19)
	sty	mos8(__rc15)
	ldy	mos8(__rc17)
	inc	mos8(__rc19)
	dec	mos8(__rc19)
	bmi	.LBB4_74
	jmp	.LBB4_25
.LBB4_74:
	jmp	.LBB4_52
.LBB4_34:
	ldx	#0
	stx	mos8(__rc2)
	ldx	#0
	stx	mos8(__rc3)
	ldx	#0
	stx	mos8(__rc13)
	ldx	#0
	stx	mos8(__rc15)
	ldx	#0
	stx	mos8(__rc6)
	ldx	#0
.LBB4_35:
	ldy	mos8(__rc13)
	sty	mos8(__rc4)
	ldy	mos8(__rc15)
	sty	mos8(__rc5)
	stx	mos8(__rc7)
	ldx	mos8(__rc27)
	lda	mos8(__rc28)
	sta	mos8(__rc16)
	ldy	.L____udivdi3_sstk+7
	sty	mos8(__rc31)
	ldy	.L____udivdi3_sstk+6
	sty	mos8(__rc30)
	ldy	.L____udivdi3_sstk+5
	sty	mos8(__rc29)
	ldy	.L____udivdi3_sstk+4
	sty	mos8(__rc28)
	ldy	.L____udivdi3_sstk+3
	sty	mos8(__rc27)
	ldy	.L____udivdi3_sstk+2
	sty	mos8(__rc26)
	ldy	.L____udivdi3_sstk+1
	sty	mos8(__rc25)
	ldy	.L____udivdi3_sstk
	sty	mos8(__rc24)
	pla
	sta	mos8(__rc23)
	pla
	sta	mos8(__rc22)
	pla
	sta	mos8(__rc21)
	pla
	sta	mos8(__rc20)
	lda	mos8(__rc16)
	rts
.LBB4_36:
	cpx	mos8(__rc13)
	bcc	.LBB4_75
	jmp	.LBB4_9
.LBB4_75:
	jmp	.LBB4_11
.LBB4_37:
	cpx	mos8(__rc12)
	bcc	.LBB4_76
	jmp	.LBB4_9
.LBB4_76:
	jmp	.LBB4_11
.LBB4_38:
	ldy	mos8(__rc22)
	cpy	mos8(__rc24)
	bne	.LBB4_44
	ldy	mos8(__rc21)
	cpy	mos8(__rc23)
	bne	.LBB4_46
	ldy	mos8(__rc2)
	cpy	mos8(__rc30)
	bne	.LBB4_49
	ldy	mos8(__rc26)
	cpy	mos8(__rc29)
	ldy	mos8(__rc20)
	jmp	.LBB4_50
.LBB4_42:
	cpy	mos8(__rc31)
	jmp	.LBB4_32
.LBB4_43:
	cpx	mos8(__rc11)
	bcc	.LBB4_77
	jmp	.LBB4_9
.LBB4_77:
	jmp	.LBB4_11
.LBB4_44:
	cpy	mos8(__rc24)
	jmp	.LBB4_47
.LBB4_45:
	cpx	mos8(__rc10)
	bcc	.LBB4_78
	jmp	.LBB4_9
.LBB4_78:
	jmp	.LBB4_11
.LBB4_46:
	cpy	mos8(__rc23)
.LBB4_47:
	ldy	mos8(__rc4)
	sty	mos8(__rc3)
	jmp	.LBB4_32
.LBB4_48:
	cpx	mos8(__rc9)
	bcc	.LBB4_79
	jmp	.LBB4_9
.LBB4_79:
	jmp	.LBB4_11
.LBB4_49:
	cpy	mos8(__rc30)
.LBB4_50:
	sty	mos8(__rc17)
	ldy	mos8(__rc4)
	sty	mos8(__rc3)
	ldy	mos8(__rc17)
	bcc	.LBB4_51
	jmp	.LBB4_33
.LBB4_51:
	ldy	mos8(__rc8)
	sty	mos8(__rc29)
	ldy	mos8(__rc9)
	sty	mos8(__rc30)
	ldy	mos8(__rc10)
	sty	mos8(__rc23)
	ldy	mos8(__rc11)
	sty	mos8(__rc24)
	ldy	mos8(__rc12)
	sty	mos8(__rc31)
	ldy	mos8(__rc13)
	sty	mos8(__rc7)
	ldy	mos8(__rc14)
	sty	mos8(__rc18)
	ldy	mos8(__rc15)
	sty	mos8(__rc19)
.LBB4_52:
	ldy	#0
	sty	mos8(__rc2)
	ldy	#0
	sty	mos8(__rc3)
	ldy	#0
	sty	mos8(__rc13)
	pha
	txa
	tay
	pla
	ldx	#0
	stx	mos8(__rc15)
	ldx	#0
	stx	mos8(__rc6)
	ldx	#0
	cpy	#0
	bne	.LBB4_53
	jmp	.LBB4_35
.LBB4_53:
	sty	mos8(__rc14)
	ldy	#0
	sty	mos8(__rc27)
	sec
	tay
	lda	mos8(__rc26)
	sbc	mos8(__rc29)
	sta	mos8(__rc8)
	lda	mos8(__rc20)
	sbc	mos8(__rc30)
	sta	mos8(__rc20)
	lda	mos8(__rc21)
	sbc	mos8(__rc23)
	sta	mos8(__rc9)
	lda	mos8(__rc22)
	sbc	mos8(__rc24)
	sta	mos8(__rc10)
	lda	mos8(__rc4)
	sbc	mos8(__rc31)
	sta	mos8(__rc4)
	lda	mos8(__rc5)
	sbc	mos8(__rc7)
	sta	mos8(__rc5)
	lda	mos8(__rc25)
	sbc	mos8(__rc18)
	sta	mos8(__rc11)
	tya
	sbc	mos8(__rc19)
	ldy	#1
	sty	mos8(__rc28)
	dey
	sty	mos8(__rc2)
	ldy	#0
	sty	mos8(__rc3)
	ldy	#0
	sty	mos8(__rc13)
	ldx	#0
	stx	mos8(__rc15)
	ldx	#0
	stx	mos8(__rc6)
	ldx	#0
.LBB4_54:
	lsr	mos8(__rc19)
	ror	mos8(__rc18)
	ror	mos8(__rc7)
	ror	mos8(__rc31)
	ror	mos8(__rc24)
	ror	mos8(__rc23)
	ror	mos8(__rc30)
	ror	mos8(__rc29)
	asl	mos8(__rc28)
	ldy	#1
	bcs	.LBB4_56
	ldy	#0
.LBB4_56:
	sty	mos8(__rc21)
	cmp	mos8(__rc19)
	bne	.LBB4_64
	sta	mos8(__rc12)
	ldy	mos8(__rc11)
	lda	mos8(__rc20)
	cpy	mos8(__rc18)
	beq	.LBB4_58
	jmp	.LBB4_67
.LBB4_58:
	ldy	mos8(__rc5)
	cpy	mos8(__rc7)
	beq	.LBB4_59
	jmp	.LBB4_68
.LBB4_59:
	ldy	mos8(__rc4)
	cpy	mos8(__rc31)
	beq	.LBB4_60
	jmp	.LBB4_69
.LBB4_60:
	ldy	mos8(__rc10)
	cpy	mos8(__rc24)
	beq	.LBB4_61
	jmp	.LBB4_70
.LBB4_61:
	ldy	mos8(__rc9)
	cpy	mos8(__rc23)
	beq	.LBB4_62
	jmp	.LBB4_71
.LBB4_62:
	cmp	mos8(__rc30)
	beq	.LBB4_63
	jmp	.LBB4_72
.LBB4_63:
	ldy	mos8(__rc8)
	cpy	mos8(__rc29)
	bcs	.LBB4_65
	jmp	.LBB4_66
.LBB4_64:
	sta	mos8(__rc12)
	cmp	mos8(__rc19)
	lda	mos8(__rc20)
	bcc	.LBB4_66
.LBB4_65:
	tay
	sec
	lda	mos8(__rc8)
	sbc	mos8(__rc29)
	sta	mos8(__rc8)
	tya
	sbc	mos8(__rc30)
	sta	mos8(__rc20)
	lda	mos8(__rc9)
	sbc	mos8(__rc23)
	sta	mos8(__rc9)
	lda	mos8(__rc10)
	sbc	mos8(__rc24)
	sta	mos8(__rc10)
	lda	mos8(__rc4)
	sbc	mos8(__rc31)
	sta	mos8(__rc4)
	lda	mos8(__rc5)
	sbc	mos8(__rc7)
	sta	mos8(__rc5)
	lda	mos8(__rc11)
	sbc	mos8(__rc18)
	sta	mos8(__rc11)
	lda	mos8(__rc12)
	sbc	mos8(__rc19)
	sta	mos8(__rc12)
	lda	mos8(__rc28)
	ora	#1
	sta	mos8(__rc28)
.LBB4_66:
	ldy	mos8(__rc21)
	cpy	#1
	rol	mos8(__rc27)
	rol	mos8(__rc2)
	rol	mos8(__rc3)
	rol	mos8(__rc13)
	rol	mos8(__rc15)
	lda	mos8(__rc6)
	rol
	sta	mos8(__rc6)
	txa
	rol
	tax
	dec	mos8(__rc14)
	lda	mos8(__rc12)
	ldy	mos8(__rc14)
	beq	.LBB4_80
	jmp	.LBB4_54
.LBB4_80:
	jmp	.LBB4_35
.LBB4_67:
	cpy	mos8(__rc18)
	bcc	.LBB4_66
	jmp	.LBB4_65
.LBB4_68:
	cpy	mos8(__rc7)
	bcc	.LBB4_66
	jmp	.LBB4_65
.LBB4_69:
	cpy	mos8(__rc31)
	bcc	.LBB4_66
	jmp	.LBB4_65
.LBB4_70:
	cpy	mos8(__rc24)
	bcc	.LBB4_66
	jmp	.LBB4_65
.LBB4_71:
	cpy	mos8(__rc23)
	bcc	.LBB4_66
	jmp	.LBB4_65
.LBB4_72:
	cmp	mos8(__rc30)
	bcc	.LBB4_66
	jmp	.LBB4_65
.Lfunc_end4:
	.size	__udivdi3, .Lfunc_end4-__udivdi3

	.section	.text.__umodqi3,"ax",@progbits
	.globl	__umodqi3
	.type	__umodqi3,@function
__umodqi3:
	tay
	txa
	beq	.LBB5_8
	stx	mos8(__rc2)
	tya
	cpy	mos8(__rc2)
	bcc	.LBB5_8
	sty	mos8(__rc5)
	lda	mos8(__rc2)
	and	#-128
	bne	.LBB5_6
	ldx	#0
	ldy	mos8(__rc2)
	sty	mos8(__rc3)
	asl	mos8(__rc3)
	lda	#0
	rol
	sta	mos8(__rc4)
	cpx	mos8(__rc4)
	bne	.LBB5_9
	lda	mos8(__rc5)
	tax
	cmp	mos8(__rc3)
	bcs	.LBB5_10
.LBB5_5:
	sec
	txa
	jmp	.LBB5_7
.LBB5_6:
	sec
	lda	mos8(__rc5)
.LBB5_7:
	sbc	mos8(__rc2)
	tay
.LBB5_8:
	tya
	rts
.LBB5_9:
	cpx	mos8(__rc4)
	ldx	mos8(__rc5)
	bcc	.LBB5_5
.LBB5_10:
	ldx	#0
	stx	mos8(__rc6)
	ldx	#0
	ldy	mos8(__rc2)
	sty	mos8(__rc7)
	jmp	.LBB5_14
.LBB5_11:
	cmp	mos8(__rc4)
	lda	mos8(__rc5)
	sta	mos8(__rc4)
	bcc	.LBB5_16
	jmp	.LBB5_17
.LBB5_12:
	clv
.LBB5_13:
	dex
	bvs	.LBB5_21
.LBB5_14:
	ldy	mos8(__rc7)
	sty	mos8(__rc8)
	ldy	mos8(__rc3)
	sty	mos8(__rc2)
	lda	mos8(__rc3)
	and	#-2
	sta	mos8(__rc7)
	sta	mos8(__rc3)
	asl	mos8(__rc3)
	lda	#0
	rol
	sta	mos8(__rc4)
	ldy	#0
	lda	#0
	cmp	mos8(__rc4)
	bne	.LBB5_11
	lda	mos8(__rc5)
	sta	mos8(__rc4)
	cmp	mos8(__rc3)
	bcs	.LBB5_17
.LBB5_16:
	ldy	#1
.LBB5_17:
	bit	__set_v
	lda	mos8(__rc6)
	bne	.LBB5_13
	lda	mos8(__rc8)
	and	#64
	bit	__set_v
	cmp	#0
	bne	.LBB5_13
	tya
	beq	.LBB5_12
	bit	__set_v
	jmp	.LBB5_13
.LBB5_21:
	sec
	lda	mos8(__rc4)
	sbc	mos8(__rc2)
	tay
	txa
	bne	.LBB5_22
	jmp	.LBB5_8
.LBB5_22:
	lsr	mos8(__rc2)
	tya
	cpy	mos8(__rc2)
	bcc	.LBB5_24
	sec
	tya
	sbc	mos8(__rc2)
	tay
.LBB5_24:
	clc
	txa
	adc	#1
	tax
	bcc	.LBB5_22
	jmp	.LBB5_8
.Lfunc_end5:
	.size	__umodqi3, .Lfunc_end5-__umodqi3

	.section	.text.__umodhi3,"ax",@progbits
	.globl	__umodhi3
	.type	__umodhi3,@function
__umodhi3:
	tay
	stx	mos8(__rc6)
	cpx	mos8(__rc3)
	bne	.LBB6_3
	sty	mos8(__rc7)
	cpy	mos8(__rc2)
	bcc	.LBB6_4
.LBB6_2:
	ldy	#0
	jmp	.LBB6_5
.LBB6_3:
	sty	mos8(__rc7)
	cpx	mos8(__rc3)
	bcs	.LBB6_2
.LBB6_4:
	ldy	#1
.LBB6_5:
	lda	mos8(__rc3)
	bne	.LBB6_7
	ldx	#1
	lda	mos8(__rc2)
	beq	.LBB6_8
.LBB6_7:
	tya
	tax
.LBB6_8:
	txa
	beq	.LBB6_9
	jmp	.LBB6_23
.LBB6_9:
	lda	mos8(__rc3)
	bpl	.LBB6_10
	jmp	.LBB6_22
.LBB6_10:
	ldx	#0
	ldy	mos8(__rc2)
	sty	mos8(__rc4)
	ldy	mos8(__rc3)
	sty	mos8(__rc5)
.LBB6_11:
	asl	mos8(__rc4)
	rol	mos8(__rc5)
	ldy	mos8(__rc6)
	cpy	mos8(__rc5)
	bne	.LBB6_13
	ldy	mos8(__rc7)
	cpy	mos8(__rc4)
	bcc	.LBB6_15
	jmp	.LBB6_14
.LBB6_13:
	cpy	mos8(__rc5)
	bcc	.LBB6_15
.LBB6_14:
	inx
	ldy	mos8(__rc4)
	sty	mos8(__rc2)
	ldy	mos8(__rc5)
	sty	mos8(__rc3)
	bpl	.LBB6_11
	jmp	.LBB6_16
.LBB6_15:
	ldy	mos8(__rc2)
	sty	mos8(__rc4)
	ldy	mos8(__rc3)
	sty	mos8(__rc5)
.LBB6_16:
	sec
	lda	mos8(__rc7)
	sbc	mos8(__rc4)
	sta	mos8(__rc7)
	lda	mos8(__rc6)
	sbc	mos8(__rc5)
	sta	mos8(__rc6)
	txa
	beq	.LBB6_23
.LBB6_17:
	lsr	mos8(__rc5)
	ror	mos8(__rc4)
	ldy	mos8(__rc6)
	cpy	mos8(__rc5)
	bne	.LBB6_21
	ldy	mos8(__rc7)
	cpy	mos8(__rc4)
	bcc	.LBB6_20
.LBB6_19:
	sec
	lda	mos8(__rc7)
	sbc	mos8(__rc4)
	sta	mos8(__rc7)
	lda	mos8(__rc6)
	sbc	mos8(__rc5)
	sta	mos8(__rc6)
.LBB6_20:
	dex
	bne	.LBB6_17
	jmp	.LBB6_23
.LBB6_21:
	cpy	mos8(__rc5)
	bcs	.LBB6_19
	jmp	.LBB6_20
.LBB6_22:
	sec
	lda	mos8(__rc7)
	sbc	mos8(__rc2)
	sta	mos8(__rc7)
	lda	mos8(__rc6)
	sbc	mos8(__rc3)
	sta	mos8(__rc6)
.LBB6_23:
	ldx	mos8(__rc6)
	lda	mos8(__rc7)
	rts
.Lfunc_end6:
	.size	__umodhi3, .Lfunc_end6-__umodhi3

	.section	.text.__umodsi3,"ax",@progbits
	.globl	__umodsi3
	.type	__umodsi3,@function
__umodsi3:
	sta	mos8(__rc11)
	stx	mos8(__rc10)
	ldy	mos8(__rc3)
	tya
	cpy	mos8(__rc7)
	bne	.LBB7_4
	ldx	mos8(__rc2)
	cpx	mos8(__rc6)
	bne	.LBB7_6
	ldx	mos8(__rc10)
	cpx	mos8(__rc5)
	beq	.LBB7_3
	jmp	.LBB7_37
.LBB7_3:
	ldx	mos8(__rc11)
	cpx	mos8(__rc4)
	bcs	.LBB7_5
	jmp	.LBB7_7
.LBB7_4:
	tax
	cmp	mos8(__rc7)
	bcc	.LBB7_7
.LBB7_5:
	ldy	#0
	jmp	.LBB7_8
.LBB7_6:
	cpx	mos8(__rc6)
	bcs	.LBB7_5
.LBB7_7:
	ldy	#1
.LBB7_8:
	ldx	mos8(__rc7)
	bne	.LBB7_12
	ldx	mos8(__rc6)
	bne	.LBB7_12
	ldx	mos8(__rc5)
	bne	.LBB7_12
	ldx	#1
	inc	mos8(__rc4)
	dec	mos8(__rc4)
	beq	.LBB7_13
.LBB7_12:
	pha
	tya
	tax
	pla
.LBB7_13:
	cpx	#0
	beq	.LBB7_14
	jmp	.LBB7_36
.LBB7_14:
	ldx	mos8(__rc7)
	bpl	.LBB7_15
	jmp	.LBB7_35
.LBB7_15:
	ldx	#0
	ldy	mos8(__rc4)
	sty	mos8(__rc12)
	ldy	mos8(__rc5)
	sty	mos8(__rc3)
	ldy	mos8(__rc6)
	sty	mos8(__rc8)
	ldy	mos8(__rc7)
	sty	mos8(__rc9)
.LBB7_16:
	asl	mos8(__rc12)
	rol	mos8(__rc3)
	rol	mos8(__rc8)
	rol	mos8(__rc9)
	tay
	cmp	mos8(__rc9)
	bne	.LBB7_20
	ldy	mos8(__rc2)
	cpy	mos8(__rc8)
	bne	.LBB7_21
	ldy	mos8(__rc10)
	cpy	mos8(__rc3)
	bne	.LBB7_22
	ldy	mos8(__rc11)
	cpy	mos8(__rc12)
	bcc	.LBB7_24
	jmp	.LBB7_23
.LBB7_20:
	tay
	cmp	mos8(__rc9)
	bcc	.LBB7_24
	jmp	.LBB7_23
.LBB7_21:
	cpy	mos8(__rc8)
	bcc	.LBB7_24
	jmp	.LBB7_23
.LBB7_22:
	cpy	mos8(__rc3)
	bcc	.LBB7_24
.LBB7_23:
	inx
	ldy	mos8(__rc12)
	sty	mos8(__rc4)
	ldy	mos8(__rc3)
	sty	mos8(__rc5)
	ldy	mos8(__rc8)
	sty	mos8(__rc6)
	ldy	mos8(__rc9)
	sty	mos8(__rc7)
	bpl	.LBB7_16
	jmp	.LBB7_25
.LBB7_24:
	ldy	mos8(__rc4)
	sty	mos8(__rc12)
	ldy	mos8(__rc5)
	sty	mos8(__rc3)
	ldy	mos8(__rc6)
	sty	mos8(__rc8)
	ldy	mos8(__rc7)
	sty	mos8(__rc9)
.LBB7_25:
	sec
	tay
	lda	mos8(__rc11)
	sbc	mos8(__rc12)
	sta	mos8(__rc11)
	lda	mos8(__rc10)
	sbc	mos8(__rc3)
	sta	mos8(__rc10)
	lda	mos8(__rc2)
	sbc	mos8(__rc8)
	sta	mos8(__rc2)
	tya
	sbc	mos8(__rc9)
	cpx	#0
	bne	.LBB7_26
	jmp	.LBB7_36
.LBB7_26:
	lsr	mos8(__rc9)
	ror	mos8(__rc8)
	ror	mos8(__rc3)
	ror	mos8(__rc12)
	tay
	cmp	mos8(__rc9)
	bne	.LBB7_30
	ldy	mos8(__rc2)
	cpy	mos8(__rc8)
	bne	.LBB7_33
	ldy	mos8(__rc10)
	cpy	mos8(__rc3)
	bne	.LBB7_34
	ldy	mos8(__rc11)
	cpy	mos8(__rc12)
	bcs	.LBB7_31
	jmp	.LBB7_32
.LBB7_30:
	tay
	cmp	mos8(__rc9)
	bcc	.LBB7_32
.LBB7_31:
	tay
	sec
	lda	mos8(__rc11)
	sbc	mos8(__rc12)
	sta	mos8(__rc11)
	lda	mos8(__rc10)
	sbc	mos8(__rc3)
	sta	mos8(__rc10)
	lda	mos8(__rc2)
	sbc	mos8(__rc8)
	sta	mos8(__rc2)
	tya
	sbc	mos8(__rc9)
.LBB7_32:
	dex
	bne	.LBB7_26
	jmp	.LBB7_36
.LBB7_33:
	cpy	mos8(__rc8)
	bcs	.LBB7_31
	jmp	.LBB7_32
.LBB7_34:
	cpy	mos8(__rc3)
	bcs	.LBB7_31
	jmp	.LBB7_32
.LBB7_35:
	sec
	tax
	lda	mos8(__rc11)
	sbc	mos8(__rc4)
	sta	mos8(__rc11)
	lda	mos8(__rc10)
	sbc	mos8(__rc5)
	sta	mos8(__rc10)
	lda	mos8(__rc2)
	sbc	mos8(__rc6)
	sta	mos8(__rc2)
	txa
	sbc	mos8(__rc7)
.LBB7_36:
	sta	mos8(__rc3)
	ldx	mos8(__rc10)
	lda	mos8(__rc11)
	rts
.LBB7_37:
	cpx	mos8(__rc5)
	bcc	.LBB7_38
	jmp	.LBB7_5
.LBB7_38:
	jmp	.LBB7_7
.Lfunc_end7:
	.size	__umodsi3, .Lfunc_end7-__umodsi3

	.section	.text.__umoddi3,"ax",@progbits
	.globl	__umoddi3
	.type	__umoddi3,@function
__umoddi3:
	sta	mos8(__rc16)
	lda	mos8(__rc20)
	pha
	lda	mos8(__rc21)
	pha
	lda	mos8(__rc22)
	pha
	lda	mos8(__rc23)
	pha
	lda	mos8(__rc16)
	ldy	mos8(__rc24)
	sty	.L____umoddi3_sstk
	ldy	mos8(__rc25)
	sty	.L____umoddi3_sstk+1
	ldy	mos8(__rc26)
	sty	.L____umoddi3_sstk+2
	sta	mos8(__rc21)
	stx	mos8(__rc20)
	lda	mos8(__rc5)
	ldx	mos8(__rc6)
	stx	mos8(__rc23)
	ldx	mos8(__rc7)
	cpx	mos8(__rc15)
	bne	.LBB8_8
	ldx	mos8(__rc23)
	cpx	mos8(__rc14)
	bne	.LBB8_10
	cmp	mos8(__rc13)
	beq	.LBB8_3
	jmp	.LBB8_33
.LBB8_3:
	ldx	mos8(__rc4)
	cpx	mos8(__rc12)
	beq	.LBB8_4
	jmp	.LBB8_34
.LBB8_4:
	ldx	mos8(__rc3)
	cpx	mos8(__rc11)
	beq	.LBB8_5
	jmp	.LBB8_40
.LBB8_5:
	ldx	mos8(__rc2)
	cpx	mos8(__rc10)
	beq	.LBB8_6
	jmp	.LBB8_42
.LBB8_6:
	ldx	mos8(__rc20)
	cpx	mos8(__rc9)
	beq	.LBB8_7
	jmp	.LBB8_44
.LBB8_7:
	ldx	mos8(__rc21)
	cpx	mos8(__rc8)
	bcs	.LBB8_9
	jmp	.LBB8_11
.LBB8_8:
	cpx	mos8(__rc15)
	bcc	.LBB8_11
.LBB8_9:
	ldy	#0
	jmp	.LBB8_12
.LBB8_10:
	ldx	mos8(__rc23)
	cpx	mos8(__rc14)
	bcs	.LBB8_9
.LBB8_11:
	ldy	#1
.LBB8_12:
	ldx	mos8(__rc15)
	bne	.LBB8_20
	ldx	mos8(__rc14)
	bne	.LBB8_20
	ldx	mos8(__rc13)
	bne	.LBB8_20
	ldx	mos8(__rc12)
	bne	.LBB8_20
	ldx	mos8(__rc11)
	bne	.LBB8_20
	ldx	mos8(__rc10)
	bne	.LBB8_20
	ldx	mos8(__rc9)
	bne	.LBB8_20
	ldx	#1
	inc	mos8(__rc8)
	dec	mos8(__rc8)
	beq	.LBB8_21
.LBB8_20:
	pha
	tya
	tax
	pla
.LBB8_21:
	cpx	#0
	beq	.LBB8_22
	jmp	.LBB8_67
.LBB8_22:
	ldx	mos8(__rc15)
	bpl	.LBB8_23
	jmp	.LBB8_32
.LBB8_23:
	ldx	#0
	ldy	mos8(__rc8)
	sty	mos8(__rc26)
	ldy	mos8(__rc9)
	sty	mos8(__rc25)
	ldy	mos8(__rc10)
	sty	mos8(__rc24)
	ldy	mos8(__rc11)
	sty	mos8(__rc5)
	ldy	mos8(__rc12)
	sty	mos8(__rc6)
	ldy	mos8(__rc13)
	sty	mos8(__rc22)
	ldy	mos8(__rc14)
	sty	mos8(__rc18)
	ldy	mos8(__rc15)
	sty	mos8(__rc19)
.LBB8_24:
	asl	mos8(__rc26)
	rol	mos8(__rc25)
	rol	mos8(__rc24)
	rol	mos8(__rc5)
	rol	mos8(__rc6)
	rol	mos8(__rc22)
	rol	mos8(__rc18)
	rol	mos8(__rc19)
	ldy	mos8(__rc7)
	cpy	mos8(__rc19)
	bne	.LBB8_28
	ldy	mos8(__rc23)
	cpy	mos8(__rc18)
	bne	.LBB8_29
	cmp	mos8(__rc22)
	bne	.LBB8_30
	ldy	mos8(__rc4)
	cpy	mos8(__rc6)
	beq	.LBB8_68
	jmp	.LBB8_39
.LBB8_68:
	jmp	.LBB8_35
.LBB8_28:
	cpy	mos8(__rc19)
	bcs	.LBB8_31
	jmp	.LBB8_46
.LBB8_29:
	ldy	mos8(__rc23)
	cpy	mos8(__rc18)
	bcs	.LBB8_31
	jmp	.LBB8_46
.LBB8_30:
	cmp	mos8(__rc22)
	bcs	.LBB8_31
	jmp	.LBB8_46
.LBB8_31:
	inx
	ldy	mos8(__rc26)
	sty	mos8(__rc8)
	ldy	mos8(__rc25)
	sty	mos8(__rc9)
	ldy	mos8(__rc24)
	sty	mos8(__rc10)
	ldy	mos8(__rc5)
	sty	mos8(__rc11)
	ldy	mos8(__rc6)
	sty	mos8(__rc12)
	ldy	mos8(__rc22)
	sty	mos8(__rc13)
	ldy	mos8(__rc18)
	sty	mos8(__rc14)
	ldy	mos8(__rc19)
	sty	mos8(__rc15)
	bmi	.LBB8_69
	jmp	.LBB8_24
.LBB8_69:
	jmp	.LBB8_47
.LBB8_32:
	sec
	ldx	mos8(__rc23)
	tay
	lda	mos8(__rc21)
	sbc	mos8(__rc8)
	sta	mos8(__rc21)
	lda	mos8(__rc20)
	sbc	mos8(__rc9)
	sta	mos8(__rc20)
	stx	mos8(__rc5)
	lda	mos8(__rc2)
	sbc	mos8(__rc10)
	sta	mos8(__rc2)
	lda	mos8(__rc3)
	sbc	mos8(__rc11)
	sta	mos8(__rc3)
	lda	mos8(__rc4)
	sbc	mos8(__rc12)
	sta	mos8(__rc4)
	tya
	sbc	mos8(__rc13)
	tax
	lda	mos8(__rc5)
	sbc	mos8(__rc14)
	sta	mos8(__rc23)
	lda	mos8(__rc7)
	sbc	mos8(__rc15)
	sta	mos8(__rc7)
	txa
	jmp	.LBB8_67
.LBB8_33:
	cmp	mos8(__rc13)
	bcc	.LBB8_70
	jmp	.LBB8_9
.LBB8_70:
	jmp	.LBB8_11
.LBB8_34:
	cpx	mos8(__rc12)
	bcc	.LBB8_71
	jmp	.LBB8_9
.LBB8_71:
	jmp	.LBB8_11
.LBB8_35:
	ldy	mos8(__rc3)
	cpy	mos8(__rc5)
	bne	.LBB8_41
	ldy	mos8(__rc2)
	cpy	mos8(__rc24)
	bne	.LBB8_43
	ldy	mos8(__rc20)
	cpy	mos8(__rc25)
	bne	.LBB8_45
	ldy	mos8(__rc21)
	cpy	mos8(__rc26)
	bcc	.LBB8_46
	jmp	.LBB8_31
.LBB8_39:
	cpy	mos8(__rc6)
	bcc	.LBB8_46
	jmp	.LBB8_31
.LBB8_40:
	cpx	mos8(__rc11)
	bcc	.LBB8_72
	jmp	.LBB8_9
.LBB8_72:
	jmp	.LBB8_11
.LBB8_41:
	cpy	mos8(__rc5)
	bcc	.LBB8_46
	jmp	.LBB8_31
.LBB8_42:
	cpx	mos8(__rc10)
	bcc	.LBB8_73
	jmp	.LBB8_9
.LBB8_73:
	jmp	.LBB8_11
.LBB8_43:
	cpy	mos8(__rc24)
	bcc	.LBB8_46
	jmp	.LBB8_31
.LBB8_44:
	cpx	mos8(__rc9)
	bcc	.LBB8_74
	jmp	.LBB8_9
.LBB8_74:
	jmp	.LBB8_11
.LBB8_45:
	cpy	mos8(__rc25)
	bcc	.LBB8_46
	jmp	.LBB8_31
.LBB8_46:
	ldy	mos8(__rc8)
	sty	mos8(__rc26)
	ldy	mos8(__rc9)
	sty	mos8(__rc25)
	ldy	mos8(__rc10)
	sty	mos8(__rc24)
	ldy	mos8(__rc11)
	sty	mos8(__rc5)
	ldy	mos8(__rc12)
	sty	mos8(__rc6)
	ldy	mos8(__rc13)
	sty	mos8(__rc22)
	ldy	mos8(__rc14)
	sty	mos8(__rc18)
	ldy	mos8(__rc15)
	sty	mos8(__rc19)
.LBB8_47:
	sec
	ldy	mos8(__rc23)
	sta	mos8(__rc8)
	lda	mos8(__rc21)
	sbc	mos8(__rc26)
	sta	mos8(__rc21)
	lda	mos8(__rc20)
	sbc	mos8(__rc25)
	sta	mos8(__rc20)
	sty	mos8(__rc9)
	lda	mos8(__rc2)
	sbc	mos8(__rc24)
	sta	mos8(__rc2)
	lda	mos8(__rc3)
	sbc	mos8(__rc5)
	sta	mos8(__rc3)
	lda	mos8(__rc4)
	sbc	mos8(__rc6)
	sta	mos8(__rc4)
	lda	mos8(__rc8)
	sbc	mos8(__rc22)
	tay
	lda	mos8(__rc9)
	sbc	mos8(__rc18)
	sta	mos8(__rc23)
	lda	mos8(__rc7)
	sbc	mos8(__rc19)
	sta	mos8(__rc7)
	txa
	bne	.LBB8_48
	jmp	.LBB8_66
.LBB8_48:
	tya
.LBB8_49:
	lsr	mos8(__rc19)
	ror	mos8(__rc18)
	ror	mos8(__rc22)
	ror	mos8(__rc6)
	ror	mos8(__rc5)
	ror	mos8(__rc24)
	ror	mos8(__rc25)
	ror	mos8(__rc26)
	ldy	mos8(__rc7)
	cpy	mos8(__rc19)
	bne	.LBB8_57
	ldy	mos8(__rc23)
	cpy	mos8(__rc18)
	beq	.LBB8_51
	jmp	.LBB8_60
.LBB8_51:
	cmp	mos8(__rc22)
	beq	.LBB8_52
	jmp	.LBB8_61
.LBB8_52:
	ldy	mos8(__rc4)
	cpy	mos8(__rc6)
	beq	.LBB8_53
	jmp	.LBB8_62
.LBB8_53:
	ldy	mos8(__rc3)
	cpy	mos8(__rc5)
	beq	.LBB8_54
	jmp	.LBB8_63
.LBB8_54:
	ldy	mos8(__rc2)
	cpy	mos8(__rc24)
	beq	.LBB8_55
	jmp	.LBB8_64
.LBB8_55:
	ldy	mos8(__rc20)
	cpy	mos8(__rc25)
	beq	.LBB8_56
	jmp	.LBB8_65
.LBB8_56:
	ldy	mos8(__rc21)
	cpy	mos8(__rc26)
	bcs	.LBB8_58
	jmp	.LBB8_59
.LBB8_57:
	cpy	mos8(__rc19)
	bcc	.LBB8_59
.LBB8_58:
	sta	mos8(__rc8)
	ldy	mos8(__rc23)
	sec
	lda	mos8(__rc21)
	sbc	mos8(__rc26)
	sta	mos8(__rc21)
	lda	mos8(__rc20)
	sbc	mos8(__rc25)
	sta	mos8(__rc20)
	lda	mos8(__rc2)
	sbc	mos8(__rc24)
	sta	mos8(__rc2)
	lda	mos8(__rc3)
	sbc	mos8(__rc5)
	sta	mos8(__rc3)
	lda	mos8(__rc4)
	sbc	mos8(__rc6)
	sta	mos8(__rc4)
	lda	mos8(__rc8)
	sbc	mos8(__rc22)
	sta	mos8(__rc8)
	tya
	sbc	mos8(__rc18)
	sta	mos8(__rc23)
	lda	mos8(__rc7)
	sbc	mos8(__rc19)
	sta	mos8(__rc7)
	lda	mos8(__rc8)
.LBB8_59:
	dex
	beq	.LBB8_67
	jmp	.LBB8_49
.LBB8_60:
	ldy	mos8(__rc23)
	cpy	mos8(__rc18)
	bcs	.LBB8_58
	jmp	.LBB8_59
.LBB8_61:
	cmp	mos8(__rc22)
	bcs	.LBB8_58
	jmp	.LBB8_59
.LBB8_62:
	cpy	mos8(__rc6)
	bcs	.LBB8_58
	jmp	.LBB8_59
.LBB8_63:
	cpy	mos8(__rc5)
	bcs	.LBB8_58
	jmp	.LBB8_59
.LBB8_64:
	cpy	mos8(__rc24)
	bcc	.LBB8_59
	jmp	.LBB8_58
.LBB8_65:
	cpy	mos8(__rc25)
	bcc	.LBB8_59
	jmp	.LBB8_58
.LBB8_66:
	tya
.LBB8_67:
	sta	mos8(__rc5)
	ldx	mos8(__rc23)
	stx	mos8(__rc6)
	ldx	mos8(__rc20)
	lda	mos8(__rc21)
	sta	mos8(__rc16)
	ldy	.L____umoddi3_sstk+2
	sty	mos8(__rc26)
	ldy	.L____umoddi3_sstk+1
	sty	mos8(__rc25)
	ldy	.L____umoddi3_sstk
	sty	mos8(__rc24)
	pla
	sta	mos8(__rc23)
	pla
	sta	mos8(__rc22)
	pla
	sta	mos8(__rc21)
	pla
	sta	mos8(__rc20)
	lda	mos8(__rc16)
	rts
.Lfunc_end8:
	.size	__umoddi3, .Lfunc_end8-__umoddi3

	.section	.text.__udivmodqi4,"ax",@progbits
	.globl	__udivmodqi4
	.type	__udivmodqi4,@function
__udivmodqi4:
	stx	mos8(__rc4)
	ldx	#0
	ldy	mos8(__rc4)
	beq	.LBB9_2
	cmp	mos8(__rc4)
	bcs	.LBB9_3
.LBB9_2:
	sta	mos8(__rc5)
	stx	mos8(__rc8)
	jmp	.LBB9_10
.LBB9_3:
	sta	mos8(__rc7)
	lda	mos8(__rc4)
	and	#-128
	ldx	#1
	stx	mos8(__rc8)
	tax
	bne	.LBB9_7
	ldx	#0
	ldy	mos8(__rc4)
	sty	mos8(__rc5)
	asl	mos8(__rc5)
	lda	#0
	rol
	sta	mos8(__rc6)
	cpx	mos8(__rc6)
	bne	.LBB9_11
	lda	mos8(__rc7)
	cmp	mos8(__rc5)
	bcs	.LBB9_12
.LBB9_6:
	sec
	jmp	.LBB9_8
.LBB9_7:
	sec
	lda	mos8(__rc7)
.LBB9_8:
	sbc	mos8(__rc4)
.LBB9_9:
	sta	mos8(__rc5)
.LBB9_10:
	lda	mos8(__rc5)
	ldy	#0
	sta	(mos8(__rc2)),y
	lda	mos8(__rc8)
	rts
.LBB9_11:
	cpx	mos8(__rc6)
	lda	mos8(__rc7)
	bcc	.LBB9_6
.LBB9_12:
	ldx	#0
	stx	mos8(__rc9)
	ldy	#0
	ldx	mos8(__rc4)
	stx	mos8(__rc10)
	jmp	.LBB9_16
.LBB9_13:
	cmp	mos8(__rc6)
	lda	mos8(__rc7)
	sta	mos8(__rc6)
	bcc	.LBB9_18
	jmp	.LBB9_19
.LBB9_14:
	clv
.LBB9_15:
	dey
	bvs	.LBB9_23
.LBB9_16:
	ldx	mos8(__rc10)
	stx	mos8(__rc11)
	ldx	mos8(__rc5)
	stx	mos8(__rc4)
	lda	mos8(__rc5)
	and	#-2
	sta	mos8(__rc10)
	sta	mos8(__rc5)
	asl	mos8(__rc5)
	lda	#0
	rol
	sta	mos8(__rc6)
	ldx	#0
	lda	#0
	cmp	mos8(__rc6)
	bne	.LBB9_13
	lda	mos8(__rc7)
	sta	mos8(__rc6)
	cmp	mos8(__rc5)
	bcs	.LBB9_19
.LBB9_18:
	ldx	#1
.LBB9_19:
	bit	__set_v
	lda	mos8(__rc9)
	bne	.LBB9_15
	lda	mos8(__rc11)
	and	#64
	bit	__set_v
	cmp	#0
	bne	.LBB9_15
	txa
	beq	.LBB9_14
	bit	__set_v
	jmp	.LBB9_15
.LBB9_23:
	sec
	lda	mos8(__rc6)
	sbc	mos8(__rc4)
	cpy	#0
	bne	.LBB9_24
	jmp	.LBB9_9
.LBB9_24:
	sta	mos8(__rc5)
	ldx	#1
	stx	mos8(__rc8)
	jmp	.LBB9_27
.LBB9_25:
	stx	mos8(__rc6)
	ora	#1
	sta	mos8(__rc8)
	sec
	txa
	sbc	mos8(__rc4)
	sta	mos8(__rc5)
.LBB9_26:
	clc
	tya
	adc	#1
	tay
	bcc	.LBB9_27
	jmp	.LBB9_10
.LBB9_27:
	lsr	mos8(__rc4)
	lda	mos8(__rc8)
	asl
	ldx	mos8(__rc5)
	cpx	mos8(__rc4)
	bcs	.LBB9_25
	sta	mos8(__rc8)
	jmp	.LBB9_26
.Lfunc_end9:
	.size	__udivmodqi4, .Lfunc_end9-__udivmodqi4

	.section	.text.__udivmodhi4,"ax",@progbits
	.globl	__udivmodhi4
	.type	__udivmodhi4,@function
__udivmodhi4:
	stx	mos8(__rc8)
	cpx	mos8(__rc3)
	bne	.LBB10_3
	tay
	cmp	mos8(__rc2)
	bcc	.LBB10_4
.LBB10_2:
	lda	#0
	jmp	.LBB10_5
.LBB10_3:
	tay
	cpx	mos8(__rc3)
	bcs	.LBB10_2
.LBB10_4:
	lda	#1
.LBB10_5:
	ldx	mos8(__rc3)
	bne	.LBB10_7
	ldx	#1
	inc	mos8(__rc2)
	dec	mos8(__rc2)
	beq	.LBB10_8
.LBB10_7:
	tax
.LBB10_8:
	lda	#0
	sta	mos8(__rc9)
	lda	#0
	cpx	#0
	beq	.LBB10_11
	sta	mos8(__rc10)
.LBB10_10:
	tya
	jmp	.LBB10_28
.LBB10_11:
	ldx	#1
	stx	mos8(__rc10)
	tya
	ldx	mos8(__rc3)
	bpl	.LBB10_12
	jmp	.LBB10_27
.LBB10_12:
	ldx	#0
	ldy	mos8(__rc2)
	sty	mos8(__rc6)
	ldy	mos8(__rc3)
	sty	mos8(__rc7)
.LBB10_13:
	asl	mos8(__rc6)
	rol	mos8(__rc7)
	ldy	mos8(__rc8)
	cpy	mos8(__rc7)
	bne	.LBB10_15
	cmp	mos8(__rc6)
	bcs	.LBB10_16
	jmp	.LBB10_17
.LBB10_15:
	cpy	mos8(__rc7)
	bcc	.LBB10_17
.LBB10_16:
	inx
	ldy	mos8(__rc6)
	sty	mos8(__rc2)
	ldy	mos8(__rc7)
	sty	mos8(__rc3)
	bpl	.LBB10_13
	jmp	.LBB10_18
.LBB10_17:
	ldy	mos8(__rc2)
	sty	mos8(__rc6)
	ldy	mos8(__rc3)
	sty	mos8(__rc7)
.LBB10_18:
	sec
	sbc	mos8(__rc6)
	tay
	lda	mos8(__rc8)
	sbc	mos8(__rc7)
	sta	mos8(__rc8)
	txa
	beq	.LBB10_10
	lda	#0
	sta	mos8(__rc9)
	lda	#1
	sta	mos8(__rc10)
	tya
.LBB10_20:
	lsr	mos8(__rc7)
	ror	mos8(__rc6)
	asl	mos8(__rc10)
	ldy	#1
	bcs	.LBB10_22
	ldy	#0
.LBB10_22:
	sty	mos8(__rc2)
	ldy	mos8(__rc8)
	cpy	mos8(__rc7)
	bne	.LBB10_26
	cmp	mos8(__rc6)
	bcc	.LBB10_25
.LBB10_24:
	tay
	lda	mos8(__rc10)
	ora	#1
	sta	mos8(__rc10)
	sec
	tya
	sbc	mos8(__rc6)
	tay
	lda	mos8(__rc8)
	sbc	mos8(__rc7)
	sta	mos8(__rc8)
	tya
.LBB10_25:
	ldy	#0
	pha
	lda	mos8(__rc2)
	cmp	#1
	pla
	rol	mos8(__rc9)
	dex
	bne	.LBB10_20
	jmp	.LBB10_29
.LBB10_26:
	cpy	mos8(__rc7)
	bcs	.LBB10_24
	jmp	.LBB10_25
.LBB10_27:
	sec
	sbc	mos8(__rc2)
	tax
	lda	mos8(__rc8)
	sbc	mos8(__rc3)
	sta	mos8(__rc8)
	txa
.LBB10_28:
	ldy	#0
.LBB10_29:
	sta	(mos8(__rc4)),y
	ldy	#1
	lda	mos8(__rc8)
	sta	(mos8(__rc4)),y
	ldx	mos8(__rc9)
	lda	mos8(__rc10)
	rts
.Lfunc_end10:
	.size	__udivmodhi4, .Lfunc_end10-__udivmodhi4

	.section	.text.__udivmodsi4,"ax",@progbits
	.globl	__udivmodsi4
	.type	__udivmodsi4,@function
__udivmodsi4:
	stx	mos8(__rc14)
	ldy	mos8(__rc2)
	ldx	mos8(__rc3)
	sty	mos8(__rc13)
	cpx	mos8(__rc7)
	bne	.LBB11_4
	cpy	mos8(__rc6)
	bne	.LBB11_6
	stx	mos8(__rc12)
	ldx	mos8(__rc14)
	cpx	mos8(__rc5)
	beq	.LBB11_3
	jmp	.LBB11_40
.LBB11_3:
	stx	mos8(__rc14)
	tax
	cmp	mos8(__rc4)
	bcs	.LBB11_5
	jmp	.LBB11_7
.LBB11_4:
	stx	mos8(__rc12)
	cpx	mos8(__rc7)
	bcc	.LBB11_7
.LBB11_5:
	ldy	#0
	jmp	.LBB11_8
.LBB11_6:
	stx	mos8(__rc12)
	cpy	mos8(__rc6)
	bcs	.LBB11_5
.LBB11_7:
	ldy	#1
.LBB11_8:
	ldx	mos8(__rc7)
	bne	.LBB11_12
	ldx	mos8(__rc6)
	bne	.LBB11_12
	ldx	mos8(__rc5)
	bne	.LBB11_12
	ldx	#1
	inc	mos8(__rc4)
	dec	mos8(__rc4)
	beq	.LBB11_13
.LBB11_12:
	pha
	tya
	tax
	pla
.LBB11_13:
	ldy	#0
	sty	mos8(__rc15)
	ldy	#0
	cpx	#0
	beq	.LBB11_15
	sty	mos8(__rc18)
	ldx	#0
	stx	mos8(__rc3)
	sta	mos8(__rc4)
	ldx	#0
	stx	mos8(__rc6)
	jmp	.LBB11_42
.LBB11_15:
	ldx	#1
	stx	mos8(__rc18)
	ldx	mos8(__rc7)
	bpl	.LBB11_16
	jmp	.LBB11_39
.LBB11_16:
	ldx	#0
	ldy	mos8(__rc4)
	sty	mos8(__rc2)
	ldy	mos8(__rc5)
	sty	mos8(__rc19)
	ldy	mos8(__rc6)
	sty	mos8(__rc10)
	ldy	mos8(__rc7)
	sty	mos8(__rc11)
	ldy	mos8(__rc12)
	sty	mos8(__rc3)
.LBB11_17:
	asl	mos8(__rc2)
	rol	mos8(__rc19)
	rol	mos8(__rc10)
	rol	mos8(__rc11)
	ldy	mos8(__rc3)
	cpy	mos8(__rc11)
	bne	.LBB11_21
	ldy	mos8(__rc13)
	cpy	mos8(__rc10)
	bne	.LBB11_22
	ldy	mos8(__rc14)
	cpy	mos8(__rc19)
	bne	.LBB11_23
	tay
	cmp	mos8(__rc2)
	bcc	.LBB11_25
	jmp	.LBB11_24
.LBB11_21:
	ldy	mos8(__rc3)
	cpy	mos8(__rc11)
	bcs	.LBB11_24
	jmp	.LBB11_25
.LBB11_22:
	cpy	mos8(__rc10)
	bcc	.LBB11_25
	jmp	.LBB11_24
.LBB11_23:
	cpy	mos8(__rc19)
	bcc	.LBB11_25
.LBB11_24:
	inx
	ldy	mos8(__rc2)
	sty	mos8(__rc4)
	ldy	mos8(__rc19)
	sty	mos8(__rc5)
	ldy	mos8(__rc10)
	sty	mos8(__rc6)
	ldy	mos8(__rc11)
	sty	mos8(__rc7)
	bpl	.LBB11_17
	jmp	.LBB11_26
.LBB11_25:
	ldy	mos8(__rc4)
	sty	mos8(__rc2)
	ldy	mos8(__rc5)
	sty	mos8(__rc19)
	ldy	mos8(__rc6)
	sty	mos8(__rc10)
	ldy	mos8(__rc7)
	sty	mos8(__rc11)
.LBB11_26:
	sec
	sbc	mos8(__rc2)
	sta	mos8(__rc4)
	lda	mos8(__rc14)
	sbc	mos8(__rc19)
	sta	mos8(__rc14)
	lda	mos8(__rc13)
	sbc	mos8(__rc10)
	sta	mos8(__rc5)
	lda	mos8(__rc3)
	sbc	mos8(__rc11)
	sta	mos8(__rc12)
	txa
	bne	.LBB11_27
	jmp	.LBB11_41
.LBB11_27:
	lda	#0
	sta	mos8(__rc15)
	lda	#1
	sta	mos8(__rc18)
	ldy	#0
	sty	mos8(__rc6)
	ldy	#0
	sty	mos8(__rc3)
	ldy	mos8(__rc5)
	sty	mos8(__rc13)
.LBB11_28:
	lsr	mos8(__rc11)
	ror	mos8(__rc10)
	ror	mos8(__rc19)
	ror	mos8(__rc2)
	asl	mos8(__rc18)
	ldy	#1
	bcs	.LBB11_30
	ldy	#0
.LBB11_30:
	sty	mos8(__rc7)
	ldy	mos8(__rc12)
	cpy	mos8(__rc11)
	bne	.LBB11_34
	ldy	mos8(__rc13)
	cpy	mos8(__rc10)
	bne	.LBB11_37
	ldy	mos8(__rc14)
	cpy	mos8(__rc19)
	bne	.LBB11_38
	ldy	mos8(__rc4)
	cpy	mos8(__rc2)
	bcs	.LBB11_35
	jmp	.LBB11_36
.LBB11_34:
	cpy	mos8(__rc11)
	bcc	.LBB11_36
.LBB11_35:
	ldy	mos8(__rc6)
	sty	mos8(__rc5)
	sec
	lda	mos8(__rc4)
	sbc	mos8(__rc2)
	sta	mos8(__rc4)
	lda	mos8(__rc14)
	sbc	mos8(__rc19)
	sta	mos8(__rc14)
	lda	mos8(__rc13)
	sbc	mos8(__rc10)
	tay
	lda	mos8(__rc12)
	sbc	mos8(__rc11)
	sta	mos8(__rc12)
	sty	mos8(__rc13)
	lda	mos8(__rc18)
	ora	#1
	sta	mos8(__rc18)
.LBB11_36:
	ldy	#0
	lda	mos8(__rc7)
	cmp	#1
	rol	mos8(__rc15)
	rol	mos8(__rc6)
	rol	mos8(__rc3)
	dex
	beq	.LBB11_42
	jmp	.LBB11_28
.LBB11_37:
	cpy	mos8(__rc10)
	bcc	.LBB11_36
	jmp	.LBB11_35
.LBB11_38:
	cpy	mos8(__rc19)
	bcs	.LBB11_35
	jmp	.LBB11_36
.LBB11_39:
	sec
	sbc	mos8(__rc4)
	sta	mos8(__rc4)
	lda	mos8(__rc14)
	sbc	mos8(__rc5)
	sta	mos8(__rc14)
	lda	mos8(__rc13)
	sbc	mos8(__rc6)
	sta	mos8(__rc13)
	lda	mos8(__rc12)
	sbc	mos8(__rc7)
	sta	mos8(__rc12)
	ldx	#0
	stx	mos8(__rc6)
	ldx	#0
	stx	mos8(__rc3)
	jmp	.LBB11_42
.LBB11_40:
	stx	mos8(__rc14)
	cpx	mos8(__rc5)
	bcc	.LBB11_43
	jmp	.LBB11_5
.LBB11_43:
	jmp	.LBB11_7
.LBB11_41:
	ldx	#0
	stx	mos8(__rc6)
	ldx	#0
	stx	mos8(__rc3)
	ldx	mos8(__rc5)
	stx	mos8(__rc13)
	ldy	#0
.LBB11_42:
	lda	mos8(__rc4)
	sta	(mos8(__rc8)),y
	ldy	#1
	ldx	mos8(__rc6)
	stx	mos8(__rc2)
	lda	mos8(__rc14)
	sta	(mos8(__rc8)),y
	iny
	lda	mos8(__rc13)
	sta	(mos8(__rc8)),y
	iny
	lda	mos8(__rc12)
	sta	(mos8(__rc8)),y
	ldx	mos8(__rc15)
	lda	mos8(__rc18)
	rts
.Lfunc_end11:
	.size	__udivmodsi4, .Lfunc_end11-__udivmodsi4

	.section	.text.__udivmoddi4,"ax",@progbits
	.globl	__udivmoddi4
	.type	__udivmoddi4,@function
__udivmoddi4:
	sta	mos8(__rc16)
	lda	mos8(__rc20)
	pha
	lda	mos8(__rc21)
	pha
	lda	mos8(__rc22)
	pha
	lda	mos8(__rc23)
	pha
	lda	mos8(__rc16)
	ldy	mos8(__rc24)
	sty	.L____udivmoddi4_sstk+1
	ldy	mos8(__rc25)
	sty	.L____udivmoddi4_sstk+2
	ldy	mos8(__rc26)
	sty	.L____udivmoddi4_sstk+3
	ldy	mos8(__rc27)
	sty	.L____udivmoddi4_sstk+4
	ldy	mos8(__rc28)
	sty	.L____udivmoddi4_sstk+5
	ldy	mos8(__rc29)
	sty	.L____udivmoddi4_sstk+6
	ldy	mos8(__rc30)
	sty	.L____udivmoddi4_sstk+7
	ldy	mos8(__rc31)
	sty	.L____udivmoddi4_sstk+8
	sta	.L____udivmoddi4_sstk
	stx	mos8(__rc28)
	lda	mos8(__rc6)
	ldx	mos8(__rc7)
	clc
	ldy	mos8(__rc0)
	sty	mos8(__rc6)
	ldy	mos8(__rc1)
	sty	mos8(__rc7)
	ldy	#0
	sta	mos8(__rc23)
	cpx	mos8(__rc15)
	bne	.LBB12_8
	cmp	mos8(__rc14)
	bne	.LBB12_10
	ldy	mos8(__rc5)
	cpy	mos8(__rc13)
	beq	.LBB12_3
	jmp	.LBB12_35
.LBB12_3:
	ldy	mos8(__rc4)
	cpy	mos8(__rc12)
	beq	.LBB12_4
	jmp	.LBB12_36
.LBB12_4:
	ldy	mos8(__rc3)
	cpy	mos8(__rc11)
	beq	.LBB12_5
	jmp	.LBB12_42
.LBB12_5:
	ldy	mos8(__rc2)
	cpy	mos8(__rc10)
	beq	.LBB12_6
	jmp	.LBB12_44
.LBB12_6:
	stx	mos8(__rc22)
	ldx	mos8(__rc28)
	cpx	mos8(__rc9)
	beq	.LBB12_7
	jmp	.LBB12_46
.LBB12_7:
	ldx	.L____udivmoddi4_sstk
	cpx	mos8(__rc8)
	jmp	.LBB12_47
.LBB12_8:
	stx	mos8(__rc22)
	cpx	mos8(__rc15)
	bcc	.LBB12_11
.LBB12_9:
	clv
	jmp	.LBB12_12
.LBB12_10:
	stx	mos8(__rc22)
	cmp	mos8(__rc14)
	bcs	.LBB12_9
.LBB12_11:
	bit	__set_v
.LBB12_12:
	lda	(mos8(__rc6)),y
	sta	mos8(__rc26)
	ldy	#1
	ldx	#1
	stx	mos8(__rc30)
	lda	(mos8(__rc6)),y
	ldx	mos8(__rc15)
	bne	.LBB12_20
	ldx	mos8(__rc14)
	bne	.LBB12_20
	ldx	mos8(__rc13)
	bne	.LBB12_20
	ldx	mos8(__rc12)
	bne	.LBB12_20
	ldx	mos8(__rc11)
	bne	.LBB12_20
	ldx	mos8(__rc10)
	bne	.LBB12_20
	ldx	mos8(__rc9)
	bne	.LBB12_20
	ldx	#1
	ldy	mos8(__rc8)
	beq	.LBB12_22
.LBB12_20:
	ldx	#1
	bvs	.LBB12_22
	ldx	#0
.LBB12_22:
	sta	mos8(__rc27)
	ldy	#0
	txa
	beq	.LBB12_24
	ldx	#0
	stx	mos8(__rc10)
	stx	mos8(__rc11)
	stx	mos8(__rc12)
	stx	mos8(__rc13)
	stx	mos8(__rc14)
	stx	mos8(__rc15)
	stx	mos8(__rc30)
	tya
	ldx	mos8(__rc4)
	stx	mos8(__rc31)
	jmp	.LBB12_73
.LBB12_24:
	lda	mos8(__rc15)
	bpl	.LBB12_25
	jmp	.LBB12_34
.LBB12_25:
	ldx	#0
	ldy	mos8(__rc8)
	sty	mos8(__rc25)
	ldy	mos8(__rc9)
	sty	mos8(__rc24)
	ldy	mos8(__rc10)
	sty	mos8(__rc6)
	ldy	mos8(__rc11)
	sty	mos8(__rc7)
	ldy	mos8(__rc12)
	sty	mos8(__rc18)
	ldy	mos8(__rc13)
	sty	mos8(__rc19)
	ldy	mos8(__rc14)
	sty	mos8(__rc20)
	ldy	mos8(__rc15)
	sty	mos8(__rc21)
	lda	mos8(__rc2)
.LBB12_26:
	asl	mos8(__rc25)
	rol	mos8(__rc24)
	rol	mos8(__rc6)
	rol	mos8(__rc7)
	rol	mos8(__rc18)
	rol	mos8(__rc19)
	rol	mos8(__rc20)
	rol	mos8(__rc21)
	ldy	mos8(__rc22)
	cpy	mos8(__rc21)
	bne	.LBB12_30
	ldy	mos8(__rc22)
	sty	mos8(__rc2)
	ldy	mos8(__rc23)
	cpy	mos8(__rc20)
	bne	.LBB12_31
	ldy	mos8(__rc5)
	cpy	mos8(__rc19)
	bne	.LBB12_32
	ldy	mos8(__rc4)
	cpy	mos8(__rc18)
	beq	.LBB12_74
	jmp	.LBB12_41
.LBB12_74:
	jmp	.LBB12_37
.LBB12_30:
	ldy	mos8(__rc22)
	sty	mos8(__rc2)
	cpy	mos8(__rc21)
	bcs	.LBB12_33
	jmp	.LBB12_49
.LBB12_31:
	cpy	mos8(__rc20)
	bcs	.LBB12_33
	jmp	.LBB12_49
.LBB12_32:
	cpy	mos8(__rc19)
	bcs	.LBB12_33
	jmp	.LBB12_49
.LBB12_33:
	inx
	ldy	mos8(__rc25)
	sty	mos8(__rc8)
	ldy	mos8(__rc24)
	sty	mos8(__rc9)
	ldy	mos8(__rc6)
	sty	mos8(__rc10)
	ldy	mos8(__rc7)
	sty	mos8(__rc11)
	ldy	mos8(__rc18)
	sty	mos8(__rc12)
	ldy	mos8(__rc19)
	sty	mos8(__rc13)
	ldy	mos8(__rc20)
	sty	mos8(__rc14)
	ldy	mos8(__rc21)
	sty	mos8(__rc15)
	ldy	mos8(__rc2)
	sty	mos8(__rc22)
	ldy	mos8(__rc21)
	bmi	.LBB12_75
	jmp	.LBB12_26
.LBB12_75:
	jmp	.LBB12_50
.LBB12_34:
	ldx	mos8(__rc30)
	sec
	lda	.L____udivmoddi4_sstk
	sbc	mos8(__rc8)
	sta	.L____udivmoddi4_sstk
	lda	mos8(__rc28)
	sbc	mos8(__rc9)
	sta	mos8(__rc28)
	lda	mos8(__rc2)
	sbc	mos8(__rc10)
	sta	mos8(__rc2)
	lda	mos8(__rc3)
	sbc	mos8(__rc11)
	sta	mos8(__rc3)
	lda	mos8(__rc4)
	sbc	mos8(__rc12)
	sta	mos8(__rc31)
	lda	mos8(__rc5)
	sbc	mos8(__rc13)
	sta	mos8(__rc5)
	lda	mos8(__rc23)
	sbc	mos8(__rc14)
	sta	mos8(__rc23)
	lda	mos8(__rc22)
	sbc	mos8(__rc15)
	sta	mos8(__rc22)
	txa
	ldx	#0
	stx	mos8(__rc10)
	stx	mos8(__rc11)
	stx	mos8(__rc12)
	stx	mos8(__rc13)
	stx	mos8(__rc14)
	stx	mos8(__rc15)
	stx	mos8(__rc30)
	jmp	.LBB12_73
.LBB12_35:
	stx	mos8(__rc22)
	cpy	mos8(__rc13)
	jmp	.LBB12_47
.LBB12_36:
	stx	mos8(__rc22)
	cpy	mos8(__rc12)
	jmp	.LBB12_47
.LBB12_37:
	ldy	mos8(__rc3)
	cpy	mos8(__rc7)
	bne	.LBB12_43
	cmp	mos8(__rc6)
	bne	.LBB12_45
	ldy	mos8(__rc28)
	cpy	mos8(__rc24)
	bne	.LBB12_48
	ldy	.L____udivmoddi4_sstk
	cpy	mos8(__rc25)
	bcc	.LBB12_49
	jmp	.LBB12_33
.LBB12_41:
	cpy	mos8(__rc18)
	bcc	.LBB12_49
	jmp	.LBB12_33
.LBB12_42:
	stx	mos8(__rc22)
	cpy	mos8(__rc11)
	jmp	.LBB12_47
.LBB12_43:
	cpy	mos8(__rc7)
	bcc	.LBB12_49
	jmp	.LBB12_33
.LBB12_44:
	stx	mos8(__rc22)
	cpy	mos8(__rc10)
	jmp	.LBB12_47
.LBB12_45:
	cmp	mos8(__rc6)
	bcc	.LBB12_49
	jmp	.LBB12_33
.LBB12_46:
	cpx	mos8(__rc9)
.LBB12_47:
	ldy	#0
	bcc	.LBB12_76
	jmp	.LBB12_9
.LBB12_76:
	jmp	.LBB12_11
.LBB12_48:
	cpy	mos8(__rc24)
	bcc	.LBB12_49
	jmp	.LBB12_33
.LBB12_49:
	ldy	mos8(__rc8)
	sty	mos8(__rc25)
	ldy	mos8(__rc9)
	sty	mos8(__rc24)
	ldy	mos8(__rc10)
	sty	mos8(__rc6)
	ldy	mos8(__rc11)
	sty	mos8(__rc7)
	ldy	mos8(__rc12)
	sty	mos8(__rc18)
	ldy	mos8(__rc13)
	sty	mos8(__rc19)
	ldy	mos8(__rc14)
	sty	mos8(__rc20)
	ldy	mos8(__rc15)
	sty	mos8(__rc21)
	ldy	mos8(__rc2)
	sty	mos8(__rc22)
.LBB12_50:
	sec
	tay
	lda	.L____udivmoddi4_sstk
	sbc	mos8(__rc25)
	sta	.L____udivmoddi4_sstk
	lda	mos8(__rc28)
	sbc	mos8(__rc24)
	sta	mos8(__rc9)
	tya
	sbc	mos8(__rc6)
	sta	mos8(__rc2)
	lda	mos8(__rc3)
	sbc	mos8(__rc7)
	sta	mos8(__rc3)
	lda	mos8(__rc4)
	sbc	mos8(__rc18)
	sta	mos8(__rc4)
	lda	mos8(__rc5)
	sbc	mos8(__rc19)
	sta	mos8(__rc5)
	lda	mos8(__rc23)
	sbc	mos8(__rc20)
	sta	mos8(__rc8)
	lda	mos8(__rc22)
	sbc	mos8(__rc21)
	sta	mos8(__rc22)
	txa
	bne	.LBB12_51
	jmp	.LBB12_72
.LBB12_51:
	lda	#0
	sta	mos8(__rc10)
	lda	#1
	ldy	#0
	sty	mos8(__rc11)
	ldy	#0
	sty	mos8(__rc12)
	ldy	#0
	sty	mos8(__rc13)
	ldy	#0
	sty	mos8(__rc14)
	ldy	#0
	sty	mos8(__rc15)
	ldy	#0
	sty	mos8(__rc30)
	ldy	mos8(__rc8)
	sty	mos8(__rc23)
	ldy	mos8(__rc4)
	sty	mos8(__rc31)
	ldy	mos8(__rc9)
	sty	mos8(__rc28)
.LBB12_52:
	lsr	mos8(__rc21)
	ror	mos8(__rc20)
	ror	mos8(__rc19)
	ror	mos8(__rc18)
	ror	mos8(__rc7)
	ror	mos8(__rc6)
	ror	mos8(__rc24)
	ror	mos8(__rc25)
	asl
	ldy	#1
	bcs	.LBB12_54
	ldy	#0
.LBB12_54:
	sty	mos8(__rc29)
	ldy	mos8(__rc22)
	cpy	mos8(__rc21)
	bne	.LBB12_62
	sta	mos8(__rc4)
	ldy	mos8(__rc23)
	cpy	mos8(__rc20)
	beq	.LBB12_56
	jmp	.LBB12_65
.LBB12_56:
	ldy	mos8(__rc5)
	cpy	mos8(__rc19)
	beq	.LBB12_57
	jmp	.LBB12_66
.LBB12_57:
	ldy	mos8(__rc31)
	cpy	mos8(__rc18)
	beq	.LBB12_58
	jmp	.LBB12_67
.LBB12_58:
	ldy	mos8(__rc3)
	cpy	mos8(__rc7)
	beq	.LBB12_59
	jmp	.LBB12_68
.LBB12_59:
	lda	mos8(__rc2)
	cmp	mos8(__rc6)
	beq	.LBB12_60
	jmp	.LBB12_69
.LBB12_60:
	ldy	mos8(__rc28)
	cpy	mos8(__rc24)
	beq	.LBB12_61
	jmp	.LBB12_70
.LBB12_61:
	ldy	.L____udivmoddi4_sstk
	cpy	mos8(__rc25)
	jmp	.LBB12_71
.LBB12_62:
	cpy	mos8(__rc21)
	bcc	.LBB12_64
.LBB12_63:
	sta	mos8(__rc9)
	sec
	lda	.L____udivmoddi4_sstk
	sbc	mos8(__rc25)
	sta	.L____udivmoddi4_sstk
	lda	mos8(__rc28)
	sbc	mos8(__rc24)
	sta	mos8(__rc8)
	lda	mos8(__rc2)
	sbc	mos8(__rc6)
	sta	mos8(__rc2)
	lda	mos8(__rc3)
	sbc	mos8(__rc7)
	sta	mos8(__rc3)
	lda	mos8(__rc31)
	sbc	mos8(__rc18)
	sta	mos8(__rc4)
	lda	mos8(__rc5)
	sbc	mos8(__rc19)
	sta	mos8(__rc5)
	lda	mos8(__rc23)
	sbc	mos8(__rc20)
	tay
	lda	mos8(__rc22)
	sbc	mos8(__rc21)
	sta	mos8(__rc22)
	lda	mos8(__rc8)
	sta	mos8(__rc28)
	lda	mos8(__rc4)
	sta	mos8(__rc31)
	sty	mos8(__rc23)
	lda	mos8(__rc9)
	ora	#1
.LBB12_64:
	ldy	#0
	pha
	lda	mos8(__rc29)
	cmp	#1
	pla
	rol	mos8(__rc10)
	rol	mos8(__rc11)
	rol	mos8(__rc12)
	rol	mos8(__rc13)
	rol	mos8(__rc14)
	rol	mos8(__rc15)
	rol	mos8(__rc30)
	dex
	beq	.LBB12_73
	jmp	.LBB12_52
.LBB12_65:
	cpy	mos8(__rc20)
	jmp	.LBB12_71
.LBB12_66:
	cpy	mos8(__rc19)
	jmp	.LBB12_71
.LBB12_67:
	cpy	mos8(__rc18)
	jmp	.LBB12_71
.LBB12_68:
	cpy	mos8(__rc7)
	jmp	.LBB12_71
.LBB12_69:
	cmp	mos8(__rc6)
	jmp	.LBB12_71
.LBB12_70:
	cpy	mos8(__rc24)
.LBB12_71:
	lda	mos8(__rc4)
	bcc	.LBB12_64
	jmp	.LBB12_63
.LBB12_72:
	lda	mos8(__rc30)
	ldx	#0
	stx	mos8(__rc10)
	stx	mos8(__rc11)
	stx	mos8(__rc12)
	stx	mos8(__rc13)
	stx	mos8(__rc14)
	stx	mos8(__rc15)
	stx	mos8(__rc30)
	ldx	mos8(__rc8)
	stx	mos8(__rc23)
	ldx	mos8(__rc4)
	stx	mos8(__rc31)
	ldx	mos8(__rc9)
	stx	mos8(__rc28)
	ldy	#0
.LBB12_73:
	sta	mos8(__rc8)
	lda	.L____udivmoddi4_sstk
	sta	(mos8(__rc26)),y
	ldy	#1
	lda	mos8(__rc28)
	sta	(mos8(__rc26)),y
	iny
	lda	mos8(__rc2)
	sta	(mos8(__rc26)),y
	iny
	lda	mos8(__rc3)
	sta	(mos8(__rc26)),y
	iny
	lda	mos8(__rc31)
	sta	(mos8(__rc26)),y
	iny
	lda	mos8(__rc5)
	sta	(mos8(__rc26)),y
	iny
	lda	mos8(__rc23)
	sta	(mos8(__rc26)),y
	iny
	lda	mos8(__rc22)
	sta	(mos8(__rc26)),y
	ldx	mos8(__rc11)
	stx	mos8(__rc2)
	ldx	mos8(__rc12)
	stx	mos8(__rc3)
	ldx	mos8(__rc13)
	stx	mos8(__rc4)
	ldx	mos8(__rc14)
	stx	mos8(__rc5)
	ldx	mos8(__rc15)
	stx	mos8(__rc6)
	ldx	mos8(__rc30)
	stx	mos8(__rc7)
	ldx	mos8(__rc10)
	lda	mos8(__rc8)
	sta	mos8(__rc16)
	ldy	.L____udivmoddi4_sstk+8
	sty	mos8(__rc31)
	ldy	.L____udivmoddi4_sstk+7
	sty	mos8(__rc30)
	ldy	.L____udivmoddi4_sstk+6
	sty	mos8(__rc29)
	ldy	.L____udivmoddi4_sstk+5
	sty	mos8(__rc28)
	ldy	.L____udivmoddi4_sstk+4
	sty	mos8(__rc27)
	ldy	.L____udivmoddi4_sstk+3
	sty	mos8(__rc26)
	ldy	.L____udivmoddi4_sstk+2
	sty	mos8(__rc25)
	ldy	.L____udivmoddi4_sstk+1
	sty	mos8(__rc24)
	pla
	sta	mos8(__rc23)
	pla
	sta	mos8(__rc22)
	pla
	sta	mos8(__rc21)
	pla
	sta	mos8(__rc20)
	lda	mos8(__rc16)
	rts
.Lfunc_end12:
	.size	__udivmoddi4, .Lfunc_end12-__udivmoddi4

	.section	.text.__divqi3,"ax",@progbits
	.globl	__divqi3
	.type	__divqi3,@function
__divqi3:
	sta	mos8(__rc16)
	lda	mos8(__rc20)
	pha
	lda	mos8(__rc21)
	pha
	lda	mos8(__rc16)
	sta	mos8(__rc20)
	txa
	ldx	mos8(__rc20)
	cpx	#129
	ldy	mos8(__rc20)
	bcc	.LBB13_2
	sec
	tax
	lda	#0
	sbc	mos8(__rc20)
	tay
	txa
.LBB13_2:
	cmp	#129
	sta	mos8(__rc21)
	bcc	.LBB13_4
	lda	#0
	sec
	ldx	mos8(__rc21)
	stx	mos8(__rc2)
	sbc	mos8(__rc21)
.LBB13_4:
	tax
	tya
	jsr	__udivqi3
	sta	mos8(__rc2)
	lda	mos8(__rc21)
	eor	mos8(__rc20)
	bpl	.LBB13_6
	lda	#0
	sec
	sbc	mos8(__rc2)
	sta	mos8(__rc2)
.LBB13_6:
	lda	mos8(__rc2)
	sta	mos8(__rc16)
	pla
	sta	mos8(__rc21)
	pla
	sta	mos8(__rc20)
	lda	mos8(__rc16)
	rts
.Lfunc_end13:
	.size	__divqi3, .Lfunc_end13-__divqi3

	.section	.text.__divhi3,"ax",@progbits
	.globl	__divhi3
	.type	__divhi3,@function
__divhi3:
	sta	mos8(__rc16)
	lda	mos8(__rc20)
	pha
	lda	mos8(__rc21)
	pha
	lda	mos8(__rc16)
	sta	mos8(__rc4)
	stx	mos8(__rc20)
	ldy	mos8(__rc3)
	cpx	#128
	bne	.LBB14_3
	ldx	mos8(__rc4)
	cpx	#1
	bcs	.LBB14_4
.LBB14_2:
	ldx	mos8(__rc20)
	stx	mos8(__rc5)
	jmp	.LBB14_5
.LBB14_3:
	ldx	mos8(__rc20)
	cpx	#128
	bcc	.LBB14_2
.LBB14_4:
	sec
	lda	#0
	sbc	mos8(__rc4)
	sta	mos8(__rc4)
	lda	#0
	sbc	mos8(__rc20)
	sta	mos8(__rc5)
.LBB14_5:
	cpy	#128
	bne	.LBB14_8
	ldx	mos8(__rc2)
	cpx	#1
	bcs	.LBB14_9
.LBB14_7:
	tya
	sta	mos8(__rc21)
	jmp	.LBB14_10
.LBB14_8:
	cpy	#128
	bcc	.LBB14_7
.LBB14_9:
	sec
	lda	#0
	sbc	mos8(__rc2)
	sta	mos8(__rc2)
	lda	#0
	sty	mos8(__rc3)
	ldx	mos8(__rc3)
	stx	mos8(__rc21)
	sbc	mos8(__rc3)
.LBB14_10:
	sta	mos8(__rc3)
	ldx	mos8(__rc5)
	lda	mos8(__rc4)
	jsr	__udivhi3
	sta	mos8(__rc3)
	stx	mos8(__rc2)
	lda	mos8(__rc21)
	eor	mos8(__rc20)
	bpl	.LBB14_12
	sec
	lda	#0
	sbc	mos8(__rc3)
	sta	mos8(__rc3)
	lda	#0
	sbc	mos8(__rc2)
	sta	mos8(__rc2)
.LBB14_12:
	ldx	mos8(__rc2)
	lda	mos8(__rc3)
	sta	mos8(__rc16)
	pla
	sta	mos8(__rc21)
	pla
	sta	mos8(__rc20)
	lda	mos8(__rc16)
	rts
.Lfunc_end14:
	.size	__divhi3, .Lfunc_end14-__divhi3

	.section	.text.__divsi3,"ax",@progbits
	.globl	__divsi3
	.type	__divsi3,@function
__divsi3:
	sta	mos8(__rc16)
	lda	mos8(__rc20)
	pha
	lda	mos8(__rc21)
	pha
	lda	mos8(__rc16)
	sta	mos8(__rc9)
	stx	mos8(__rc8)
	ldx	mos8(__rc3)
	stx	mos8(__rc20)
	ldx	mos8(__rc7)
	stx	mos8(__rc21)
	ldx	mos8(__rc3)
	cpx	#128
	bne	.LBB15_4
	lda	mos8(__rc2)
	bne	.LBB15_6
	lda	mos8(__rc8)
	bne	.LBB15_7
	ldx	mos8(__rc9)
	cpx	#1
	bcc	.LBB15_5
	jmp	.LBB15_9
.LBB15_4:
	ldx	mos8(__rc20)
	cpx	#128
	bcs	.LBB15_9
.LBB15_5:
	ldy	mos8(__rc20)
	jmp	.LBB15_10
.LBB15_6:
	ldx	mos8(__rc2)
	jmp	.LBB15_8
.LBB15_7:
	ldx	mos8(__rc8)
.LBB15_8:
	cpx	#0
	bcc	.LBB15_5
.LBB15_9:
	sec
	lda	#0
	sbc	mos8(__rc9)
	sta	mos8(__rc9)
	lda	#0
	sbc	mos8(__rc8)
	sta	mos8(__rc8)
	lda	#0
	sbc	mos8(__rc2)
	sta	mos8(__rc2)
	lda	#0
	sbc	mos8(__rc20)
	tay
.LBB15_10:
	ldx	mos8(__rc21)
	cpx	#128
	bne	.LBB15_14
	lda	mos8(__rc6)
	bne	.LBB15_16
	lda	mos8(__rc5)
	bne	.LBB15_17
	ldx	mos8(__rc4)
	cpx	#1
	bcc	.LBB15_15
	jmp	.LBB15_19
.LBB15_14:
	ldx	mos8(__rc21)
	cpx	#128
	bcs	.LBB15_19
.LBB15_15:
	lda	mos8(__rc21)
	jmp	.LBB15_20
.LBB15_16:
	ldx	mos8(__rc6)
	jmp	.LBB15_18
.LBB15_17:
	ldx	mos8(__rc5)
.LBB15_18:
	cpx	#0
	bcc	.LBB15_15
.LBB15_19:
	sec
	lda	#0
	sbc	mos8(__rc4)
	sta	mos8(__rc4)
	lda	#0
	sbc	mos8(__rc5)
	sta	mos8(__rc5)
	lda	#0
	sbc	mos8(__rc6)
	sta	mos8(__rc6)
	lda	#0
	sbc	mos8(__rc21)
.LBB15_20:
	sty	mos8(__rc3)
	sta	mos8(__rc7)
	ldx	mos8(__rc8)
	lda	mos8(__rc9)
	jsr	__udivsi3
	sta	mos8(__rc5)
	stx	mos8(__rc4)
	asl	mos8(__rc21)
	lda	#0
	rol
	sta	mos8(__rc6)
	lda	#0
	rol
	asl	mos8(__rc20)
	sta	mos8(__rc7)
	lda	#0
	rol
	sta	mos8(__rc8)
	lda	#0
	rol
	cmp	mos8(__rc7)
	bne	.LBB15_22
	ldx	mos8(__rc8)
	cpx	mos8(__rc6)
	beq	.LBB15_23
.LBB15_22:
	sec
	lda	#0
	sbc	mos8(__rc5)
	sta	mos8(__rc5)
	lda	#0
	sbc	mos8(__rc4)
	sta	mos8(__rc4)
	lda	#0
	sbc	mos8(__rc2)
	sta	mos8(__rc2)
	lda	#0
	sbc	mos8(__rc3)
	sta	mos8(__rc3)
.LBB15_23:
	ldx	mos8(__rc4)
	lda	mos8(__rc5)
	sta	mos8(__rc16)
	pla
	sta	mos8(__rc21)
	pla
	sta	mos8(__rc20)
	lda	mos8(__rc16)
	rts
.Lfunc_end15:
	.size	__divsi3, .Lfunc_end15-__divsi3

	.section	.text.__divdi3,"ax",@progbits
	.globl	__divdi3
	.type	__divdi3,@function
__divdi3:
	sta	mos8(__rc16)
	lda	mos8(__rc20)
	pha
	lda	mos8(__rc21)
	pha
	lda	mos8(__rc16)
	sta	mos8(__rc19)
	stx	mos8(__rc18)
	ldx	mos8(__rc7)
	stx	mos8(__rc20)
	ldx	mos8(__rc15)
	stx	mos8(__rc21)
	ldx	mos8(__rc7)
	cpx	#128
	bne	.LBB16_8
	lda	mos8(__rc6)
	bne	.LBB16_10
	lda	mos8(__rc5)
	bne	.LBB16_11
	lda	mos8(__rc4)
	bne	.LBB16_12
	lda	mos8(__rc3)
	bne	.LBB16_13
	lda	mos8(__rc2)
	bne	.LBB16_14
	lda	mos8(__rc18)
	bne	.LBB16_15
	ldx	mos8(__rc19)
	cpx	#1
	bcc	.LBB16_9
	jmp	.LBB16_17
.LBB16_8:
	ldx	mos8(__rc20)
	cpx	#128
	bcs	.LBB16_17
.LBB16_9:
	ldy	mos8(__rc20)
	jmp	.LBB16_18
.LBB16_10:
	ldx	mos8(__rc6)
	jmp	.LBB16_16
.LBB16_11:
	ldx	mos8(__rc5)
	jmp	.LBB16_16
.LBB16_12:
	ldx	mos8(__rc4)
	jmp	.LBB16_16
.LBB16_13:
	ldx	mos8(__rc3)
	jmp	.LBB16_16
.LBB16_14:
	ldx	mos8(__rc2)
	jmp	.LBB16_16
.LBB16_15:
	ldx	mos8(__rc18)
.LBB16_16:
	cpx	#0
	bcc	.LBB16_9
.LBB16_17:
	sec
	lda	#0
	sbc	mos8(__rc19)
	sta	mos8(__rc19)
	lda	#0
	sbc	mos8(__rc18)
	sta	mos8(__rc18)
	lda	#0
	sbc	mos8(__rc2)
	sta	mos8(__rc2)
	lda	#0
	sbc	mos8(__rc3)
	sta	mos8(__rc3)
	lda	#0
	sbc	mos8(__rc4)
	sta	mos8(__rc4)
	lda	#0
	sbc	mos8(__rc5)
	sta	mos8(__rc5)
	lda	#0
	sbc	mos8(__rc6)
	sta	mos8(__rc6)
	lda	#0
	sbc	mos8(__rc20)
	tay
.LBB16_18:
	ldx	mos8(__rc21)
	cpx	#128
	bne	.LBB16_26
	lda	mos8(__rc14)
	bne	.LBB16_28
	lda	mos8(__rc13)
	bne	.LBB16_29
	lda	mos8(__rc12)
	bne	.LBB16_30
	lda	mos8(__rc11)
	bne	.LBB16_31
	lda	mos8(__rc10)
	bne	.LBB16_32
	lda	mos8(__rc9)
	bne	.LBB16_33
	ldx	mos8(__rc8)
	cpx	#1
	bcc	.LBB16_27
	jmp	.LBB16_35
.LBB16_26:
	ldx	mos8(__rc21)
	cpx	#128
	bcs	.LBB16_35
.LBB16_27:
	lda	mos8(__rc21)
	jmp	.LBB16_36
.LBB16_28:
	ldx	mos8(__rc14)
	jmp	.LBB16_34
.LBB16_29:
	ldx	mos8(__rc13)
	jmp	.LBB16_34
.LBB16_30:
	ldx	mos8(__rc12)
	jmp	.LBB16_34
.LBB16_31:
	ldx	mos8(__rc11)
	jmp	.LBB16_34
.LBB16_32:
	ldx	mos8(__rc10)
	jmp	.LBB16_34
.LBB16_33:
	ldx	mos8(__rc9)
.LBB16_34:
	cpx	#0
	bcc	.LBB16_27
.LBB16_35:
	sec
	lda	#0
	sbc	mos8(__rc8)
	sta	mos8(__rc8)
	lda	#0
	sbc	mos8(__rc9)
	sta	mos8(__rc9)
	lda	#0
	sbc	mos8(__rc10)
	sta	mos8(__rc10)
	lda	#0
	sbc	mos8(__rc11)
	sta	mos8(__rc11)
	lda	#0
	sbc	mos8(__rc12)
	sta	mos8(__rc12)
	lda	#0
	sbc	mos8(__rc13)
	sta	mos8(__rc13)
	lda	#0
	sbc	mos8(__rc14)
	sta	mos8(__rc14)
	lda	#0
	sbc	mos8(__rc21)
.LBB16_36:
	sty	mos8(__rc7)
	sta	mos8(__rc15)
	ldx	mos8(__rc18)
	lda	mos8(__rc19)
	jsr	__udivdi3
	sta	mos8(__rc9)
	stx	mos8(__rc8)
	asl	mos8(__rc21)
	lda	#0
	rol
	sta	mos8(__rc10)
	lda	#0
	rol
	asl	mos8(__rc20)
	sta	mos8(__rc11)
	lda	#0
	rol
	sta	mos8(__rc12)
	lda	#0
	rol
	cmp	mos8(__rc11)
	bne	.LBB16_38
	ldx	mos8(__rc12)
	cpx	mos8(__rc10)
	beq	.LBB16_39
.LBB16_38:
	sec
	lda	#0
	sbc	mos8(__rc9)
	sta	mos8(__rc9)
	lda	#0
	sbc	mos8(__rc8)
	sta	mos8(__rc8)
	lda	#0
	sbc	mos8(__rc2)
	sta	mos8(__rc2)
	lda	#0
	sbc	mos8(__rc3)
	sta	mos8(__rc3)
	lda	#0
	sbc	mos8(__rc4)
	sta	mos8(__rc4)
	lda	#0
	sbc	mos8(__rc5)
	sta	mos8(__rc5)
	lda	#0
	sbc	mos8(__rc6)
	sta	mos8(__rc6)
	lda	#0
	sbc	mos8(__rc7)
	sta	mos8(__rc7)
.LBB16_39:
	ldx	mos8(__rc8)
	lda	mos8(__rc9)
	sta	mos8(__rc16)
	pla
	sta	mos8(__rc21)
	pla
	sta	mos8(__rc20)
	lda	mos8(__rc16)
	rts
.Lfunc_end16:
	.size	__divdi3, .Lfunc_end16-__divdi3

	.section	.text.__modqi3,"ax",@progbits
	.globl	__modqi3
	.type	__modqi3,@function
__modqi3:
	sta	mos8(__rc16)
	lda	mos8(__rc20)
	pha
	lda	mos8(__rc16)
	sta	mos8(__rc20)
	stx	mos8(__rc2)
	tax
	cmp	#129
	bcc	.LBB17_2
	lda	#0
	sec
	sbc	mos8(__rc20)
.LBB17_2:
	ldx	mos8(__rc2)
	cpx	#129
	bcc	.LBB17_4
	sec
	tax
	lda	#0
	sbc	mos8(__rc2)
	sta	mos8(__rc2)
	txa
.LBB17_4:
	ldx	mos8(__rc2)
	jsr	__umodqi3
	sta	mos8(__rc2)
	lda	mos8(__rc20)
	bpl	.LBB17_6
	lda	#0
	sec
	sbc	mos8(__rc2)
	sta	mos8(__rc2)
.LBB17_6:
	lda	mos8(__rc2)
	sta	mos8(__rc16)
	pla
	sta	mos8(__rc20)
	lda	mos8(__rc16)
	rts
.Lfunc_end17:
	.size	__modqi3, .Lfunc_end17-__modqi3

	.section	.text.__modhi3,"ax",@progbits
	.globl	__modhi3
	.type	__modhi3,@function
__modhi3:
	sta	mos8(__rc16)
	lda	mos8(__rc20)
	pha
	lda	mos8(__rc16)
	sta	mos8(__rc4)
	stx	mos8(__rc20)
	cpx	#128
	bne	.LBB18_3
	ldx	mos8(__rc4)
	cpx	#1
	bcs	.LBB18_4
.LBB18_2:
	lda	mos8(__rc20)
	jmp	.LBB18_5
.LBB18_3:
	ldx	mos8(__rc20)
	cpx	#128
	bcc	.LBB18_2
.LBB18_4:
	sec
	lda	#0
	sbc	mos8(__rc4)
	sta	mos8(__rc4)
	lda	#0
	sbc	mos8(__rc20)
.LBB18_5:
	ldx	mos8(__rc3)
	cpx	#128
	bne	.LBB18_11
	ldx	mos8(__rc2)
	cpx	#1
	bcc	.LBB18_8
.LBB18_7:
	tax
	sec
	lda	#0
	sbc	mos8(__rc2)
	sta	mos8(__rc2)
	lda	#0
	sbc	mos8(__rc3)
	sta	mos8(__rc3)
	txa
.LBB18_8:
	tax
	lda	mos8(__rc4)
	jsr	__umodhi3
	sta	mos8(__rc3)
	stx	mos8(__rc2)
	lda	mos8(__rc20)
	bpl	.LBB18_10
	sec
	lda	#0
	sbc	mos8(__rc3)
	sta	mos8(__rc3)
	lda	#0
	sbc	mos8(__rc2)
	sta	mos8(__rc2)
.LBB18_10:
	ldx	mos8(__rc2)
	lda	mos8(__rc3)
	sta	mos8(__rc16)
	pla
	sta	mos8(__rc20)
	lda	mos8(__rc16)
	rts
.LBB18_11:
	ldx	mos8(__rc3)
	cpx	#128
	bcs	.LBB18_7
	jmp	.LBB18_8
.Lfunc_end18:
	.size	__modhi3, .Lfunc_end18-__modhi3

	.section	.text.__modsi3,"ax",@progbits
	.globl	__modsi3
	.type	__modsi3,@function
__modsi3:
	sta	mos8(__rc16)
	lda	mos8(__rc20)
	pha
	lda	mos8(__rc16)
	sta	mos8(__rc9)
	stx	mos8(__rc8)
	ldx	mos8(__rc3)
	stx	mos8(__rc20)
	ldx	mos8(__rc3)
	cpx	#128
	bne	.LBB19_4
	lda	mos8(__rc2)
	bne	.LBB19_6
	lda	mos8(__rc8)
	bne	.LBB19_7
	ldx	mos8(__rc9)
	cpx	#1
	bcc	.LBB19_5
	jmp	.LBB19_9
.LBB19_4:
	ldx	mos8(__rc20)
	cpx	#128
	bcs	.LBB19_9
.LBB19_5:
	lda	mos8(__rc20)
	jmp	.LBB19_10
.LBB19_6:
	ldx	mos8(__rc2)
	jmp	.LBB19_8
.LBB19_7:
	ldx	mos8(__rc8)
.LBB19_8:
	cpx	#0
	bcc	.LBB19_5
.LBB19_9:
	sec
	lda	#0
	sbc	mos8(__rc9)
	sta	mos8(__rc9)
	lda	#0
	sbc	mos8(__rc8)
	sta	mos8(__rc8)
	lda	#0
	sbc	mos8(__rc2)
	sta	mos8(__rc2)
	lda	#0
	sbc	mos8(__rc20)
.LBB19_10:
	ldx	mos8(__rc7)
	cpx	#128
	bne	.LBB19_14
	ldx	mos8(__rc6)
	beq	.LBB19_12
	jmp	.LBB19_19
.LBB19_12:
	ldx	mos8(__rc5)
	beq	.LBB19_13
	jmp	.LBB19_20
.LBB19_13:
	ldx	mos8(__rc4)
	cpx	#1
	bcs	.LBB19_15
	jmp	.LBB19_16
.LBB19_14:
	ldx	mos8(__rc7)
	cpx	#128
	bcc	.LBB19_16
.LBB19_15:
	tax
	sec
	lda	#0
	sbc	mos8(__rc4)
	sta	mos8(__rc4)
	lda	#0
	sbc	mos8(__rc5)
	sta	mos8(__rc5)
	lda	#0
	sbc	mos8(__rc6)
	sta	mos8(__rc6)
	lda	#0
	sbc	mos8(__rc7)
	sta	mos8(__rc7)
	txa
.LBB19_16:
	sta	mos8(__rc3)
	ldx	mos8(__rc8)
	lda	mos8(__rc9)
	jsr	__umodsi3
	sta	mos8(__rc5)
	stx	mos8(__rc4)
	lda	mos8(__rc20)
	bpl	.LBB19_18
	sec
	lda	#0
	sbc	mos8(__rc5)
	sta	mos8(__rc5)
	lda	#0
	sbc	mos8(__rc4)
	sta	mos8(__rc4)
	lda	#0
	sbc	mos8(__rc2)
	sta	mos8(__rc2)
	lda	#0
	sbc	mos8(__rc3)
	sta	mos8(__rc3)
.LBB19_18:
	ldx	mos8(__rc4)
	lda	mos8(__rc5)
	sta	mos8(__rc16)
	pla
	sta	mos8(__rc20)
	lda	mos8(__rc16)
	rts
.LBB19_19:
	ldx	mos8(__rc6)
	jmp	.LBB19_21
.LBB19_20:
	ldx	mos8(__rc5)
.LBB19_21:
	cpx	#0
	bcc	.LBB19_16
	jmp	.LBB19_15
.Lfunc_end19:
	.size	__modsi3, .Lfunc_end19-__modsi3

	.section	.text.__moddi3,"ax",@progbits
	.globl	__moddi3
	.type	__moddi3,@function
__moddi3:
	sta	mos8(__rc16)
	lda	mos8(__rc20)
	pha
	lda	mos8(__rc16)
	sta	mos8(__rc19)
	stx	mos8(__rc18)
	ldx	mos8(__rc7)
	stx	mos8(__rc20)
	ldx	mos8(__rc7)
	cpx	#128
	bne	.LBB20_8
	lda	mos8(__rc6)
	bne	.LBB20_10
	lda	mos8(__rc5)
	bne	.LBB20_11
	lda	mos8(__rc4)
	bne	.LBB20_12
	lda	mos8(__rc3)
	bne	.LBB20_13
	lda	mos8(__rc2)
	bne	.LBB20_14
	lda	mos8(__rc18)
	bne	.LBB20_15
	ldx	mos8(__rc19)
	cpx	#1
	bcc	.LBB20_9
	jmp	.LBB20_17
.LBB20_8:
	ldx	mos8(__rc20)
	cpx	#128
	bcs	.LBB20_17
.LBB20_9:
	lda	mos8(__rc20)
	jmp	.LBB20_18
.LBB20_10:
	ldx	mos8(__rc6)
	jmp	.LBB20_16
.LBB20_11:
	ldx	mos8(__rc5)
	jmp	.LBB20_16
.LBB20_12:
	ldx	mos8(__rc4)
	jmp	.LBB20_16
.LBB20_13:
	ldx	mos8(__rc3)
	jmp	.LBB20_16
.LBB20_14:
	ldx	mos8(__rc2)
	jmp	.LBB20_16
.LBB20_15:
	ldx	mos8(__rc18)
.LBB20_16:
	cpx	#0
	bcc	.LBB20_9
.LBB20_17:
	sec
	lda	#0
	sbc	mos8(__rc19)
	sta	mos8(__rc19)
	lda	#0
	sbc	mos8(__rc18)
	sta	mos8(__rc18)
	lda	#0
	sbc	mos8(__rc2)
	sta	mos8(__rc2)
	lda	#0
	sbc	mos8(__rc3)
	sta	mos8(__rc3)
	lda	#0
	sbc	mos8(__rc4)
	sta	mos8(__rc4)
	lda	#0
	sbc	mos8(__rc5)
	sta	mos8(__rc5)
	lda	#0
	sbc	mos8(__rc6)
	sta	mos8(__rc6)
	lda	#0
	sbc	mos8(__rc20)
.LBB20_18:
	ldx	mos8(__rc15)
	cpx	#128
	bne	.LBB20_26
	ldx	mos8(__rc14)
	beq	.LBB20_20
	jmp	.LBB20_31
.LBB20_20:
	ldx	mos8(__rc13)
	beq	.LBB20_21
	jmp	.LBB20_32
.LBB20_21:
	ldx	mos8(__rc12)
	beq	.LBB20_22
	jmp	.LBB20_33
.LBB20_22:
	ldx	mos8(__rc11)
	beq	.LBB20_23
	jmp	.LBB20_34
.LBB20_23:
	ldx	mos8(__rc10)
	beq	.LBB20_24
	jmp	.LBB20_35
.LBB20_24:
	ldx	mos8(__rc9)
	beq	.LBB20_25
	jmp	.LBB20_36
.LBB20_25:
	ldx	mos8(__rc8)
	cpx	#1
	bcs	.LBB20_27
	jmp	.LBB20_28
.LBB20_26:
	ldx	mos8(__rc15)
	cpx	#128
	bcc	.LBB20_28
.LBB20_27:
	tax
	sec
	lda	#0
	sbc	mos8(__rc8)
	sta	mos8(__rc8)
	lda	#0
	sbc	mos8(__rc9)
	sta	mos8(__rc9)
	lda	#0
	sbc	mos8(__rc10)
	sta	mos8(__rc10)
	lda	#0
	sbc	mos8(__rc11)
	sta	mos8(__rc11)
	lda	#0
	sbc	mos8(__rc12)
	sta	mos8(__rc12)
	lda	#0
	sbc	mos8(__rc13)
	sta	mos8(__rc13)
	lda	#0
	sbc	mos8(__rc14)
	sta	mos8(__rc14)
	lda	#0
	sbc	mos8(__rc15)
	sta	mos8(__rc15)
	txa
.LBB20_28:
	sta	mos8(__rc7)
	ldx	mos8(__rc18)
	lda	mos8(__rc19)
	jsr	__umoddi3
	sta	mos8(__rc9)
	stx	mos8(__rc8)
	lda	mos8(__rc20)
	bpl	.LBB20_30
	sec
	lda	#0
	sbc	mos8(__rc9)
	sta	mos8(__rc9)
	lda	#0
	sbc	mos8(__rc8)
	sta	mos8(__rc8)
	lda	#0
	sbc	mos8(__rc2)
	sta	mos8(__rc2)
	lda	#0
	sbc	mos8(__rc3)
	sta	mos8(__rc3)
	lda	#0
	sbc	mos8(__rc4)
	sta	mos8(__rc4)
	lda	#0
	sbc	mos8(__rc5)
	sta	mos8(__rc5)
	lda	#0
	sbc	mos8(__rc6)
	sta	mos8(__rc6)
	lda	#0
	sbc	mos8(__rc7)
	sta	mos8(__rc7)
.LBB20_30:
	ldx	mos8(__rc8)
	lda	mos8(__rc9)
	sta	mos8(__rc16)
	pla
	sta	mos8(__rc20)
	lda	mos8(__rc16)
	rts
.LBB20_31:
	ldx	mos8(__rc14)
	jmp	.LBB20_37
.LBB20_32:
	ldx	mos8(__rc13)
	jmp	.LBB20_37
.LBB20_33:
	ldx	mos8(__rc12)
	jmp	.LBB20_37
.LBB20_34:
	ldx	mos8(__rc11)
	jmp	.LBB20_37
.LBB20_35:
	ldx	mos8(__rc10)
	jmp	.LBB20_37
.LBB20_36:
	ldx	mos8(__rc9)
.LBB20_37:
	cpx	#0
	bcc	.LBB20_38
	jmp	.LBB20_27
.LBB20_38:
	jmp	.LBB20_28
.Lfunc_end20:
	.size	__moddi3, .Lfunc_end20-__moddi3

	.section	.text.__divmodqi4,"ax",@progbits
	.globl	__divmodqi4
	.type	__divmodqi4,@function
__divmodqi4:
	sta	mos8(__rc4)
	pha
	txa
	tay
	pla
	tax
	cmp	#129
	sta	mos8(__rc9)
	bcc	.LBB21_2
	sec
	lda	#0
	sbc	mos8(__rc4)
	sta	mos8(__rc9)
.LBB21_2:
	ldx	#0
	cpy	#129
	bcs	.LBB21_5
	sty	mos8(__rc5)
	sty	mos8(__rc8)
	tya
	bne	.LBB21_6
	ldy	mos8(__rc9)
	jmp	.LBB21_7
.LBB21_5:
	sty	mos8(__rc5)
	lda	#0
	sec
	ldy	mos8(__rc5)
	sty	mos8(__rc8)
	sbc	mos8(__rc5)
	sta	mos8(__rc5)
.LBB21_6:
	ldy	mos8(__rc9)
	cpy	mos8(__rc5)
	bcs	.LBB21_9
.LBB21_7:
	sty	mos8(__rc7)
.LBB21_8:
	stx	mos8(__rc6)
	jmp	.LBB21_15
.LBB21_9:
	ldy	#1
	lda	mos8(__rc5)
	and	#-128
	bne	.LBB21_13
	ldx	#0
	lda	mos8(__rc5)
	sta	mos8(__rc6)
	asl	mos8(__rc6)
	lda	#0
	rol
	sta	mos8(__rc7)
	cpx	mos8(__rc7)
	bne	.LBB21_20
	lda	mos8(__rc9)
	cmp	mos8(__rc6)
	bcs	.LBB21_21
.LBB21_12:
	sec
	jmp	.LBB21_14
.LBB21_13:
	sec
	lda	mos8(__rc9)
.LBB21_14:
	sbc	mos8(__rc5)
	sta	mos8(__rc7)
	sty	mos8(__rc6)
.LBB21_15:
	lda	mos8(__rc4)
	bpl	.LBB21_17
	lda	#0
	sec
	sbc	mos8(__rc7)
	sta	mos8(__rc7)
.LBB21_17:
	lda	mos8(__rc8)
	eor	mos8(__rc4)
	tax
	ldy	#0
	lda	mos8(__rc7)
	sta	(mos8(__rc2)),y
	txa
	bpl	.LBB21_19
	lda	#0
	sec
	sbc	mos8(__rc6)
	sta	mos8(__rc6)
.LBB21_19:
	lda	mos8(__rc6)
	rts
.LBB21_20:
	cpx	mos8(__rc7)
	lda	mos8(__rc9)
	bcc	.LBB21_12
.LBB21_21:
	ldx	#1
	stx	mos8(__rc10)
	dex
	stx	mos8(__rc11)
	ldx	#0
	ldy	mos8(__rc5)
	sty	mos8(__rc12)
	jmp	.LBB21_25
.LBB21_22:
	cmp	mos8(__rc7)
	lda	mos8(__rc9)
	sta	mos8(__rc7)
	bcc	.LBB21_27
	jmp	.LBB21_28
.LBB21_23:
	clv
.LBB21_24:
	dex
	bvs	.LBB21_32
.LBB21_25:
	ldy	mos8(__rc12)
	sty	mos8(__rc13)
	ldy	mos8(__rc6)
	sty	mos8(__rc5)
	lda	mos8(__rc6)
	and	#-2
	sta	mos8(__rc12)
	sta	mos8(__rc6)
	asl	mos8(__rc6)
	lda	#0
	rol
	sta	mos8(__rc7)
	ldy	#0
	lda	#0
	cmp	mos8(__rc7)
	bne	.LBB21_22
	lda	mos8(__rc9)
	sta	mos8(__rc7)
	cmp	mos8(__rc6)
	bcs	.LBB21_28
.LBB21_27:
	ldy	#1
.LBB21_28:
	bit	__set_v
	lda	mos8(__rc11)
	bne	.LBB21_24
	lda	mos8(__rc13)
	and	#64
	bit	__set_v
	cmp	#0
	bne	.LBB21_24
	tya
	beq	.LBB21_23
	bit	__set_v
	jmp	.LBB21_24
.LBB21_32:
	sec
	lda	mos8(__rc7)
	sbc	mos8(__rc5)
	sta	mos8(__rc11)
	txa
	beq	.LBB21_38
	ldy	#1
	sty	mos8(__rc9)
	jmp	.LBB21_36
.LBB21_34:
	lda	mos8(__rc9)
	ora	#1
	sta	mos8(__rc9)
	sec
	lda	mos8(__rc11)
	sbc	mos8(__rc5)
	tay
.LBB21_35:
	clc
	txa
	adc	#1
	tax
	sty	mos8(__rc7)
	lda	mos8(__rc9)
	sta	mos8(__rc6)
	sty	mos8(__rc11)
	bcc	.LBB21_36
	jmp	.LBB21_15
.LBB21_36:
	lsr	mos8(__rc5)
	asl	mos8(__rc9)
	ldy	mos8(__rc11)
	cpy	mos8(__rc5)
	bcs	.LBB21_34
	ldy	mos8(__rc11)
	jmp	.LBB21_35
.LBB21_38:
	ldx	mos8(__rc11)
	stx	mos8(__rc7)
	ldx	mos8(__rc10)
	jmp	.LBB21_8
.Lfunc_end21:
	.size	__divmodqi4, .Lfunc_end21-__divmodqi4

	.section	.text.__divmodhi4,"ax",@progbits
	.globl	__divmodhi4
	.type	__divmodhi4,@function
__divmodhi4:
	sta	mos8(__rc7)
	stx	mos8(__rc6)
	ldy	mos8(__rc3)
	cpx	#128
	bne	.LBB22_3
	ldx	mos8(__rc7)
	cpx	#1
	bcs	.LBB22_4
.LBB22_2:
	lda	mos8(__rc7)
	ldx	mos8(__rc6)
	stx	mos8(__rc10)
	jmp	.LBB22_5
.LBB22_3:
	ldx	mos8(__rc6)
	cpx	#128
	bcc	.LBB22_2
.LBB22_4:
	sec
	lda	#0
	sbc	mos8(__rc7)
	tax
	lda	#0
	sbc	mos8(__rc6)
	sta	mos8(__rc10)
	txa
.LBB22_5:
	sty	mos8(__rc11)
	sta	mos8(__rc9)
	cpy	#128
	bne	.LBB22_8
	ldx	mos8(__rc2)
	cpx	#1
	bcs	.LBB22_9
.LBB22_7:
	sty	mos8(__rc3)
	jmp	.LBB22_10
.LBB22_8:
	cpy	#128
	bcc	.LBB22_7
.LBB22_9:
	sec
	lda	#0
	sbc	mos8(__rc2)
	sta	mos8(__rc2)
	lda	#0
	ldx	mos8(__rc11)
	stx	mos8(__rc3)
	sbc	mos8(__rc11)
	sta	mos8(__rc3)
	lda	mos8(__rc9)
.LBB22_10:
	ldx	mos8(__rc10)
	cpx	mos8(__rc3)
	bne	.LBB22_13
	cmp	mos8(__rc2)
	bcc	.LBB22_14
.LBB22_12:
	lda	#0
	jmp	.LBB22_15
.LBB22_13:
	cpx	mos8(__rc3)
	bcs	.LBB22_12
.LBB22_14:
	lda	#1
.LBB22_15:
	ldx	mos8(__rc3)
	bne	.LBB22_17
	ldx	#1
	ldy	mos8(__rc2)
	beq	.LBB22_18
.LBB22_17:
	tax
.LBB22_18:
	ldy	#0
	lda	#0
	cpx	#0
	beq	.LBB22_20
	sta	mos8(__rc7)
	jmp	.LBB22_40
.LBB22_20:
	ldx	#1
	lda	mos8(__rc3)
	bpl	.LBB22_21
	jmp	.LBB22_37
.LBB22_21:
	ldx	#1
	stx	mos8(__rc12)
	dex
	lda	mos8(__rc2)
	sta	mos8(__rc7)
	lda	mos8(__rc3)
	sta	mos8(__rc8)
	lda	mos8(__rc9)
.LBB22_22:
	sta	mos8(__rc13)
	asl	mos8(__rc7)
	rol	mos8(__rc8)
	lda	mos8(__rc10)
	cmp	mos8(__rc8)
	bne	.LBB22_24
	lda	mos8(__rc13)
	cmp	mos8(__rc7)
	bcc	.LBB22_27
	jmp	.LBB22_25
.LBB22_24:
	cmp	mos8(__rc8)
	lda	mos8(__rc13)
	bcc	.LBB22_27
.LBB22_25:
	inx
	sty	mos8(__rc17)
	ldy	mos8(__rc7)
	sty	mos8(__rc2)
	ldy	mos8(__rc8)
	sty	mos8(__rc3)
	ldy	mos8(__rc17)
	inc	mos8(__rc8)
	dec	mos8(__rc8)
	bpl	.LBB22_22
	lda	#0
	sta	mos8(__rc2)
	lda	mos8(__rc9)
	ldy	#-128
	sty	mos8(__rc3)
	ldy	#0
.LBB22_27:
	sec
	sbc	mos8(__rc2)
	sta	mos8(__rc9)
	lda	mos8(__rc10)
	sbc	mos8(__rc3)
	cpx	#0
	bne	.LBB22_28
	jmp	.LBB22_38
.LBB22_28:
	stx	mos8(__rc13)
	ldx	mos8(__rc9)
	stx	mos8(__rc12)
	ldy	#1
	ldx	#0
	jmp	.LBB22_32
.LBB22_29:
	cmp	mos8(__rc3)
	bcc	.LBB22_36
.LBB22_30:
	sta	mos8(__rc8)
	lda	mos8(__rc7)
	ora	#1
	tay
	sec
	lda	mos8(__rc12)
	sbc	mos8(__rc2)
	sta	mos8(__rc12)
	lda	mos8(__rc8)
	sbc	mos8(__rc3)
.LBB22_31:
	sty	mos8(__rc17)
	ldy	mos8(__rc9)
	cpy	#1
	ldy	mos8(__rc17)
	stx	mos8(__rc8)
	rol	mos8(__rc8)
	dec	mos8(__rc13)
	ldx	mos8(__rc12)
	stx	mos8(__rc9)
	sta	mos8(__rc10)
	sty	mos8(__rc7)
	ldx	mos8(__rc8)
	inc	mos8(__rc13)
	dec	mos8(__rc13)
	beq	.LBB22_41
.LBB22_32:
	lsr	mos8(__rc3)
	ror	mos8(__rc2)
	sty	mos8(__rc7)
	asl	mos8(__rc7)
	ldy	#1
	bcs	.LBB22_34
	ldy	#0
.LBB22_34:
	sty	mos8(__rc9)
	cmp	mos8(__rc3)
	bne	.LBB22_29
	ldy	mos8(__rc12)
	cpy	mos8(__rc2)
	bcs	.LBB22_30
.LBB22_36:
	ldy	mos8(__rc7)
	jmp	.LBB22_31
.LBB22_37:
	lda	mos8(__rc10)
	eor	#-128
	sta	mos8(__rc10)
	jmp	.LBB22_39
.LBB22_38:
	sta	mos8(__rc10)
	ldx	mos8(__rc12)
.LBB22_39:
	stx	mos8(__rc7)
.LBB22_40:
	sty	mos8(__rc8)
.LBB22_41:
	lda	mos8(__rc6)
	bpl	.LBB22_43
	sec
	lda	#0
	sbc	mos8(__rc9)
	sta	mos8(__rc9)
	lda	#0
	sbc	mos8(__rc10)
	sta	mos8(__rc10)
.LBB22_43:
	lda	mos8(__rc11)
	eor	mos8(__rc6)
	tax
	ldy	#0
	lda	mos8(__rc9)
	sta	(mos8(__rc4)),y
	iny
	lda	mos8(__rc10)
	sta	(mos8(__rc4)),y
	txa
	bpl	.LBB22_45
	sec
	lda	#0
	sbc	mos8(__rc7)
	sta	mos8(__rc7)
	lda	#0
	sbc	mos8(__rc8)
	sta	mos8(__rc8)
.LBB22_45:
	ldx	mos8(__rc8)
	lda	mos8(__rc7)
	rts
.Lfunc_end22:
	.size	__divmodhi4, .Lfunc_end22-__divmodhi4

	.section	.text.__divmodsi4,"ax",@progbits
	.globl	__divmodsi4
	.type	__divmodsi4,@function
__divmodsi4:
	sta	mos8(__rc16)
	lda	mos8(__rc20)
	pha
	lda	mos8(__rc21)
	pha
	lda	mos8(__rc22)
	pha
	lda	mos8(__rc23)
	pha
	lda	mos8(__rc16)
	ldy	mos8(__rc24)
	sty	.L____divmodsi4_sstk
	ldy	mos8(__rc25)
	sty	.L____divmodsi4_sstk+1
	ldy	mos8(__rc26)
	sty	.L____divmodsi4_sstk+2
	sta	mos8(__rc11)
	stx	mos8(__rc10)
	ldx	mos8(__rc3)
	cpx	#128
	bne	.LBB23_4
	lda	mos8(__rc2)
	bne	.LBB23_6
	lda	mos8(__rc10)
	bne	.LBB23_7
	ldx	mos8(__rc11)
	cpx	#1
	bcc	.LBB23_5
	jmp	.LBB23_9
.LBB23_4:
	ldx	mos8(__rc3)
	cpx	#128
	bcs	.LBB23_9
.LBB23_5:
	ldx	mos8(__rc10)
	stx	mos8(__rc15)
	ldy	mos8(__rc2)
	ldx	mos8(__rc3)
	stx	mos8(__rc19)
	jmp	.LBB23_10
.LBB23_6:
	ldx	mos8(__rc2)
	jmp	.LBB23_8
.LBB23_7:
	ldx	mos8(__rc10)
.LBB23_8:
	cpx	#0
	bcc	.LBB23_5
.LBB23_9:
	sec
	lda	#0
	sbc	mos8(__rc11)
	sta	mos8(__rc11)
	lda	#0
	sbc	mos8(__rc10)
	sta	mos8(__rc15)
	lda	#0
	sbc	mos8(__rc2)
	tay
	lda	#0
	sbc	mos8(__rc3)
	sta	mos8(__rc19)
.LBB23_10:
	ldx	mos8(__rc7)
	lda	mos8(__rc11)
	sta	mos8(__rc14)
	sty	mos8(__rc18)
	cpx	#128
	bne	.LBB23_14
	lda	mos8(__rc6)
	bne	.LBB23_16
	lda	mos8(__rc5)
	bne	.LBB23_17
	ldx	mos8(__rc4)
	cpx	#1
	bcc	.LBB23_15
	jmp	.LBB23_19
.LBB23_14:
	ldx	mos8(__rc7)
	cpx	#128
	bcs	.LBB23_19
.LBB23_15:
	ldx	mos8(__rc7)
	stx	mos8(__rc11)
	jmp	.LBB23_20
.LBB23_16:
	ldx	mos8(__rc6)
	jmp	.LBB23_18
.LBB23_17:
	ldx	mos8(__rc5)
.LBB23_18:
	cpx	#0
	bcc	.LBB23_15
.LBB23_19:
	sec
	lda	#0
	sbc	mos8(__rc4)
	sta	mos8(__rc4)
	lda	#0
	sbc	mos8(__rc5)
	sta	mos8(__rc5)
	lda	#0
	sbc	mos8(__rc6)
	sta	mos8(__rc6)
	lda	#0
	sbc	mos8(__rc7)
	sta	mos8(__rc11)
	ldy	mos8(__rc18)
.LBB23_20:
	ldx	mos8(__rc19)
	cpx	mos8(__rc11)
	bne	.LBB23_24
	cpy	mos8(__rc6)
	bne	.LBB23_26
	ldx	mos8(__rc15)
	cpx	mos8(__rc5)
	beq	.LBB23_23
	jmp	.LBB23_64
.LBB23_23:
	ldx	mos8(__rc14)
	cpx	mos8(__rc4)
	bcs	.LBB23_25
	jmp	.LBB23_27
.LBB23_24:
	cpx	mos8(__rc11)
	bcc	.LBB23_27
.LBB23_25:
	lda	#0
	jmp	.LBB23_28
.LBB23_26:
	cpy	mos8(__rc6)
	bcs	.LBB23_25
.LBB23_27:
	lda	#1
.LBB23_28:
	ldx	mos8(__rc11)
	bne	.LBB23_32
	ldx	mos8(__rc6)
	bne	.LBB23_32
	ldx	mos8(__rc5)
	bne	.LBB23_32
	ldx	#1
	ldy	mos8(__rc4)
	beq	.LBB23_33
.LBB23_32:
	tax
.LBB23_33:
	ldy	#0
	lda	#0
	cpx	#0
	beq	.LBB23_35
	sta	mos8(__rc13)
	jmp	.LBB23_67
.LBB23_35:
	ldx	#1
	lda	mos8(__rc11)
	bpl	.LBB23_36
	jmp	.LBB23_63
.LBB23_36:
	ldx	#1
	stx	mos8(__rc21)
	dex
	lda	mos8(__rc4)
	sta	mos8(__rc2)
	lda	mos8(__rc5)
	sta	mos8(__rc10)
	lda	mos8(__rc6)
	sta	mos8(__rc12)
	lda	mos8(__rc11)
	sta	mos8(__rc13)
	lda	mos8(__rc18)
.LBB23_37:
	stx	mos8(__rc20)
	asl	mos8(__rc2)
	rol	mos8(__rc10)
	rol	mos8(__rc12)
	rol	mos8(__rc13)
	ldx	mos8(__rc19)
	cpx	mos8(__rc13)
	bne	.LBB23_41
	cmp	mos8(__rc12)
	bne	.LBB23_42
	lda	mos8(__rc15)
	cmp	mos8(__rc10)
	bne	.LBB23_43
	lda	mos8(__rc14)
	cmp	mos8(__rc2)
	jmp	.LBB23_44
.LBB23_41:
	cpx	mos8(__rc13)
	bcs	.LBB23_45
	jmp	.LBB23_47
.LBB23_42:
	cmp	mos8(__rc12)
	bcc	.LBB23_47
	jmp	.LBB23_45
.LBB23_43:
	cmp	mos8(__rc10)
.LBB23_44:
	lda	mos8(__rc18)
	bcc	.LBB23_47
.LBB23_45:
	ldx	mos8(__rc20)
	inx
	sty	mos8(__rc17)
	ldy	mos8(__rc2)
	sty	mos8(__rc4)
	ldy	mos8(__rc10)
	sty	mos8(__rc5)
	ldy	mos8(__rc12)
	sty	mos8(__rc6)
	ldy	mos8(__rc13)
	sty	mos8(__rc11)
	ldy	mos8(__rc17)
	inc	mos8(__rc13)
	dec	mos8(__rc13)
	bpl	.LBB23_37
	lda	#0
	sta	mos8(__rc4)
	sta	mos8(__rc5)
	lda	#0
	sta	mos8(__rc6)
	lda	#-128
	sta	mos8(__rc11)
	jmp	.LBB23_48
.LBB23_47:
	ldx	mos8(__rc20)
.LBB23_48:
	sec
	lda	mos8(__rc14)
	sbc	mos8(__rc4)
	sta	mos8(__rc14)
	lda	mos8(__rc15)
	sbc	mos8(__rc5)
	sta	mos8(__rc15)
	lda	mos8(__rc18)
	sbc	mos8(__rc6)
	sta	mos8(__rc18)
	lda	mos8(__rc19)
	sbc	mos8(__rc11)
	sta	mos8(__rc25)
	txa
	bne	.LBB23_49
	jmp	.LBB23_65
.LBB23_49:
	ldy	mos8(__rc18)
	sty	mos8(__rc20)
	ldy	mos8(__rc14)
	sty	mos8(__rc24)
	ldy	#1
	lda	#0
	sta	mos8(__rc21)
	lda	#0
	sta	mos8(__rc22)
	lda	#0
	sta	mos8(__rc23)
	lda	mos8(__rc15)
	jmp	.LBB23_57
.LBB23_50:
	ldy	mos8(__rc25)
	sty	mos8(__rc10)
	cpy	mos8(__rc11)
	bcs	.LBB23_55
.LBB23_51:
	tay
	lda	mos8(__rc10)
	sta	mos8(__rc25)
	lda	mos8(__rc13)
	jmp	.LBB23_56
.LBB23_52:
	cpx	mos8(__rc6)
	jmp	.LBB23_54
.LBB23_53:
	cmp	mos8(__rc5)
.LBB23_54:
	ldx	mos8(__rc12)
	bcc	.LBB23_51
.LBB23_55:
	sta	mos8(__rc2)
	sec
	lda	mos8(__rc24)
	sbc	mos8(__rc4)
	sta	mos8(__rc24)
	lda	mos8(__rc2)
	sbc	mos8(__rc5)
	tay
	lda	mos8(__rc20)
	sbc	mos8(__rc6)
	sta	mos8(__rc20)
	lda	mos8(__rc10)
	sbc	mos8(__rc11)
	sta	mos8(__rc25)
	lda	mos8(__rc13)
	ora	#1
.LBB23_56:
	sty	mos8(__rc17)
	ldy	mos8(__rc14)
	cpy	#1
	ldy	mos8(__rc21)
	sty	mos8(__rc12)
	rol	mos8(__rc12)
	ldy	mos8(__rc22)
	sty	mos8(__rc2)
	rol	mos8(__rc2)
	ldy	mos8(__rc23)
	sty	mos8(__rc10)
	rol	mos8(__rc10)
	dex
	ldy	mos8(__rc24)
	sty	mos8(__rc14)
	ldy	mos8(__rc17)
	sty	mos8(__rc26)
	ldy	mos8(__rc26)
	sty	mos8(__rc15)
	ldy	mos8(__rc20)
	sty	mos8(__rc18)
	ldy	mos8(__rc25)
	sty	mos8(__rc19)
	tay
	sta	mos8(__rc13)
	lda	mos8(__rc12)
	sta	mos8(__rc21)
	lda	mos8(__rc2)
	sta	mos8(__rc22)
	lda	mos8(__rc10)
	sta	mos8(__rc23)
	lda	mos8(__rc26)
	cpx	#0
	bne	.LBB23_57
	jmp	.LBB23_68
.LBB23_57:
	lsr	mos8(__rc11)
	ror	mos8(__rc6)
	ror	mos8(__rc5)
	ror	mos8(__rc4)
	sty	mos8(__rc13)
	asl	mos8(__rc13)
	ldy	#1
	bcs	.LBB23_59
	ldy	#0
.LBB23_59:
	sty	mos8(__rc14)
	ldy	mos8(__rc25)
	cpy	mos8(__rc11)
	beq	.LBB23_60
	jmp	.LBB23_50
.LBB23_60:
	stx	mos8(__rc12)
	ldx	mos8(__rc25)
	stx	mos8(__rc10)
	ldx	mos8(__rc20)
	cpx	mos8(__rc6)
	beq	.LBB23_61
	jmp	.LBB23_52
.LBB23_61:
	cmp	mos8(__rc5)
	beq	.LBB23_62
	jmp	.LBB23_53
.LBB23_62:
	sta	mos8(__rc2)
	lda	mos8(__rc24)
	cmp	mos8(__rc4)
	lda	mos8(__rc2)
	jmp	.LBB23_54
.LBB23_63:
	lda	mos8(__rc19)
	eor	#-128
	sta	mos8(__rc19)
	jmp	.LBB23_66
.LBB23_64:
	cpx	mos8(__rc5)
	bcc	.LBB23_74
	jmp	.LBB23_25
.LBB23_74:
	jmp	.LBB23_27
.LBB23_65:
	ldx	mos8(__rc25)
	stx	mos8(__rc19)
	ldx	mos8(__rc21)
.LBB23_66:
	stx	mos8(__rc13)
.LBB23_67:
	sty	mos8(__rc12)
	sty	mos8(__rc2)
	sty	mos8(__rc10)
.LBB23_68:
	lda	mos8(__rc3)
	bpl	.LBB23_70
	sec
	lda	#0
	sbc	mos8(__rc14)
	sta	mos8(__rc14)
	lda	#0
	sbc	mos8(__rc15)
	sta	mos8(__rc15)
	lda	#0
	sbc	mos8(__rc18)
	sta	mos8(__rc18)
	lda	#0
	sbc	mos8(__rc19)
	sta	mos8(__rc19)
.LBB23_70:
	ldy	#0
	lda	mos8(__rc14)
	sta	(mos8(__rc8)),y
	iny
	lda	mos8(__rc15)
	sta	(mos8(__rc8)),y
	iny
	lda	mos8(__rc18)
	sta	(mos8(__rc8)),y
	iny
	lda	mos8(__rc19)
	sta	(mos8(__rc8)),y
	asl	mos8(__rc7)
	lda	#0
	rol
	sta	mos8(__rc4)
	lda	#0
	rol
	asl	mos8(__rc3)
	sta	mos8(__rc3)
	lda	#0
	rol
	sta	mos8(__rc5)
	lda	#0
	rol
	cmp	mos8(__rc3)
	bne	.LBB23_72
	ldx	mos8(__rc5)
	cpx	mos8(__rc4)
	beq	.LBB23_73
.LBB23_72:
	sec
	lda	#0
	sbc	mos8(__rc13)
	sta	mos8(__rc13)
	lda	#0
	sbc	mos8(__rc12)
	sta	mos8(__rc12)
	lda	#0
	sbc	mos8(__rc2)
	sta	mos8(__rc2)
	lda	#0
	sbc	mos8(__rc10)
	sta	mos8(__rc10)
.LBB23_73:
	ldx	mos8(__rc10)
	stx	mos8(__rc3)
	ldx	mos8(__rc12)
	lda	mos8(__rc13)
	sta	mos8(__rc16)
	ldy	.L____divmodsi4_sstk+2
	sty	mos8(__rc26)
	ldy	.L____divmodsi4_sstk+1
	sty	mos8(__rc25)
	ldy	.L____divmodsi4_sstk
	sty	mos8(__rc24)
	pla
	sta	mos8(__rc23)
	pla
	sta	mos8(__rc22)
	pla
	sta	mos8(__rc21)
	pla
	sta	mos8(__rc20)
	lda	mos8(__rc16)
	rts
.Lfunc_end23:
	.size	__divmodsi4, .Lfunc_end23-__divmodsi4

	.section	.text.__divmoddi4,"ax",@progbits
	.globl	__divmoddi4
	.type	__divmoddi4,@function
__divmoddi4:
	sta	mos8(__rc16)
	lda	mos8(__rc20)
	pha
	lda	mos8(__rc21)
	pha
	lda	mos8(__rc22)
	pha
	lda	mos8(__rc23)
	pha
	lda	mos8(__rc16)
	ldy	mos8(__rc24)
	sty	.L____divmoddi4_sstk+15
	ldy	mos8(__rc25)
	sty	.L____divmoddi4_sstk+16
	ldy	mos8(__rc26)
	sty	.L____divmoddi4_sstk+17
	ldy	mos8(__rc27)
	sty	.L____divmoddi4_sstk+18
	ldy	mos8(__rc28)
	sty	.L____divmoddi4_sstk+19
	ldy	mos8(__rc29)
	sty	.L____divmoddi4_sstk+20
	ldy	mos8(__rc30)
	sty	.L____divmoddi4_sstk+21
	ldy	mos8(__rc31)
	sty	.L____divmoddi4_sstk+22
	sta	mos8(__rc19)
	stx	mos8(__rc18)
	ldx	mos8(__rc7)
	cpx	#128
	bne	.LBB24_8
	lda	mos8(__rc6)
	bne	.LBB24_10
	lda	mos8(__rc5)
	bne	.LBB24_11
	lda	mos8(__rc4)
	bne	.LBB24_12
	lda	mos8(__rc3)
	bne	.LBB24_13
	lda	mos8(__rc2)
	bne	.LBB24_14
	lda	mos8(__rc18)
	bne	.LBB24_15
	ldx	mos8(__rc19)
	cpx	#1
	bcc	.LBB24_9
	jmp	.LBB24_17
.LBB24_8:
	ldx	mos8(__rc7)
	cpx	#128
	bcs	.LBB24_17
.LBB24_9:
	lda	mos8(__rc19)
	ldx	mos8(__rc18)
	stx	mos8(__rc23)
	ldx	mos8(__rc3)
	stx	mos8(__rc25)
	ldx	mos8(__rc4)
	stx	mos8(__rc3)
	ldx	mos8(__rc5)
	stx	mos8(__rc27)
	ldx	mos8(__rc7)
	stx	mos8(__rc29)
	jmp	.LBB24_18
.LBB24_10:
	ldx	mos8(__rc6)
	jmp	.LBB24_16
.LBB24_11:
	ldx	mos8(__rc5)
	jmp	.LBB24_16
.LBB24_12:
	ldx	mos8(__rc4)
	jmp	.LBB24_16
.LBB24_13:
	ldx	mos8(__rc3)
	jmp	.LBB24_16
.LBB24_14:
	ldx	mos8(__rc2)
	jmp	.LBB24_16
.LBB24_15:
	ldx	mos8(__rc18)
.LBB24_16:
	cpx	#0
	bcc	.LBB24_9
.LBB24_17:
	sec
	lda	#0
	sbc	mos8(__rc19)
	tax
	lda	#0
	sbc	mos8(__rc18)
	sta	mos8(__rc23)
	lda	#0
	sbc	mos8(__rc2)
	sta	mos8(__rc2)
	lda	#0
	sbc	mos8(__rc3)
	sta	mos8(__rc25)
	lda	#0
	sbc	mos8(__rc4)
	sta	mos8(__rc3)
	lda	#0
	sbc	mos8(__rc5)
	sta	mos8(__rc27)
	lda	#0
	sbc	mos8(__rc6)
	sta	mos8(__rc6)
	lda	#0
	sbc	mos8(__rc7)
	sta	mos8(__rc29)
	txa
.LBB24_18:
	ldx	mos8(__rc15)
	sta	mos8(__rc22)
	ldy	mos8(__rc2)
	sty	mos8(__rc4)
	sty	mos8(__rc24)
	ldy	mos8(__rc3)
	sty	mos8(__rc5)
	sty	mos8(__rc26)
	ldy	mos8(__rc6)
	sty	mos8(__rc28)
	cpx	#128
	bne	.LBB24_26
	ldx	mos8(__rc14)
	bne	.LBB24_28
	ldx	mos8(__rc13)
	bne	.LBB24_29
	ldx	mos8(__rc12)
	bne	.LBB24_30
	ldx	mos8(__rc11)
	bne	.LBB24_31
	ldx	mos8(__rc10)
	bne	.LBB24_32
	ldx	mos8(__rc9)
	bne	.LBB24_33
	ldx	mos8(__rc8)
	cpx	#1
	bcc	.LBB24_27
	jmp	.LBB24_35
.LBB24_26:
	ldx	mos8(__rc15)
	cpx	#128
	bcs	.LBB24_35
.LBB24_27:
	ldx	mos8(__rc7)
	stx	.L____divmoddi4_sstk+14
	ldx	mos8(__rc15)
	stx	.L____divmoddi4_sstk+13
	jmp	.LBB24_36
.LBB24_28:
	ldx	mos8(__rc14)
	jmp	.LBB24_34
.LBB24_29:
	ldx	mos8(__rc13)
	jmp	.LBB24_34
.LBB24_30:
	ldx	mos8(__rc12)
	jmp	.LBB24_34
.LBB24_31:
	ldx	mos8(__rc11)
	jmp	.LBB24_34
.LBB24_32:
	ldx	mos8(__rc10)
	jmp	.LBB24_34
.LBB24_33:
	ldx	mos8(__rc9)
.LBB24_34:
	cpx	#0
	bcc	.LBB24_27
.LBB24_35:
	ldx	mos8(__rc7)
	stx	.L____divmoddi4_sstk+14
	sec
	lda	#0
	sbc	mos8(__rc8)
	sta	mos8(__rc8)
	lda	#0
	sbc	mos8(__rc9)
	sta	mos8(__rc9)
	lda	#0
	sbc	mos8(__rc10)
	sta	mos8(__rc10)
	lda	#0
	sbc	mos8(__rc11)
	sta	mos8(__rc11)
	lda	#0
	sbc	mos8(__rc12)
	sta	mos8(__rc12)
	lda	#0
	sbc	mos8(__rc13)
	sta	mos8(__rc13)
	lda	#0
	sbc	mos8(__rc14)
	sta	mos8(__rc14)
	lda	#0
	ldx	mos8(__rc15)
	stx	.L____divmoddi4_sstk+13
	sbc	mos8(__rc15)
	sta	mos8(__rc15)
	lda	mos8(__rc22)
	ldx	mos8(__rc24)
	stx	mos8(__rc4)
	ldx	mos8(__rc26)
	stx	mos8(__rc5)
	ldx	mos8(__rc28)
	stx	mos8(__rc6)
.LBB24_36:
	clc
	ldx	mos8(__rc0)
	stx	mos8(__rc2)
	ldx	mos8(__rc1)
	stx	mos8(__rc3)
	ldx	mos8(__rc29)
	ldy	mos8(__rc15)
	sty	.L____divmoddi4_sstk
	cpx	mos8(__rc15)
	bne	.LBB24_44
	ldx	mos8(__rc6)
	cpx	mos8(__rc14)
	bne	.LBB24_46
	ldx	mos8(__rc27)
	cpx	mos8(__rc13)
	beq	.LBB24_39
	jmp	.LBB24_105
.LBB24_39:
	ldx	mos8(__rc5)
	cpx	mos8(__rc12)
	beq	.LBB24_40
	jmp	.LBB24_107
.LBB24_40:
	ldx	mos8(__rc25)
	cpx	mos8(__rc11)
	beq	.LBB24_41
	jmp	.LBB24_113
.LBB24_41:
	ldx	mos8(__rc4)
	cpx	mos8(__rc10)
	beq	.LBB24_42
	jmp	.LBB24_115
.LBB24_42:
	ldx	mos8(__rc23)
	cpx	mos8(__rc9)
	beq	.LBB24_43
	jmp	.LBB24_117
.LBB24_43:
	cmp	mos8(__rc8)
	bcs	.LBB24_45
	jmp	.LBB24_47
.LBB24_44:
	cpx	mos8(__rc15)
	bcc	.LBB24_47
.LBB24_45:
	ldx	#0
	jmp	.LBB24_48
.LBB24_46:
	cpx	mos8(__rc14)
	bcs	.LBB24_45
.LBB24_47:
	ldx	#1
.LBB24_48:
	lda	.L____divmoddi4_sstk
	bne	.LBB24_56
	lda	mos8(__rc14)
	bne	.LBB24_56
	lda	mos8(__rc13)
	bne	.LBB24_56
	lda	mos8(__rc12)
	bne	.LBB24_56
	lda	mos8(__rc11)
	bne	.LBB24_56
	lda	mos8(__rc10)
	bne	.LBB24_56
	lda	mos8(__rc9)
	bne	.LBB24_56
	bit	__set_v
	lda	mos8(__rc8)
	beq	.LBB24_59
.LBB24_56:
	txa
	beq	.LBB24_58
	bit	__set_v
	jmp	.LBB24_59
.LBB24_58:
	clv
.LBB24_59:
	ldy	#0
	lda	(mos8(__rc2)),y
	sta	.L____divmoddi4_sstk+11
	ldx	#0
	iny
	lda	(mos8(__rc2)),y
	bvc	.LBB24_61
	tay
	sta	.L____divmoddi4_sstk+12
	ldy	mos8(__rc23)
	sty	mos8(__rc12)
	stx	mos8(__rc21)
	jmp	.LBB24_74
.LBB24_61:
	ldx	#1
	stx	mos8(__rc19)
	tax
	sta	.L____divmoddi4_sstk+12
	ldx	.L____divmoddi4_sstk
	bpl	.LBB24_62
	jmp	.LBB24_73
.LBB24_62:
	ldy	#0
	sty	mos8(__rc15)
	ldy	mos8(__rc8)
	sty	mos8(__rc2)
	ldy	mos8(__rc9)
	sty	mos8(__rc3)
	ldy	mos8(__rc10)
	sty	mos8(__rc4)
	ldy	mos8(__rc11)
	sty	mos8(__rc5)
	ldy	mos8(__rc12)
	sty	mos8(__rc6)
	ldy	mos8(__rc13)
	sty	mos8(__rc18)
	ldy	mos8(__rc14)
	sty	mos8(__rc20)
	stx	mos8(__rc21)
	ldx	mos8(__rc24)
	stx	mos8(__rc30)
	ldx	mos8(__rc26)
	stx	mos8(__rc31)
	ldx	mos8(__rc28)
	lda	mos8(__rc29)
.LBB24_63:
	asl	mos8(__rc2)
	rol	mos8(__rc3)
	rol	mos8(__rc4)
	rol	mos8(__rc5)
	rol	mos8(__rc6)
	rol	mos8(__rc18)
	rol	mos8(__rc20)
	rol	mos8(__rc21)
	cmp	mos8(__rc21)
	bne	.LBB24_67
	ldy	mos8(__rc22)
	sty	mos8(__rc7)
	ldy	#0
	cpx	mos8(__rc20)
	bne	.LBB24_68
	lda	mos8(__rc27)
	cmp	mos8(__rc18)
	bne	.LBB24_69
	ldx	mos8(__rc31)
	cpx	mos8(__rc6)
	beq	.LBB24_121
	jmp	.LBB24_112
.LBB24_121:
	jmp	.LBB24_108
.LBB24_67:
	cmp	mos8(__rc21)
	ldy	#0
	bcs	.LBB24_71
	jmp	.LBB24_81
.LBB24_68:
	cpx	mos8(__rc20)
	bcs	.LBB24_71
	jmp	.LBB24_82
.LBB24_69:
	cmp	mos8(__rc18)
.LBB24_70:
	ldx	mos8(__rc28)
	lda	mos8(__rc29)
	bcs	.LBB24_71
	jmp	.LBB24_82
.LBB24_71:
	inc	mos8(__rc15)
	ldy	mos8(__rc2)
	sty	mos8(__rc8)
	ldy	mos8(__rc3)
	sty	mos8(__rc9)
	ldy	mos8(__rc4)
	sty	mos8(__rc10)
	ldy	mos8(__rc5)
	sty	mos8(__rc11)
	ldy	mos8(__rc6)
	sty	mos8(__rc12)
	ldy	mos8(__rc18)
	sty	mos8(__rc13)
	ldy	mos8(__rc20)
	sty	mos8(__rc14)
	ldy	mos8(__rc21)
	sty	.L____divmoddi4_sstk
	bmi	.LBB24_72
	jmp	.LBB24_63
.LBB24_72:
	lda	#0
	ldx	#-128
	sta	mos8(__rc8)
	sta	mos8(__rc9)
	sta	mos8(__rc10)
	sta	mos8(__rc11)
	sta	mos8(__rc12)
	sta	mos8(__rc13)
	sta	mos8(__rc14)
	stx	mos8(__rc2)
	stx	.L____divmoddi4_sstk
	lda	mos8(__rc22)
	ldy	#0
	jmp	.LBB24_83
.LBB24_73:
	lda	mos8(__rc29)
	eor	#-128
	ldx	mos8(__rc23)
	stx	mos8(__rc12)
	ldx	mos8(__rc19)
	stx	mos8(__rc21)
	sta	mos8(__rc29)
.LBB24_74:
	ldx	#0
	stx	mos8(__rc20)
	stx	mos8(__rc2)
	stx	mos8(__rc3)
	stx	mos8(__rc4)
	stx	mos8(__rc5)
	stx	mos8(__rc6)
	stx	mos8(__rc18)
.LBB24_75:
	ldx	.L____divmoddi4_sstk+11
	stx	mos8(__rc8)
	ldx	.L____divmoddi4_sstk+12
	stx	mos8(__rc9)
	ldx	.L____divmoddi4_sstk+14
	stx	mos8(__rc7)
	bpl	.LBB24_77
	sec
	lda	#0
	sbc	mos8(__rc22)
	sta	mos8(__rc22)
	lda	#0
	sbc	mos8(__rc12)
	sta	mos8(__rc12)
	lda	#0
	sbc	mos8(__rc24)
	sta	mos8(__rc24)
	lda	#0
	sbc	mos8(__rc25)
	sta	mos8(__rc25)
	lda	#0
	sbc	mos8(__rc26)
	sta	mos8(__rc26)
	lda	#0
	sbc	mos8(__rc27)
	sta	mos8(__rc27)
	lda	#0
	sbc	mos8(__rc28)
	sta	mos8(__rc28)
	lda	#0
	sbc	mos8(__rc29)
	sta	mos8(__rc29)
.LBB24_77:
	lda	.L____divmoddi4_sstk+13
	sta	mos8(__rc10)
	ldy	#0
	lda	mos8(__rc22)
	sta	(mos8(__rc8)),y
	iny
	lda	mos8(__rc12)
	sta	(mos8(__rc8)),y
	iny
	lda	mos8(__rc24)
	sta	(mos8(__rc8)),y
	iny
	lda	mos8(__rc25)
	sta	(mos8(__rc8)),y
	iny
	lda	mos8(__rc26)
	sta	(mos8(__rc8)),y
	iny
	lda	mos8(__rc27)
	sta	(mos8(__rc8)),y
	iny
	lda	mos8(__rc28)
	sta	(mos8(__rc8)),y
	iny
	lda	mos8(__rc29)
	sta	(mos8(__rc8)),y
	asl	mos8(__rc10)
	lda	#0
	rol
	sta	mos8(__rc8)
	lda	#0
	rol
	asl	mos8(__rc7)
	sta	mos8(__rc7)
	lda	#0
	rol
	sta	mos8(__rc9)
	lda	#0
	rol
	cmp	mos8(__rc7)
	bne	.LBB24_79
	ldx	mos8(__rc9)
	cpx	mos8(__rc8)
	beq	.LBB24_80
.LBB24_79:
	sec
	lda	#0
	sbc	mos8(__rc21)
	sta	mos8(__rc21)
	lda	#0
	sbc	mos8(__rc20)
	sta	mos8(__rc20)
	lda	#0
	sbc	mos8(__rc2)
	sta	mos8(__rc2)
	lda	#0
	sbc	mos8(__rc3)
	sta	mos8(__rc3)
	lda	#0
	sbc	mos8(__rc4)
	sta	mos8(__rc4)
	lda	#0
	sbc	mos8(__rc5)
	sta	mos8(__rc5)
	lda	#0
	sbc	mos8(__rc6)
	sta	mos8(__rc6)
	lda	#0
	sbc	mos8(__rc18)
	sta	mos8(__rc18)
.LBB24_80:
	ldx	mos8(__rc18)
	stx	mos8(__rc7)
	ldx	mos8(__rc20)
	lda	mos8(__rc21)
	sta	mos8(__rc16)
	ldy	.L____divmoddi4_sstk+22
	sty	mos8(__rc31)
	ldy	.L____divmoddi4_sstk+21
	sty	mos8(__rc30)
	ldy	.L____divmoddi4_sstk+20
	sty	mos8(__rc29)
	ldy	.L____divmoddi4_sstk+19
	sty	mos8(__rc28)
	ldy	.L____divmoddi4_sstk+18
	sty	mos8(__rc27)
	ldy	.L____divmoddi4_sstk+17
	sty	mos8(__rc26)
	ldy	.L____divmoddi4_sstk+16
	sty	mos8(__rc25)
	ldy	.L____divmoddi4_sstk+15
	sty	mos8(__rc24)
	pla
	sta	mos8(__rc23)
	pla
	sta	mos8(__rc22)
	pla
	sta	mos8(__rc21)
	pla
	sta	mos8(__rc20)
	lda	mos8(__rc16)
	rts
.LBB24_81:
	ldx	mos8(__rc22)
	stx	mos8(__rc7)
.LBB24_82:
	lda	mos8(__rc7)
.LBB24_83:
	sec
	sbc	mos8(__rc8)
	sta	mos8(__rc22)
	lda	mos8(__rc23)
	sbc	mos8(__rc9)
	sta	mos8(__rc3)
	lda	mos8(__rc24)
	sbc	mos8(__rc10)
	sta	mos8(__rc24)
	lda	mos8(__rc25)
	sbc	mos8(__rc11)
	sta	mos8(__rc25)
	lda	mos8(__rc26)
	sbc	mos8(__rc12)
	sta	mos8(__rc26)
	lda	mos8(__rc27)
	sbc	mos8(__rc13)
	sta	mos8(__rc27)
	lda	mos8(__rc28)
	sbc	mos8(__rc14)
	sta	mos8(__rc28)
	lda	mos8(__rc29)
	ldx	.L____divmoddi4_sstk
	stx	mos8(__rc2)
	sbc	mos8(__rc2)
	sta	mos8(__rc7)
	lda	mos8(__rc15)
	bne	.LBB24_84
	jmp	.LBB24_106
.LBB24_84:
	ldx	mos8(__rc15)
	ldy	mos8(__rc14)
	sty	.L____divmoddi4_sstk+10
	ldy	mos8(__rc13)
	sty	.L____divmoddi4_sstk+9
	ldy	mos8(__rc12)
	sty	.L____divmoddi4_sstk+8
	ldy	mos8(__rc11)
	sty	.L____divmoddi4_sstk+7
	ldy	mos8(__rc10)
	sty	.L____divmoddi4_sstk+6
	ldy	mos8(__rc8)
	sty	.L____divmoddi4_sstk+4
	ldy	mos8(__rc9)
	sty	.L____divmoddi4_sstk+5
	ldy	mos8(__rc28)
	sty	mos8(__rc8)
	ldy	mos8(__rc27)
	sty	mos8(__rc15)
	ldy	mos8(__rc26)
	sty	mos8(__rc19)
	ldy	mos8(__rc25)
	sty	mos8(__rc31)
	ldy	mos8(__rc24)
	sty	mos8(__rc30)
	ldy	mos8(__rc22)
	sty	mos8(__rc13)
	lda	#0
	sta	mos8(__rc14)
	ldy	#1
	lda	#0
	sta	mos8(__rc9)
	lda	#0
	sta	mos8(__rc10)
	lda	#0
	sta	mos8(__rc11)
	lda	#0
	sta	.L____divmoddi4_sstk+3
	lda	#0
	sta	.L____divmoddi4_sstk+2
	lda	#0
	sta	.L____divmoddi4_sstk+1
	lda	mos8(__rc3)
.LBB24_85:
	stx	mos8(__rc24)
	ldx	.L____divmoddi4_sstk
	stx	mos8(__rc23)
	lsr	mos8(__rc23)
	ldx	.L____divmoddi4_sstk+10
	stx	mos8(__rc21)
	ror	mos8(__rc21)
	ldx	.L____divmoddi4_sstk+9
	stx	mos8(__rc20)
	ror	mos8(__rc20)
	ldx	.L____divmoddi4_sstk+8
	stx	mos8(__rc18)
	ror	mos8(__rc18)
	ldx	.L____divmoddi4_sstk+7
	stx	mos8(__rc6)
	ror	mos8(__rc6)
	ldx	.L____divmoddi4_sstk+6
	stx	mos8(__rc5)
	ror	mos8(__rc5)
	ldx	.L____divmoddi4_sstk+5
	stx	mos8(__rc3)
	ror	mos8(__rc3)
	ldx	.L____divmoddi4_sstk+4
	stx	mos8(__rc4)
	ror	mos8(__rc4)
	sty	mos8(__rc25)
	asl	mos8(__rc25)
	ldx	#1
	bcs	.LBB24_87
	ldx	#0
.LBB24_87:
	stx	mos8(__rc26)
	ldx	mos8(__rc7)
	cpx	mos8(__rc23)
	bne	.LBB24_95
	ldx	mos8(__rc8)
	cpx	mos8(__rc21)
	beq	.LBB24_89
	jmp	.LBB24_97
.LBB24_89:
	ldx	mos8(__rc15)
	cpx	mos8(__rc20)
	beq	.LBB24_90
	jmp	.LBB24_100
.LBB24_90:
	ldx	mos8(__rc19)
	cpx	mos8(__rc18)
	beq	.LBB24_91
	jmp	.LBB24_101
.LBB24_91:
	ldx	mos8(__rc31)
	cpx	mos8(__rc6)
	beq	.LBB24_92
	jmp	.LBB24_102
.LBB24_92:
	ldx	mos8(__rc30)
	cpx	mos8(__rc5)
	beq	.LBB24_93
	jmp	.LBB24_103
.LBB24_93:
	cmp	mos8(__rc3)
	beq	.LBB24_94
	jmp	.LBB24_104
.LBB24_94:
	sta	mos8(__rc2)
	lda	mos8(__rc13)
	cmp	mos8(__rc4)
	lda	mos8(__rc2)
	bcc	.LBB24_96
	jmp	.LBB24_98
.LBB24_95:
	ldx	mos8(__rc7)
	cpx	mos8(__rc23)
	bcs	.LBB24_98
.LBB24_96:
	ldx	mos8(__rc23)
	stx	.L____divmoddi4_sstk
	ldx	mos8(__rc21)
	stx	.L____divmoddi4_sstk+10
	ldx	mos8(__rc20)
	stx	.L____divmoddi4_sstk+9
	ldx	mos8(__rc18)
	stx	.L____divmoddi4_sstk+8
	ldx	mos8(__rc6)
	stx	.L____divmoddi4_sstk+7
	ldx	mos8(__rc5)
	stx	.L____divmoddi4_sstk+6
	ldx	mos8(__rc4)
	stx	.L____divmoddi4_sstk+4
	ldx	mos8(__rc3)
	stx	.L____divmoddi4_sstk+5
	sta	mos8(__rc27)
	ldx	mos8(__rc24)
	lda	mos8(__rc25)
	jmp	.LBB24_99
.LBB24_97:
	cpx	mos8(__rc21)
	bcc	.LBB24_96
.LBB24_98:
	sta	mos8(__rc2)
	sec
	lda	mos8(__rc13)
	ldx	mos8(__rc4)
	stx	.L____divmoddi4_sstk+4
	sbc	mos8(__rc4)
	sta	mos8(__rc13)
	lda	mos8(__rc2)
	ldx	mos8(__rc3)
	stx	.L____divmoddi4_sstk+5
	sbc	mos8(__rc3)
	sta	mos8(__rc27)
	lda	mos8(__rc30)
	ldx	mos8(__rc5)
	stx	.L____divmoddi4_sstk+6
	sbc	mos8(__rc5)
	sta	mos8(__rc30)
	lda	mos8(__rc31)
	ldx	mos8(__rc6)
	stx	.L____divmoddi4_sstk+7
	sbc	mos8(__rc6)
	sta	mos8(__rc31)
	lda	mos8(__rc19)
	ldx	mos8(__rc18)
	stx	.L____divmoddi4_sstk+8
	sbc	mos8(__rc18)
	sta	mos8(__rc19)
	lda	mos8(__rc15)
	ldx	mos8(__rc20)
	stx	.L____divmoddi4_sstk+9
	sbc	mos8(__rc20)
	sta	mos8(__rc15)
	lda	mos8(__rc8)
	ldx	mos8(__rc21)
	stx	.L____divmoddi4_sstk+10
	sbc	mos8(__rc21)
	sta	mos8(__rc8)
	lda	mos8(__rc7)
	ldx	mos8(__rc23)
	stx	.L____divmoddi4_sstk
	sbc	mos8(__rc23)
	sta	mos8(__rc7)
	lda	mos8(__rc25)
	ora	#1
	ldx	mos8(__rc24)
.LBB24_99:
	ldy	mos8(__rc26)
	cpy	#1
	ldy	mos8(__rc14)
	sty	mos8(__rc20)
	rol	mos8(__rc20)
	ldy	mos8(__rc9)
	sty	mos8(__rc2)
	rol	mos8(__rc2)
	ldy	mos8(__rc10)
	sty	mos8(__rc3)
	rol	mos8(__rc3)
	ldy	mos8(__rc11)
	sty	mos8(__rc4)
	rol	mos8(__rc4)
	ldy	.L____divmoddi4_sstk+3
	sty	mos8(__rc5)
	rol	mos8(__rc5)
	ldy	.L____divmoddi4_sstk+2
	sty	mos8(__rc6)
	rol	mos8(__rc6)
	ldy	.L____divmoddi4_sstk+1
	sty	mos8(__rc18)
	rol	mos8(__rc18)
	dex
	ldy	mos8(__rc13)
	sty	mos8(__rc22)
	ldy	mos8(__rc27)
	sty	mos8(__rc23)
	ldy	mos8(__rc27)
	sty	mos8(__rc12)
	ldy	mos8(__rc30)
	sty	mos8(__rc24)
	ldy	mos8(__rc31)
	sty	mos8(__rc25)
	ldy	mos8(__rc19)
	sty	mos8(__rc26)
	ldy	mos8(__rc15)
	sty	mos8(__rc27)
	ldy	mos8(__rc8)
	sty	mos8(__rc28)
	ldy	mos8(__rc7)
	sty	mos8(__rc29)
	tay
	sta	mos8(__rc21)
	lda	mos8(__rc20)
	sta	mos8(__rc14)
	lda	mos8(__rc2)
	sta	mos8(__rc9)
	lda	mos8(__rc3)
	sta	mos8(__rc10)
	lda	mos8(__rc4)
	sta	mos8(__rc11)
	lda	mos8(__rc5)
	sta	.L____divmoddi4_sstk+3
	lda	mos8(__rc6)
	sta	.L____divmoddi4_sstk+2
	lda	mos8(__rc18)
	sta	.L____divmoddi4_sstk+1
	lda	mos8(__rc23)
	cpx	#0
	beq	.LBB24_122
	jmp	.LBB24_85
.LBB24_122:
	jmp	.LBB24_75
.LBB24_100:
	cpx	mos8(__rc20)
	bcs	.LBB24_123
	jmp	.LBB24_96
.LBB24_123:
	jmp	.LBB24_98
.LBB24_101:
	cpx	mos8(__rc18)
	bcs	.LBB24_124
	jmp	.LBB24_96
.LBB24_124:
	jmp	.LBB24_98
.LBB24_102:
	cpx	mos8(__rc6)
	bcs	.LBB24_125
	jmp	.LBB24_96
.LBB24_125:
	jmp	.LBB24_98
.LBB24_103:
	cpx	mos8(__rc5)
	bcs	.LBB24_126
	jmp	.LBB24_96
.LBB24_126:
	jmp	.LBB24_98
.LBB24_104:
	cmp	mos8(__rc3)
	bcs	.LBB24_127
	jmp	.LBB24_96
.LBB24_127:
	jmp	.LBB24_98
.LBB24_105:
	cpx	mos8(__rc13)
	bcc	.LBB24_128
	jmp	.LBB24_45
.LBB24_128:
	jmp	.LBB24_47
.LBB24_106:
	ldx	mos8(__rc3)
	stx	mos8(__rc12)
	ldx	mos8(__rc19)
	stx	mos8(__rc21)
	ldx	mos8(__rc7)
	stx	mos8(__rc29)
	sty	mos8(__rc20)
	sty	mos8(__rc2)
	sty	mos8(__rc3)
	sty	mos8(__rc4)
	sty	mos8(__rc5)
	sty	mos8(__rc6)
	sty	mos8(__rc18)
	jmp	.LBB24_75
.LBB24_107:
	cpx	mos8(__rc12)
	bcc	.LBB24_129
	jmp	.LBB24_45
.LBB24_129:
	jmp	.LBB24_47
.LBB24_108:
	lda	mos8(__rc25)
	cmp	mos8(__rc5)
	bne	.LBB24_114
	ldx	mos8(__rc30)
	cpx	mos8(__rc4)
	bne	.LBB24_116
	lda	mos8(__rc23)
	cmp	mos8(__rc3)
	bne	.LBB24_118
	ldx	mos8(__rc7)
	cpx	mos8(__rc2)
	jmp	.LBB24_119
.LBB24_112:
	cpx	mos8(__rc6)
	jmp	.LBB24_70
.LBB24_113:
	cpx	mos8(__rc11)
	bcc	.LBB24_130
	jmp	.LBB24_45
.LBB24_130:
	jmp	.LBB24_47
.LBB24_114:
	cmp	mos8(__rc5)
	jmp	.LBB24_120
.LBB24_115:
	cpx	mos8(__rc10)
	bcc	.LBB24_131
	jmp	.LBB24_45
.LBB24_131:
	jmp	.LBB24_47
.LBB24_116:
	cpx	mos8(__rc4)
	jmp	.LBB24_120
.LBB24_117:
	cpx	mos8(__rc9)
	bcc	.LBB24_132
	jmp	.LBB24_45
.LBB24_132:
	jmp	.LBB24_47
.LBB24_118:
	cmp	mos8(__rc3)
.LBB24_119:
	ldx	mos8(__rc24)
	stx	mos8(__rc30)
.LBB24_120:
	ldx	mos8(__rc26)
	stx	mos8(__rc31)
	jmp	.LBB24_70
.Lfunc_end24:
	.size	__divmoddi4, .Lfunc_end24-__divmoddi4

	.section	.text.__mulqi3,"ax",@progbits
	.globl	__mulqi3
	.type	__mulqi3,@function
__mulqi3:
	cpx	#0
	beq	.LBB25_6
	sta	mos8(__rc2)
	stx	mos8(__rc3)
	lda	#0
.LBB25_2:
	lsr	mos8(__rc3)
	bcc	.LBB25_4
	clc
	adc	mos8(__rc2)
.LBB25_4:
	asl	mos8(__rc2)
	ldx	mos8(__rc3)
	bne	.LBB25_2
	rts
.LBB25_6:
	lda	#0
	rts
.Lfunc_end25:
	.size	__mulqi3, .Lfunc_end25-__mulqi3

	.section	.text.__mulhi3,"ax",@progbits
	.globl	__mulhi3
	.type	__mulhi3,@function
__mulhi3:
	sta	mos8(__rc4)
	stx	mos8(__rc5)
	lda	mos8(__rc3)
	bne	.LBB26_2
	ldy	#0
	ldx	#0
	lda	mos8(__rc2)
	beq	.LBB26_7
.LBB26_2:
	ldy	#0
	ldx	#0
.LBB26_3:
	lsr	mos8(__rc3)
	ror	mos8(__rc2)
	bcc	.LBB26_5
	tya
	clc
	adc	mos8(__rc4)
	tay
	txa
	adc	mos8(__rc5)
	tax
.LBB26_5:
	asl	mos8(__rc4)
	rol	mos8(__rc5)
	lda	mos8(__rc3)
	bne	.LBB26_3
	lda	mos8(__rc2)
	bne	.LBB26_3
.LBB26_7:
	tya
	rts
.Lfunc_end26:
	.size	__mulhi3, .Lfunc_end26-__mulhi3

	.section	.text.__mulsi3,"ax",@progbits
	.globl	__mulsi3
	.type	__mulsi3,@function
__mulsi3:
	sta	mos8(__rc8)
	stx	mos8(__rc9)
	lda	mos8(__rc7)
	bne	.LBB27_4
	lda	mos8(__rc6)
	bne	.LBB27_4
	lda	mos8(__rc5)
	bne	.LBB27_4
	ldx	#0
	stx	mos8(__rc11)
	ldx	#0
	stx	mos8(__rc12)
	ldy	#0
	ldx	#0
	lda	mos8(__rc4)
	beq	.LBB27_11
.LBB27_4:
	ldx	#0
	stx	mos8(__rc11)
	ldx	#0
	stx	mos8(__rc12)
	ldy	#0
	ldx	#0
.LBB27_5:
	lsr	mos8(__rc7)
	ror	mos8(__rc6)
	ror	mos8(__rc5)
	ror	mos8(__rc4)
	bcc	.LBB27_7
	lda	mos8(__rc11)
	clc
	adc	mos8(__rc8)
	sta	mos8(__rc11)
	lda	mos8(__rc12)
	adc	mos8(__rc9)
	sta	mos8(__rc12)
	tya
	adc	mos8(__rc2)
	tay
	txa
	adc	mos8(__rc3)
	tax
.LBB27_7:
	asl	mos8(__rc8)
	rol	mos8(__rc9)
	rol	mos8(__rc2)
	rol	mos8(__rc3)
	lda	mos8(__rc7)
	bne	.LBB27_5
	lda	mos8(__rc6)
	bne	.LBB27_5
	lda	mos8(__rc5)
	bne	.LBB27_5
	lda	mos8(__rc4)
	bne	.LBB27_5
.LBB27_11:
	sty	mos8(__rc2)
	stx	mos8(__rc3)
	ldx	mos8(__rc12)
	lda	mos8(__rc11)
	rts
.Lfunc_end27:
	.size	__mulsi3, .Lfunc_end27-__mulsi3

	.section	.text.__muldi3,"ax",@progbits
	.globl	__muldi3
	.type	__muldi3,@function
__muldi3:
	sta	mos8(__rc16)
	lda	mos8(__rc20)
	pha
	lda	mos8(__rc21)
	pha
	lda	mos8(__rc22)
	pha
	lda	mos8(__rc23)
	pha
	lda	mos8(__rc16)
	ldy	mos8(__rc24)
	sty	.L____muldi3_sstk
	ldy	mos8(__rc25)
	sty	.L____muldi3_sstk+1
	sta	mos8(__rc18)
	stx	mos8(__rc19)
	lda	mos8(__rc15)
	bne	.LBB28_8
	lda	mos8(__rc14)
	bne	.LBB28_8
	lda	mos8(__rc13)
	bne	.LBB28_8
	lda	mos8(__rc12)
	bne	.LBB28_8
	lda	mos8(__rc11)
	bne	.LBB28_8
	lda	mos8(__rc10)
	bne	.LBB28_8
	lda	mos8(__rc9)
	bne	.LBB28_8
	ldx	#0
	stx	mos8(__rc21)
	ldx	#0
	stx	mos8(__rc22)
	ldx	#0
	stx	mos8(__rc20)
	ldx	#0
	stx	mos8(__rc24)
	ldx	#0
	stx	mos8(__rc23)
	lda	#0
	sta	mos8(__rc25)
	ldx	#0
	ldy	#0
	lda	mos8(__rc8)
	bne	.LBB28_8
	jmp	.LBB28_19
.LBB28_8:
	ldx	#0
	stx	mos8(__rc21)
	ldx	#0
	stx	mos8(__rc22)
	ldx	#0
	stx	mos8(__rc20)
	ldx	#0
	stx	mos8(__rc24)
	ldx	#0
	stx	mos8(__rc23)
	lda	#0
	sta	mos8(__rc25)
	ldx	#0
	ldy	#0
.LBB28_9:
	lsr	mos8(__rc15)
	ror	mos8(__rc14)
	ror	mos8(__rc13)
	ror	mos8(__rc12)
	ror	mos8(__rc11)
	ror	mos8(__rc10)
	ror	mos8(__rc9)
	ror	mos8(__rc8)
	bcc	.LBB28_11
	lda	mos8(__rc21)
	clc
	adc	mos8(__rc18)
	sta	mos8(__rc21)
	lda	mos8(__rc22)
	adc	mos8(__rc19)
	sta	mos8(__rc22)
	lda	mos8(__rc20)
	adc	mos8(__rc2)
	sta	mos8(__rc20)
	lda	mos8(__rc24)
	adc	mos8(__rc3)
	sta	mos8(__rc24)
	lda	mos8(__rc23)
	adc	mos8(__rc4)
	sta	mos8(__rc23)
	lda	mos8(__rc25)
	adc	mos8(__rc5)
	sta	mos8(__rc25)
	txa
	adc	mos8(__rc6)
	tax
	tya
	adc	mos8(__rc7)
	tay
.LBB28_11:
	asl	mos8(__rc18)
	rol	mos8(__rc19)
	rol	mos8(__rc2)
	rol	mos8(__rc3)
	rol	mos8(__rc4)
	rol	mos8(__rc5)
	rol	mos8(__rc6)
	rol	mos8(__rc7)
	lda	mos8(__rc15)
	beq	.LBB28_12
	jmp	.LBB28_9
.LBB28_12:
	lda	mos8(__rc14)
	beq	.LBB28_13
	jmp	.LBB28_9
.LBB28_13:
	lda	mos8(__rc13)
	beq	.LBB28_14
	jmp	.LBB28_9
.LBB28_14:
	lda	mos8(__rc12)
	beq	.LBB28_15
	jmp	.LBB28_9
.LBB28_15:
	lda	mos8(__rc11)
	beq	.LBB28_16
	jmp	.LBB28_9
.LBB28_16:
	lda	mos8(__rc10)
	beq	.LBB28_17
	jmp	.LBB28_9
.LBB28_17:
	lda	mos8(__rc9)
	beq	.LBB28_18
	jmp	.LBB28_9
.LBB28_18:
	lda	mos8(__rc8)
	beq	.LBB28_19
	jmp	.LBB28_9
.LBB28_19:
	lda	mos8(__rc20)
	sta	mos8(__rc2)
	lda	mos8(__rc24)
	sta	mos8(__rc3)
	lda	mos8(__rc23)
	sta	mos8(__rc4)
	lda	mos8(__rc25)
	sta	mos8(__rc5)
	stx	mos8(__rc6)
	sty	mos8(__rc7)
	ldx	mos8(__rc22)
	lda	mos8(__rc21)
	sta	mos8(__rc16)
	ldy	.L____muldi3_sstk+1
	sty	mos8(__rc25)
	ldy	.L____muldi3_sstk
	sty	mos8(__rc24)
	pla
	sta	mos8(__rc23)
	pla
	sta	mos8(__rc22)
	pla
	sta	mos8(__rc21)
	pla
	sta	mos8(__rc20)
	lda	mos8(__rc16)
	rts
.Lfunc_end28:
	.size	__muldi3, .Lfunc_end28-__muldi3

	.section	.text.__ashlqi3,"ax",@progbits
	.globl	__ashlqi3
	.type	__ashlqi3,@function
__ashlqi3:
	jmp	.LBB29_2
.LBB29_1:
	dex
	asl
.LBB29_2:
	cpx	#0
	bne	.LBB29_1
	rts
.Lfunc_end29:
	.size	__ashlqi3, .Lfunc_end29-__ashlqi3

	.section	.text.__ashlhi3,"ax",@progbits
	.globl	__ashlhi3
	.type	__ashlhi3,@function
__ashlhi3:
	stx	mos8(__rc3)
	ldx	mos8(__rc2)
	beq	.LBB30_3
	ldx	mos8(__rc2)
.LBB30_2:
	dex
	asl
	rol	mos8(__rc3)
	cpx	#0
	bne	.LBB30_2
.LBB30_3:
	ldx	mos8(__rc3)
	rts
.Lfunc_end30:
	.size	__ashlhi3, .Lfunc_end30-__ashlhi3

	.section	.text.__ashlsi3,"ax",@progbits
	.globl	__ashlsi3
	.type	__ashlsi3,@function
__ashlsi3:
	stx	mos8(__rc5)
	ldx	mos8(__rc4)
	beq	.LBB31_3
	ldx	mos8(__rc4)
.LBB31_2:
	dex
	asl
	rol	mos8(__rc5)
	rol	mos8(__rc2)
	rol	mos8(__rc3)
	cpx	#0
	bne	.LBB31_2
.LBB31_3:
	ldx	mos8(__rc5)
	rts
.Lfunc_end31:
	.size	__ashlsi3, .Lfunc_end31-__ashlsi3

	.section	.text.__ashldi3,"ax",@progbits
	.globl	__ashldi3
	.type	__ashldi3,@function
__ashldi3:
	stx	mos8(__rc9)
	ldx	mos8(__rc8)
	beq	.LBB32_3
	ldx	mos8(__rc8)
.LBB32_2:
	dex
	asl
	rol	mos8(__rc9)
	rol	mos8(__rc2)
	rol	mos8(__rc3)
	rol	mos8(__rc4)
	rol	mos8(__rc5)
	rol	mos8(__rc6)
	rol	mos8(__rc7)
	cpx	#0
	bne	.LBB32_2
.LBB32_3:
	ldx	mos8(__rc9)
	rts
.Lfunc_end32:
	.size	__ashldi3, .Lfunc_end32-__ashldi3

	.section	.text.__lshrqi3,"ax",@progbits
	.globl	__lshrqi3
	.type	__lshrqi3,@function
__lshrqi3:
	jmp	.LBB33_2
.LBB33_1:
	dex
	lsr
.LBB33_2:
	cpx	#0
	bne	.LBB33_1
	rts
.Lfunc_end33:
	.size	__lshrqi3, .Lfunc_end33-__lshrqi3

	.section	.text.__lshrhi3,"ax",@progbits
	.globl	__lshrhi3
	.type	__lshrhi3,@function
__lshrhi3:
	stx	mos8(__rc3)
	ldx	mos8(__rc2)
	beq	.LBB34_3
	ldx	mos8(__rc2)
.LBB34_2:
	dex
	lsr	mos8(__rc3)
	ror
	cpx	#0
	bne	.LBB34_2
.LBB34_3:
	ldx	mos8(__rc3)
	rts
.Lfunc_end34:
	.size	__lshrhi3, .Lfunc_end34-__lshrhi3

	.section	.text.__lshrsi3,"ax",@progbits
	.globl	__lshrsi3
	.type	__lshrsi3,@function
__lshrsi3:
	stx	mos8(__rc5)
	ldx	mos8(__rc4)
	beq	.LBB35_3
	ldx	mos8(__rc4)
.LBB35_2:
	dex
	lsr	mos8(__rc3)
	ror	mos8(__rc2)
	ror	mos8(__rc5)
	ror
	cpx	#0
	bne	.LBB35_2
.LBB35_3:
	ldx	mos8(__rc5)
	rts
.Lfunc_end35:
	.size	__lshrsi3, .Lfunc_end35-__lshrsi3

	.section	.text.__lshrdi3,"ax",@progbits
	.globl	__lshrdi3
	.type	__lshrdi3,@function
__lshrdi3:
	stx	mos8(__rc9)
	ldx	mos8(__rc8)
	beq	.LBB36_3
	ldx	mos8(__rc8)
.LBB36_2:
	dex
	lsr	mos8(__rc7)
	ror	mos8(__rc6)
	ror	mos8(__rc5)
	ror	mos8(__rc4)
	ror	mos8(__rc3)
	ror	mos8(__rc2)
	ror	mos8(__rc9)
	ror
	cpx	#0
	bne	.LBB36_2
.LBB36_3:
	ldx	mos8(__rc9)
	rts
.Lfunc_end36:
	.size	__lshrdi3, .Lfunc_end36-__lshrdi3

	.section	.text.__ashrqi3,"ax",@progbits
	.globl	__ashrqi3
	.type	__ashrqi3,@function
__ashrqi3:
	jmp	.LBB37_2
.LBB37_1:
	dex
	cmp	#128
	ror
.LBB37_2:
	cpx	#0
	bne	.LBB37_1
	rts
.Lfunc_end37:
	.size	__ashrqi3, .Lfunc_end37-__ashrqi3

	.section	.text.__ashrhi3,"ax",@progbits
	.globl	__ashrhi3
	.type	__ashrhi3,@function
__ashrhi3:
	sta	mos8(__rc3)
	txa
	ldx	mos8(__rc2)
	beq	.LBB38_3
	ldx	mos8(__rc2)
.LBB38_2:
	dex
	cmp	#128
	ror
	ror	mos8(__rc3)
	cpx	#0
	bne	.LBB38_2
.LBB38_3:
	tax
	lda	mos8(__rc3)
	rts
.Lfunc_end38:
	.size	__ashrhi3, .Lfunc_end38-__ashrhi3

	.section	.text.__ashrsi3,"ax",@progbits
	.globl	__ashrsi3
	.type	__ashrsi3,@function
__ashrsi3:
	sta	mos8(__rc6)
	stx	mos8(__rc5)
	lda	mos8(__rc3)
	ldx	mos8(__rc4)
	beq	.LBB39_3
	ldx	mos8(__rc4)
.LBB39_2:
	dex
	cmp	#128
	ror
	ror	mos8(__rc2)
	ror	mos8(__rc5)
	ror	mos8(__rc6)
	cpx	#0
	bne	.LBB39_2
.LBB39_3:
	sta	mos8(__rc3)
	ldx	mos8(__rc5)
	lda	mos8(__rc6)
	rts
.Lfunc_end39:
	.size	__ashrsi3, .Lfunc_end39-__ashrsi3

	.section	.text.__ashrdi3,"ax",@progbits
	.globl	__ashrdi3
	.type	__ashrdi3,@function
__ashrdi3:
	sta	mos8(__rc10)
	stx	mos8(__rc9)
	lda	mos8(__rc7)
	ldx	mos8(__rc8)
	beq	.LBB40_3
	ldx	mos8(__rc8)
.LBB40_2:
	dex
	cmp	#128
	ror
	ror	mos8(__rc6)
	ror	mos8(__rc5)
	ror	mos8(__rc4)
	ror	mos8(__rc3)
	ror	mos8(__rc2)
	ror	mos8(__rc9)
	ror	mos8(__rc10)
	cpx	#0
	bne	.LBB40_2
.LBB40_3:
	sta	mos8(__rc7)
	ldx	mos8(__rc9)
	lda	mos8(__rc10)
	rts
.Lfunc_end40:
	.size	__ashrdi3, .Lfunc_end40-__ashrdi3

	.section	.text.putchar,"ax",@progbits
	.globl	putchar
	.type	putchar,@function
putchar:
	sta	mos8(__rc16)
	lda	mos8(__rc20)
	pha
	lda	mos8(__rc21)
	pha
	lda	mos8(__rc16)
	sta	mos8(__rc20)
	stx	mos8(__rc21)
	jsr	__chrout
	ldx	mos8(__rc21)
	lda	mos8(__rc20)
	sta	mos8(__rc16)
	pla
	sta	mos8(__rc21)
	pla
	sta	mos8(__rc20)
	lda	mos8(__rc16)
	rts
.Lfunc_end41:
	.size	putchar, .Lfunc_end41-putchar

	.section	.text.memcmp,"ax",@progbits
	.globl	memcmp
	.type	memcmp,@function
memcmp:
	ldy	#0
	sty	mos8(__rc8)
	cpx	#0
	bne	.LBB42_2
	tay
	beq	.LBB42_12
.LBB42_2:
	ldy	mos8(__rc4)
	sty	mos8(__rc6)
	ldy	mos8(__rc2)
	sty	mos8(__rc7)
	ldy	#0
.LBB42_3:
	sta	mos8(__rc9)
	lda	mos8(__rc6)
	sta	mos8(__rc4)
	lda	mos8(__rc7)
	sta	mos8(__rc2)
	lda	(mos8(__rc4)),y
	sta	mos8(__rc4)
	lda	(mos8(__rc2)),y
	cmp	mos8(__rc4)
	bne	.LBB42_14
	inc	mos8(__rc7)
	bne	.LBB42_6
	inc	mos8(__rc3)
.LBB42_6:
	lda	mos8(__rc9)
	inc	mos8(__rc6)
	bne	.LBB42_8
	inc	mos8(__rc5)
.LBB42_8:
	clc
	adc	#255
	cmp	#255
	bne	.LBB42_10
	dex
.LBB42_10:
	cpx	#0
	bne	.LBB42_3
	cmp	#0
	bne	.LBB42_3
.LBB42_12:
	lda	#0
.LBB42_13:
	tax
	lda	mos8(__rc8)
	rts
.LBB42_14:
	sec
	sbc	mos8(__rc4)
	sta	mos8(__rc8)
	lda	#0
	sbc	#0
	jmp	.LBB42_13
.Lfunc_end42:
	.size	memcmp, .Lfunc_end42-memcmp

	.section	.text.memcpy,"ax",@progbits
	.globl	memcpy
	.type	memcpy,@function
memcpy:
	tay
	txa
	bne	.LBB43_2
	tya
	beq	.LBB43_11
.LBB43_2:
	lda	mos8(__rc4)
	sta	mos8(__rc7)
	lda	mos8(__rc2)
	sta	mos8(__rc6)
	lda	mos8(__rc3)
	sta	mos8(__rc9)
.LBB43_3:
	sty	mos8(__rc10)
	ldy	mos8(__rc7)
	sty	mos8(__rc4)
	ldy	mos8(__rc6)
	sty	mos8(__rc8)
	ldy	#0
	lda	(mos8(__rc4)),y
	sta	(mos8(__rc8)),y
	inc	mos8(__rc6)
	bne	.LBB43_5
	inc	mos8(__rc9)
.LBB43_5:
	ldy	mos8(__rc10)
	inc	mos8(__rc7)
	bne	.LBB43_7
	inc	mos8(__rc5)
.LBB43_7:
	dey
	cpy	#255
	bne	.LBB43_9
	dex
.LBB43_9:
	txa
	bne	.LBB43_3
	tya
	bne	.LBB43_3
.LBB43_11:
	rts
.Lfunc_end43:
	.size	memcpy, .Lfunc_end43-memcpy

	.section	.text.memset,"ax",@progbits
	.globl	memset
	.type	memset,@function
memset:
	ldx	mos8(__rc4)
	ldy	mos8(__rc5)
	bne	.LBB44_2
	cpx	#0
	beq	.LBB44_9
.LBB44_2:
	ldy	mos8(__rc2)
	sty	mos8(__rc4)
	ldy	mos8(__rc3)
	sty	mos8(__rc7)
	ldy	#0
.LBB44_3:
	sty	mos8(__rc17)
	ldy	mos8(__rc4)
	sty	mos8(__rc6)
	ldy	mos8(__rc17)
	sta	(mos8(__rc6)),y
	inc	mos8(__rc4)
	bne	.LBB44_5
	inc	mos8(__rc7)
.LBB44_5:
	dex
	cpx	#255
	bne	.LBB44_7
	dec	mos8(__rc5)
.LBB44_7:
	inc	mos8(__rc5)
	dec	mos8(__rc5)
	bne	.LBB44_3
	cpx	#0
	bne	.LBB44_3
.LBB44_9:
	rts
.Lfunc_end44:
	.size	memset, .Lfunc_end44-memset

	.section	.text.__memset,"ax",@progbits
	.globl	__memset
	.type	__memset,@function
__memset:
	ldy	mos8(__rc4)
	bne	.LBB45_2
	cpx	#0
	beq	.LBB45_9
.LBB45_2:
	ldy	mos8(__rc2)
	sty	mos8(__rc5)
	ldy	#0
.LBB45_3:
	sty	mos8(__rc17)
	ldy	mos8(__rc5)
	sty	mos8(__rc2)
	ldy	mos8(__rc17)
	sta	(mos8(__rc2)),y
	inc	mos8(__rc5)
	bne	.LBB45_5
	inc	mos8(__rc3)
.LBB45_5:
	dex
	cpx	#255
	bne	.LBB45_7
	dec	mos8(__rc4)
.LBB45_7:
	inc	mos8(__rc4)
	dec	mos8(__rc4)
	bne	.LBB45_3
	cpx	#0
	bne	.LBB45_3
.LBB45_9:
	rts
.Lfunc_end45:
	.size	__memset, .Lfunc_end45-__memset

	.section	.text.memmove,"ax",@progbits
	.globl	memmove
	.type	memmove,@function
memmove:
	sta	mos8(__rc16)
	lda	mos8(__rc20)
	pha
	lda	mos8(__rc21)
	pha
	lda	mos8(__rc16)
	sta	mos8(__rc7)
	stx	mos8(__rc6)
	ldx	mos8(__rc2)
	stx	mos8(__rc20)
	ldx	mos8(__rc3)
	stx	mos8(__rc21)
	ldx	mos8(__rc5)
	cpx	mos8(__rc21)
	beq	.LBB46_1
	jmp	.LBB46_13
.LBB46_1:
	ldx	mos8(__rc4)
	cpx	mos8(__rc20)
	bcc	.LBB46_2
	jmp	.LBB46_14
.LBB46_2:
	lda	mos8(__rc6)
	bne	.LBB46_4
	lda	mos8(__rc7)
	bne	.LBB46_4
	jmp	.LBB46_15
.LBB46_4:
	ldy	#0
.LBB46_5:
	lda	mos8(__rc4)
	clc
	adc	mos8(__rc7)
	tax
	lda	mos8(__rc5)
	adc	mos8(__rc6)
	dex
	cpx	#255
	bne	.LBB46_7
	clc
	adc	#255
.LBB46_7:
	stx	mos8(__rc2)
	sta	mos8(__rc3)
	lda	mos8(__rc20)
	clc
	adc	mos8(__rc7)
	tax
	lda	mos8(__rc21)
	adc	mos8(__rc6)
	dex
	cpx	#255
	bne	.LBB46_9
	clc
	adc	#255
.LBB46_9:
	stx	mos8(__rc8)
	sta	mos8(__rc9)
	lda	(mos8(__rc2)),y
	sta	(mos8(__rc8)),y
	ldx	mos8(__rc7)
	dex
	cpx	#255
	bne	.LBB46_11
	dec	mos8(__rc6)
.LBB46_11:
	stx	mos8(__rc7)
	lda	mos8(__rc6)
	bne	.LBB46_5
	stx	mos8(__rc7)
	txa
	bne	.LBB46_5
	jmp	.LBB46_15
.LBB46_13:
	cpx	mos8(__rc21)
	bcs	.LBB46_14
	jmp	.LBB46_2
.LBB46_14:
	ldx	mos8(__rc20)
	stx	mos8(__rc2)
	ldx	mos8(__rc21)
	stx	mos8(__rc3)
	ldx	mos8(__rc6)
	lda	mos8(__rc7)
	jsr	memcpy
.LBB46_15:
	ldx	mos8(__rc20)
	stx	mos8(__rc2)
	ldx	mos8(__rc21)
	stx	mos8(__rc3)
	pla
	sta	mos8(__rc21)
	pla
	sta	mos8(__rc20)
	rts
.Lfunc_end46:
	.size	memmove, .Lfunc_end46-memmove

	.section	.text.__chrout,"ax",@progbits
	.type	__chrout,@function
__chrout:
	cmp	#10
	beq	.LBB47_2
.LBB47_1:
	;APP
	tax
	lda	58375
	pha
	lda	58374
	pha
	txa
	rts

	;NO_APP
	rts
.LBB47_2:
	lda	#-101
	jmp	.LBB47_1
.Lfunc_end47:
	.size	__chrout, .Lfunc_end47-__chrout

	.type	.L____udivdi3_sstk,@object
	.section	.bss..L____udivdi3_sstk,"aw",@nobits
.L____udivdi3_sstk:
	.zero	8
	.size	.L____udivdi3_sstk, 8

	.type	.L____umoddi3_sstk,@object
	.section	.bss..L____umoddi3_sstk,"aw",@nobits
.L____umoddi3_sstk:
	.zero	3
	.size	.L____umoddi3_sstk, 3

	.type	.L____udivmoddi4_sstk,@object
	.section	.bss..L____udivmoddi4_sstk,"aw",@nobits
.L____udivmoddi4_sstk:
	.zero	9
	.size	.L____udivmoddi4_sstk, 9

	.type	.L____divmodsi4_sstk,@object
	.section	.bss..L____divmodsi4_sstk,"aw",@nobits
.L____divmodsi4_sstk:
	.zero	3
	.size	.L____divmodsi4_sstk, 3

	.type	.L____divmoddi4_sstk,@object
	.section	.bss..L____divmoddi4_sstk,"aw",@nobits
.L____divmoddi4_sstk:
	.zero	23
	.size	.L____divmoddi4_sstk, 23

	.type	.L____muldi3_sstk,@object
	.section	.bss..L____muldi3_sstk,"aw",@nobits
.L____muldi3_sstk:
	.zero	2
	.size	.L____muldi3_sstk, 2

	.ident	"clang version 14.0.0 (https://github.com/llvm-mos/llvm-mos e85426ddcf2427a3131e666529abe2cb6987c4b2)"
	.ident	"clang version 14.0.0 (https://github.com/llvm-mos/llvm-mos e85426ddcf2427a3131e666529abe2cb6987c4b2)"
	.ident	"clang version 14.0.0 (https://github.com/llvm-mos/llvm-mos e85426ddcf2427a3131e666529abe2cb6987c4b2)"
	.ident	"clang version 14.0.0 (https://github.com/llvm-mos/llvm-mos e85426ddcf2427a3131e666529abe2cb6987c4b2)"
	.ident	"clang version 14.0.0 (https://github.com/llvm-mos/llvm-mos e85426ddcf2427a3131e666529abe2cb6987c4b2)"
	.ident	"clang version 14.0.0 (https://github.com/llvm-mos/llvm-mos e85426ddcf2427a3131e666529abe2cb6987c4b2)"
	.ident	"clang version 14.0.0 (https://github.com/llvm-mos/llvm-mos e85426ddcf2427a3131e666529abe2cb6987c4b2)"
	.ident	"clang version 14.0.0 (https://github.com/llvm-mos/llvm-mos e85426ddcf2427a3131e666529abe2cb6987c4b2)"
	.section	".note.GNU-stack","",@progbits
	.addrsig
	.addrsig_sym __bss_begin
	.addrsig_sym __bss_end
