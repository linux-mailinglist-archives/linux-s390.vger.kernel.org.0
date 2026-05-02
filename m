Return-Path: <linux-s390+bounces-19291-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ePu9FFeh9WkWNgIAu9opvQ
	(envelope-from <linux-s390+bounces-19291-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Sat, 02 May 2026 09:01:43 +0200
X-Original-To: lists+linux-s390@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 61CFB4B136A
	for <lists+linux-s390@lfdr.de>; Sat, 02 May 2026 09:01:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 077853007B09
	for <lists+linux-s390@lfdr.de>; Sat,  2 May 2026 07:00:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 978E32FFF8F;
	Sat,  2 May 2026 07:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eH/+rImX"
X-Original-To: linux-s390@vger.kernel.org
Received: from mail-dl1-f74.google.com (mail-dl1-f74.google.com [74.125.82.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 340532FF147
	for <linux-s390@vger.kernel.org>; Sat,  2 May 2026 07:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777705213; cv=none; b=m5qqsgsyBoOVri6bitzUPw8onBNN/kaJzvLuBB2q3EME4iYimF46sa7e0H7ckdECZ9hl6N2h1xn2ODhdxf5Pb4XAXkSqg+jD3Tk7UkSdO+IGxlnhM7Lmtyb5Ta8t3fGgn54IWw3DKSnohEFUUYpW9DviKlRFQamGDmks/bgAzrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777705213; c=relaxed/simple;
	bh=91rmZ7HpXZMQRzqJ+APlDS7mfx0zJTjOHRhup1RYxFs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=JgJp+GggmaHcw7lVpI7yI09C2jNBwxXn0rEmwKA8G40RB3kZqbzBHzXD/DHFX4D33hUHHEG+CEUTJdAwhRZEmm/M98nwUAXbtBFi+ojDMDmK6+OmjQEHeelUPEojyKrEj/KDATmues34SzpkRnuh7KHbztgroeKoQ3ck7cgbZ00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eH/+rImX; arc=none smtp.client-ip=74.125.82.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-dl1-f74.google.com with SMTP id a92af1059eb24-12df9e440d3so2131545c88.0
        for <linux-s390@vger.kernel.org>; Sat, 02 May 2026 00:00:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777705206; x=1778310006; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=0Hvpb4pkIwMjbfShD1pPaCPvI8UVK1DoFRvpInh9Nmk=;
        b=eH/+rImX6+CgCX40Pd3SlzZ5eno3LEIGndb1P/OBTTrdRQtYdVH2i0iaA3R1t5ftZS
         2kmGeYfQi4P3uVJ7VNlNTLI64OWiZSh2MF71yxvWEffsL45GstKTIeu5tc5IanuUzCDg
         R94UDZxsVvv8StOzfcybZwxeITkDU3n++hzfXjm+zLYGrJze1lZL0gZ8IgbeecPpCzVK
         t7jqHbwzXA1GobmYnXUk7Yv4f2HeLqwvXVLUoGwV0/zYj7l0zjJofGymVZlmgKtWnndj
         Fe1/Cw70nvF8HAFJvd9Xl2HGMxbYyMy7ZHyd0niT+b9/pvY6G3iXDQ3/Q7BXr1aHFbxh
         rIkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777705206; x=1778310006;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0Hvpb4pkIwMjbfShD1pPaCPvI8UVK1DoFRvpInh9Nmk=;
        b=EhjJkWuFhXVTekxKZl4691bCxwGGwrcACcVfXw0cdTd54xwN9y32WilauNd6DR7Kja
         hY959wbF6DHGXO6/PGGU2kEWk+glHuqZdx9vpZQwEPHrAm3mM/bef8FBK9USk9dWRIZS
         /o/9OCT2p+EtGH/e259pHAY4rE6M7nFkCACC7m6iShyBJXInSX8Dl3aPXO82Gp4xyMKB
         QMPGGdZYEdQjrZ4FCm9vExXbz4u11jPtFaUMAQyVT/pi0X1LYwjiZzV7nJhrwHZYDsXb
         FDh44yLwwA6IV4YiG5ZLCyILMBRJCJpfCa55JwmYNT+jSr1JqKn0fa2f53uVv0iUyn6H
         GIsA==
X-Forwarded-Encrypted: i=1; AFNElJ8K1d8t3Xw9yoWkQeMHn4T4CTskKAk3h8LVvfpaDHswjDh+UTVzAWYxUZFO2ybvZq0heC05VC/hroMB@vger.kernel.org
X-Gm-Message-State: AOJu0YzYpNwmJZhlL4qECQruQMBCqvWpl/ziZq8zdvms4yFO6PPMhMIC
	85vSdPoUHnrPPBr0bTOg/b7Mc2UBFW5qKuMMvZ0N+5CCjnIcZX88+2eASdyGcCnpslcwRTkQDNs
	OU+wZwcsNDQ==
X-Received: from dltt17.prod.google.com ([2002:a05:701a:c971:b0:12a:c5dd:73f9])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:e994:b0:128:cea1:7e3b
 with SMTP id a92af1059eb24-12dfd824dacmr838017c88.23.1777705206125; Sat, 02
 May 2026 00:00:06 -0700 (PDT)
Date: Fri,  1 May 2026 23:59:25 -0700
In-Reply-To: <20260502065935.291960-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260409230620.4176210-2-irogers@google.com> <20260502065935.291960-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260502065935.291960-8-irogers@google.com>
Subject: [PATCH v8 07/17] perf sort: Use perf_env e_machine rather than arch
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org, 
	tmricht@linux.ibm.com
Cc: agordeev@linux.ibm.com, gor@linux.ibm.com, hca@linux.ibm.com, 
	jameshongleiwang@126.com, japo@linux.ibm.com, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-s390@vger.kernel.org, 
	sumanthk@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 61CFB4B136A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-19291-lists,linux-s390=lfdr.de];
	FREEMAIL_CC(0.00)[linux.ibm.com,126.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[irogers@google.com,linux-s390@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-s390];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_TWELVE(0.00)[13];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]

Use the e_machine rather than the arch to determine x86 or PPC types.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/sort.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/tools/perf/util/sort.c b/tools/perf/util/sort.c
index 0020089cb13c..06a641cf49e3 100644
--- a/tools/perf/util/sort.c
+++ b/tools/perf/util/sort.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <ctype.h>
+#include <elf.h>
 #include <errno.h>
 #include <inttypes.h>
 #include <regex.h>
@@ -2673,9 +2674,10 @@ struct sort_dimension {
 
 static int arch_support_sort_key(const char *sort_key, struct perf_env *env)
 {
-	const char *arch = perf_env__arch(env);
+	uint16_t e_machine = perf_env__e_machine(env, /*e_eflags=*/NULL);
 
-	if (!strcmp("x86", arch) || !strcmp("powerpc", arch)) {
+	if (e_machine == EM_X86_64 || e_machine == EM_386 ||
+	    e_machine == EM_PPC64 || e_machine == EM_PPC) {
 		if (!strcmp(sort_key, "p_stage_cyc"))
 			return 1;
 		if (!strcmp(sort_key, "local_p_stage_cyc"))
@@ -2686,14 +2688,14 @@ static int arch_support_sort_key(const char *sort_key, struct perf_env *env)
 
 static const char *arch_perf_header_entry(const char *se_header, struct perf_env *env)
 {
-	const char *arch = perf_env__arch(env);
+	uint16_t e_machine = perf_env__e_machine(env, /*e_eflags=*/NULL);
 
-	if (!strcmp("x86", arch)) {
+	if (e_machine == EM_X86_64 || e_machine == EM_386) {
 		if (!strcmp(se_header, "Local Pipeline Stage Cycle"))
 			return "Local Retire Latency";
 		else if (!strcmp(se_header, "Pipeline Stage Cycle"))
 			return "Retire Latency";
-	} else if (!strcmp("powerpc", arch)) {
+	} else if (e_machine == EM_PPC64 || e_machine == EM_PPC) {
 		if (!strcmp(se_header, "Local INSTR Latency"))
 			return "Finish Cyc";
 		else if (!strcmp(se_header, "INSTR Latency"))
-- 
2.54.0.545.g6539524ca2-goog


