Return-Path: <linux-s390+bounces-20286-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gICNOiUuHWqcWAkAu9opvQ
	(envelope-from <linux-s390+bounces-20286-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Mon, 01 Jun 2026 09:00:53 +0200
X-Original-To: lists+linux-s390@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6471A61A8AD
	for <lists+linux-s390@lfdr.de>; Mon, 01 Jun 2026 09:00:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EE2183064A78
	for <lists+linux-s390@lfdr.de>; Mon,  1 Jun 2026 06:55:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A78E7387364;
	Mon,  1 Jun 2026 06:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GlX1ueRQ"
X-Original-To: linux-s390@vger.kernel.org
Received: from mail-dl1-f73.google.com (mail-dl1-f73.google.com [74.125.82.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DF26387563
	for <linux-s390@vger.kernel.org>; Mon,  1 Jun 2026 06:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780296882; cv=none; b=Ak+dkabPv7zV5QLDPelnsTWDg5WaysJ5WynkT+0edGFlwuDq633hWY9A05QPQUFZSd7NgU43EBYpXgo+fOWk0eE3EA8/rGiOvtCARn3FwyzB0ohtDbzWYiVvD1jdH6uMmWt6vgGUaT4kpgrbA/0K94CG4sCU5cQPj6/Ry2zmGZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780296882; c=relaxed/simple;
	bh=q8F5fXyoFYv4Qz6hTTwJfP/908BeEKRkibPni3u/nVc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=IHL8dTTmj6e7ZK722RIdc+bqC6f5B7jwudEHEMJ+uvoBzuKIOVczC1xa8jHRYpqlBV3txxshYBjIC47A73TWyOu8AsgYpaCkj7O3V3v9hy9/MvhoQXqk3ERnxYyQewefVnFLH4SpIahkdZxuk957P2S4wU67wHzIb+AdhwLWloo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GlX1ueRQ; arc=none smtp.client-ip=74.125.82.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-dl1-f73.google.com with SMTP id a92af1059eb24-137dd3a60e8so1236736c88.0
        for <linux-s390@vger.kernel.org>; Sun, 31 May 2026 23:54:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780296879; x=1780901679; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=p3BK9PCy7aBGu0lizAF2iiEjPcXEwff1QpswcRMbmnA=;
        b=GlX1ueRQ9FfPohjCKa0zwkefZ31FvEj8PWvm+FRN0Myed/tRc+wyMIZzPObgbZ5VgP
         yYnfZo91sQG4rhBJg4KJe1sO/lhZUQnycvep5t2OwM8N0yz+JpAl4116br12fKdi60+g
         3IG5Ef7VdUqbUYURmox90H09xTj04Fn7Idqp1taAiy67tyjzUz0luNEYe/wS+U41FowH
         oiWrXAVL9gDooxDK7PtNy5TOidy/5vwmG/0Jbphty9e9vxsxfwF2SOnqMI+JyFvY4zTo
         1+uU2IkZUn9zpjlYn3x3S4USFo275w35HLFLV8HfEcJVfOJ+mZbRpucmbTDcoZc6raCf
         4aJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780296879; x=1780901679;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=p3BK9PCy7aBGu0lizAF2iiEjPcXEwff1QpswcRMbmnA=;
        b=fnrVrzTaU5+L8wS6A0AizPff66bwQQauagZebznVUFkzdpyd7PTN3qahv/1gHWshbg
         G8XpdVLf3NItM6o5BD82+vULSDBvK6U4NsFD6gHdd13MkWhMtDKwODF8oA4o9KiWscoX
         h683Tkdffbi6WOa77lA36yXbcWK1O4FW/k78IS1VKlWgqxKdI88W6vbHFFf9HPOWAZiJ
         EPnTZIOkIESkI0xHRgcNl+zBkbfCiScgYiIoj3gdKuJE1+TnDk6BOntatSDZHgQ2hGFD
         HcircS3z0pCOSIM+AaCIywMd+C0hkYFol84PXIP6ksXhSO8KDTh6fcDHKB9yrnzI3gKh
         7ZQQ==
X-Forwarded-Encrypted: i=1; AFNElJ90M6YScg8LcjSbuZfLvxmChQEyMauQbFfvwaxd21cNSxMvXWrljx3bKw3kUpFN4sYgq3ObXVha6CcS@vger.kernel.org
X-Gm-Message-State: AOJu0YwWFS+B52zphjGsQDfsfVHQTomJHaUf04v3LYqnhDBuDxwFRfFV
	mhhmZ34a/z5vALcvYZhc02MWPRfQIpQf0wGqKkG2M0Ax3psuO5KGmG1FQorY0bWtpeIkqAc+RCx
	okCME4jD10Q==
X-Received: from dlbqq4.prod.google.com ([2002:a05:7022:ed04:b0:137:ea37:a378])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:6192:b0:132:956b:3a3
 with SMTP id a92af1059eb24-137d401b909mr3976817c88.10.1780296879243; Sun, 31
 May 2026 23:54:39 -0700 (PDT)
Date: Sun, 31 May 2026 23:54:02 -0700
In-Reply-To: <20260601065407.1597927-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260503002248.1040791-1-irogers@google.com> <20260601065407.1597927-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.823.g6e5bcc1fc9-goog
Message-ID: <20260601065407.1597927-14-irogers@google.com>
Subject: [PATCH v10 13/18] perf lock-contention: Use perf_env e_machine rather
 than arch
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: agordeev@linux.ibm.com, gor@linux.ibm.com, hca@linux.ibm.com, 
	jameshongleiwang@126.com, japo@linux.ibm.com, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-s390@vger.kernel.org, 
	sumanthk@linux.ibm.com, tmricht@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20286-lists,linux-s390=lfdr.de];
	FREEMAIL_CC(0.00)[linux.ibm.com,126.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[irogers@google.com,linux-s390@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-s390];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_TWELVE(0.00)[13];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 6471A61A8AD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Use the e_machine rather than arch string matching for powerpc.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/lock-contention.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/lock-contention.c b/tools/perf/util/lock-contention.c
index 92e7b7b572a2..119a7206f3cd 100644
--- a/tools/perf/util/lock-contention.c
+++ b/tools/perf/util/lock-contention.c
@@ -104,7 +104,8 @@ bool match_callstack_filter(struct machine *machine, u64 *callstack, int max_sta
 	struct map *kmap;
 	struct symbol *sym;
 	u64 ip;
-	const char *arch = perf_env__arch(machine->env);
+	uint16_t e_machine = perf_env__e_machine(machine->env, /*e_flags=*/NULL);
+	bool is_powerpc = e_machine == EM_PPC64 || e_machine == EM_PPC;
 
 	if (list_empty(&callstack_filters))
 		return true;
@@ -125,8 +126,7 @@ bool match_callstack_filter(struct machine *machine, u64 *callstack, int max_sta
 		 * incase first or second callstack index entry has 0
 		 * address for powerpc.
 		 */
-		if (!callstack || (!callstack[i] && (strcmp(arch, "powerpc") ||
-						(i != 1 && i != 2))))
+		if (!callstack || (!callstack[i] && (!is_powerpc || (i != 1 && i != 2))))
 			break;
 
 		ip = callstack[i];
-- 
2.54.0.823.g6e5bcc1fc9-goog


