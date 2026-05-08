Return-Path: <linux-s390+bounces-19441-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8PnRJX/l/WnckQAAu9opvQ
	(envelope-from <linux-s390+bounces-19441-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Fri, 08 May 2026 15:30:39 +0200
X-Original-To: lists+linux-s390@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E2C664F7146
	for <lists+linux-s390@lfdr.de>; Fri, 08 May 2026 15:30:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 08CD830727D9
	for <lists+linux-s390@lfdr.de>; Fri,  8 May 2026 13:17:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAC4B3E3C62;
	Fri,  8 May 2026 13:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NmqMd9nq"
X-Original-To: linux-s390@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82DC73E3154;
	Fri,  8 May 2026 13:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778246235; cv=none; b=M8esSJuLJaqVGiemc1hrFurQqsxzHvOi5dMpqwLkaugxjwkLh87lWWQnfyN9R/e3yE3k4xxqhsnndrkV96e8l2nrnS+h+o6dzuqcEqTHtNcfcvwfEux9JpiNsaqParvY9iEe+TfnYvi7lqohEGQZ7AToTu/b0EM+N+a60ii5nnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778246235; c=relaxed/simple;
	bh=auNYKADD05SLlsp/9RYz5+LVvmnhMqjrsvSp8Ju4hXc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qdLuT8nVzI1ySg9IAL8x4snqHQktb/dSmRsWoIc1nRbLGYekCRJAi0VDNyNuW+LHP3xvr/l35/92yQyv1zzf93RTAZlANT8zNUqpIF371HRXknsH0474yMnPB+YdHXI+N3wPrIoh3tcaijgBmF1f5ONqkDGcuCatu86cEZXFMRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NmqMd9nq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F370C2BCB8;
	Fri,  8 May 2026 13:17:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778246235;
	bh=auNYKADD05SLlsp/9RYz5+LVvmnhMqjrsvSp8Ju4hXc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NmqMd9nq7hn4woGsz+DEgaq28CUB6LJXpklLRcwhPyjO9vgeTr1+3cmtj3FWbKsV/
	 5TkXkZ+SdTaVAeNvXcOr8pfQw8K+krvr+81SLj/aHPs1GBL86UBk6hNkLpoY9IQKVI
	 nqFmsdeDcLO7sT7j26IJRNUZLe00M2AP6Qwnt4NfZt4l0DiBRrc755lwhpMlN4YCqs
	 Vgj7bYiyp0bzNJFH7HcZnUprszddIl9TLq0FmW2TNdWYt/dAIwOxui9fbXYMdFTiBQ
	 CJza4ccWbDGNwRDTCbBGx5b4BrcZ2ee5GPDcut1s1ZlRnZbRF3z6sEfXsXIe26hbaM
	 LKiMXzlugQm9w==
From: Frederic Weisbecker <frederic@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Ben Segall <bsegall@google.com>, Boqun Feng <boqun.feng@gmail.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Heiko Carstens <hca@linux.ibm.com>, Ingo Molnar <mingo@kernel.org>,
	Ingo Molnar <mingo@redhat.com>, Jan Kiszka <jan.kiszka@siemens.com>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Kieran Bingham <kbingham@kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Mel Gorman <mgorman@suse.de>, Michael Ellerman <mpe@ellerman.id.au>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>, Sashiko@web.codeaurora.org,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Sven Schnelle <svens@linux.ibm.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Uladzislau Rezki <urezki@gmail.com>,
	Valentin Schneider <vschneid@redhat.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Xin Zhao <jackzxcui1989@163.com>, linux-pm@vger.kernel.org,
	linux-s390@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 01/15] tick/sched: Fix TOCTOU in nohz idle time fetch
Date: Fri,  8 May 2026 15:16:33 +0200
Message-ID: <20260508131647.43868-2-frederic@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260508131647.43868-1-frederic@kernel.org>
References: <20260508131647.43868-1-frederic@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: E2C664F7146
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [3.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[signature check failed: fail, {[1] = sig:subspace.kernel.org:reject}];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-19441-lists,linux-s390=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,linux.ibm.com,linutronix.de,google.com,gmail.com,arm.com,redhat.com,siemens.com,nvidia.com,suse.de,ellerman.id.au,infradead.org,web.codeaurora.org,goodmis.org,linaro.org,163.com,vger.kernel.org,lists.ozlabs.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[38];
	MIME_TRACE(0.00)[0:+];
	NEURAL_SPAM(0.00)[0.920];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[linux-s390];
	FROM_NEQ_ENVFROM(0.00)[frederic@kernel.org,linux-s390@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	R_DKIM_REJECT(0.00)[kernel.org:s=k20201202];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DKIM_TRACE(0.00)[kernel.org:-];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Action: no action

When the nohz idle time is fetched, the current clock timestamp is taken
outside the seqcount, which can result in such a race as reported by
Sashiko:

    get_cpu_sleep_time_us()                 tick_nohz_start_idle()
    -----------------------                 ---------------------
    now = ktime_get()
                                            write_seqcount_begin(idle_sleeptime_seq);
                                            idle_entrytime = ktime_get()
                                            tick_sched_flag_set(ts, TS_FLAG_IDLE_ACTIVE);
                                            write_seqcount_end(&ts->idle_sleeptime_seq);
    read_seqcount_begin(idle_sleeptime_seq)
    delta = now - idle_entrytime);
    //!! But now < idle_entrytime
    idle = *sleeptime +  delta;
    read_seqcount_retry(&ts->idle_sleeptime_seq, seq)

Here the read side fetches the timestamp before the write side and its
update. As a result the time delta computed on the read side is negative
(ktime_t is signed) and breaks the cputime monotonicity guarantee.

This could possibly be fixed with reading the current clock timestamp
inside the seqcount but the reader overhead might then increase. Also
simply checking that the current timestamp is above the idle entry time
is enough to prevent any issue of the like.

Reported-by: Sashiko
Fixes: 620a30fa0bd1 ("timers/nohz: Protect idle/iowait sleep time under seqcount")
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 kernel/time/tick-sched.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index cbbb87a0c6e7..171393367b5c 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -797,15 +797,16 @@ static u64 get_cpu_sleep_time_us(struct tick_sched *ts, ktime_t *sleeptime,
 		*last_update_time = ktime_to_us(now);
 
 	do {
+		ktime_t delta = 0;
+
 		seq = read_seqcount_begin(&ts->idle_sleeptime_seq);
 
 		if (tick_sched_flag_test(ts, TS_FLAG_IDLE_ACTIVE) && compute_delta) {
-			ktime_t delta = ktime_sub(now, ts->idle_entrytime);
-
-			idle = ktime_add(*sleeptime, delta);
-		} else {
-			idle = *sleeptime;
+			if (now > ts->idle_entrytime)
+				delta = ktime_sub(now, ts->idle_entrytime);
 		}
+
+		idle = ktime_add(*sleeptime, delta);
 	} while (read_seqcount_retry(&ts->idle_sleeptime_seq, seq));
 
 	return ktime_to_us(idle);
-- 
2.53.0


