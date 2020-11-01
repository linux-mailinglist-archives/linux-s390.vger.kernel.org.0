Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A0792A2057
	for <lists+linux-s390@lfdr.de>; Sun,  1 Nov 2020 18:32:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727043AbgKARcB (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Sun, 1 Nov 2020 12:32:01 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:11276 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727033AbgKARcA (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Sun, 1 Nov 2020 12:32:00 -0500
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0A1H2Fh1110533;
        Sun, 1 Nov 2020 12:31:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=X287ZemI8drd5iRdGgnxRWXXXkjEo33OfHlUXzVDIxM=;
 b=N5mCZdetjryH5bAAfuvvc0/yrMUrh61nICAapLf1vZ1UQFhFiOS9JXc+wsjtHJemA8Qv
 8Jv+ZMOxnyeKZQBsWXJA1DcGd2Ux2v+7Z3sM8ZBmgaLQYwhMvwkzQkv5b0p2jHwTSXFm
 Ap/yYb6Bt0oZziPS4cOMmJsklsHYyYe+uKU8cM5KPCvgcNDx+OeFgXjmembwrbNMGz4n
 ky1ZCe2zGehQplku/5pSmexCmSU4GkjA4WUouXrTcq3ex9hoX9lWLb/856pJ7xcuRW/o
 B4jEOmms6eDNDS9t5umHQT6/nePR/newmLYlFVHjzN+igPjAJ/u+dBgZCiYhv/jdWNNY Lw== 
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0a-001b2d01.pphosted.com with ESMTP id 34hmyqnnsf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 01 Nov 2020 12:31:58 -0500
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0A1HSbbj031175;
        Sun, 1 Nov 2020 17:31:57 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma04fra.de.ibm.com with ESMTP id 34h0f6rn7g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 01 Nov 2020 17:31:57 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0A1HVtB935979692
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 1 Nov 2020 17:31:55 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F05585204E;
        Sun,  1 Nov 2020 17:31:54 +0000 (GMT)
Received: from osiris (unknown [9.171.90.71])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTPS id C660052051;
        Sun,  1 Nov 2020 17:31:54 +0000 (GMT)
Date:   Sun, 1 Nov 2020 18:31:53 +0100
From:   Heiko Carstens <hca@linux.ibm.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-s390@vger.kernel.org
Subject: Re: [PATCH] s390: add support for TIF_NOTIFY_SIGNAL
Message-ID: <20201101173153.GC9375@osiris>
References: <251a204d-9362-82b7-e5d9-14c55feb2df2@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <251a204d-9362-82b7-e5d9-14c55feb2df2@kernel.dk>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-01_05:2020-10-30,2020-11-01 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 clxscore=1011
 mlxlogscore=897 impostorscore=0 suspectscore=0 priorityscore=1501
 lowpriorityscore=0 adultscore=0 phishscore=0 spamscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011010135
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Thu, Oct 29, 2020 at 10:21:11AM -0600, Jens Axboe wrote:
> Wire up TIF_NOTIFY_SIGNAL handling for s390.
> 
> Cc: linux-s390@vger.kernel.org
> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> ---
> 
> 5.11 has support queued up for TIF_NOTIFY_SIGNAL, see this posting
> for details:
> 
> https://lore.kernel.org/io-uring/20201026203230.386348-1-axboe@kernel.dk/
> 
> As part of that work, I'm adding TIF_NOTIFY_SIGNAL support to all archs,
> as that will enable a set of cleanups once all of them support it. I'm
> happy carrying this patch if need be, or it can be funelled through the
> arch tree. Let me know.
> 
>  arch/s390/include/asm/thread_info.h | 2 ++
>  arch/s390/kernel/entry.S            | 7 ++++++-
>  2 files changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/s390/include/asm/thread_info.h b/arch/s390/include/asm/thread_info.h
> index 13a04fcf7762..0045341ade48 100644
> --- a/arch/s390/include/asm/thread_info.h
> +++ b/arch/s390/include/asm/thread_info.h
> @@ -65,6 +65,7 @@ void arch_setup_new_exec(void);
>  #define TIF_GUARDED_STORAGE	4	/* load guarded storage control block */
>  #define TIF_PATCH_PENDING	5	/* pending live patching update */
>  #define TIF_PGSTE		6	/* New mm's will use 4K page tables */
> +#define TIF_NOTIFY_SIGNAL	7	/* signal notifications exist */
>  #define TIF_ISOLATE_BP		8	/* Run process with isolated BP */
>  #define TIF_ISOLATE_BP_GUEST	9	/* Run KVM guests with isolated BP */
>  
> @@ -82,6 +83,7 @@ void arch_setup_new_exec(void);
>  #define TIF_SYSCALL_TRACEPOINT	27	/* syscall tracepoint instrumentation */
>  
>  #define _TIF_NOTIFY_RESUME	BIT(TIF_NOTIFY_RESUME)
> +#define _TIF_NOTIFY_SIGNAL	BIT(TIF_NOTIFY_SIGNAL)
>  #define _TIF_SIGPENDING		BIT(TIF_SIGPENDING)
>  #define _TIF_NEED_RESCHED	BIT(TIF_NEED_RESCHED)
>  #define _TIF_UPROBE		BIT(TIF_UPROBE)
> diff --git a/arch/s390/kernel/entry.S b/arch/s390/kernel/entry.S
> index 86235919c2d1..a30d891e8045 100644
> --- a/arch/s390/kernel/entry.S
> +++ b/arch/s390/kernel/entry.S
> @@ -52,7 +52,8 @@ STACK_SIZE  = 1 << STACK_SHIFT
>  STACK_INIT = STACK_SIZE - STACK_FRAME_OVERHEAD - __PT_SIZE
>  
>  _TIF_WORK	= (_TIF_SIGPENDING | _TIF_NOTIFY_RESUME | _TIF_NEED_RESCHED | \
> -		   _TIF_UPROBE | _TIF_GUARDED_STORAGE | _TIF_PATCH_PENDING)
> +		   _TIF_UPROBE | _TIF_GUARDED_STORAGE | _TIF_PATCH_PENDING | \
> +		   _TIF_NOTIFY_SIGNAL)
>  _TIF_TRACE	= (_TIF_SYSCALL_TRACE | _TIF_SYSCALL_AUDIT | _TIF_SECCOMP | \
>  		   _TIF_SYSCALL_TRACEPOINT)
>  _CIF_WORK	= (_CIF_ASCE_PRIMARY | _CIF_ASCE_SECONDARY | _CIF_FPU)
> @@ -463,6 +464,8 @@ ENTRY(system_call)
>  #endif
>  	TSTMSK	__PT_FLAGS(%r11),_PIF_SYSCALL_RESTART
>  	jo	.Lsysc_syscall_restart
> +	TSTMSK	__TI_flags(%r12),_TIF_NOTIFY_SIGNAL
> +	jo	.Lsysc_sigpending
>  	TSTMSK	__TI_flags(%r12),_TIF_SIGPENDING
>  	jo	.Lsysc_sigpending
>  	TSTMSK	__TI_flags(%r12),_TIF_NOTIFY_RESUME
> @@ -857,6 +860,8 @@ ENTRY(io_int_handler)
>  #endif
>  	TSTMSK	__TI_flags(%r12),_TIF_SIGPENDING
>  	jo	.Lio_sigpending
> +	TSTMSK	__TI_flags(%r12),_TIF_NOTIFY_SIGNAL
> +	jo	.Lio_sigpending
>  	TSTMSK	__TI_flags(%r12),_TIF_NOTIFY_RESUME
>  	jo	.Lio_notify_resume
>  	TSTMSK	__TI_flags(%r12),_TIF_GUARDED_STORAGE

(full quote so you can make sense of the patch below).

Please merge the patch below into this one. With that:

Acked-by: Heiko Carstens <hca@linux.ibm.com>

diff --git a/arch/s390/kernel/entry.S b/arch/s390/kernel/entry.S
index a30d891e8045..31f16d903ef3 100644
--- a/arch/s390/kernel/entry.S
+++ b/arch/s390/kernel/entry.S
@@ -464,9 +464,7 @@ ENTRY(system_call)
 #endif
 	TSTMSK	__PT_FLAGS(%r11),_PIF_SYSCALL_RESTART
 	jo	.Lsysc_syscall_restart
-	TSTMSK	__TI_flags(%r12),_TIF_NOTIFY_SIGNAL
-	jo	.Lsysc_sigpending
-	TSTMSK	__TI_flags(%r12),_TIF_SIGPENDING
+	TSTMSK	__TI_flags(%r12),(_TIF_SIGPENDING|_TIF_NOTIFY_SIGNAL)
 	jo	.Lsysc_sigpending
 	TSTMSK	__TI_flags(%r12),_TIF_NOTIFY_RESUME
 	jo	.Lsysc_notify_resume
@@ -858,9 +856,7 @@ ENTRY(io_int_handler)
 	TSTMSK	__TI_flags(%r12),_TIF_PATCH_PENDING
 	jo	.Lio_patch_pending
 #endif
-	TSTMSK	__TI_flags(%r12),_TIF_SIGPENDING
-	jo	.Lio_sigpending
-	TSTMSK	__TI_flags(%r12),_TIF_NOTIFY_SIGNAL
+	TSTMSK	__TI_flags(%r12),(_TIF_SIGPENDING|_TIF_NOTIFY_SIGNAL)
 	jo	.Lio_sigpending
 	TSTMSK	__TI_flags(%r12),_TIF_NOTIFY_RESUME
 	jo	.Lio_notify_resume
