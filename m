Return-Path: <linux-s390+bounces-2457-lists+linux-s390=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 838BF877CD8
	for <lists+linux-s390@lfdr.de>; Mon, 11 Mar 2024 10:34:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7750D1C20EFB
	for <lists+linux-s390@lfdr.de>; Mon, 11 Mar 2024 09:34:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE987182D2;
	Mon, 11 Mar 2024 09:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="ffG/HZ+B"
X-Original-To: linux-s390@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 176D517BA1
	for <linux-s390@vger.kernel.org>; Mon, 11 Mar 2024 09:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710149671; cv=none; b=AbZXFbkoSZ6bpDkALncT2SL0c4Foy1zsg+Awm0Ao05Gs9bxQrrDgAk3ePIk4lg1AeUFLausSeHnJArWw+45LVVW5xgW/fkS9js98RqaWrEPJgyL8nenbZRrLrFeB22W3imZkvZsNuXlUF9NILaRzDsUZrf7/juAoG2btAuBpTyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710149671; c=relaxed/simple;
	bh=pBeh1umlMjjCC1pK7F323M1Zc7qg2K4wSufxhi0XFAM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=bU9autvdHJ/aSfVG+dJvQ8HFWhRJVaFkNyPCO7/qOV7AdgMi9/2MJL9xg7jJ4RoPYi6LSOnYc6IvqKUEjrpQrNAh4O0Kka8FK9d1LOW9frvC2k8MZNfd82dE1G45yznRKeUiw68nV8aOCUmMU2/Y1xbZ7Fhn8v4iTCrxXcOi5wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=ffG/HZ+B; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-5d8b887bb0cso3552476a12.2
        for <linux-s390@vger.kernel.org>; Mon, 11 Mar 2024 02:34:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1710149668; x=1710754468; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=q244jOj8DhushyleU2bCeCOJVSr6CNZEpUiu8vv3bQA=;
        b=ffG/HZ+B8yrIVOK/qYG59RUdohMjv5PQB9dYaGiHUU+ASzULmDl7U/eRznhMxavukW
         q/9asER5pDzsuLeYizqLkl21sNN++hDUtPCCIxMiXXAm1rDQkNkMwZbNmrwHGRh+4TQ5
         ASaXgjcqSd6tYEZBKWmbyBM3Tm0osQi8pIAmKs+2ei45zGC8LH2Yq9efyXibU34BeO4+
         8anHabvfkQ/7HtK/mIn1uQBLgbW0F+FfPXQMh6SdsrN651Tkf+2zWo+CYVCFtDmBj3/+
         8kaoZ87Ov7LgVeCPFPgP00Hps8wq7GazTp6KZ9/l0FegQKB6ogLDZhemtVu3H0hSM+UC
         gwyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710149668; x=1710754468;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q244jOj8DhushyleU2bCeCOJVSr6CNZEpUiu8vv3bQA=;
        b=VzbeWZqVJ48vI5/LLLKNu6pcxnoCXmfTydod8SeCrtV5+co9lBG0E+sEUQUwU+oLn/
         YbB5kD41Rj20CvMa6+jh7fG17zDNmnFlMj7iSPsXqVvlASklCQZWluMfsy3Q0GSCUNUk
         3brsNjdxG9FQAkRfeffgvJJGvME/lhhoI68iLApzIzHm6ZeWv/UAtGHuEMT2xV/c8foY
         20Qvgn1Vkqdg9ZwrtepcXwMjV5DY3QYL9nvUus+rMWyTPHLlFRA8nPmWX7Uilz3aaYmP
         bjVzm5Izj47YxKp0Jpkodmd5H3kjcO+2a2HSss+z7aWwdhzNUOmA2lODaGqyBaTfhEKm
         FLGA==
X-Forwarded-Encrypted: i=1; AJvYcCW1AHZfofgQLja35W+fS4JtbX8XIcfMLdm/q1arh+Zyxga/KDjpPNfHZ+9v4IuOrCXz9BOAT4+NdmpgS5nTmM2I6J/wuIq0Eb163g==
X-Gm-Message-State: AOJu0YwDx3QyvnkKiyVAgbVG3b0JddbHqvNwI/Lv0PDOYWaUrsIun8M7
	ZEBpC2twUht7tIcWgaUCvllZgF+TN+L9bObuU/AeqwrX/2mPpMnxgG8tTzmWpPg=
X-Google-Smtp-Source: AGHT+IElS3MTAJT6oKHCK2ojNj/jD5/lk4XV4NzHmUyXpO9L/Z2ncrXc9UjeUvKY0ZMwD8Lzv32+BQ==
X-Received: by 2002:a05:6a20:9f99:b0:1a1:7df5:ee5a with SMTP id mm25-20020a056a209f9900b001a17df5ee5amr9151303pzb.35.1710149668389;
        Mon, 11 Mar 2024 02:34:28 -0700 (PDT)
Received: from localhost.localdomain ([43.129.25.208])
        by smtp.gmail.com with ESMTPSA id h9-20020a170902f7c900b001dcad9cbf8bsm4253365plw.239.2024.03.11.02.34.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Mar 2024 02:34:27 -0700 (PDT)
From: Menglong Dong <dongmenglong.8@bytedance.com>
To: andrii@kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@google.com,
	haoluo@google.com,
	jolsa@kernel.org,
	agordeev@linux.ibm.com,
	borntraeger@linux.ibm.com,
	svens@linux.ibm.com,
	davem@davemloft.net,
	dsahern@kernel.org,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	rostedt@goodmis.org,
	mathieu.desnoyers@efficios.com,
	quentin@isovalent.com,
	bpf@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Menglong Dong <dongmenglong.8@bytedance.com>
Subject: [PATCH bpf-next v2 0/9] bpf: make tracing program support multi-link
Date: Mon, 11 Mar 2024 17:35:17 +0800
Message-Id: <20240311093526.1010158-1-dongmenglong.8@bytedance.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For now, the BPF program of type BPF_PROG_TYPE_TRACING is not allowed to
be attached to multiple hooks, and we have to create a BPF program for
each kernel function, for which we want to trace, even through all the
program have the same (or similar) logic. This can consume extra memory,
and make the program loading slow if we have plenty of kernel function to
trace.

In this series, we add the support to allow attaching a tracing BPF
program to multi hooks, which is similar to BPF_TRACE_KPROBE_MULTI.

In the 1st patch, we add the support to record index of the accessed
function args of the target for tracing program. Meanwhile, we add the
function btf_check_func_part_match() to compare the accessed function args
of two function prototype. This function will be used in the next commit.

In the 2nd patch, we refactor the struct modules_array to ptr_array, as
we need similar function to hold the target btf, target program and kernel
modules that we reference to in the following commit.

In the 3rd patch, we introduce the struct bpf_tramp_link_conn to be the
bridge between bpf_link and trampoline, as the releation between bpf_link
and trampoline is not one-to-one anymore.

In the 4th patch, we add the struct bpf_tramp_multi_link and
bpf_trampoline_multi_{link,unlink}_prog for multi-link of trampoline.

In the 5th patch, we add target btf to the function args of
bpf_check_attach_target(), then the caller can specify the btf to check.

The 6th patch is the main part to add multi-link supporting for tracing.
For now, only the following attach type is supported:

  BPF_TRACE_FENTRY_MULTI
  BPF_TRACE_FEXIT_MULTI
  BPF_MODIFY_RETURN_MULTI

The attach type of BPF_TRACE_RAW_TP has different link type, so we skip
this part in this series for now.

In the 7th and 8th patches, we add multi-link supporting of tracing to
libbpf. Note that we don't free btfs that we load after the bpf programs
are loaded into the kernel now if any programs of type tracing multi-link
existing, as we need to lookup the btf types during attaching.

In the 9th patch, we add the testcases for this series.

Changes since v1:
- According to the advice of Alexei, introduce multi-link for tracing
  instead of attaching a tracing program to multiple trampolines with
  creating multi instance of bpf_link.

Menglong Dong (9):
  bpf: tracing: add support to record and check the accessed args
  bpf: refactor the modules_array to ptr_array
  bpf: trampoline: introduce struct bpf_tramp_link_conn
  bpf: trampoline: introduce bpf_tramp_multi_link
  bpf: verifier: add btf to the function args of bpf_check_attach_target
  bpf: tracing: add multi-link support
  libbpf: don't free btf if program of multi-link tracing existing
  libbpf: add support for the multi-link of tracing
  selftests/bpf: add testcases for multi-link of tracing

 arch/arm64/net/bpf_jit_comp.c                 |   4 +-
 arch/riscv/net/bpf_jit_comp64.c               |   4 +-
 arch/s390/net/bpf_jit_comp.c                  |   4 +-
 arch/x86/net/bpf_jit_comp.c                   |   4 +-
 include/linux/bpf.h                           |  51 ++-
 include/linux/bpf_verifier.h                  |   1 +
 include/uapi/linux/bpf.h                      |  10 +
 kernel/bpf/bpf_struct_ops.c                   |   2 +-
 kernel/bpf/btf.c                              | 113 ++++-
 kernel/bpf/syscall.c                          | 425 +++++++++++++++++-
 kernel/bpf/trampoline.c                       |  97 +++-
 kernel/bpf/verifier.c                         |  24 +-
 kernel/trace/bpf_trace.c                      |  48 +-
 net/bpf/test_run.c                            |   3 +
 net/core/bpf_sk_storage.c                     |   2 +
 tools/bpf/bpftool/common.c                    |   3 +
 tools/include/uapi/linux/bpf.h                |  10 +
 tools/lib/bpf/bpf.c                           |  10 +
 tools/lib/bpf/bpf.h                           |   6 +
 tools/lib/bpf/libbpf.c                        | 215 ++++++++-
 tools/lib/bpf/libbpf.h                        |  16 +
 tools/lib/bpf/libbpf.map                      |   2 +
 .../selftests/bpf/bpf_testmod/bpf_testmod.c   |  49 ++
 .../bpf/prog_tests/tracing_multi_link.c       | 153 +++++++
 .../selftests/bpf/progs/tracing_multi_test.c  | 209 +++++++++
 25 files changed, 1366 insertions(+), 99 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/tracing_multi_link.c
 create mode 100644 tools/testing/selftests/bpf/progs/tracing_multi_test.c

-- 
2.39.2


