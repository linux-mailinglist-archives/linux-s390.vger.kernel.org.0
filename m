Return-Path: <linux-s390+bounces-20392-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 90TOJsX4Hmp0bAAAu9opvQ
	(envelope-from <linux-s390+bounces-20392-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Tue, 02 Jun 2026 17:37:41 +0200
X-Original-To: lists+linux-s390@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CCBB62FD91
	for <lists+linux-s390@lfdr.de>; Tue, 02 Jun 2026 17:37:41 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b="cHpOT/OE";
	spf=pass (mail.lfdr.de: domain of "linux-s390+bounces-20392-lists+linux-s390=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-s390+bounces-20392-lists+linux-s390=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DF6D830EE665
	for <lists+linux-s390@lfdr.de>; Tue,  2 Jun 2026 15:26:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAE161ACEDE;
	Tue,  2 Jun 2026 15:25:51 +0000 (UTC)
X-Original-To: linux-s390@vger.kernel.org
Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAA4E3F39ED
	for <linux-s390@vger.kernel.org>; Tue,  2 Jun 2026 15:25:50 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780413951; cv=none; b=G4foGptsYytqAeOzyu9UZi0+OKG4WkOf8nXtTdmaiHBTLfDidmBGA51b4AHhPpUu46dOxWcWssLZXi2QRnwEu8aZDEnunnuGnWR0DLqoLUk5x2AgL0sSgW7HDSWQwggO4wBy+LRLB1CjytfoNY+3hchwQsUJkBl0nbFvIG5M3As=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780413951; c=relaxed/simple;
	bh=Z4WrN2+59MV/rg4sfdg9lA449vNSt4qPYiJQIWHMBoA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=l1HGwiResu/zoZf7ggvocKrc3Mm1UxJCP03wMedoQ+d3VZTy47jUfLWRcdaRIEsHNBFNO7HLgr1uMFMv4NntzC2YRithsHa/IiJgNM72nKmzvux9PWdDzD1DRBNz7vdoK4hqOcv16fmSwG7hFgMtGwFz/juE25GCCtpwHqSqZpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cHpOT/OE; arc=none smtp.client-ip=74.125.82.201
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-304ec73b015so6545533eec.1
        for <linux-s390@vger.kernel.org>; Tue, 02 Jun 2026 08:25:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780413950; x=1781018750; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=VKmVi04Xi/VezwoSJHiJtxgWwe8v8etyrpuu8J1PVow=;
        b=cHpOT/OEgbZR75uBRgqUZxEpYX7h5px/RexbA6cj6fQ9J2qubmxEGRWtHjMe2GFyNF
         +YxS0NRgLmtcJKxhqGuPVN0JFKlk82Q2gpf9OXRL5lIs9D9ubVIAf7MDyQoYyrOlyyt2
         Enugjl3oW/PskPxxjhy+kLLc4oEpWtfe7YEFKm6dXW8MtogdFspNbhERyCHgGVmeoTi2
         1EeSwMmoU/GiEXZghI00ZxmvUrTvjYC9ZlzAMGdalI5DP76ZFu/tkoUJSBbeE4ChCuTa
         75eemB2VkTnHP/wynGz4Ja1fl8RdcCEYr/QXze7hF3Ocxv5qjY0LEEBTehvcVy1AdztJ
         zMWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780413950; x=1781018750;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VKmVi04Xi/VezwoSJHiJtxgWwe8v8etyrpuu8J1PVow=;
        b=TG9OnE3v4TLUh6VBewerpODfMURciJGowF/5U5h3o+lpU6ZshkvBSC6YyoKYWPbuJG
         ipLfG4PeCMdQumUUcD85eeX5Owq3zCuV5DUTRVCsI+B7JcT1VxPXDR3uxWo1tBFW5jUe
         8DHwPItaPye4cOKfXqU7tsS1E2vDJtmAKM1ShKpPIMyTff6YGc2MqECHKqwVpgybFE9M
         eVGDkhv5rzREymQSWnsheLQZQcCfeA2T8yE6hKMZFpwHEbncLBkaIT++xB/wfUTIm3Ab
         f0TcKWlG7HVT9RBQnb2+WTiOJwhx+DBMWwanq/B3jsixaTvZJMg27sb4oviChfhs7sln
         T68g==
X-Forwarded-Encrypted: i=1; AFNElJ813vRX7ei5pksSgCrOvZu2LO2uPRpMG6M1xzQ7GAHNXhd6purQSro6EYSMb+AXCi163qAecJBbAKZf@vger.kernel.org
X-Gm-Message-State: AOJu0YxaSLChpTEG7beQDkSsxUpFrqdd1KolygB44fr76Ue0qDMlMps/
	+WFSQm86+qJirLHzclNSHs3de29LhmLF4Xk4escO3aa1e0JFg2L5vdDYAzAqXHfBxTuUoryFIDu
	Qc42jMBa0Iw==
X-Received: from dyaf4-n2.prod.google.com ([2002:a05:693c:8384:20b0:2f1:5dbf:fd4e])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:4306:b0:2ef:9961:27fa
 with SMTP id 5a478bee46e88-304fa5ee3bcmr8041922eec.18.1780413949696; Tue, 02
 Jun 2026 08:25:49 -0700 (PDT)
Date: Tue,  2 Jun 2026 08:25:04 -0700
In-Reply-To: <20260602152516.2831152-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260602062452.2583619-1-irogers@google.com> <20260602152516.2831152-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.929.g9b7fa37559-goog
Message-ID: <20260602152516.2831152-8-irogers@google.com>
Subject: [PATCH v12 07/19] perf machine: Use perf_env e_machine rather than arch
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: agordeev@linux.ibm.com, gor@linux.ibm.com, hca@linux.ibm.com, 
	jameshongleiwang@126.com, japo@linux.ibm.com, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-s390@vger.kernel.org, 
	sumanthk@linux.ibm.com, tmricht@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:irogers@google.com,m:acme@kernel.org,m:namhyung@kernel.org,m:agordeev@linux.ibm.com,m:gor@linux.ibm.com,m:hca@linux.ibm.com,m:jameshongleiwang@126.com,m:japo@linux.ibm.com,m:linux-kernel@vger.kernel.org,m:linux-perf-users@vger.kernel.org,m:linux-s390@vger.kernel.org,m:sumanthk@linux.ibm.com,m:tmricht@linux.ibm.com,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-20392-lists,linux-s390=lfdr.de];
	FREEMAIL_CC(0.00)[linux.ibm.com,126.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[irogers@google.com,linux-s390@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[irogers@google.com,linux-s390@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-s390];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0CCBB62FD91

The arch string is derived from uname and may be normalized causing
potential differences meaning the ELF machine can be more
precise. Reduce the scope of machine__is as often it is better to use
a thread for the e_machine rather than the machine. Switch from string
to ELF machine constant comparisons.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/machine.c | 35 ++++++++++++++++++-----------------
 tools/perf/util/machine.h |  2 --
 2 files changed, 18 insertions(+), 19 deletions(-)

diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index e5d1e8b882a9..47be7a44a5f7 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -9,6 +9,7 @@
 #include "debug.h"
 #include "dso.h"
 #include "env.h"
+#include "dwarf-regs.h"
 #include "event.h"
 #include "evsel.h"
 #include "hist.h"
@@ -1627,10 +1628,24 @@ static bool machine__uses_kcore(struct machine *machine)
 	return dsos__for_each_dso(&machine->dsos, machine__uses_kcore_cb, NULL) != 0 ? true : false;
 }
 
+static bool machine__is(struct machine *machine, uint16_t e_machine)
+{
+	if (!machine)
+		return false;
+
+	if (!machine->env) {
+		if (machine__is_host(machine))
+			return e_machine == EM_HOST;
+		return false;
+	}
+
+	return perf_env__e_machine(machine->env, NULL) == e_machine;
+}
+
 static bool perf_event__is_extra_kernel_mmap(struct machine *machine,
 					     struct extra_kernel_map *xm)
 {
-	return machine__is(machine, "x86_64") &&
+	return machine__is(machine, EM_X86_64) &&
 	       is_entry_trampoline(xm->name);
 }
 
@@ -2786,7 +2801,7 @@ static int find_prev_cpumode(struct ip_callchain *chain, struct thread *thread,
 static u64 get_leaf_frame_caller(struct perf_sample *sample,
 		struct thread *thread, int usr_idx)
 {
-	if (machine__normalized_is(maps__machine(thread__maps(thread)), "arm64"))
+	if (thread__e_machine(thread, /*machine=*/NULL, /*e_flags=*/NULL) == EM_AARCH64)
 		return get_leaf_frame_caller_aarch64(sample, thread, usr_idx);
 	else
 		return 0;
@@ -3157,20 +3172,6 @@ int machine__set_current_tid(struct machine *machine, int cpu, pid_t pid,
 	return 0;
 }
 
-/*
- * Compares the raw arch string. N.B. see instead perf_env__arch() or
- * machine__normalized_is() if a normalized arch is needed.
- */
-bool machine__is(struct machine *machine, const char *arch)
-{
-	return machine && !strcmp(perf_env__raw_arch(machine->env), arch);
-}
-
-bool machine__normalized_is(struct machine *machine, const char *arch)
-{
-	return machine && !strcmp(perf_env__arch(machine->env), arch);
-}
-
 int machine__nr_cpus_avail(struct machine *machine)
 {
 	return machine ? perf_env__nr_cpus_avail(machine->env) : 0;
@@ -3197,7 +3198,7 @@ int machine__get_kernel_start(struct machine *machine)
 		 * start of kernel text, but still above 2^63. So leave
 		 * kernel_start = 1ULL << 63 for x86_64.
 		 */
-		if (!err && !machine__is(machine, "x86_64"))
+		if (!err && !machine__is(machine, EM_X86_64))
 			machine->kernel_start = map__start(map);
 	}
 	return err;
diff --git a/tools/perf/util/machine.h b/tools/perf/util/machine.h
index 048b24e9bd38..aaddfb70ea66 100644
--- a/tools/perf/util/machine.h
+++ b/tools/perf/util/machine.h
@@ -224,8 +224,6 @@ static inline bool machine__is_host(struct machine *machine)
 }
 
 bool machine__is_lock_function(struct machine *machine, u64 addr);
-bool machine__is(struct machine *machine, const char *arch);
-bool machine__normalized_is(struct machine *machine, const char *arch);
 int machine__nr_cpus_avail(struct machine *machine);
 
 struct thread *machine__findnew_thread(struct machine *machine, pid_t pid, pid_t tid);
-- 
2.54.0.929.g9b7fa37559-goog


