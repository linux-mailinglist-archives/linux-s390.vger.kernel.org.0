Return-Path: <linux-s390+bounces-20400-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id E0ymAMH3HmqaawAAu9opvQ
	(envelope-from <linux-s390+bounces-20400-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Tue, 02 Jun 2026 17:33:21 +0200
X-Original-To: lists+linux-s390@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BFB6262FCD4
	for <lists+linux-s390@lfdr.de>; Tue, 02 Jun 2026 17:33:16 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=WLgBe3Eg;
	spf=pass (mail.lfdr.de: domain of "linux-s390+bounces-20400-lists+linux-s390=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-s390+bounces-20400-lists+linux-s390=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 22FB03071CD1
	for <lists+linux-s390@lfdr.de>; Tue,  2 Jun 2026 15:28:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B669F3F8891;
	Tue,  2 Jun 2026 15:26:16 +0000 (UTC)
X-Original-To: linux-s390@vger.kernel.org
Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50A113F7A88
	for <linux-s390@vger.kernel.org>; Tue,  2 Jun 2026 15:26:15 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780413976; cv=none; b=scTNJJngJc3JqByMPSncaX7/LWCIM32WtMSuZhdOGUNl2kWVRTQJkpIkn8Whbb7kvlbSQnBinZjsOZcg3jIN3QKu2l9Fc84MgxIG1Cqr1LJ77/HWJb/h2f6/tdA9yrZf0ziyco4NtFdyvv4zOIEKV1X1z28R862PmBOfdBKCdjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780413976; c=relaxed/simple;
	bh=wBx2XjIbGKm4f6lxUHRV7mNoOSTxIfLQoUK89yQfzt4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Xy93Y6e0+tz170XihPvwb4fUQWHtdjae3l7RXLrL/Z1nkBdiN5UM8XUGFN5/Gv/P0bIUXe+Hvlpm0eBtKBnovh8jZBFTcRZx/+GlyEdL39TuEUGy0ZNn1Uyp8vQra1wC66Qf3nD2C8B1hEMfER+xA0sz5PStJJmd0Fqs3+1RUm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WLgBe3Eg; arc=none smtp.client-ip=74.125.82.201
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-304ee7d1368so4353056eec.0
        for <linux-s390@vger.kernel.org>; Tue, 02 Jun 2026 08:26:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780413975; x=1781018775; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=harhKEg0rLSKe3QU5NRI1JfZjDmZUxT37Wq4SdyYcDA=;
        b=WLgBe3EgWJEmIlat/WvXPEEfmDVj/AEn8Xe9Xl+LMCnJ1SR6v5ggvgUGuip9wjvdlZ
         5no5yejQdCwxve+KI8s4HDO71FoxN7IjtpRVqrRcs8yyXrEhd/MGXhkqczShXae1Vs6i
         GnRbHddNJyGWLSA6ZSr2SFCFiTZJYvFSvShV8pvr+1cSWKNSFhNkBFUJ43K8ES690+8z
         YX6M3/IT4vhdj4ruExMdPLWFVSCRWDmfy5B9Di11Bj4P1V0K0H58c+F/TCFzGBBcEqqA
         TpxrYQ7ZXZ60FugwmQHxLTRRNUpXbqMcqp1UxbtWZFlbOabcorx0bhyo8l7z5uRNKUiK
         JsXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780413975; x=1781018775;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=harhKEg0rLSKe3QU5NRI1JfZjDmZUxT37Wq4SdyYcDA=;
        b=s9zrfOUATY0bTSwk3hfco2Woc+KKkv7E1yjgKYAcxomPkW7X97BwYYo7jk8NZC/a14
         Ohf6lm18iTkzh90qYXeMESgbiHa4IqmHbp9b7O+VfPdj3+p2ZV++3pldeEitjTLHCAEP
         vjfLY5EEkVgkkUWvdBwxqNL8xY5xLzU3vRo22Smq6OrYmjifEVunoRSBfvQxKpsLTTax
         VlTP8aXX+H1RUX8n/QJTxBjqSXy04Ip/6Rmw1YgbVCjUPYG46pigRz1VpVsHJbWijn1V
         h63eoMPhaubHrrdVs1G40JPqivMktfVmQBGKm6k+EEaxRRYNEGONM29FrglBXIrRmAlv
         URDQ==
X-Forwarded-Encrypted: i=1; AFNElJ9p+mbpV9yaef05hEcl4qCkOLsE1wdcCNRZd2ikBTC8BhDwGIZmYzwrJxwhDEOvSujiUC6feCBN7pPZ@vger.kernel.org
X-Gm-Message-State: AOJu0YyA/ezL3CyDfYZafpTpU2e0+dKO1Ek6XtxtOktgANkDs/7tO/DM
	jrGCx9x0rto4xaRTfab6aogC/vuzy85TjhrjwPdnbDSQXdFBi/LezoB1dI+Fdus3bqKhb/zGGhj
	3NbLMvgIlEA==
X-Received: from dybmd42.prod.google.com ([2002:a05:7301:182a:b0:300:7c0d:9eac])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7301:4918:b0:304:630d:e4ec
 with SMTP id 5a478bee46e88-304fa666a76mr7942028eec.28.1780413974271; Tue, 02
 Jun 2026 08:26:14 -0700 (PDT)
Date: Tue,  2 Jun 2026 08:25:12 -0700
In-Reply-To: <20260602152516.2831152-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260602062452.2583619-1-irogers@google.com> <20260602152516.2831152-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.929.g9b7fa37559-goog
Message-ID: <20260602152516.2831152-16-irogers@google.com>
Subject: [PATCH v12 15/19] perf env: Remove unused perf_env__raw_arch
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
	TAGGED_FROM(0.00)[bounces-20400-lists,linux-s390=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: BFB6262FCD4

The switch to using e_machine has made the perf_env__raw_arch function
unused so remove it.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/env.c | 18 ------------------
 tools/perf/util/env.h |  1 -
 2 files changed, 19 deletions(-)

diff --git a/tools/perf/util/env.c b/tools/perf/util/env.c
index b41562fb06c6..28c54c58193e 100644
--- a/tools/perf/util/env.c
+++ b/tools/perf/util/env.c
@@ -470,19 +470,6 @@ int perf_env__read_cpuid(struct perf_env *env)
 	return 0;
 }
 
-static int perf_env__read_arch(struct perf_env *env)
-{
-	struct utsname uts;
-
-	if (env->arch)
-		return 0;
-
-	if (!uname(&uts))
-		env->arch = strdup(uts.machine);
-
-	return env->arch ? 0 : -ENOMEM;
-}
-
 static int perf_env__read_nr_cpus_avail(struct perf_env *env)
 {
 	if (env->nr_cpus_avail == 0)
@@ -601,11 +588,6 @@ int perf_env__read_core_pmu_caps(struct perf_env *env)
 	return ret;
 }
 
-const char *perf_env__raw_arch(struct perf_env *env)
-{
-	return env && !perf_env__read_arch(env) ? env->arch : "unknown";
-}
-
 int perf_env__nr_cpus_avail(struct perf_env *env)
 {
 	return env && !perf_env__read_nr_cpus_avail(env) ? env->nr_cpus_avail : 0;
diff --git a/tools/perf/util/env.h b/tools/perf/util/env.h
index 5a917271ca0d..83e74328798f 100644
--- a/tools/perf/util/env.h
+++ b/tools/perf/util/env.h
@@ -190,7 +190,6 @@ uint16_t perf_env__e_machine(struct perf_env *env, uint32_t *e_flags);
 const char *perf_env__arch(struct perf_env *env);
 const char *perf_env__arch_strerrno(uint16_t e_machine, int err);
 const char *perf_env__cpuid(struct perf_env *env);
-const char *perf_env__raw_arch(struct perf_env *env);
 int perf_env__nr_cpus_avail(struct perf_env *env);
 
 void perf_env__init(struct perf_env *env);
-- 
2.54.0.929.g9b7fa37559-goog


