Return-Path: <linux-s390+bounces-20394-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id I/LPNjD3Hmr1agAAu9opvQ
	(envelope-from <linux-s390+bounces-20394-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Tue, 02 Jun 2026 17:30:56 +0200
X-Original-To: lists+linux-s390@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F5CD62FC64
	for <lists+linux-s390@lfdr.de>; Tue, 02 Jun 2026 17:30:54 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=ekN9WwZe;
	spf=pass (mail.lfdr.de: domain of "linux-s390+bounces-20394-lists+linux-s390=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-s390+bounces-20394-lists+linux-s390=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 667A63051672
	for <lists+linux-s390@lfdr.de>; Tue,  2 Jun 2026 15:27:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3D083EDE79;
	Tue,  2 Jun 2026 15:25:57 +0000 (UTC)
X-Original-To: linux-s390@vger.kernel.org
Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A1DD3F44F5
	for <linux-s390@vger.kernel.org>; Tue,  2 Jun 2026 15:25:56 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780413957; cv=none; b=S9K9IGw0fmau2CzGj64g5jGwHPBGyFyAbrVZdNBTS2ypPxMSWbukL2Vru0al2B7zkzheXliOo+TIbkUpekIP7/qUi9AfMzfUWNCzLfaQg4JZ7t1Tm0XRndu74JxnEiqDS4HTPmIlTq/eMtI7fI4o63ldKowEehTTy3L8ivibfv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780413957; c=relaxed/simple;
	bh=F2CPix35dUffd03PpiODYF/Y/HMWspE7itJrwYnRzhA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=F5ihadIkXOxLP5NF/BniC3XuiXQDZIaK2VALvYmcUZcUGFwLzSw12Scwb03MuSeNUXXDTK2BxLgeh2+2/vRIu6V21+YnVJ9HMZ8AR+HCJvmaH2TT0cRA9+ae3r5InBjNnmFgKNrOy2RAmP0rDWEN//h1EPcI/tQnaB5/lddw0BU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ekN9WwZe; arc=none smtp.client-ip=74.125.82.201
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-304e7fc90b1so4363594eec.1
        for <linux-s390@vger.kernel.org>; Tue, 02 Jun 2026 08:25:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780413956; x=1781018756; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=amlPmLXVpdwhmAERUmH3g/HD3HbPai/uUl8j2YKLcm4=;
        b=ekN9WwZe9vgxhiSymjEgDXS81b7P/iklusnYLDLAD9J2mHHKujbhioOhrFW+n8GDFs
         QeFEx4KtGuiu1DKwYYsBTqhMgQRntUozcV23KSP5C4vFuLR6qkJlKz1aPJusj2dBUMvb
         1ces9Df/FU9+V9w5Xm6zLSt53awWFkVxMouBbDsmuNVlEWtWTcXf2IsaP59lVG/+RRBG
         LPAddkaVWwwPdYsmMRX+oBw2ekP6qrWyqGPoUD5+XxsGdBqwljqSoriO2Kz71C2W1DPd
         iIQ7Y6Qs8FqcU2D0QTsc+sU2K5XPsX/8gDOQVDR+6XVH4smoEPaUE0Hy05Qy4mYn4u4b
         /+5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780413956; x=1781018756;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=amlPmLXVpdwhmAERUmH3g/HD3HbPai/uUl8j2YKLcm4=;
        b=rnXtPRqbakOybNnz0ki5vU04drkqj5BaM5kGDn/E7ZBBKQ1FGUTJoJzDq6IXg4yFHb
         eJ2RTy3J7Y6rZ7OZ/nZmesKjM5eT1ZU5eYmJBcIKnKpf09tL5xBe+jmyD3p0PnYTPuVV
         JtYXHn+/EUPz6QMN05MLVzjTwbzF3808EcA5wpt1+66pEwI+GqO0nblNkpw/frWNpc0V
         lZpr54L72KVtqDfnLPmwjymBmqE+zRJgsDmvEmS+2Yw1O+ug+yRDuMdKcIAj5p0vAc2K
         zWGeV6MmeD1oyydiiusipsgVi4ghxz+bVvJL9FmTREykPIWD+hKzVe0oZ6FQGpSLrC/Y
         zWZQ==
X-Forwarded-Encrypted: i=1; AFNElJ/ZokNBD+c5/eR/VqKaZSa1uZsW507k+gwm8kHwqnNZqCk+vY15Vlo9aeoo85f9ymJP2/eOfbznzRQa@vger.kernel.org
X-Gm-Message-State: AOJu0YwHyN3EAOqnvXM8OCo/1wWujEX89oHcmc2CC4saY++uv4f5NavB
	HE6cEFzkMZ30r9MEz7OZxneGUSXvj/Dk8UxdqoqbPH5+zNNpFgTKLlOOzYh9PaTxhMj8aU7KWvK
	StJ5N/xE2jg==
X-Received: from dleb5-n1.prod.google.com ([2002:a05:701b:4245:10b0:136:23d8:d537])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:b81:b0:137:ed87:817e
 with SMTP id a92af1059eb24-137ed878419mr2517652c88.28.1780413955440; Tue, 02
 Jun 2026 08:25:55 -0700 (PDT)
Date: Tue,  2 Jun 2026 08:25:06 -0700
In-Reply-To: <20260602152516.2831152-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260602062452.2583619-1-irogers@google.com> <20260602152516.2831152-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.929.g9b7fa37559-goog
Message-ID: <20260602152516.2831152-10-irogers@google.com>
Subject: [PATCH v12 09/19] perf sort: Use perf_env e_machine rather than arch
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-20394-lists,linux-s390=lfdr.de];
	FREEMAIL_CC(0.00)[linux.ibm.com,126.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:irogers@google.com,m:acme@kernel.org,m:namhyung@kernel.org,m:agordeev@linux.ibm.com,m:gor@linux.ibm.com,m:hca@linux.ibm.com,m:jameshongleiwang@126.com,m:japo@linux.ibm.com,m:linux-kernel@vger.kernel.org,m:linux-perf-users@vger.kernel.org,m:linux-s390@vger.kernel.org,m:sumanthk@linux.ibm.com,m:tmricht@linux.ibm.com,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-s390];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3F5CD62FC64

Use the e_machine rather than the arch to determine x86 or PPC types.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/sort.c | 58 +++++++++++++++++++++++-------------------
 1 file changed, 32 insertions(+), 26 deletions(-)

diff --git a/tools/perf/util/sort.c b/tools/perf/util/sort.c
index 0020089cb13c..90bc4a31bb55 100644
--- a/tools/perf/util/sort.c
+++ b/tools/perf/util/sort.c
@@ -1,40 +1,45 @@
 // SPDX-License-Identifier: GPL-2.0
+#include "sort.h"
+
 #include <ctype.h>
 #include <errno.h>
 #include <inttypes.h>
-#include <regex.h>
 #include <stdlib.h>
+
+#include <elf.h>
+#include <linux/kernel.h>
 #include <linux/mman.h>
+#include <linux/string.h>
 #include <linux/time64.h>
+
+#include <regex.h>
+
+#include "annotate-data.h"
+#include "annotate.h"
+#include "branch.h"
+#include "cacheline.h"
+#include "cgroup.h"
+#include "comm.h"
 #include "debug.h"
 #include "dso.h"
-#include "sort.h"
+#include "event.h"
+#include "evlist.h"
+#include "evsel.h"
 #include "hist.h"
-#include "cacheline.h"
-#include "comm.h"
+#include "machine.h"
 #include "map.h"
-#include "maps.h"
-#include "symbol.h"
 #include "map_symbol.h"
-#include "branch.h"
-#include "thread.h"
-#include "evsel.h"
-#include "evlist.h"
-#include "srcline.h"
-#include "strlist.h"
-#include "strbuf.h"
+#include "maps.h"
 #include "mem-events.h"
 #include "mem-info.h"
-#include "annotate.h"
-#include "annotate-data.h"
-#include "event.h"
-#include "time-utils.h"
-#include "cgroup.h"
-#include "machine.h"
 #include "session.h"
+#include "srcline.h"
+#include "strbuf.h"
+#include "strlist.h"
+#include "symbol.h"
+#include "thread.h"
+#include "time-utils.h"
 #include "trace-event.h"
-#include <linux/kernel.h>
-#include <linux/string.h>
 
 #ifdef HAVE_LIBTRACEEVENT
 #include <event-parse.h>
@@ -2673,9 +2678,10 @@ struct sort_dimension {
 
 static int arch_support_sort_key(const char *sort_key, struct perf_env *env)
 {
-	const char *arch = perf_env__arch(env);
+	uint16_t e_machine = perf_env__e_machine(env, /*e_eflags=*/NULL);
 
-	if (!strcmp("x86", arch) || !strcmp("powerpc", arch)) {
+	if (e_machine == EM_X86_64 || e_machine == EM_386 || e_machine == EM_PPC64 ||
+	    e_machine == EM_PPC) {
 		if (!strcmp(sort_key, "p_stage_cyc"))
 			return 1;
 		if (!strcmp(sort_key, "local_p_stage_cyc"))
@@ -2686,14 +2692,14 @@ static int arch_support_sort_key(const char *sort_key, struct perf_env *env)
 
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
2.54.0.929.g9b7fa37559-goog


