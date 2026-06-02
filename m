Return-Path: <linux-s390+bounces-20395-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ROVUNdz6HmoebgAAu9opvQ
	(envelope-from <linux-s390+bounces-20395-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Tue, 02 Jun 2026 17:46:36 +0200
X-Original-To: lists+linux-s390@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D60EA62FEEC
	for <lists+linux-s390@lfdr.de>; Tue, 02 Jun 2026 17:46:35 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=QMP+zJGt;
	spf=pass (mail.lfdr.de: domain of "linux-s390+bounces-20395-lists+linux-s390=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="linux-s390+bounces-20395-lists+linux-s390=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D924E30FAF75
	for <lists+linux-s390@lfdr.de>; Tue,  2 Jun 2026 15:27:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE6853F0A81;
	Tue,  2 Jun 2026 15:26:00 +0000 (UTC)
X-Original-To: linux-s390@vger.kernel.org
Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5456C3F4DD6
	for <linux-s390@vger.kernel.org>; Tue,  2 Jun 2026 15:25:59 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780413960; cv=none; b=NPsoJirGtUawhF7eEHHJ9goz9yLtA+aDXKYtyOM+HBZG6hXa1dHUxx+fdxNuK0RmzGjBVhowaVpePb5x4H34BGpgGBrVlcMq/qvv3lgQxBBenPvdVsLcjgKzhoZJtH4gfJmFarnVbqrHzkhtgQuLiGww5zqO7gbi7ijRsSzEARw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780413960; c=relaxed/simple;
	bh=1TN4Off0WzSGb6E8PmC/hd8tjykbHBLDgI/eo85jqRM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=cmTqux3o5KSezaAlVRR6qliJnnzNT/5KUViCNFBYxVRFv7QTNE+iewlRGv+TcbEdSFhZG5uLAXkk/oYrA2GDWs0r1+FgdmHAMmDYmLLWqFMKoBXgpm35M2Xp0d2U2B28LmCb19imNPJeKz4J/IVMpB5GqJB5bvOdsXRvr7SzSyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QMP+zJGt; arc=none smtp.client-ip=74.125.82.201
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-304e4636205so12768925eec.1
        for <linux-s390@vger.kernel.org>; Tue, 02 Jun 2026 08:25:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780413959; x=1781018759; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=gjedQh85bqRmyx/dzkbLSjIKr+my71zFRmku8NoRk3U=;
        b=QMP+zJGtnvFT73U1jqLeFMADiKW2z8QOJ/wfVraG3sJzwmVtxRM+HYka9bjkHs4taX
         9maICGexzYAUB3159+uzcFq9ytVTu7C1AJKjLOopitZ9pSXNDpLzogB7TSyYVz/bPL/V
         iky8GfvZAgMLH7wuO09Qp4LXQT83UgKWGUw8RwhFwaRDoTIdoLB9b1VVZxIs6jc5V308
         0LiA3kXf+Jl2rS39HgsMtSKp38AIi/fawnsKlN8ATSrYiswJwJy1AoInbW8QltS8hZTM
         j54M9+Xyxil7ytsahzzBkCzMpXB3CdoEgM/WlU6/eHDL11hKkjGvfSUxmJTIVNMDz9tu
         0tQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780413959; x=1781018759;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gjedQh85bqRmyx/dzkbLSjIKr+my71zFRmku8NoRk3U=;
        b=Kf3SL0UBvXlZie1lSL7P2qoIr0VZ+J741mUuBr+dcsPB2S+gbjwrZDhziGmmwWKhJM
         w8Z934IjqRBdeMj5xLp+/e12Jlhk8Xn1VVXKK3nLoqib78f5TqK5KPPa9KFdBuSAj6TH
         vLmoEN7OdBUeeEc4ByCe5yJcLLxc0jPRTnQD0wOetmYixI3LwRnAcl45QveMUl+hjeWC
         /UHBsciTP4YOrtSM2B/fZ3W3zbp6FenvN7U+E/H/cLoS8wYQSQRn6x9bHHsHzDLQaDhQ
         E2IyKqppjEw7tX+jxuXyBJ+YV3GYX2My5QOyKJfzTM4wcwAS2jFUqZXjOYMOvLOQwdyi
         reIA==
X-Forwarded-Encrypted: i=1; AFNElJ8b6nRFSuONxEwj8jr+mtBesAcTH8QythFqkPJljq2mfC5hEfvoKvWGtwehy0ZNRtp74cdE75FcECcH@vger.kernel.org
X-Gm-Message-State: AOJu0YwviENMI48ZdUOI0QzB2LilfsEV8645t5yi2nucZjIUCbun7rNo
	w/URKl+RTVkyWcjeVXZwxdV1EgoiD1hK5w/SQ5AANQOrCJuLxmaaTGRRYhfDh28MBBeqGujR5fl
	WUPkqt7NFJw==
X-Received: from dybsy7.prod.google.com ([2002:a05:7301:7007:b0:303:98b0:efec])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:7243:b0:304:eaa8:11ea
 with SMTP id 5a478bee46e88-304fa781775mr9133294eec.34.1780413958358; Tue, 02
 Jun 2026 08:25:58 -0700 (PDT)
Date: Tue,  2 Jun 2026 08:25:07 -0700
In-Reply-To: <20260602152516.2831152-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260602062452.2583619-1-irogers@google.com> <20260602152516.2831152-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.929.g9b7fa37559-goog
Message-ID: <20260602152516.2831152-11-irogers@google.com>
Subject: [PATCH v12 10/19] perf arch common: Use perf_env e_machine rather
 than arch
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-20395-lists,linux-s390=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-s390];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D60EA62FEEC

Use the e_machine rather than arch string matching.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/arch/common.c | 92 ++++++++++++++++++++++++++++++----------
 1 file changed, 69 insertions(+), 23 deletions(-)

diff --git a/tools/perf/arch/common.c b/tools/perf/arch/common.c
index ad0cab830a4d..5ad50e331c55 100644
--- a/tools/perf/arch/common.c
+++ b/tools/perf/arch/common.c
@@ -1,13 +1,18 @@
 // SPDX-License-Identifier: GPL-2.0
+#include "common.h"
+
 #include <limits.h>
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
+
+#include <linux/zalloc.h>
 #include <unistd.h>
-#include "common.h"
-#include "../util/env.h"
+
+#include <dwarf-regs.h>
+
 #include "../util/debug.h"
-#include <linux/zalloc.h>
+#include "../util/env.h"
 
 static const char *const arc_triplets[] = {
 	"arc-linux-",
@@ -141,11 +146,40 @@ static int lookup_triplets(const char *const *triplets, const char *name)
 	return -1;
 }
 
+static bool is_native_compatible(struct perf_env *env, uint16_t target, uint16_t host)
+{
+	if (target != host) {
+		/* A 64-bit host can natively disassemble its 32-bit compat architecture */
+		if (host == EM_X86_64 && target == EM_386)
+			return true;
+		if (host == EM_AARCH64 && target == EM_ARM)
+			return true;
+		if (host == EM_PPC64 && target == EM_PPC)
+			return true;
+		if (host == EM_SPARCV9 && target == EM_SPARC)
+			return true;
+		return false;
+	}
+
+	/* target == host case */
+	if (target == EM_RISCV) {
+		bool target_is_64 = perf_env__kernel_is_64_bit(env);
+		bool host_is_64 = (sizeof(void *) == 8);
+
+		/* 32-bit host cannot natively disassemble 64-bit target */
+		if (!host_is_64 && target_is_64)
+			return false;
+	}
+
+	return true;
+}
+
 static int perf_env__lookup_binutils_path(struct perf_env *env,
 					  const char *name, char **path)
 {
 	int idx;
-	const char *arch = perf_env__arch(env), *cross_env;
+	uint16_t e_machine = perf_env__e_machine(env, /*e_flags=*/NULL);
+	const char *cross_env;
 	const char *const *path_list;
 	char *buf = NULL;
 
@@ -153,7 +187,7 @@ static int perf_env__lookup_binutils_path(struct perf_env *env,
 	 * We don't need to try to find objdump path for native system.
 	 * Just use default binutils path (e.g.: "objdump").
 	 */
-	if (!strcmp(perf_env__arch(NULL), arch))
+	if (is_native_compatible(env, e_machine, EM_HOST))
 		goto out;
 
 	cross_env = getenv("CROSS_COMPILE");
@@ -170,30 +204,42 @@ static int perf_env__lookup_binutils_path(struct perf_env *env,
 		zfree(&buf);
 	}
 
-	if (!strcmp(arch, "arc"))
+	switch (e_machine) {
+	case EM_ARC:
 		path_list = arc_triplets;
-	else if (!strcmp(arch, "arm"))
+		break;
+	case EM_ARM:
 		path_list = arm_triplets;
-	else if (!strcmp(arch, "arm64"))
+		break;
+	case EM_AARCH64:
 		path_list = arm64_triplets;
-	else if (!strcmp(arch, "powerpc"))
+		break;
+	case EM_PPC:
+	case EM_PPC64:
 		path_list = powerpc_triplets;
-	else if (!strcmp(arch, "riscv32"))
-		path_list = riscv32_triplets;
-	else if (!strcmp(arch, "riscv64"))
-		path_list = riscv64_triplets;
-	else if (!strcmp(arch, "sh"))
+		break;
+	case EM_RISCV:
+		path_list = perf_env__kernel_is_64_bit(env) ? riscv64_triplets : riscv32_triplets;
+		break;
+	case EM_SH:
 		path_list = sh_triplets;
-	else if (!strcmp(arch, "s390"))
+		break;
+	case EM_S390:
 		path_list = s390_triplets;
-	else if (!strcmp(arch, "sparc"))
+		break;
+	case EM_SPARC:
+	case EM_SPARCV9:
 		path_list = sparc_triplets;
-	else if (!strcmp(arch, "x86"))
+		break;
+	case EM_X86_64:
+	case EM_386:
 		path_list = x86_triplets;
-	else if (!strcmp(arch, "mips"))
+		break;
+	case EM_MIPS:
 		path_list = mips_triplets;
-	else {
-		ui__error("binutils for %s not supported.\n", arch);
+		break;
+	default:
+		ui__error("binutils for %s not supported.\n", perf_env__arch(env));
 		goto out_error;
 	}
 
@@ -202,7 +248,7 @@ static int perf_env__lookup_binutils_path(struct perf_env *env,
 		ui__error("Please install %s for %s.\n"
 			  "You can add it to PATH, set CROSS_COMPILE or "
 			  "override the default using --%s.\n",
-			  name, arch, name);
+			  name, perf_env__arch(env), name);
 		goto out_error;
 	}
 
@@ -237,7 +283,7 @@ int perf_env__lookup_objdump(struct perf_env *env, char **path)
  */
 bool perf_env__single_address_space(struct perf_env *env)
 {
-	const char *arch = perf_env__arch(env);
+	uint16_t e_machine = perf_env__e_machine(env, /*e_flags=*/NULL);
 
-	return strcmp(arch, "s390") && strcmp(arch, "sparc");
+	return e_machine != EM_SPARC && e_machine != EM_SPARCV9 && e_machine != EM_S390;
 }
-- 
2.54.0.929.g9b7fa37559-goog


