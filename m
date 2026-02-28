Return-Path: <linux-s390+bounces-16657-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4F/uEoFco2nW/AQAu9opvQ
	(envelope-from <linux-s390+bounces-16657-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Sat, 28 Feb 2026 22:22:09 +0100
X-Original-To: lists+linux-s390@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A11FF1C8F32
	for <lists+linux-s390@lfdr.de>; Sat, 28 Feb 2026 22:22:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0130330210D9
	for <lists+linux-s390@lfdr.de>; Sat, 28 Feb 2026 19:43:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B40B13590A9;
	Sat, 28 Feb 2026 17:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SFPrCK9U"
X-Original-To: linux-s390@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E80433F378;
	Sat, 28 Feb 2026 17:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300906; cv=none; b=JcCU5bnd2NYJsdvD0iLa7lRgzhuBaOURrTvx495Uk1tfJufBu4iH2Y9w1lMcSrcXd+CUAdxN5jq3hYqplNQ+oXOWaaD7zeMtFxIotCEcb9McMomOPuOn6HeAc6zS69J8hxNsgRQoRPXCl6t3o4ry4XK8kJiSYxg0jw7GzFzCtsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300906; c=relaxed/simple;
	bh=bjZvF3HoqucTEu5JA0Fv2fjutW/UGHafxWfYSwNBAoY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nMn1JA9WdMN4HEEq98r/az171CysHV6Nc96aSfp5dMOA0nJS2riXskxyRgR6Df+h9zmG8c+DeD177pCuMzIo/Y28dSjGXL4gwJJDgeCkRmEdPHoO2SMFzjZgBANa+4TudaDR8VhHopzgi+n2FRSzNIRhYFc9sEiwwQydIWZOg2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SFPrCK9U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3584DC116D0;
	Sat, 28 Feb 2026 17:48:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300906;
	bh=bjZvF3HoqucTEu5JA0Fv2fjutW/UGHafxWfYSwNBAoY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SFPrCK9UMveqTujE8khluLueeERuSiYW1ugxUhArv9/SMwyBd7dYCWaSx6QH5cTHi
	 kSvmwd137fKg0+i3QYsrtXnx5a6q+TVgDYJawwzNtvqz0aHs7ZWjllmn2IfG0LR/g1
	 oWoljd7r1ZTU2c9z6XdreHddETeu+XKDX4iUwoUzqS7Rt/c53osjsDOn6d0JwHhro+
	 jEG94HMBpBSEPWr0aZyifixwUSjvRUgZ7o635KauXOhU0v6GE+rqErq67LMND5mJIc
	 QJjBBpZkC3mYcCe0TL6/3jkwIdanilX64bHX+42WVtMOokeYwrNnOqKH3nzihzwhbX
	 Nhz3mO8TIrbNA==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev
Cc: Thomas Richter <tmricht@linux.ibm.com>,
	Jan Polensky <japo@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Ian Rogers <irogers@google.com>,
	linux-s390@vger.kernel.org,
	Namhyung Kim <namhyung@kernel.org>,
	Sumanth Korikkar <sumanthk@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 020/752] perf test: Fix test case perftool-testsuite_report for s390
Date: Sat, 28 Feb 2026 12:35:31 -0500
Message-ID: <20260228174750.1542406-20-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228174750.1542406-1-sashal@kernel.org>
References: <20260228174750.1542406-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16657-lists,linux-s390=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,linux-s390@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-s390];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,perf.data:url]
X-Rspamd-Queue-Id: A11FF1C8F32
X-Rspamd-Action: no action

From: Thomas Richter <tmricht@linux.ibm.com>

[ Upstream commit 3d012b8614ee020666f3dd15af9f65dc487e3f5f ]

Test case perftool-testsuite_report fails on s390 for some time
now.

Root cause is a time out which is too tight for large s390 machines.
The time out value addr2line_timeout_ms is per default set to 1 second.

This is the maximum time the function read_addr2line_record() waits for
a reply from the forked off tool addr2line, which is started as a child
in interactive mode.

It reads stdin (an address in hexadecimal) and replies on stdout with
function name, file name and line number. This might take more than one
second.

However one second is not always enough and the reply from addr2line
tool is not received. Function read_addr2line_record() fails and emits
a warning, which is not expected by the test case. It fails.

Output before:

 # perf test -F 133
 -- [ PASS ] -- perf_report :: setup :: prepare the perf.data file
 ==================
 [ perf record: Woken up 1 times to write data ]
 [ perf record: Captured and wrote 0.087 MB \
	/tmp/perftool-testsuite_report.FHz/perf_report/perf.data.1 \
	(207 samples) ]
 ==================
 -- [ PASS ] -- perf_report :: setup :: prepare the perf.data.1 file
 ## [ PASS ] ## perf_report :: setup SUMMARY
 -- [ SKIP ] -- perf_report :: test_basic :: help message :: testcase skipped
 Line did not match any pattern: "cmd__addr2line /usr/lib/debug/lib/modules/
 	6.19.0-20260205.rc8.git366.9845cf73f7db.300.fc43.s390x+next/
	vmlinux: could not read first record"
 Line did not match any pattern: "cmd__addr2line /usr/lib/debug/lib/modules/
	6.19.0-20260205.rc8.git366.9845cf73f7db.300.fc43.s390x+next/
	vmlinux: could not read first record"
 -- [ FAIL ] -- perf_report :: test_basic :: basic execution
	(output regexp parsing)
 ....
 133: perftool-testsuite_report      : FAILED!

Output after:

 # ./perf test -F 133
 -- [ PASS ] -- perf_report :: setup :: prepare the perf.data file
 ==================
 [ perf record: Woken up 1 times to write data ]
 [ perf record: Captured and wrote 0.087 MB \
	 /tmp/perftool-testsuite_report.Mlp/perf_report/perf.data.1
	 (188 samples) ]
 ==================
 -- [ PASS ] -- perf_report :: setup :: prepare the perf.data.1 file
 ## [ PASS ] ## perf_report :: setup SUMMARY
 -- [ SKIP ] -- perf_report :: test_basic :: help message :: testcase skipped
 -- [ PASS ] -- perf_report :: test_basic :: basic execution
 -- [ PASS ] -- perf_report :: test_basic :: number of samples
 -- [ PASS ] -- perf_report :: test_basic :: header
 -- [ PASS ] -- perf_report :: test_basic :: header timestamp
 -- [ PASS ] -- perf_report :: test_basic :: show CPU utilization
 -- [ PASS ] -- perf_report :: test_basic :: pid
 -- [ PASS ] -- perf_report :: test_basic :: non-existing symbol
 -- [ PASS ] -- perf_report :: test_basic :: symbol filter
 -- [ PASS ] -- perf_report :: test_basic :: latency header
 -- [ PASS ] -- perf_report :: test_basic :: default report for latency profile
 -- [ PASS ] -- perf_report :: test_basic :: latency report for latency profile
 -- [ PASS ] -- perf_report :: test_basic :: parallelism histogram
 ## [ PASS ] ## perf_report :: test_basic SUMMARY
 133: perftool-testsuite_report      : Ok
 #

Fixes: 257046a36750a6db ("perf srcline: Fallback between addr2line implementations")
Reviewed-by: Jan Polensky <japo@linux.ibm.com>
Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>
Cc: Heiko Carstens <hca@linux.ibm.com>
Cc: Ian Rogers <irogers@google.com>
Cc: linux-s390@vger.kernel.org
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Sumanth Korikkar <sumanthk@linux.ibm.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/perf/util/addr2line.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/addr2line.c b/tools/perf/util/addr2line.c
index f2d94a3272d71..a8b39f4f202b6 100644
--- a/tools/perf/util/addr2line.c
+++ b/tools/perf/util/addr2line.c
@@ -18,8 +18,8 @@
 
 #define MAX_INLINE_NEST 1024
 
-/* If addr2line doesn't return data for 1 second then timeout. */
-int addr2line_timeout_ms = 1 * 1000;
+/* If addr2line doesn't return data for 5 seconds then timeout. */
+int addr2line_timeout_ms = 5 * 1000;
 
 static int filename_split(char *filename, unsigned int *line_nr)
 {
-- 
2.51.0


