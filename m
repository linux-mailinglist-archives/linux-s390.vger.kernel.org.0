Return-Path: <linux-s390+bounces-17224-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +DSSGO4wsmmzJQAAu9opvQ
	(envelope-from <linux-s390+bounces-17224-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Thu, 12 Mar 2026 04:20:14 +0100
X-Original-To: lists+linux-s390@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BA65126CBEB
	for <lists+linux-s390@lfdr.de>; Thu, 12 Mar 2026 04:20:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D9D4B303DAEB
	for <lists+linux-s390@lfdr.de>; Thu, 12 Mar 2026 03:19:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B82C2386C1C;
	Thu, 12 Mar 2026 03:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="h2CrqDhe"
X-Original-To: linux-s390@vger.kernel.org
Received: from mail-dl1-f74.google.com (mail-dl1-f74.google.com [74.125.82.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47DE73603CD
	for <linux-s390@vger.kernel.org>; Thu, 12 Mar 2026 03:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773285575; cv=none; b=Sja+boc9GsknBGcwZmu7Egd/0S0BK097WxhxrbGMk3W9eZZq7SgispI1JEcAPoSgaZ8zf7IaxuhQT9XfZ45KD6lLrR8Tq77zY9B8+Ic0xTzKvr0nYgmZ/bSE5QhxXsSbJVJPcbdcUXjd0cc73wuGZ0INE6ZbcG3bOACk1xelpww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773285575; c=relaxed/simple;
	bh=B7pLGrhr1M3AUUWzljLJh9qQCW/pH11OsJvYTeDvP/Q=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=do9fJCe2rOogrDJnqcK639ah5PwTTCufBP1M/Rur+VbA51vYamTNsV9WAb2ydhYu5rurVBEAfDoVdUuDZ5w32/GM1PrT+QUjxegTBCr4QkzjuKiaQa11S8Zif11RYw65wQ5a7iLuTIZtdZrAcl4+W9wOkhXLzrRBC8jahY5ZmTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=h2CrqDhe; arc=none smtp.client-ip=74.125.82.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-dl1-f74.google.com with SMTP id a92af1059eb24-127337c8e52so17556712c88.1
        for <linux-s390@vger.kernel.org>; Wed, 11 Mar 2026 20:19:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773285572; x=1773890372; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=6nJNlw9AbBLbWaDxnsrG+aJBf6+0dB3NQVrAkWPs2QY=;
        b=h2CrqDhe/j2te1JaFtqy4k35qCSVN+9JG6Mbhm5WK/xXK7IDnVzyTX17iC06CwuWkm
         FlLI8sj7xg/btUVU2NT0EyCW7/0x/IOIAKjdylQbJVBfMymCaikWcJIDAczQIyEzcYhc
         HC7N8/z1sHYbLiEqhajfLpaR8+BeRaplsY6mmi+oFdZ4rIcPkRHtugmBucoX+D4pYgtv
         8IVdO9KcP5LfRrZW3Dat58uJz3xmVhkCVq/m9Uo3jzLBJ4YAT7jElHjyZecKnFcAwUPa
         ip31R2cwob/AVA4EBwMxYOA8PDhxvSTyFI7JIAF1tEErwUCyj70m79QJ6gIfH7a1XTy1
         JWCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773285572; x=1773890372;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6nJNlw9AbBLbWaDxnsrG+aJBf6+0dB3NQVrAkWPs2QY=;
        b=XWmy/WRr57mrqs7Q3hYSffgunNfVTPeAVpUt9Wy9WuRsdHW1VKzUOC+WDKMsCHn+Ug
         DC+fqvLCLKMedRq5dMYuHJ8xJqQ2ud9r4P8yg1RRVLMIHH/1c68jW0a83rME5k/meLD/
         cuvaT7mQhqZkzKpAAReGDU6S0ekuRgSRgtjl+suAdxzaWIiDtPbLzmWfbmkF2+I4PePW
         5+kxUAksm0RlhLq02Zq42YgS3Gjnx0CGSSVqXdt8XNHfA2Jk1tzSFAcVeSAJvhNdxGO0
         eY5oewxashzicLAw38sSnk4q/DKebuLUnQ150mWQOuvOz/FFTsj4R1w8mwjKTX2QnAs4
         mLXg==
X-Forwarded-Encrypted: i=1; AJvYcCXsp0A8G61sWb0qaujIjbfJ8Ri6SUL+2TXMomMIoAolNgfA/LqJx/xKDidz9CoMgeDmDJMXai7gA/tt@vger.kernel.org
X-Gm-Message-State: AOJu0Yzlbx9liQEuKTYFgCvl7PK36QlIa8eh2KxjkarMwgI3UkjmEZVV
	BHiwkEnwDD3/7Kn6yEbQ3HNXOny6IJYpqroWOMaREl7bYxve5+s4ra5YYJkOqv1CrqDoCXvYZy8
	mI2NqqBGZaA==
X-Received: from dldz19-n1.prod.google.com ([2002:a05:701b:4193:10b0:128:cff2:6560])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:61a2:b0:128:cf5c:5362
 with SMTP id a92af1059eb24-128e77aed60mr2077124c88.12.1773285572154; Wed, 11
 Mar 2026 20:19:32 -0700 (PDT)
Date: Wed, 11 Mar 2026 20:19:26 -0700
In-Reply-To: <131d7e1e-701e-4f5b-961f-c85af74f1d96@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <131d7e1e-701e-4f5b-961f-c85af74f1d96@linux.ibm.com>
X-Mailer: git-send-email 2.53.0.851.ga537e3e6e9-goog
Message-ID: <20260312031928.1494864-1-irogers@google.com>
Subject: [PATCH v1 0/2] perf evsel fallback changes
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-17224-lists,linux-s390=lfdr.de];
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
X-Rspamd-Queue-Id: BA65126CBEB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Discussion with Thomas Richter in:
https://lore.kernel.org/lkml/20260306071002.2526085-1-tmricht@linux.ibm.com/
showed that the evsel__fallback wasn't working for s390. These patches
avoid the problematic frame pointer callchain on s390 and fix
evsel__fallback from a range of problems when falling back to a
software event. I simulated failures when developing the patches but
they are untested other than that.

Ian Rogers (2):
  perf evsel: Improve falling back from cycles
  perf evsel: Don't configure framepointer callchains on s390

 tools/perf/util/evsel.c | 49 +++++++++++++++++++++++++++++------------
 tools/perf/util/evsel.h |  2 ++
 2 files changed, 37 insertions(+), 14 deletions(-)

-- 
2.53.0.851.ga537e3e6e9-goog


