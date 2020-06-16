Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5ACA91FB1C4
	for <lists+linux-s390@lfdr.de>; Tue, 16 Jun 2020 15:13:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726606AbgFPNNl (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Tue, 16 Jun 2020 09:13:41 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:38024 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726052AbgFPNNk (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 16 Jun 2020 09:13:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592313218;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:openpgp:openpgp;
        bh=JBPAifMJNlcrBEUwh/D0BYGOXb4AfCXj5frjE3u0wNw=;
        b=WhDd7C7Z2nPDY7rd7BVQth3WlI6i1wcZwEn5o49ia+KqI2OpgeOG+U/+5Xk/hv6qrLrgr4
        uw9fZ//zGgB9jiSuz5VJJHlJIAg3uA16BzsTDKRbbZajxdbDKXLLeOpqkGO7a1bGvOwUQo
        SyB0o/5SCSxx02SqTjbH9QPQTwKLTN8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-295-LD307xFVOXSktcChKX9A9Q-1; Tue, 16 Jun 2020 09:13:37 -0400
X-MC-Unique: LD307xFVOXSktcChKX9A9Q-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DCDE980330E;
        Tue, 16 Jun 2020 13:13:35 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-114-128.ams2.redhat.com [10.36.114.128])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6EBB45D9D7;
        Tue, 16 Jun 2020 13:13:34 +0000 (UTC)
Subject: Re: [kvm-unit-tests PATCH v9 01/12] s390x: Use PSW bits definitions
 in cstart
To:     Pierre Morel <pmorel@linux.ibm.com>, kvm@vger.kernel.org
Cc:     linux-s390@vger.kernel.org, frankja@linux.ibm.com,
        david@redhat.com, cohuck@redhat.com
References: <1592213521-19390-1-git-send-email-pmorel@linux.ibm.com>
 <1592213521-19390-2-git-send-email-pmorel@linux.ibm.com>
From:   Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <f160d328-694a-4476-4863-c49a1d0e5349@redhat.com>
Date:   Tue, 16 Jun 2020 15:13:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <1592213521-19390-2-git-send-email-pmorel@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 15/06/2020 11.31, Pierre Morel wrote:
> This patch defines the PSW bits EA/BA used to initialize the PSW masks
> for exceptions.
> 
> Since some PSW mask definitions exist already in arch_def.h we add these
> definitions there.
> We move all PSW definitions together and protect assembler code against
> C syntax.
> 
> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
> Reviewed-by: Janosch Frank <frankja@linux.ibm.com>
> ---
>  lib/s390x/asm/arch_def.h | 15 +++++++++++----
>  s390x/cstart64.S         | 15 ++++++++-------
>  2 files changed, 19 insertions(+), 11 deletions(-)
> 
> diff --git a/lib/s390x/asm/arch_def.h b/lib/s390x/asm/arch_def.h
> index 1b3bb0c..b5d7aca 100644
> --- a/lib/s390x/asm/arch_def.h
> +++ b/lib/s390x/asm/arch_def.h
> @@ -10,15 +10,21 @@
>  #ifndef _ASM_S390X_ARCH_DEF_H_
>  #define _ASM_S390X_ARCH_DEF_H_
>  
> +#define PSW_MASK_EXT			0x0100000000000000UL
> +#define PSW_MASK_DAT			0x0400000000000000UL
> +#define PSW_MASK_SHORT_PSW		0x0008000000000000UL
> +#define PSW_MASK_PSTATE			0x0001000000000000UL
> +#define PSW_MASK_BA			0x0000000080000000UL
> +#define PSW_MASK_EA			0x0000000100000000UL
> +
> +#define PSW_MASK_ON_EXCEPTION	(PSW_MASK_EA | PSW_MASK_BA)
> +
> +#ifndef __ASSEMBLER__
>  struct psw {
>  	uint64_t	mask;
>  	uint64_t	addr;
>  };
>  
> -#define PSW_MASK_EXT			0x0100000000000000UL
> -#define PSW_MASK_DAT			0x0400000000000000UL
> -#define PSW_MASK_PSTATE			0x0001000000000000UL
> -
>  #define CR0_EXTM_SCLP			0x0000000000000200UL
>  #define CR0_EXTM_EXTC			0x0000000000002000UL
>  #define CR0_EXTM_EMGC			0x0000000000004000UL
> @@ -297,4 +303,5 @@ static inline uint32_t get_prefix(void)
>  	return current_prefix;
>  }
>  
> +#endif /* __ASSEMBLER */
>  #endif
> diff --git a/s390x/cstart64.S b/s390x/cstart64.S
> index e084f13..d386f35 100644
> --- a/s390x/cstart64.S
> +++ b/s390x/cstart64.S
> @@ -12,6 +12,7 @@
>   */
>  #include <asm/asm-offsets.h>
>  #include <asm/sigp.h>
> +#include <asm/arch_def.h>
>  
>  .section .init
>  
> @@ -198,19 +199,19 @@ svc_int:
>  
>  	.align	8
>  reset_psw:
> -	.quad	0x0008000180000000
> +	.quad	PSW_MASK_ON_EXCEPTION | PSW_MASK_SHORT_PSW
>  initial_psw:
> -	.quad	0x0000000180000000, clear_bss_start
> +	.quad	PSW_MASK_ON_EXCEPTION, clear_bss_start
>  pgm_int_psw:
> -	.quad	0x0000000180000000, pgm_int
> +	.quad	PSW_MASK_ON_EXCEPTION, pgm_int
>  ext_int_psw:
> -	.quad	0x0000000180000000, ext_int
> +	.quad	PSW_MASK_ON_EXCEPTION, ext_int
>  mcck_int_psw:
> -	.quad	0x0000000180000000, mcck_int
> +	.quad	PSW_MASK_ON_EXCEPTION, mcck_int
>  io_int_psw:
> -	.quad	0x0000000180000000, io_int
> +	.quad	PSW_MASK_ON_EXCEPTION, io_int
>  svc_int_psw:
> -	.quad	0x0000000180000000, svc_int
> +	.quad	PSW_MASK_ON_EXCEPTION, svc_int
>  initial_cr0:
>  	/* enable AFP-register control, so FP regs (+BFP instr) can be used */
>  	.quad	0x0000000000040000
> 

I'm afraid, by when I compile this on RHEL7, the toolchain complains:

s390x/cstart64.S: Assembler messages:
s390x/cstart64.S:239: Error: found 'L', expected: ')'
s390x/cstart64.S:239: Error: junk at end of line, first unrecognized
character is `L'
s390x/cstart64.S:241: Error: found 'L', expected: ')'
s390x/cstart64.S:241: Error: junk at end of line, first unrecognized
character is `L'
s390x/cstart64.S:243: Error: found 'L', expected: ')'
s390x/cstart64.S:243: Error: junk at end of line, first unrecognized
character is `L'
s390x/cstart64.S:245: Error: found 'L', expected: ')'
s390x/cstart64.S:245: Error: junk at end of line, first unrecognized
character is `L'
s390x/cstart64.S:247: Error: found 'L', expected: ')'
s390x/cstart64.S:247: Error: junk at end of line, first unrecognized
character is `L'
s390x/cstart64.S:249: Error: found 'L', expected: ')'
s390x/cstart64.S:249: Error: junk at end of line, first unrecognized
character is `L'
s390x/cstart64.S:251: Error: found 'L', expected: ')'
s390x/cstart64.S:251: Error: junk at end of line, first unrecognized
character is `L'
s390x/cstart64.S:254: Error: junk at end of line, first unrecognized
character is `L'

Shall we skip the update to the assembler file for now?

 Thomas

