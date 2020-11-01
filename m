Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5470E2A20DC
	for <lists+linux-s390@lfdr.de>; Sun,  1 Nov 2020 19:58:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727262AbgKAS6w (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Sun, 1 Nov 2020 13:58:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726889AbgKAS6w (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Sun, 1 Nov 2020 13:58:52 -0500
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3A38C0617A6
        for <linux-s390@vger.kernel.org>; Sun,  1 Nov 2020 10:58:50 -0800 (PST)
Received: by mail-pf1-x441.google.com with SMTP id e7so9068888pfn.12
        for <linux-s390@vger.kernel.org>; Sun, 01 Nov 2020 10:58:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=J0a71tD3nZxVWHOaiUWxkBQOAudrQ90pNbrsGvepQLM=;
        b=adfaX2OPmBR9FIXkYLjIk/msN5VrRueJK+BzgeChciVX6H+z+q2+vEq9EgB5IdcJCo
         UXVhXi/3f92AcgumeHbWTUbtLXpK/OZoLYcjRwpi5NYgq06a9ztDUc0OJTHVkFSlhwTl
         k7GYI/HxgxT7k4sTdZdSI6iOVKVKiGX8qxpYQPKwI+cZiejaolzu3azvSmy78cC+xsTU
         /RIyQEFIGs2R7+15F+Un8Mywjz4z2BbUGHYEd4Kch04MsXVopnpaHxQcYVApfDCvfab4
         U4lTdy/qoAbJf4BVrtum5Fd2Tym9IOLbHVwC0OQ8dEJ1yNnBIHm61IaxE0w0Gkh8x6Tj
         EO6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=J0a71tD3nZxVWHOaiUWxkBQOAudrQ90pNbrsGvepQLM=;
        b=GQTTmPdlsDOu4te3moQnh9ZLASIQsx/H6mbOGcoe/0d40DsEE/aeJgdu3MECHDQvie
         aANhmnyB5HLHKCZNrWEGy+4IrkJqi+iT8PnWTDnz7LZJ2A07+5vl7zj+T8ESCaHyGSbj
         eMdqXqMda7fPoNBgpcR/1YfTdYs7oMY5j7EXuUuHQHKIPC3ybups3PTXA8K8pciPRePF
         EJGX75UHL47Y3dmycp6OPMlgEknKbPpuFBCCjfbbEvMW+ht6huswvGeUB+T+sy8HQIoK
         G3d8H23i05gIc1KP4obyoHlkohcjnvaQq5eEavqr4JU34oCK8idP6ex+jZF9spLy1A/c
         plIg==
X-Gm-Message-State: AOAM531N2Dl6eBD7ELra+wdraU4tEbk46EsPfDzCpnEjou4+xy4BkFC0
        WxFnyZOPJqm9rZGXyXNOhYby3s+HRqnkng==
X-Google-Smtp-Source: ABdhPJyMYKRzKaP931GWOUUjkw2M/66Ec0yRf8sbk5KTnIHf7poxoSjSvTjB2m067/N80+beUwT8cg==
X-Received: by 2002:a05:6a00:783:b029:156:7d68:637c with SMTP id g3-20020a056a000783b02901567d68637cmr18698330pfu.18.1604257130001;
        Sun, 01 Nov 2020 10:58:50 -0800 (PST)
Received: from [192.168.1.134] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id l20sm1744843pjt.2.2020.11.01.10.58.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 01 Nov 2020 10:58:49 -0800 (PST)
Subject: Re: [PATCH] s390: add support for TIF_NOTIFY_SIGNAL
To:     Heiko Carstens <hca@linux.ibm.com>
Cc:     linux-s390@vger.kernel.org
References: <251a204d-9362-82b7-e5d9-14c55feb2df2@kernel.dk>
 <20201101173153.GC9375@osiris>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <0fe8c058-657f-020d-4920-66eb628eba2f@kernel.dk>
Date:   Sun, 1 Nov 2020 11:58:47 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201101173153.GC9375@osiris>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 11/1/20 10:31 AM, Heiko Carstens wrote:
> On Thu, Oct 29, 2020 at 10:21:11AM -0600, Jens Axboe wrote:
>> Wire up TIF_NOTIFY_SIGNAL handling for s390.
>>
>> Cc: linux-s390@vger.kernel.org
>> Signed-off-by: Jens Axboe <axboe@kernel.dk>
>> ---
>>
>> 5.11 has support queued up for TIF_NOTIFY_SIGNAL, see this posting
>> for details:
>>
>> https://lore.kernel.org/io-uring/20201026203230.386348-1-axboe@kernel.dk/
>>
>> As part of that work, I'm adding TIF_NOTIFY_SIGNAL support to all archs,
>> as that will enable a set of cleanups once all of them support it. I'm
>> happy carrying this patch if need be, or it can be funelled through the
>> arch tree. Let me know.
>>
>>  arch/s390/include/asm/thread_info.h | 2 ++
>>  arch/s390/kernel/entry.S            | 7 ++++++-
>>  2 files changed, 8 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/s390/include/asm/thread_info.h b/arch/s390/include/asm/thread_info.h
>> index 13a04fcf7762..0045341ade48 100644
>> --- a/arch/s390/include/asm/thread_info.h
>> +++ b/arch/s390/include/asm/thread_info.h
>> @@ -65,6 +65,7 @@ void arch_setup_new_exec(void);
>>  #define TIF_GUARDED_STORAGE	4	/* load guarded storage control block */
>>  #define TIF_PATCH_PENDING	5	/* pending live patching update */
>>  #define TIF_PGSTE		6	/* New mm's will use 4K page tables */
>> +#define TIF_NOTIFY_SIGNAL	7	/* signal notifications exist */
>>  #define TIF_ISOLATE_BP		8	/* Run process with isolated BP */
>>  #define TIF_ISOLATE_BP_GUEST	9	/* Run KVM guests with isolated BP */
>>  
>> @@ -82,6 +83,7 @@ void arch_setup_new_exec(void);
>>  #define TIF_SYSCALL_TRACEPOINT	27	/* syscall tracepoint instrumentation */
>>  
>>  #define _TIF_NOTIFY_RESUME	BIT(TIF_NOTIFY_RESUME)
>> +#define _TIF_NOTIFY_SIGNAL	BIT(TIF_NOTIFY_SIGNAL)
>>  #define _TIF_SIGPENDING		BIT(TIF_SIGPENDING)
>>  #define _TIF_NEED_RESCHED	BIT(TIF_NEED_RESCHED)
>>  #define _TIF_UPROBE		BIT(TIF_UPROBE)
>> diff --git a/arch/s390/kernel/entry.S b/arch/s390/kernel/entry.S
>> index 86235919c2d1..a30d891e8045 100644
>> --- a/arch/s390/kernel/entry.S
>> +++ b/arch/s390/kernel/entry.S
>> @@ -52,7 +52,8 @@ STACK_SIZE  = 1 << STACK_SHIFT
>>  STACK_INIT = STACK_SIZE - STACK_FRAME_OVERHEAD - __PT_SIZE
>>  
>>  _TIF_WORK	= (_TIF_SIGPENDING | _TIF_NOTIFY_RESUME | _TIF_NEED_RESCHED | \
>> -		   _TIF_UPROBE | _TIF_GUARDED_STORAGE | _TIF_PATCH_PENDING)
>> +		   _TIF_UPROBE | _TIF_GUARDED_STORAGE | _TIF_PATCH_PENDING | \
>> +		   _TIF_NOTIFY_SIGNAL)
>>  _TIF_TRACE	= (_TIF_SYSCALL_TRACE | _TIF_SYSCALL_AUDIT | _TIF_SECCOMP | \
>>  		   _TIF_SYSCALL_TRACEPOINT)
>>  _CIF_WORK	= (_CIF_ASCE_PRIMARY | _CIF_ASCE_SECONDARY | _CIF_FPU)
>> @@ -463,6 +464,8 @@ ENTRY(system_call)
>>  #endif
>>  	TSTMSK	__PT_FLAGS(%r11),_PIF_SYSCALL_RESTART
>>  	jo	.Lsysc_syscall_restart
>> +	TSTMSK	__TI_flags(%r12),_TIF_NOTIFY_SIGNAL
>> +	jo	.Lsysc_sigpending
>>  	TSTMSK	__TI_flags(%r12),_TIF_SIGPENDING
>>  	jo	.Lsysc_sigpending
>>  	TSTMSK	__TI_flags(%r12),_TIF_NOTIFY_RESUME
>> @@ -857,6 +860,8 @@ ENTRY(io_int_handler)
>>  #endif
>>  	TSTMSK	__TI_flags(%r12),_TIF_SIGPENDING
>>  	jo	.Lio_sigpending
>> +	TSTMSK	__TI_flags(%r12),_TIF_NOTIFY_SIGNAL
>> +	jo	.Lio_sigpending
>>  	TSTMSK	__TI_flags(%r12),_TIF_NOTIFY_RESUME
>>  	jo	.Lio_notify_resume
>>  	TSTMSK	__TI_flags(%r12),_TIF_GUARDED_STORAGE
> 
> (full quote so you can make sense of the patch below).
> 
> Please merge the patch below into this one. With that:

Thanks Heiko, I merged that in, does look better. And I've added your
acked-by.

-- 
Jens Axboe

