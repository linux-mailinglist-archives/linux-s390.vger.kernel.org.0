Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E5771B2C60
	for <lists+linux-s390@lfdr.de>; Tue, 21 Apr 2020 18:19:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729218AbgDUQQR (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Tue, 21 Apr 2020 12:16:17 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:22295 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726157AbgDUQQQ (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 21 Apr 2020 12:16:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587485774;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=qdpVj7/sqLwKqxiFveqkA0IVu1ZzLXadZw1QFch4DVI=;
        b=GHBKeWK3FKYv/Ss9GbaDyBjVb/nPHa8oLjqxfu6gn2tdWeHywPgB9iOSWwsory9SqJufzD
        CqNlZ1s88ZAZV50dfQE6spnU4uebABxyfLkUBpcI03JC2IjACSVx6/liZ2y5Xnnqw1alEd
        MtlXSQ5MkNqQa+NZ6fjdVrjEg9d2J40=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-411-WYcnnzJINBqENEI0HumWvw-1; Tue, 21 Apr 2020 12:16:09 -0400
X-MC-Unique: WYcnnzJINBqENEI0HumWvw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B12B513F8;
        Tue, 21 Apr 2020 16:16:08 +0000 (UTC)
Received: from [10.36.113.245] (ovpn-113-245.ams2.redhat.com [10.36.113.245])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 445B648;
        Tue, 21 Apr 2020 16:16:07 +0000 (UTC)
Subject: Re: [kvm-unit-tests PATCH v5 02/10] s390x: Use PSW bits definitions
 in cstart
To:     Pierre Morel <pmorel@linux.ibm.com>, kvm@vger.kernel.org
Cc:     linux-s390@vger.kernel.org, frankja@linux.ibm.com,
        thuth@redhat.com, cohuck@redhat.com
References: <1582200043-21760-1-git-send-email-pmorel@linux.ibm.com>
 <1582200043-21760-3-git-send-email-pmorel@linux.ibm.com>
From:   David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; prefer-encrypt=mutual; keydata=
 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
Organization: Red Hat GmbH
Message-ID: <f8cb512c-8146-3777-13a8-5c06017334cf@redhat.com>
Date:   Tue, 21 Apr 2020 18:16:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <1582200043-21760-3-git-send-email-pmorel@linux.ibm.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 20.02.20 13:00, Pierre Morel wrote:
> This patch defines the PSW bits EA/BA used to initialize the PSW masks
> for exceptions.
> 
> Since some PSW mask definitions exist already in arch_def.h we add these
> definitions there.
> We move all PSW definitions together and protect assembler code against
> C syntax.
> 
> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
> ---
>  lib/s390x/asm/arch_def.h | 15 +++++++++++----
>  s390x/cstart64.S         | 15 ++++++++-------
>  2 files changed, 19 insertions(+), 11 deletions(-)
> 
> diff --git a/lib/s390x/asm/arch_def.h b/lib/s390x/asm/arch_def.h
> index 15a4d49..69a8256 100644
> --- a/lib/s390x/asm/arch_def.h
> +++ b/lib/s390x/asm/arch_def.h
> @@ -10,15 +10,21 @@
>  #ifndef _ASM_S390X_ARCH_DEF_H_
>  #define _ASM_S390X_ARCH_DEF_H_
>  
> +#define PSW_MASK_EXT			0x0100000000000000UL
> +#define PSW_MASK_DAT			0x0400000000000000UL
> +#define PSW_MASK_PSTATE			0x0001000000000000UL
> +#define PSW_MASK_BA			0x0000000080000000UL
> +#define PSW_MASK_EA			0x0000000100000000UL
> +
> +#define PSW_EXCEPTION_MASK (PSW_MASK_EA|PSW_MASK_BA)
> +
> +#ifndef __ASSEMBLER__
> +
>  struct psw {
>  	uint64_t	mask;
>  	uint64_t	addr;
>  };
>  
> -#define PSW_MASK_EXT			0x0100000000000000UL
> -#define PSW_MASK_DAT			0x0400000000000000UL
> -#define PSW_MASK_PSTATE			0x0001000000000000UL
> -
>  #define CR0_EXTM_SCLP			0X0000000000000200UL
>  #define CR0_EXTM_EXTC			0X0000000000002000UL
>  #define CR0_EXTM_EMGC			0X0000000000004000UL
> @@ -297,4 +303,5 @@ static inline uint32_t get_prefix(void)
>  	return current_prefix;
>  }
>  
> +#endif /* not __ASSEMBLER__ */
>  #endif
> diff --git a/s390x/cstart64.S b/s390x/cstart64.S
> index 45da523..2885a36 100644
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
> @@ -214,19 +215,19 @@ svc_int:
>  
>  	.align	8
>  reset_psw:
> -	.quad	0x0008000180000000
> +	.quad	PSW_EXCEPTION_MASK
>  initial_psw:
> -	.quad	0x0000000180000000, clear_bss_start
> +	.quad	PSW_EXCEPTION_MASK, clear_bss_start
>  pgm_int_psw:
> -	.quad	0x0000000180000000, pgm_int
> +	.quad	PSW_EXCEPTION_MASK, pgm_int
>  ext_int_psw:
> -	.quad	0x0000000180000000, ext_int
> +	.quad	PSW_EXCEPTION_MASK, ext_int
>  mcck_int_psw:
> -	.quad	0x0000000180000000, mcck_int
> +	.quad	PSW_EXCEPTION_MASK, mcck_int
>  io_int_psw:
> -	.quad	0x0000000180000000, io_int
> +	.quad	PSW_EXCEPTION_MASK, io_int
>  svc_int_psw:
> -	.quad	0x0000000180000000, svc_int
> +	.quad	PSW_EXCEPTION_MASK, svc_int
>  initial_cr0:
>  	/* enable AFP-register control, so FP regs (+BFP instr) can be used */
>  	.quad	0x0000000000040000
> 

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

