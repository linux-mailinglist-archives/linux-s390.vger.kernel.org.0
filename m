Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 385406FB9DE
	for <lists+linux-s390@lfdr.de>; Mon,  8 May 2023 23:35:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233952AbjEHVfz (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Mon, 8 May 2023 17:35:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233883AbjEHVfx (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 8 May 2023 17:35:53 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42E5E9ECD;
        Mon,  8 May 2023 14:35:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=F/mEORQVn/+4FFZhPg8/YI2Izvfuw/wjd2XHaIHu63c=; b=Pa03uAZPkgmVJ1RZq0PF/mn8c1
        HPEOlUYH9qYdyoyKnkKFpNHIQxWCxbxmPqtEcXtMCyC5MDbaWkfX0UrH0hkIb9CV8qOjWm6rgdprk
        niysJMBzcsXHUnMTk9nSR3egA9I3LQ1USG94wywxRwRJvHwmPKF6ayuB3A4oFDSj12zDQZmmUKHsH
        ttMq2ONLodkV45d9K7qsEUKCFt/NdTZ9JhtPbBg7T11iaTSKaVYre+oFuJfDMVLCbg7BB3nFk8wX6
        hwrKf3Mf+048gPWaw5o1Eei5BCLQv2fvJHqreq6r/unM6mdvy4/TToL4svY6eeQDB7ymYDjRLs04F
        VZBXFB4g==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pw8UY-00EW3b-6j; Mon, 08 May 2023 21:33:58 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 9F96C30613D;
        Mon,  8 May 2023 23:33:48 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 38F4D2482941E; Mon,  8 May 2023 23:33:48 +0200 (CEST)
Message-ID: <20230508213147.650971590@infradead.org>
User-Agent: quilt/0.66
Date:   Mon, 08 May 2023 23:19:55 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     bigeasy@linutronix.de
Cc:     mark.rutland@arm.com, maz@kernel.org, catalin.marinas@arm.com,
        will@kernel.org, chenhuacai@kernel.org, kernel@xen0n.name,
        hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        borntraeger@linux.ibm.com, svens@linux.ibm.com,
        pbonzini@redhat.com, wanpengli@tencent.com, vkuznets@redhat.com,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        jgross@suse.com, boris.ostrovsky@oracle.com,
        daniel.lezcano@linaro.org, kys@microsoft.com,
        haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
        rafael@kernel.org, peterz@infradead.org, longman@redhat.com,
        boqun.feng@gmail.com, pmladek@suse.com, senozhatsky@chromium.org,
        rostedt@goodmis.org, john.ogness@linutronix.de,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com, jstultz@google.com,
        sboyd@kernel.org, linux-kernel@vger.kernel.org,
        loongarch@lists.linux.dev, linux-s390@vger.kernel.org,
        kvm@vger.kernel.org, linux-hyperv@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: [RFC][PATCH 4/9] arm64/arch_timer: Provide noinstr sched_clock_read() functions
References: <20230508211951.901961964@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

With the intent to provide local_clock_noinstr(), a variant of
local_clock() that's safe to be called from noinstr code (with the
assumption that any such code will already be non-preemptible),
prepare for things by providing a noinstr sched_clock_read() function.

Specifically, preempt_enable_*() calls out to schedule(), which upsets
noinstr validation efforts.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/arm64/include/asm/arch_timer.h  |    8 ----
 drivers/clocksource/arm_arch_timer.c |   60 ++++++++++++++++++++++++++---------
 2 files changed, 47 insertions(+), 21 deletions(-)

--- a/arch/arm64/include/asm/arch_timer.h
+++ b/arch/arm64/include/asm/arch_timer.h
@@ -88,13 +88,7 @@ static inline notrace u64 arch_timer_rea
 
 #define arch_timer_reg_read_stable(reg)					\
 	({								\
-		u64 _val;						\
-									\
-		preempt_disable_notrace();				\
-		_val = erratum_handler(read_ ## reg)();			\
-		preempt_enable_notrace();				\
-									\
-		_val;							\
+		erratum_handler(read_ ## reg)();			\
 	})
 
 /*
--- a/drivers/clocksource/arm_arch_timer.c
+++ b/drivers/clocksource/arm_arch_timer.c
@@ -191,22 +191,40 @@ u32 arch_timer_reg_read(int access, enum
 	return val;
 }
 
-static notrace u64 arch_counter_get_cntpct_stable(void)
+static noinstr u64 _arch_counter_get_cntpct_stable(void)
 {
 	return __arch_counter_get_cntpct_stable();
 }
 
-static notrace u64 arch_counter_get_cntpct(void)
+static notrace u64 arch_counter_get_cntpct_stable(void)
+{
+	u64 val;
+	preempt_disable_notrace();
+	val = __arch_counter_get_cntpct_stable();
+	preempt_enable_notrace();
+	return val;
+}
+
+static noinstr u64 arch_counter_get_cntpct(void)
 {
 	return __arch_counter_get_cntpct();
 }
 
-static notrace u64 arch_counter_get_cntvct_stable(void)
+static noinstr u64 _arch_counter_get_cntvct_stable(void)
 {
 	return __arch_counter_get_cntvct_stable();
 }
 
-static notrace u64 arch_counter_get_cntvct(void)
+static notrace u64 arch_counter_get_cntvct_stable(void)
+{
+	u64 val;
+	preempt_disable_notrace();
+	val = __arch_counter_get_cntvct_stable();
+	preempt_enable_notrace();
+	return val;
+}
+
+static noinstr u64 arch_counter_get_cntvct(void)
 {
 	return __arch_counter_get_cntvct();
 }
@@ -753,14 +771,14 @@ static int arch_timer_set_next_event_phy
 	return 0;
 }
 
-static u64 arch_counter_get_cnt_mem(struct arch_timer *t, int offset_lo)
+static noinstr u64 arch_counter_get_cnt_mem(struct arch_timer *t, int offset_lo)
 {
 	u32 cnt_lo, cnt_hi, tmp_hi;
 
 	do {
-		cnt_hi = readl_relaxed(t->base + offset_lo + 4);
-		cnt_lo = readl_relaxed(t->base + offset_lo);
-		tmp_hi = readl_relaxed(t->base + offset_lo + 4);
+		cnt_hi = __raw_readl(t->base + offset_lo + 4);
+		cnt_lo = __raw_readl(t->base + offset_lo);
+		tmp_hi = __raw_readl(t->base + offset_lo + 4);
 	} while (cnt_hi != tmp_hi);
 
 	return ((u64) cnt_hi << 32) | cnt_lo;
@@ -1060,7 +1078,7 @@ bool arch_timer_evtstrm_available(void)
 	return cpumask_test_cpu(raw_smp_processor_id(), &evtstrm_available);
 }
 
-static u64 arch_counter_get_cntvct_mem(void)
+static noinstr u64 arch_counter_get_cntvct_mem(void)
 {
 	return arch_counter_get_cnt_mem(arch_timer_mem, CNTVCT_LO);
 }
@@ -1074,6 +1092,13 @@ struct arch_timer_kvm_info *arch_timer_g
 
 static void __init arch_counter_register(unsigned type)
 {
+	/*
+	 * Default to cp15 based access because arm64 uses this function for
+	 * sched_clock() before DT is probed and the cp15 method is guaranteed
+	 * to exist on arm64. arm doesn't use this before DT is probed so even
+	 * if we don't have the cp15 accessors we won't have a problem.
+	 */
+	u64 (*scr)(void) = arch_counter_get_cntvct;
 	u64 start_count;
 	int width;
 
@@ -1083,21 +1108,28 @@ static void __init arch_counter_register
 
 		if ((IS_ENABLED(CONFIG_ARM64) && !is_hyp_mode_available()) ||
 		    arch_timer_uses_ppi == ARCH_TIMER_VIRT_PPI) {
-			if (arch_timer_counter_has_wa())
+			if (arch_timer_counter_has_wa()) {
 				rd = arch_counter_get_cntvct_stable;
-			else
+				scr = _arch_counter_get_cntvct_stable;
+			} else {
 				rd = arch_counter_get_cntvct;
+				scr = arch_counter_get_cntvct;
+			}
 		} else {
-			if (arch_timer_counter_has_wa())
+			if (arch_timer_counter_has_wa()) {
 				rd = arch_counter_get_cntpct_stable;
-			else
+				scr = _arch_counter_get_cntpct_stable;
+			} else {
 				rd = arch_counter_get_cntpct;
+				scr = arch_counter_get_cntpct;
+			}
 		}
 
 		arch_timer_read_counter = rd;
 		clocksource_counter.vdso_clock_mode = vdso_default;
 	} else {
 		arch_timer_read_counter = arch_counter_get_cntvct_mem;
+		scr = arch_counter_get_cntvct_mem;
 	}
 
 	width = arch_counter_get_width();
@@ -1113,7 +1145,7 @@ static void __init arch_counter_register
 	timecounter_init(&arch_timer_kvm_info.timecounter,
 			 &cyclecounter, start_count);
 
-	sched_clock_register(arch_timer_read_counter, width, arch_timer_rate);
+	sched_clock_register(scr, width, arch_timer_rate);
 }
 
 static void arch_timer_stop(struct clock_event_device *clk)


