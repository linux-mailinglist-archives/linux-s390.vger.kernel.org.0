Return-Path: <linux-s390+bounces-17612-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OsBGKUE5u2mJhAIAu9opvQ
	(envelope-from <linux-s390+bounces-17612-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Thu, 19 Mar 2026 00:46:09 +0100
X-Original-To: lists+linux-s390@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E2BE92C3E23
	for <lists+linux-s390@lfdr.de>; Thu, 19 Mar 2026 00:46:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 34C9F308E869
	for <lists+linux-s390@lfdr.de>; Wed, 18 Mar 2026 23:46:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE5DE6BB5B;
	Wed, 18 Mar 2026 23:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FdFxsHfR"
X-Original-To: linux-s390@vger.kernel.org
Received: from mail-dl1-f73.google.com (mail-dl1-f73.google.com [74.125.82.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08C73280324
	for <linux-s390@vger.kernel.org>; Wed, 18 Mar 2026 23:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773877565; cv=none; b=CbQRGCqv73Q6sAC78THRdRXCFP5XYhssxGDVghv6820iJThWqCFgjhmNcBu/rh91wHW3WO7cqAazLjLJT/OZ1XBbXZmaP9Y7z/yIE0TrQmZAkUDokMtFwo7I303ZhPckcFBAq5iaiMMhioAV9dusVBrOg0mOhj/YagDMJVbcJlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773877565; c=relaxed/simple;
	bh=9hk/jTbTeFBs/Raf4UzdEAdOzoe90cY9oR+Ev7T6CyA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=VIeOy/DplEftlXNg8QhBoedgVLsxcxuuq/DG65dSCDkc0DWpElSqJb0FE2KABFZiEodDNx2d8Jtdp8Hhat438tkLO/rQgLpbEJNdD/Lc2AbqifGm8uLd/agQ66OnvNBeOv1v6P2naoVjZdry8Av3D5gqQFK+8SffXUOd1BYaEDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FdFxsHfR; arc=none smtp.client-ip=74.125.82.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-dl1-f73.google.com with SMTP id a92af1059eb24-1276e71652fso431001c88.0
        for <linux-s390@vger.kernel.org>; Wed, 18 Mar 2026 16:46:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773877563; x=1774482363; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=y1tJO6bvBiqRV6daDgX/JVHvb0vulQrD8Ue1sGra/Sw=;
        b=FdFxsHfRXsxW02V9i9BRl0Gv0QjIKEOCmyHcWb5yKo+xuGJs4FoOFa8APwvFIv0eEm
         yJBNZMOUtzybgc3kTeNsl1ya8c7+Rd6eCBGLG+ikjmRm6P41EJaKA/et/ROrsgI6XfMQ
         eU6e4w0sJh1m8WAtdAHovKcH6vBxLlvK+vvELFP5i8kbO8uCOnIQPM9wI60ATBj9f6Rq
         kD+cF1Q+E0Et7qQbpAr2R9Y7BFWn3TrptbMVgvNkQYplEiI9xITu7kqikW0tVKajp2L9
         8YJGUOvikZZW1RFaP5x8rQXLFWXHm68gAySj/zk/KbMIjQWKp532YjJKIf7tq1mftQcx
         7jMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773877563; x=1774482363;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=y1tJO6bvBiqRV6daDgX/JVHvb0vulQrD8Ue1sGra/Sw=;
        b=cyOBoTBN+tEy0lAz9NZ+UKEiuBXQ0k5zgA7Bj768L/czKKueaH+fi5cijEx+VHp6Bt
         ke2oNJjZ9nFZ7et4QJksnsxhaWdmhcoHcbbpWInN7yegHfi6xsLj55kZFZeLO5pCZVeZ
         I7vOJqTGg5405RzX4u2ZV/HR+rwsOqeGR0P5ztsoHGqPJnDvMbDkMwFFPb72Fnh7jy0k
         GuXfLDqMUvWamR6Qfvtp9EOddWduDL/19lkbxLHRZIHLDeO2lB+5R0qp8sZLZYRCAwqa
         S0hB7cINAENl0HSffrWuW6PGM9RsGyr4d6iOkb599uVYuP9XTaNk/bX7FgOi95bOXSs3
         HguA==
X-Forwarded-Encrypted: i=1; AJvYcCWskSnUjXmBuzc66rFsd+GIgz6cqYcYEK0a3OVXQFxHqxJK5czRAw/9EjCGnvkBtJecJX8gEdnVR4tE@vger.kernel.org
X-Gm-Message-State: AOJu0Yyzw1Ikx+5Y9+cj0QbVhq29ej1kzWsO2ZmX8viGmIaxBLfmI2P6
	8GFsRzMRAGqbbKX0WJVfv64CN5lghvo+QSVQAlxmcC/ezD24M+p9F852o42zA6A5vewV8No00kE
	1G4d2o0jXrw==
X-Received: from dlea10-n1.prod.google.com ([2002:a05:701b:420a:10b0:128:cf1e:df72])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:6a4:b0:128:d5bd:357f
 with SMTP id a92af1059eb24-129a70e5ee1mr2452430c88.30.1773877562736; Wed, 18
 Mar 2026 16:46:02 -0700 (PDT)
Date: Wed, 18 Mar 2026 16:45:55 -0700
In-Reply-To: <20260318175808.582009-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260318175808.582009-1-irogers@google.com>
X-Mailer: git-send-email 2.53.0.851.ga537e3e6e9-goog
Message-ID: <20260318234600.730340-1-irogers@google.com>
Subject: [PATCH v8 0/5] perf evsel fallback changes, better s390 defaults
From: Ian Rogers <irogers@google.com>
To: acme@kernel.org, namhyung@kernel.org, tmricht@linux.ibm.com
Cc: irogers@google.com, agordeev@linux.ibm.com, gor@linux.ibm.com, 
	hca@linux.ibm.com, japo@linux.ibm.com, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-s390@vger.kernel.org, 
	sumanthk@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-17612-lists,linux-s390=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[irogers@google.com,linux-s390@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-s390];
	NEURAL_HAM(-0.00)[-0.985];
	RCPT_COUNT_TWELVE(0.00)[12];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E2BE92C3E23
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Discussion with Thomas Richter in:
https://lore.kernel.org/lkml/20260306071002.2526085-1-tmricht@linux.ibm.com/
showed that the evsel__fallback wasn't working for s390. These patches
avoid the problematic frame pointer callchain on s390 and fix
evsel__fallback from a range of problems when falling back to a
software event. I simulated failures when developing the patches but
they are untested other than that.

v8: Address sashiko review that target wasn't fully initialized for
    `perf record` with '-u'. Ensure the callchain is enabled with '-g'
    and a .perfconfig setting. This don't impact testing so keeping
    Thomas' tested-by tags.
https://sashiko.dev/#/patchset/20260318175808.582009-1-irogers%40google.com

v7: In perf top, move the target uid handling back to after the evlist
    is setup. A regression caught by Sashiko in:
https://sashiko.dev/#/patchset/20260317175642.161647-1-irogers%40google.com
https://lore.kernel.org/lkml/20260318175808.582009-1-irogers@google.com/

v6: Sashiko noted that target wasn't fully set up when creating the
    default evlist in `perf top`, so move it earlier. Fix const char*
    casting issues in __parse_callchain_report_opt. Make '-g' not
    override the .perfconfig setting again.
https://sashiko.dev/#/patchset/20260317055334.760347-1-irogers%40google.com
https://lore.kernel.org/lkml/20260317175642.161647-1-irogers@google.com/

v5: Fix the value for the top option to match that of record. Tidy the
    callchain parsing option callbacks. Based on AI review feedback:
https://sashiko.dev/#/patchset/20260317030601.567422-1-irogers%40google.com
https://lore.kernel.org/lkml/20260317055334.760347-1-irogers@google.com/

v4: Changing the callchain parameter at configuration time means other
    options aren't set the same as they would for `--call-graph
    dwarf`, for example the stack size. Switch to setting the
    callchain option on s390 to parameter parse time. For '-g' use
    '--call-graph dwarf' for s390. Other --call-graph options are
    parsed as normal, but a warning is generated when setting
    `--call-graph fp` for s390. Also fix that sample IDs aren't wanted
    when there is only 1 event in the evlist.
https://lore.kernel.org/lkml/20260317030601.567422-1-irogers@google.com/

v3: Incorporate feedback about event and callchain behavior for s390:
https://lore.kernel.org/lkml/20260312061628.1593105-1-irogers@google.com/
https://lore.kernel.org/lkml/20260313202811.2599195-1-irogers@google.com/

v2: try exclude_callchain_user for s390 rather than fully disabling
    the callchain. Fix a missed clearing of is_pmu_core if the
    software event fallback.
https://lore.kernel.org/lkml/20260312061628.1593105-1-irogers@google.com/

v1: https://lore.kernel.org/lkml/20260312031928.1494864-1-irogers@google.com/

Ian Rogers (5):
  perf evsel: Improve falling back from cycles
  perf target: Constify simple check functions
  perf evsel: Constify option arguments to config functions
  perf callchain: Refactor callchain option parsing
  perf evlist: Improve default event for s390

 tools/perf/builtin-record.c      | 81 ++++++++++----------------------
 tools/perf/builtin-top.c         | 46 +++++++++++-------
 tools/perf/builtin-trace.c       |  9 +++-
 tools/perf/tests/event_update.c  |  4 +-
 tools/perf/tests/expand-cgroup.c |  4 +-
 tools/perf/tests/perf-record.c   |  7 ++-
 tools/perf/tests/topology.c      |  4 +-
 tools/perf/util/callchain.c      | 73 +++++++++++++++++++++++-----
 tools/perf/util/callchain.h      | 12 ++---
 tools/perf/util/evlist.c         | 32 ++++++++-----
 tools/perf/util/evlist.h         |  2 +-
 tools/perf/util/evsel.c          | 70 +++++++++++++++++----------
 tools/perf/util/evsel.h          | 10 ++--
 tools/perf/util/target.h         | 12 ++---
 14 files changed, 219 insertions(+), 147 deletions(-)

-- 
2.53.0.851.ga537e3e6e9-goog


