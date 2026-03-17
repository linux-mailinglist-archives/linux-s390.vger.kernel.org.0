Return-Path: <linux-s390+bounces-17432-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QM79DETFuGnTjAEAu9opvQ
	(envelope-from <linux-s390+bounces-17432-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Tue, 17 Mar 2026 04:06:44 +0100
X-Original-To: lists+linux-s390@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A180F2A3042
	for <lists+linux-s390@lfdr.de>; Tue, 17 Mar 2026 04:06:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C8DF1300DF5E
	for <lists+linux-s390@lfdr.de>; Tue, 17 Mar 2026 03:06:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68AE02C027B;
	Tue, 17 Mar 2026 03:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="b06y/exZ"
X-Original-To: linux-s390@vger.kernel.org
Received: from mail-dl1-f74.google.com (mail-dl1-f74.google.com [74.125.82.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E3612BEC52
	for <linux-s390@vger.kernel.org>; Tue, 17 Mar 2026 03:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773716772; cv=none; b=W9oJW6DSRoT1Qufn5sdH+wKrg8HDuTS6okgAOHGiIdBKoxMKlIPqOy7NidgEVUtJbToiKm/c5GwS7p8VwaUucrEXKMkOgEqrulci56KGykuni8AciqEQIwpXpbHt8k9ujYxAx3QBcWEBl1FOuyI7tULN0FvUhaIHR0HTA6PmxSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773716772; c=relaxed/simple;
	bh=RC/sNA7UZ675UVSNKiDi/OnG1i7OJo/S7122TlWs0xA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Au6gHc6KPWCBRtKmesUISS2oShSl8sIMDOUwDvhc9TYKBx3eymjNZUr3kvEuUtCERccnYtaNJRipz3YqtKxVR0TZj4eQ8BJ/V4BEXGSaWW4BjAim6O8k4t0hhKR+AZnnZJFxtuAnCa7fpUpbvdALXrx07Lw60epWlUw16Wt5wVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=b06y/exZ; arc=none smtp.client-ip=74.125.82.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-dl1-f74.google.com with SMTP id a92af1059eb24-1279caef718so6363049c88.1
        for <linux-s390@vger.kernel.org>; Mon, 16 Mar 2026 20:06:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773716770; x=1774321570; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=jWlPZpg3Ia2Drs4Ekojtbptw9u9IS3zjvlx9f7SLX1I=;
        b=b06y/exZKvI81P/gv/KzU6Rq9aqstcPUNxbpDzcAM7hU/Amu3Cqg2ntbBIA4BWLXRh
         +QSNbN5mdq8HZtgiFKSv+IBVdHS6H13l06QCG4qLbG1ItTejmMc790Esg3FB3KNVlIdM
         wSdIgUXK9kIWayy/vdi2mL+9tIWb3eiOQ7FWzIvHkoZbAPhHF8mt6lDQVwJJ8coxl3Hg
         2oqSRDlAQhcxEXIOtGMbC+7l3UR9mtp3v2Iwmt8sFK65iaOeU2k9m1eHusWtIWNbr2PW
         znlbmPeWercfxlrpB2RCEZ96UXvK1n1GCdeaZAoXHLDVaOw7WcYEgwzY9dXWyPOCEbki
         j+KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773716770; x=1774321570;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jWlPZpg3Ia2Drs4Ekojtbptw9u9IS3zjvlx9f7SLX1I=;
        b=pyRLkBGT8puUlXtrAtwEa9m3fxBWcdUS8sf+6YALdO9oqQuoU/s0wtxlzLkvraPXeq
         Q3zsmOeRDYoaSLgCWK+IxPPx7eM0+lsceL8b9noSp/tRvQvylchy7LG4N3BtCr+rboyG
         kO82olhgcPxSwICOb+FsAqTgqDfn6fVvO1YSnQi4ShftYG5RFUwjzpYgRfNqeWi1y6FP
         nrb0evbTEa3UWV96Z3+lAaFKlifLlhuBi3zLMzt9YDp7Sr/zRf239ziAK+MB+txOTnGF
         5ItwsJdXbFDaKBSCK/NOVbqDcSRVLH1HESWgmr5OVWzDW2C7QtM798SoXCBHgsuTzHOH
         Hyvg==
X-Forwarded-Encrypted: i=1; AJvYcCW3E1zhh5ICu8ugvPj7ctihzWphZnmO1TdUM2PQ1iluKcKTtC0NiWnDVcMfJsFAWjFt/KbMmt5yAYWE@vger.kernel.org
X-Gm-Message-State: AOJu0YzDtqe//tkR9lupgw/hpeQDvMAOAWLWYXWAtk0tMpXNJ66Mnpqm
	nLSBvhy2UlPlGp2uaIGD/KPXN4a9lA7a8VAJ88Y6S8F3hdOLuLf0AU1KbK5gSe2Nz01rxMSsL76
	X/ktJ+i1tGA==
X-Received: from dlaf5.prod.google.com ([2002:a05:701b:2405:b0:128:d36e:eb6f])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:4397:b0:122:33e:6d41
 with SMTP id a92af1059eb24-128f3dc5911mr6735342c88.23.1773716770021; Mon, 16
 Mar 2026 20:06:10 -0700 (PDT)
Date: Mon, 16 Mar 2026 20:05:56 -0700
In-Reply-To: <CAP-5=fU9SJu=x2+aKTV4eXXLVv77SbtBr0shDLTfWw9eByYZ4Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <CAP-5=fU9SJu=x2+aKTV4eXXLVv77SbtBr0shDLTfWw9eByYZ4Q@mail.gmail.com>
X-Mailer: git-send-email 2.53.0.851.ga537e3e6e9-goog
Message-ID: <20260317030601.567422-1-irogers@google.com>
Subject: [PATCH v4 0/5] perf evsel fallback changes
From: Ian Rogers <irogers@google.com>
To: tmricht@linux.ibm.com
Cc: irogers@google.com, acme@kernel.org, agordeev@linux.ibm.com, 
	gor@linux.ibm.com, hca@linux.ibm.com, japo@linux.ibm.com, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	linux-s390@vger.kernel.org, namhyung@kernel.org, sumanthk@linux.ibm.com
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
	TAGGED_FROM(0.00)[bounces-17432-lists,linux-s390=lfdr.de];
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
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_TWELVE(0.00)[12];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A180F2A3042
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Discussion with Thomas Richter in:
https://lore.kernel.org/lkml/20260306071002.2526085-1-tmricht@linux.ibm.com/
showed that the evsel__fallback wasn't working for s390. These patches
avoid the problematic frame pointer callchain on s390 and fix
evsel__fallback from a range of problems when falling back to a
software event. I simulated failures when developing the patches but
they are untested other than that.

v4: Changing the callchain parameter at configuration time means other
    options aren't set the same as they would for `--call-graph
    dwarf`, for example the stack size. Switch to setting the
    callchain option on s390 to parameter parse time. For '-g' use
    '--call-graph dwarf' for s390. Other --call-graph options are
    parsed as normal, but a warning is generated when setting
    `--call-graph fp` for s390. Also fix that sample IDs aren't wanted
    when there is only 1 event in the evlist.

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
  perf callchain: Move callchain option parsing out of builtin
  perf evlist: Improve default event for s390

 tools/perf/builtin-record.c      | 64 ++---------------------------
 tools/perf/builtin-top.c         |  2 +-
 tools/perf/tests/event_update.c  |  4 +-
 tools/perf/tests/expand-cgroup.c |  4 +-
 tools/perf/tests/perf-record.c   |  7 +++-
 tools/perf/tests/topology.c      |  4 +-
 tools/perf/util/callchain.c      | 61 ++++++++++++++++++++++++++++
 tools/perf/util/evlist.c         | 32 ++++++++++-----
 tools/perf/util/evlist.h         |  2 +-
 tools/perf/util/evsel.c          | 70 +++++++++++++++++++++-----------
 tools/perf/util/evsel.h          | 10 +++--
 tools/perf/util/target.h         | 12 +++---
 12 files changed, 159 insertions(+), 113 deletions(-)

-- 
2.53.0.851.ga537e3e6e9-goog


