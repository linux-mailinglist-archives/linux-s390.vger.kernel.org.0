Return-Path: <linux-s390+bounces-17226-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IHkrCRkxsmmzJQAAu9opvQ
	(envelope-from <linux-s390+bounces-17226-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Thu, 12 Mar 2026 04:20:57 +0100
X-Original-To: lists+linux-s390@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ED9626CC09
	for <lists+linux-s390@lfdr.de>; Thu, 12 Mar 2026 04:20:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2305831510FF
	for <lists+linux-s390@lfdr.de>; Thu, 12 Mar 2026 03:19:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6B10388E6A;
	Thu, 12 Mar 2026 03:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WlHraXiD"
X-Original-To: linux-s390@vger.kernel.org
Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6869388E4A
	for <linux-s390@vger.kernel.org>; Thu, 12 Mar 2026 03:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773285577; cv=none; b=jX5zHUw4+/RETj4qHjNrdS0SEiBIJ1a/yfYATGfomyBDwBfjabO/sR0E8vVrfmmg9ZH0ZjLiQLYMEjurD1p4J73ZsaMM4RJeutx96DAKvOb/xdB/Cj09EroQRVmmJSQuFdAdyaiFCGn4q30B9V22MnAROEXFTeiVtd0YB8k+n2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773285577; c=relaxed/simple;
	bh=eMdrmPvDMm+52SqbNbea/beENK4MxOLUj+Cxk3vRRPw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=S8IO9VejKQBPxPMCIMOKNlbzHLUn+daWMReo1W4mpC419qpL0IgMwsIH/aJShZ+BqEZGKTB4nwu51mZvfC4su+grH+ZRkC6PYYcYiperkchzs6MzTQYFWdB8GqHYf198lqBnvFgYm7Y/90jsKzvtbl1Qz+sg/+NiBNDgs1RhGl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WlHraXiD; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-2be191ce356so760875eec.1
        for <linux-s390@vger.kernel.org>; Wed, 11 Mar 2026 20:19:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773285576; x=1773890376; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=gwq8xyklWlpYEF6mLaWonmc6y+ATBgchvwlt4VuDkuE=;
        b=WlHraXiDBUPQIDQOWS2rwp39b5MYDdhcIehZYPnfanttMkzbcIjKMeOxk8GkmAbyYv
         ijG8LezsXzB3Tsiyxv+pgTEOZGqrMhyDcV5/4XnbnPMk0L6Oaz811f9IC0gBrOJu4gZl
         CGvrVSRlwNYC8i9CLJHzHSVnTTM3qJ2QoYREMoq1Nl2O4y4drygXSkYDVcjG+Csh+CAU
         AvktfURUs+47QWdQG1D1XoyUw3xCnNrjatfhACQc09gtzO28eFNnt0uy9UgXIUjZrnNd
         1ERVrd6dycqtqkGQ9XKR0Oz+jTW3GFqSYsENHwuyTNLGtB3ufeF9g2Or8S1gAanYh2Ak
         L3mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773285576; x=1773890376;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gwq8xyklWlpYEF6mLaWonmc6y+ATBgchvwlt4VuDkuE=;
        b=Mcdko6o94N3+fX+EWsoEIWna09mtWbnACC92XCmMLCT/dS2+JlI8hW3OA1kp7jX61K
         Eic4CftYx5C5sENvMs1/jotAPQKZEIe4b3xkjBSGsdY+I8lByKaTUCWB+/f8OG//Jxwe
         J6xFhQ7N9OrMbFG2b8ibllbfhLHnKiRBkuYujpVLwIyA90eeGjeXYBDUzkYF4xgAVn1M
         wOthdCJHdiDmEyrKSZzldj1LLdLoSeEaUElqEsJsz3Q4FefLHqbrybl+q1N4kdcxlmbh
         RdmvJQvOCXzYk0ruksXkQMEw00ylrHaEOx+T+RxRQo9A0z8KgWtl6yHFQoIXkF7LjT3f
         d5RA==
X-Forwarded-Encrypted: i=1; AJvYcCWN4mXcsVk1XpBXFo4+fOOw7rRsPypjQR6aI7FaLqkkREB2XZrbKc2VcTLA1UOP+ddR3BHKZHLJE5Km@vger.kernel.org
X-Gm-Message-State: AOJu0Yypgc4OJ4agHx9taLuxRf+hRqRdbUgU8WuLLuZKp1wZOIDVjF69
	qBDg7cIMNrIR064bekJ2wvSHm11182+ZMD+BC8CCzYPsEgBHIjJvORfMBWS7kDjjtTaDX4zMsh/
	9UDH5zoxx1w==
X-Received: from dyb14.prod.google.com ([2002:a05:693c:630e:b0:2be:2a85:dd95])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:72d0:b0:2b8:26b8:3446
 with SMTP id 5a478bee46e88-2be8a24ec51mr2056552eec.2.1773285575686; Wed, 11
 Mar 2026 20:19:35 -0700 (PDT)
Date: Wed, 11 Mar 2026 20:19:28 -0700
In-Reply-To: <20260312031928.1494864-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <131d7e1e-701e-4f5b-961f-c85af74f1d96@linux.ibm.com> <20260312031928.1494864-1-irogers@google.com>
X-Mailer: git-send-email 2.53.0.851.ga537e3e6e9-goog
Message-ID: <20260312031928.1494864-3-irogers@google.com>
Subject: [PATCH v1 2/2] perf evsel: Don't configure framepointer callchains on s390
From: Ian Rogers <irogers@google.com>
To: tmricht@linux.ibm.com
Cc: acme@kernel.org, agordeev@linux.ibm.com, gor@linux.ibm.com, 
	hca@linux.ibm.com, irogers@google.com, japo@linux.ibm.com, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	linux-s390@vger.kernel.org, namhyung@kernel.org, sumanthk@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-17226-lists,linux-s390=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[irogers@google.com,linux-s390@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-s390];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_TWELVE(0.00)[12];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9ED9626CC09
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Frame pointer callchains are not supported on s390. Ignore the option
and print a warning.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/evsel.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 2258fea2ef5b..a54ef52e01d2 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -1021,6 +1021,11 @@ static void __evsel__config_callchain(struct evsel *evsel, struct record_opts *o
 	bool function = evsel__is_function_event(evsel);
 	struct perf_event_attr *attr = &evsel->core.attr;
 
+	if (EM_HOST == EM_S390 && param->record_mode == CALLCHAIN_FP) {
+		pr_warning("Framepointer unwinding not supported on s390, option ignored. Try '--call-graph dwarf'\n");
+		return;
+	}
+
 	evsel__set_sample_bit(evsel, CALLCHAIN);
 
 	attr->sample_max_stack = param->max_stack;
-- 
2.53.0.851.ga537e3e6e9-goog


