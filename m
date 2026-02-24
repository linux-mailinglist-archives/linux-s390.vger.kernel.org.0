Return-Path: <linux-s390+bounces-16429-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qGScGjZvnWk9QAQAu9opvQ
	(envelope-from <linux-s390+bounces-16429-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Tue, 24 Feb 2026 10:28:22 +0100
X-Original-To: lists+linux-s390@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BDE17184955
	for <lists+linux-s390@lfdr.de>; Tue, 24 Feb 2026 10:28:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E662F3021714
	for <lists+linux-s390@lfdr.de>; Tue, 24 Feb 2026 09:22:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C50F366DCF;
	Tue, 24 Feb 2026 09:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lHY5sumw"
X-Original-To: linux-s390@vger.kernel.org
Received: from mail-pl1-f195.google.com (mail-pl1-f195.google.com [209.85.214.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6030820A5F3
	for <linux-s390@vger.kernel.org>; Tue, 24 Feb 2026 09:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771924947; cv=none; b=YQdHo+IZSHQvG1o0HJhGPRWznqNBI3xux1715FQ/9s9lC+MsOgXN9LTk4RrWInPqLj6uU9NHrmQsNM1VveXJ49fCEf8X1OzwkUJ+LJ/e4BH4ekQ4YwG+CB1+CqKyaN4A8j10tp9bCVbTrtK2l9zn0T7E6oxUxu/HYgepoJEiYHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771924947; c=relaxed/simple;
	bh=VlROADzLBdvADEC6gprBeewTzGs6dd+rHVjt/NXRkHE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Boq//GH0+Ig38K4IrfEoxYMLIeay+xo/qWY/3s9vLM7n1WAMFIgPWVZ7hw7RVitOglUtig9bSuU7DX2yrNKR+Eub0JxSW1W+zgQ3+/nq3Yq/AnPZMlQvLdeuKr+rjzv1AWT2+G6SRpzjeUAOG0jwfKDIjLO/dOKUZswpm52+m5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lHY5sumw; arc=none smtp.client-ip=209.85.214.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f195.google.com with SMTP id d9443c01a7336-2ad617d5b80so32934615ad.1
        for <linux-s390@vger.kernel.org>; Tue, 24 Feb 2026 01:22:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771924946; x=1772529746; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+mIPlGUglrjJyYi2dqgFCL83ozadlbrMVQN9MvZE08o=;
        b=lHY5sumw+YZpQcS5ZT+jUHv73U8JaK6yQbUGhdvLfo/obYRewMRe1r0VtNYm9k2BcB
         FbDC2m9PXLrtFj6hpMg3zt5RFCUSha/uuPOMYhgWgY1RGD91fQupml5GD1JDcqlfWHy+
         /bv38U13irbDpMPCXNrZTowd5+5GJCKjt8yzVT5iEOazQiwKO7yhAIgDV1kXXUm26seM
         opjbtkRycu5PnVo9Bc0ag3jB5Wv/LtyPws08EXOqYyRm8JAvIzuZlc8HLQao6BiUFE2x
         TJyhsUo6yTUgRq1bmz2yF5335Noa/2kUhGz7pU4N7d5xCCUxNiP+DYQBzP5ULU23SKsk
         m5Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771924946; x=1772529746;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+mIPlGUglrjJyYi2dqgFCL83ozadlbrMVQN9MvZE08o=;
        b=Mu6F+4qNP6pRbbdR65EfL1vvJPFaqpVb5SeRQGswTjU/y67BjoIu9kTmD9G1Y5GYl6
         j8Ujf9SmmcBTn6nA31/URyjY+yhxc+0sprcrK5ls04BlGa6Memr7tw5MzPTkA3Ip/g6y
         RfJMHbTNOjaP2FQDrHCAsRJe/37cPWMTvhz2zfVFLEjCtTuVPu6e/26w9+kQuRioZSQg
         I51C0KWxEAgkMMCmbxx7mbA/JLiNWZag2WLx+sp2Bo+ryO3p4373MxGmkvfobeiffSyK
         aNHDalt2ik12HGG0A4JSoFI8B8rMoiSIS76WqTvIw9Byh0luttmlnGKuCH1O0Ahwf2fy
         i3rA==
X-Forwarded-Encrypted: i=1; AJvYcCXOpkv0QSxJehRPkXTAZoGKslNxBB6oLaVzrkbCmYKhPcy/PlNZPuCO2MpqYjgjTdO0QOvsxOfOZY5z@vger.kernel.org
X-Gm-Message-State: AOJu0YyCiatSJT6EGIlENA1NtSFnZErRMk2uxxGzkVqPAe6RgatGH0Cr
	XiWnm4+gEWG8mBAjHKL73zZryeRzh3orghUQ4jI8s8spRy8/TqxeVP/n
X-Gm-Gg: ATEYQzwu7tXtJHMt9GLKb3XglSQEp880nivQ48jl7Go9KKbpZnqieSPvz7xBl1z3tsb
	3+gtbXGcxMAtkD1IH6VlvPwjn9hWYs3DA/yWfIUOGknOM8NpCr4KOVkeQPiVKpK9fGBZ6UJ8gFD
	TgyjKo2iDmkmutFf7fx5UG8s7CHK8qLMBWOF9UCLYTX5mrXAvEdEnL2P4yMMHgxodSdcIBuEFTf
	i+/JehniyUIHplEkhIV3uV2XmA0c2JYaNRjy/FO4g56F+MlnhmSQwJJ0qqXzoRzD7SmwO4p/v2s
	8N/k0TCP1ySCSFqy/RoDstAjZ234poEDNnhdVxhfjG1XbXmV3vaEeA+qq36yzFBF6bhzdV6F3Ae
	jkjlfCliAKpGb5yBsiHXow6Ey73sYwgbtooJ3pERLmPhsb5e4NW2xdYr0PurutA8ysn3M0gKfUB
	saRejWf9BSE8hTDrcdOS3c
X-Received: by 2002:a17:902:ecc6:b0:2aa:d7a7:8084 with SMTP id d9443c01a7336-2ad74419486mr113804165ad.6.1771924945667;
        Tue, 24 Feb 2026 01:22:25 -0800 (PST)
Received: from 7940hx ([103.173.155.241])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ad7500e2b2sm97181695ad.52.2026.02.24.01.22.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Feb 2026 01:22:25 -0800 (PST)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: ast@kernel.org,
	iii@linux.ibm.com
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	hca@linux.ibm.com,
	gor@linux.ibm.com,
	agordeev@linux.ibm.com,
	borntraeger@linux.ibm.com,
	svens@linux.ibm.com,
	bpf@vger.kernel.org,
	linux-s390@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v2 0/3] bpf: fsession support for s390
Date: Tue, 24 Feb 2026 17:22:05 +0800
Message-ID: <20260224092208.1395085-1-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16429-lists,linux-s390=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[iogearbox.net,kernel.org,linux.dev,gmail.com,fomichev.me,google.com,linux.ibm.com,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[21];
	FROM_NEQ_ENVFROM(0.00)[menglong8dong@gmail.com,linux-s390@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[linux-s390];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,chinatelecom.cn:mid]
X-Rspamd-Queue-Id: BDE17184955
X-Rspamd-Action: no action

Implement bpf fsession for the s390 architecture.

Changes v2 -> v1:
* keep LGHI as it was in the 1st patch
* fix up the comment style
* remove the unnecessary checking of fentry->nr_links and fexit->nr_links
  in the 2nd patch
* v1: https://lore.kernel.org/bpf/20260223084022.653186-1-dongml2@chinatelecom.cn/

Menglong Dong (3):
  bpf,s390: introduce emit_store_stack_imm64() for trampoline
  bpf,s390: add fsession support for trampolines
  selftests/bpf: factor out get_func_* tests for fsession

 arch/s390/net/bpf_jit_comp.c                  | 95 ++++++++++++++-----
 .../bpf/prog_tests/get_func_args_test.c       | 25 ++++-
 .../bpf/prog_tests/get_func_ip_test.c         | 28 +++++-
 .../bpf/progs/get_func_args_fsession_test.c   | 37 ++++++++
 .../selftests/bpf/progs/get_func_args_test.c  | 38 --------
 .../bpf/progs/get_func_ip_fsession_test.c     | 21 ++++
 .../selftests/bpf/progs/get_func_ip_test.c    | 23 -----
 7 files changed, 178 insertions(+), 89 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/get_func_args_fsession_test.c
 create mode 100644 tools/testing/selftests/bpf/progs/get_func_ip_fsession_test.c

-- 
2.53.0


