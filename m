Return-Path: <linux-s390+bounces-2464-lists+linux-s390=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 10F17877D05
	for <lists+linux-s390@lfdr.de>; Mon, 11 Mar 2024 10:37:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 798171F22DB8
	for <lists+linux-s390@lfdr.de>; Mon, 11 Mar 2024 09:37:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C78B18658;
	Mon, 11 Mar 2024 09:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="gMaLG/p9"
X-Original-To: linux-s390@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 565702375F
	for <linux-s390@vger.kernel.org>; Mon, 11 Mar 2024 09:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710149724; cv=none; b=JNUZ4p+34B65KChRvo6PQueU4ijfEqSOGT7S7gtPbijw5+/LMJkslz98l53/Sy3jLgRmZDwXQF6bJkJLKiJoN9sK7h0t0PLTcKiPBB7+lF5SfB8M9eu85IwJBiLIqofjh9bM3NyVjP3lARh9wm+x90U2LIuVA9nanL46PS41hEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710149724; c=relaxed/simple;
	bh=MMYdj+Pqcad6f1WZpx/CyHy39qDgjfK1UQH4N/XhTXY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fAldz5MKpWzXqtG7SnJ9554fzWf9E/nxMF1uGmEeQPfg/CJ2psU2RFaz2FFBn3PtURK9pe0jCiZQK5RsU1nvxyT4VNrJ+uS//oVprceMf42jQkUsjnr9cOSg9btoT8E4n4ScVPQSt+xKsXjsLI9wjzHA5aicUxx1/LSxLCqRpvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=gMaLG/p9; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-6da202aa138so2577666b3a.2
        for <linux-s390@vger.kernel.org>; Mon, 11 Mar 2024 02:35:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1710149722; x=1710754522; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XgF85BcnRi6YfuBECKn9LdNVtsda3wFJUMkfKzYPaTg=;
        b=gMaLG/p9jve5U6qy2DPai3S/xKuCYtdcfFyuaDSRhb/D27dQXnjbSGHAIXQwoVhz/7
         T+nPgf4Cjo822sHZKZ5OCbd6nWB/p0bw8m6yZ0n0W9FMETdjGfeK7SHbKVtNXbuAJR3r
         ekR5KdAI3wNNzHfX24AKItj4RwdXa2wSb6kuddxPmBNLIzOTtvM4FYvCxUzCvJiVSY3o
         ikw3yhg8n/hpZyLDusY2hnqMDz7nlmTv3HjRe4ffEYANe33t0O1WvEg1OmfP0b3OcCVB
         PIzCCnCQ+tpV0EDn9WpWA2386rMybvs9uM6fR7jDS6GinliDrMMK+SV13WGPr5/lHZiB
         qe/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710149722; x=1710754522;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XgF85BcnRi6YfuBECKn9LdNVtsda3wFJUMkfKzYPaTg=;
        b=KDQqdQBVIlysn3IkGuOV6CKNAes83Dg3yZF+xgw6fc8ANq150OcvhWtynsN5q6J32C
         melOQkhZBoUu+u3FEIRbnRr3lLVPQ4nM889M5jadZ/lxiRBK3kq6sovbNlnd1yc+Us+x
         R+ex5WPwgrKjBGeHtVkOnv0sHOS+MqqDKyj81wLjMCH38SIqw+z/8ZM8WdMroWjuLTAC
         AmZ1cUFrVuMxtjem4iZN08e8RTM53XlEn3mvN57jv4jxq7O5GABNvAUi3mxgaDce3uqK
         dJ/WXhyeSyWKmsgGZlGBj6EKb8miS9H+tE+Cvy3VkhTOuEgjNZcMhjrKjdLJcPKy1b7J
         G7BQ==
X-Forwarded-Encrypted: i=1; AJvYcCVUoOUzQSlky64nnmuBD/3oIbyv+45JsmWE5k3u7SiN2obkjd36pOZnJVDo+C4IoHvCyRWPjhDg6Fz88X/lI2w5oIgoDm1G5OBF6Q==
X-Gm-Message-State: AOJu0YwGZzNLbYExMzSdII6bqcGTaAy3x7K9RagsCKoBOjOz6FW01EHo
	ubEJ3CWT15CmoEiccVHCMZelqplMLwyjgrO83YP4QuBrzAFZxc8Af/Fl/U53FV0=
X-Google-Smtp-Source: AGHT+IFGOb1BTeFqqztsZqYiXrANUPvsqRtIr4BKGzv55kaAP5codanubKYDi1f1h+yfBwPdORvCXA==
X-Received: by 2002:a05:6a20:3944:b0:1a1:6c19:a175 with SMTP id r4-20020a056a20394400b001a16c19a175mr8143881pzg.8.1710149721824;
        Mon, 11 Mar 2024 02:35:21 -0700 (PDT)
Received: from localhost.localdomain ([43.129.25.208])
        by smtp.gmail.com with ESMTPSA id h9-20020a170902f7c900b001dcad9cbf8bsm4253365plw.239.2024.03.11.02.35.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Mar 2024 02:35:21 -0700 (PDT)
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
Subject: [PATCH bpf-next v2 7/9] libbpf: don't free btf if program of multi-link tracing existing
Date: Mon, 11 Mar 2024 17:35:24 +0800
Message-Id: <20240311093526.1010158-8-dongmenglong.8@bytedance.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240311093526.1010158-1-dongmenglong.8@bytedance.com>
References: <20240311093526.1010158-1-dongmenglong.8@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

By default, the kernel btf that we load during loading program will be
freed after the programs are loaded in bpf_object_load(). However, we
still need to use these btf for tracing of multi-link during attaching.
Therefore, we don't free the btfs until the bpf object is closed if any
bpf programs of the type multi-link tracing exist.

Meanwhile, introduce the new api bpf_object__free_btf() to manually free
the btfs after attaching.

Signed-off-by: Menglong Dong <dongmenglong.8@bytedance.com>
---
 tools/lib/bpf/libbpf.c   | 47 ++++++++++++++++++++++++++++++----------
 tools/lib/bpf/libbpf.h   |  2 ++
 tools/lib/bpf/libbpf.map |  1 +
 3 files changed, 38 insertions(+), 12 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 567ad367e7aa..fd5428494a7e 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -8267,6 +8267,39 @@ static int bpf_object_prepare_struct_ops(struct bpf_object *obj)
 	return 0;
 }
 
+void bpf_object__free_btfs(struct bpf_object *obj)
+{
+	int i;
+
+	/* clean up module BTFs */
+	for (i = 0; i < obj->btf_module_cnt; i++) {
+		close(obj->btf_modules[i].fd);
+		btf__free(obj->btf_modules[i].btf);
+		free(obj->btf_modules[i].name);
+	}
+	free(obj->btf_modules);
+	obj->btf_modules = NULL;
+	obj->btf_module_cnt = 0;
+
+	/* clean up vmlinux BTF */
+	btf__free(obj->btf_vmlinux);
+	obj->btf_vmlinux = NULL;
+}
+
+static void bpf_object_early_free_btf(struct bpf_object *obj)
+{
+	struct bpf_program *prog;
+
+	bpf_object__for_each_program(prog, obj) {
+		if (prog->expected_attach_type == BPF_TRACE_FENTRY_MULTI ||
+		    prog->expected_attach_type == BPF_TRACE_FEXIT_MULTI ||
+		    prog->expected_attach_type == BPF_MODIFY_RETURN_MULTI)
+			return;
+	}
+
+	bpf_object__free_btfs(obj);
+}
+
 static int bpf_object_load(struct bpf_object *obj, int extra_log_level, const char *target_btf_path)
 {
 	int err, i;
@@ -8307,18 +8340,7 @@ static int bpf_object_load(struct bpf_object *obj, int extra_log_level, const ch
 	/* clean up fd_array */
 	zfree(&obj->fd_array);
 
-	/* clean up module BTFs */
-	for (i = 0; i < obj->btf_module_cnt; i++) {
-		close(obj->btf_modules[i].fd);
-		btf__free(obj->btf_modules[i].btf);
-		free(obj->btf_modules[i].name);
-	}
-	free(obj->btf_modules);
-
-	/* clean up vmlinux BTF */
-	btf__free(obj->btf_vmlinux);
-	obj->btf_vmlinux = NULL;
-
+	bpf_object_early_free_btf(obj);
 	obj->loaded = true; /* doesn't matter if successfully or not */
 
 	if (err)
@@ -8791,6 +8813,7 @@ void bpf_object__close(struct bpf_object *obj)
 	usdt_manager_free(obj->usdt_man);
 	obj->usdt_man = NULL;
 
+	bpf_object__free_btfs(obj);
 	bpf_gen__free(obj->gen_loader);
 	bpf_object__elf_finish(obj);
 	bpf_object_unload(obj);
diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
index 5723cbbfcc41..c41a909ea4c1 100644
--- a/tools/lib/bpf/libbpf.h
+++ b/tools/lib/bpf/libbpf.h
@@ -299,6 +299,8 @@ LIBBPF_API struct bpf_program *
 bpf_object__find_program_by_name(const struct bpf_object *obj,
 				 const char *name);
 
+LIBBPF_API void bpf_object__free_btfs(struct bpf_object *obj);
+
 LIBBPF_API int
 libbpf_prog_type_by_name(const char *name, enum bpf_prog_type *prog_type,
 			 enum bpf_attach_type *expected_attach_type);
diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
index 86804fd90dd1..57642b78917f 100644
--- a/tools/lib/bpf/libbpf.map
+++ b/tools/lib/bpf/libbpf.map
@@ -413,4 +413,5 @@ LIBBPF_1.4.0 {
 		bpf_token_create;
 		btf__new_split;
 		btf_ext__raw_data;
+		bpf_object__free_btfs;
 } LIBBPF_1.3.0;
-- 
2.39.2


