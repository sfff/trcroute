# trcroute
#
# Copyright (c) 2004, Aleksey Samsonov <0@bk.ru>
# All rights reserved.
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions are met: 
#
# 1. Redistributions of source code must retain the above copyright notice, this
#    list of conditions and the following disclaimer. 
# 2. Redistributions in binary form must reproduce the above copyright notice,
#    this list of conditions and the following disclaimer in the documentation
#    and/or other materials provided with the distribution. 
#
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
# ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
# WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
# DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR
# ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
# (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
# LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
# ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
# (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
# SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
#
#################################################################################

	.globl _start


		SYS_WRITE		=	4
		SYS_GETPID		=	20
		SYS_ALARM		=	27
		SYS_SIGNAL		=	48
		SYS_GETTIMEOFDAY	=	78
		SYS_SOCKETCALL		=	102

		SIGALRM			=	14
		SIG_IGN			=	1

		SYS_SOCKET		=	1
		SYS_BIND		=	2
		SYS_SETSOCKOPT		=	14
		SYS_SENDTO		=	11
		SYS_RECVFROM		=	12

		ICMP_TIME_EXCEEDED      =       11
		ICMP_DEST_UNREACH       =       3

		AF_INET			=	2

		SOCK_RAW		=	3
		SOCK_DGRAM		=	2

		IPPROTO_ICMP		=	1
		IPPROTO_IP		=	0
		IP_TTL			=	2
		INADDR_ANY		=	0


	.data

		StrArgsErr:	.ascii		"Usage: trcroute <ip-address>\nExample: # trcroute 127.0.0.1\n"
		StrArgsErrLen	= .-StrArgsErr

		StrTarget:	.ascii		"Target ip-address: "
		StrTargetLen	= .-StrTarget

		TableHexToStr:	.long		0x1000030,0x1000031,0x1000032,0x1000033,0x1000034,0x1000035,0x1000036,0x1000037,0x1000038,0x1000039,0x2003031,0x2003131,0x2003231,0x2003331,0x2003431,0x2003531,0x2003631,0x2003731,0x2003831,0x2003931,0x2003032,0x2003132,0x2003232,0x2003332,0x2003432,0x2003532,0x2003632,0x2003732,0x2003832,0x2003932,0x2003033,0x2003133,0x2003233,0x2003333,0x2003433,0x2003533,0x2003633,0x2003733,0x2003833,0x2003933,0x2003034,0x2003134,0x2003234,0x2003334,0x2003434,0x2003534,0x2003634,0x2003734,0x2003834,0x2003934,0x2003035,0x2003135,0x2003235,0x2003335,0x2003435,0x2003535,0x2003635,0x2003735,0x2003835,0x2003935,0x2003036,0x2003136,0x2003236,0x2003336,0x2003436,0x2003536,0x2003636,0x2003736,0x2003836,0x2003936,0x2003037,0x2003137,0x2003237,0x2003337,0x2003437,0x2003537,0x2003637,0x2003737,0x2003837,0x2003937,0x2003038,0x2003138,0x2003238,0x2003338,0x2003438,0x2003538,0x2003638,0x2003738,0x2003838,0x2003938,0x2003039,0x2003139,0x2003239,0x2003339,0x2003439,0x2003539,0x2003639,0x2003739,0x2003839,0x2003939,0x3303031,0x3313031,0x3323031,0x3333031,0x3343031,0x3353031,0x3363031,0x3373031,0x3383031,0x3393031,0x3303131,0x3313131,0x3323131,0x3333131,0x3343131,0x3353131,0x3363131,0x3373131,0x3383131,0x3393131,0x3303231,0x3313231,0x3323231,0x3333231,0x3343231,0x3353231,0x3363231,0x3373231,0x3383231,0x3393231,0x3303331,0x3313331,0x3323331,0x3333331,0x3343331,0x3353331,0x3363331,0x3373331,0x3383331,0x3393331,0x3303431,0x3313431,0x3323431,0x3333431,0x3343431,0x3353431,0x3363431,0x3373431,0x3383431,0x3393431,0x3303531,0x3313531,0x3323531,0x3333531,0x3343531,0x3353531,0x3363531,0x3373531,0x3383531,0x3393531,0x3303631,0x3313631,0x3323631,0x3333631,0x3343631,0x3353631,0x3363631,0x3373631,0x3383631,0x3393631,0x3303731,0x3313731,0x3323731,0x3333731,0x3343731,0x3353731,0x3363731,0x3373731,0x3383731,0x3393731,0x3303831,0x3313831,0x3323831,0x3333831,0x3343831,0x3353831,0x3363831,0x3373831,0x3383831,0x3393831,0x3303931,0x3313931,0x3323931,0x3333931,0x3343931,0x3353931,0x3363931,0x3373931,0x3383931,0x3393931,0x3303032,0x3313032,0x3323032,0x3333032,0x3343032,0x3353032,0x3363032,0x3373032,0x3383032,0x3393032,0x3303132,0x3313132,0x3323132,0x3333132,0x3343132,0x3353132,0x3363132,0x3373132,0x3383132,0x3393132,0x3303232,0x3313232,0x3323232,0x3333232,0x3343232,0x3353232,0x3363232,0x3373232,0x3383232,0x3393232,0x3303332,0x3313332,0x3323332,0x3333332,0x3343332,0x3353332,0x3363332,0x3373332,0x3383332,0x3393332,0x3303432,0x3313432,0x3323432,0x3333432,0x3343432,0x3353432,0x3363432,0x3373432,0x3383432,0x3393432,0x3303532,0x3313532,0x3323532,0x3333532,0x3343532,0x3353532

		TableDiv:	.long		10,100,1000,10000,100000,1000000

		TargetIp:	.long		0

		SendFd:		.long		0
		RecvFd:		.long		0

		SPort:		.word		0
		TPort:		.word		0xAAAA

		Ttl:		.long		1

		LastIp:		.long		0

		Time1:		.long		0, 0
		Time0:		.long		0, 0

################################################################################

	.text

		# %edi - IP address for output

CoutHexEDI:

		xor	%ebx, %ebx
		push	$0x2E
		inc	%ebx
		jmp	CoutHex_m1
		nop

	CoutHex_m0:

		lea	3(%ebx), %eax              # mov   $SYS_WRITE, %eax
		mov	%esp, %ecx
		mov	%ebx, %edx
		int	$0x80

	CoutHex_m1:

		mov	%edi, %edx
		shr	$8, %edi
		and	$0xFF, %edx
		lea	TableHexToStr(, %edx, 4), %ecx
		movw	TableHexToStr+2(, %edx, 4), %dx

		mov	$SYS_WRITE, %eax
		shr	$8, %edx
		int	$0x80

		test	%edi, %edi
		jnz	CoutHex_m0


		pop	%eax
		ret


		nop

################################################################################

		# %eax - time in ns for output

Coutns:
		xor	%ebx, %ebx
		and	$0x7FFFFF, %eax
		inc	%ebx

		push	%eax

		pushl	$32

		mov	%ebx, %edx
		mov	%esp, %ecx
		mov	$SYS_WRITE, %eax
		int	$0x80

		pop	%eax
		mov	$5, %edi
		pop	%eax

		nop
	Coutns_m0:

		xor	%edx, %edx
		divl	TableDiv(,%edi,4)

		push	%edx

		lea	TableHexToStr(, %eax, 4), %ecx
		mov	%ebx, %edx
		mov	$SYS_WRITE, %eax
		int	$0x80

		pop	%eax
		dec	%edi
		jns	Coutns_m0

		add	$0x206B6D30, %eax
		mov	$4, %edx
		push	%eax
		mov	%esp, %ecx
		mov	%edx, %eax                 # $SYS_WRITE, %eax
		int	$0x80

		pop	%eax
		ret

		nop

################################################################################

SignalAlrm:
		push	$-3
		jmp	Receive_m0
		
		nop


Receive:
		mov	%esp, %ebp

		movl	$SignalAlrm, %ecx
		mov	$SIGALRM, %ebx
                mov	$SYS_SIGNAL, %eax
		int	$0x80

		mov	$3, %ebx
		mov	$SYS_ALARM, %eax
		int	$0x80

		pushl	$0                         # align
		pushl	$0                         # align
		pushl	$0                         # INADDR_ANY
		pushl	$AF_INET                   # port == 0
		mov	%esp, %edx
		push	$16                        # sizeof(sockaddr)
		mov	%esp, %eax
		sub	$0x1000, %esp
		mov	%esp, %edi

		push	%eax
		push	%edx
		push	$0
		push	$0x1000
		push	%edi
		push	(RecvFd)


	ReceiveLoop:

		mov	%esp, %ecx
		mov	$SYS_RECVFROM, %ebx
		mov	$SYS_SOCKETCALL, %eax
		int	$0x80

		# %edi - ptr to receive IP packet

		movb	(%edi), %dl
		and	$0xF, %edx
		movw	(%edi, %edx, 4), %ax

		mov	$-2, %ecx
		cmpb	$ICMP_TIME_EXCEEDED, %al
		jz	ReceiveExit

		mov	$-1, %ecx
		cmpb	$ICMP_DEST_UNREACH, %al
		jnz	ReceiveLoop

	ReceiveExit:

		lea	8(%edi, %edx, 4), %edx
		movb	(%edx), %al
		and	$0xF, %eax

		movw	(%edx, %eax, 4), %ax       # UDP - source port
		cmp	(SPort), %ax
		jnz	ReceiveLoop

		push	%ecx


		mov	$Time1, %ebx
		xor	%ecx, %ecx
		mov	$SYS_GETTIMEOFDAY, %eax
		int	$0x80


		mov	12(%edi), %edi
		nop
		cmp	(LastIp), %edi
		jz	Receive_m0


		mov	%edi, (LastIp)

		call	CoutHexEDI


	Receive_m0:

		mov	$SIG_IGN, %ecx
		mov	$SIGALRM, %ebx
		mov	$SYS_SIGNAL, %eax
		int	$0x80


		pop	%eax

		mov	%ebp, %esp
		ret


		nop

################################################################################

_start:
		pop	%eax

		sub	$2, %eax
		jnz	exit_err_msg

		pop	%edx

		mov	$16, %ecx

		mov	(%esp), %edi

		lea	-1(%ecx), %edx

		repne
		scasb

		sub	%ecx, %edx

		xor	%ebx, %ebx
		pop	%ecx
		xor	%edi, %edi
		movb	$0x2E, (%ecx, %edx)
		nop

	start_m0:

		mov	(%ecx), %al
		cmp	$0x2E, %al
		jz	start_m1

		lea	(%ebx, %ebx, 4), %ebx
		shl	$1, %ebx
		lea	-0x30(%ebx, %eax), %ebx
		jmp	start_m2

	start_m1:

		add	%ebx, %edi
		ror	$8, %edi
		xor	%ebx, %ebx

	start_m2:

		inc	%ecx
		dec	%edx
		jns	start_m0


		movl	%edi, (TargetIp)

		lea	2(%edx), %ebx
		lea	5(%edx), %eax
		mov	$StrTargetLen, %edx
                mov	$StrTarget, %ecx
		push	%eax
		int	$0x80


		call	CoutHexEDI


		pop	%eax
		push	$10
		mov	%ebx, %edx
		mov	%esp, %ecx
		int	$0x80

		movl	$exit, (%esp)
		jmp	main

	exit_err_msg:

		mov	$StrArgsErrLen, %edx
		xor	%ebx, %ebx
		mov	$StrArgsErr, %ecx
		inc	%ebx
		mov	$SYS_WRITE, %eax
		int	$0x80

	exit:
		xor	%eax, %eax
		xor	%ebx, %ebx
		inc	%eax
		int	$0x80


		nop

################################################################################

main:
		pushl	$IPPROTO_ICMP
		pushl	$SOCK_RAW
		pushl	$AF_INET
		mov	%esp, %ecx
		mov	$SYS_SOCKETCALL, %eax
		mov	$SYS_SOCKET, %ebx
		int	$0x80
		mov	%eax, (RecvFd)
		inc	%eax
		jz	exit_err_msg

		movl	$0, 8(%esp)
		movl	$SOCK_DGRAM, 4(%esp)
		mov	$SYS_SOCKETCALL, %eax
		int	$0x80

		mov	%eax, (SendFd)

		inc	%eax
                jz	exit_err_msg


		mov	$SYS_GETPID, %eax
		int	$0x80

		or	$0x40, %eax
		nop
		mov	%ax, (SPort)

		movl	$0, 4(%esp)                # align
		shl	$16, %eax
		movl	$0, (%esp)                 # INADDR_ANY
		mov	$AF_INET, %ax
		push	%eax                       # port << 16  |  AF_INET
		mov	%esp, %eax
		pushl	$16
		push	%eax
		pushl	(SendFd)
		mov	%esp, %ecx
		inc	%ebx                       # SYS_BIND
		mov	$SYS_SOCKETCALL, %eax
		int	$0x80

		####################################
		#         stack
		#           0
		#           0
		#           0
		#  x << 16  |  AF_INET   <----\
		#          16                  |
		#          ptr ---------------/
		#       (SendFd)

		mov	(TargetIp), %eax
		movl	%eax, 16(%esp)
		pop	%edx
		pushl	$0                         # flag
		pushl	$4                         # sizeof(bufrcv)
		pushl	$Ttl                       # bufrcv
		push	%edx

		pushl	$4                         # sizeof(Ttl)
		pushl	$Ttl
		pushl	$IP_TTL
		pushl	$IPPROTO_IP
		pushl	%edx


	mainloop:

		mov	$3, %esi
		mov	(Ttl), %edi
		mov	%esi, (LastIp)

		call	CoutHexEDI                 # cout value Ttl


		# %ebx == 1
		# %edx - count to out (1 or 2)

		pushl	$0x202020
		xor	%esi, %edx                 # xor   $3, %edx
		mov	%esp, %ecx
		inc	%edx
		mov	$SYS_WRITE, %eax
		int	$0x80
		pop	%eax


	mainloop0:

		mov	%esp, %ecx
		mov	$SYS_SETSOCKOPT, %ebx
		mov	$SYS_SOCKETCALL, %eax
		int	$0x80


		mov	$Time0, %ebx
                xor	%ecx, %ecx
                mov	$SYS_GETTIMEOFDAY, %eax
                int	$0x80


		incw	(TPort)
		movw	(TPort), %ax
		lea	20(%esp), %ecx
		xchg	%al, %ah                   # network arch
		mov	$SYS_SENDTO, %ebx
		movw	%ax, 46(%esp)
		mov	$SYS_SOCKETCALL, %eax
		int	$0x80


		call	Receive

		xor	%edx, %edx
		inc	%edx

		push	$0x202A

		inc	%edx

		add	%edx, %eax
		js	main_m0

		dec	%eax
		cmovz	%eax, %esi


		mov	(Time1+4), %ecx
		mov	(Time1), %eax
		sub	(Time0+4), %ecx
		sub	(Time0), %eax
		mull	(TableDiv+4*5)
		add	%ecx, %eax

		call	Coutns

		xor	%edx, %edx

	main_m0:

		dec	%esi
		jnle	main_m1

		movw	$10, (%esp, %edx)
		inc	%edx

	main_m1:

		xor	%ebx, %ebx
		inc	%esi
		mov	%esp, %ecx
		inc	%ebx
		mov	$SYS_WRITE, %eax
		int	$0x80

		pop	%eax

		dec	%esi
		js	main_exit
		jnz	mainloop0

		incl	(Ttl)
		cmp	$50, (Ttl)
		jna	mainloop

	main_exit:

		add	$60, %esp
		ret

################################################################################

