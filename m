Return-Path: <linux-s390+bounces-2465-lists+linux-s390=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 603A2877D0C
	for <lists+linux-s390@lfdr.de>; Mon, 11 Mar 2024 10:38:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 83FB51C20FDF
	for <lists+linux-s390@lfdr.de>; Mon, 11 Mar 2024 09:38:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B4E53D388;
	Mon, 11 Mar 2024 09:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="IJw1BOVE"
X-Original-To: linux-s390@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30D6B3E499
	for <linux-s390@vger.kernel.org>; Mon, 11 Mar 2024 09:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710149734; cv=none; b=U8yHwdTtAr/IqvaNSaeLBGMs/gt5u8aBbodPuS3Yy5ibMnb+ROZF9iHGL0GTLgKEhZT3vQiyJH83S9Ju9bpebFPHrL2ILbzn4rxW3Onau0BvT1DVL/uzC+yllQcv4x7BvqneTJMBGDQJuw3GBPswjFMljTQ1jNy8OgE/6jFc7hY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710149734; c=relaxed/simple;
	bh=ibzml+PzSFzKH42zzI5+IahEHBtbwOKK2hMI0h78KBM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GQwCrTSsh4h+xqRzmXIag99u1abQPV+RzqdHEHqerxq6Rq6qPpPxkmPJy868migD8yrbUUO3hMcWaZjNS4jfpkFEPtlyUTbxPPFIJeS/18Qhka0jbQrh00K//TuG8/YkyfgPHcRInb310HTX/8RzjK9Exvlj8yOOHcYK+mF+R8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=IJw1BOVE; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1dc96f64c10so31670695ad.1
        for <linux-s390@vger.kernel.org>; Mon, 11 Mar 2024 02:35:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1710149731; x=1710754531; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JFf08lEs3m84/dbvV4ZlLUOMjMFpJvm5xegIfbyJ9HU=;
        b=IJw1BOVEKlp2EdC5OdG9+ILZTcu8cTvJvjCj56vkSBEDC3OZrC7HF3TOVTr+vFIiq4
         FSIvwTwJlo1In9aEsOEp+lPbCVGRKr78CMgSnTgggi46BE3Lhj5i5GtVpgGjfsADGSnO
         Kf4dR0pU6Bf8V8TXsn+cyi5IE3GMaJ8C2COzMosFZSuXJPDhkiGJXPznCFJRvIeTa1cL
         CngqTNIQRxBl/7yQZ3xFFqBH95DBKK0oaklwawrBmD5gyjh6i798cJofSmslddv0URsh
         fw1mGBkYfMIR4nBibl2QlMk0dAY8QvpgvIYpQObYYRM5fnI4GW2WbaG8IZufYBxTjIeT
         vf0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710149731; x=1710754531;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JFf08lEs3m84/dbvV4ZlLUOMjMFpJvm5xegIfbyJ9HU=;
        b=RFu3X+GaKUrnunumRK4xVBhkr6twMt+aU9Nc7aoRLEPd/AdX8ZmI9EXZbURF9aBJ1M
         uz70YIVQp8jZuXJDy/uaNHjlfb60oetEdIimE6i4wvZqnz+q6QDfFTGZ82YhwCPOdF6W
         BuAMR9T2PamMxH15G5R4oj9zJ24YsBHZBk2i49WGY+IBbNAKpT59oVRDOl57/cWqoo//
         Xq8AJiGxfPE+NwEj0M56kXUzPicEiw5KqaZRuaSgsPhn5ErJwm/lKyDS+eeyn5psN/Et
         wkyKKNeiOgapEnl8tzO3qurMXL9Uut7ZvXkvCyO4YDAlnUlMrpfezBdr6WQAyIrcLp0R
         PRgQ==
X-Forwarded-Encrypted: i=1; AJvYcCVtZFXS5QgUZBtTTrLZffNfEvzwTPZr4PIP3t+Gr2cJ8184INr+uWaov237zhtdXv8/Yi6Q+oEqbwJeALKcI1emSNxdYbRs8rxbBw==
X-Gm-Message-State: AOJu0YxMA2UMRQH98dWrcbif+r/MsoB16piHaxWxARel6REVUq5bGYQ7
	xq3MFuFh4SLzJbwPX86i6hokQkO1Lv2wCbWbOnaZR1xbFDQBdWd6A5FuuOepuQQ=
X-Google-Smtp-Source: AGHT+IFQIVN/SFlbgP5cEEuZ7moW9KP5l9jB6qy51la06bqNfTxjZ7YG5WDDYrE2U6yDVhQ3L+9Yxw==
X-Received: by 2002:a17:902:988c:b0:1dd:772e:d504 with SMTP id s12-20020a170902988c00b001dd772ed504mr4091891plp.66.1710149729346;
        Mon, 11 Mar 2024 02:35:29 -0700 (PDT)
Received: from localhost.localdomain ([43.129.25.208])
        by smtp.gmail.com with ESMTPSA id h9-20020a170902f7c900b001dcad9cbf8bsm4253365plw.239.2024.03.11.02.35.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Mar 2024 02:35:29 -0700 (PDT)
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
Subject: [PATCH bpf-next v2 8/9] libbpf: add support for the multi-link of tracing
Date: Mon, 11 Mar 2024 17:35:25 +0800
Message-Id: <20240311093526.1010158-9-dongmenglong.8@bytedance.com>
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

Add support for the attach types of:

BPF_TRACE_FENTRY_MULTI
BPF_TRACE_FEXIT_MULTI
BPF_MODIFY_RETURN_MULTI

Signed-off-by: Menglong Dong <dongmenglong.8@bytedance.com>
---
 tools/bpf/bpftool/common.c |   3 +
 tools/lib/bpf/bpf.c        |  10 +++
 tools/lib/bpf/bpf.h        |   6 ++
 tools/lib/bpf/libbpf.c     | 168 ++++++++++++++++++++++++++++++++++++-
 tools/lib/bpf/libbpf.h     |  14 ++++
 tools/lib/bpf/libbpf.map   |   1 +
 6 files changed, 199 insertions(+), 3 deletions(-)

diff --git a/tools/bpf/bpftool/common.c b/tools/bpf/bpftool/common.c
index cc6e6aae2447..ffc85256671d 100644
--- a/tools/bpf/bpftool/common.c
+++ b/tools/bpf/bpftool/common.c
@@ -1089,6 +1089,9 @@ const char *bpf_attach_type_input_str(enum bpf_attach_type t)
 	case BPF_TRACE_FENTRY:			return "fentry";
 	case BPF_TRACE_FEXIT:			return "fexit";
 	case BPF_MODIFY_RETURN:			return "mod_ret";
+	case BPF_TRACE_FENTRY_MULTI:		return "fentry_multi";
+	case BPF_TRACE_FEXIT_MULTI:		return "fexit_multi";
+	case BPF_MODIFY_RETURN_MULTI:		return "mod_ret_multi";
 	case BPF_SK_REUSEPORT_SELECT:		return "sk_skb_reuseport_select";
 	case BPF_SK_REUSEPORT_SELECT_OR_MIGRATE:	return "sk_skb_reuseport_select_or_migrate";
 	default:	return libbpf_bpf_attach_type_str(t);
diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
index 97ec005c3c47..63d4734dbae4 100644
--- a/tools/lib/bpf/bpf.c
+++ b/tools/lib/bpf/bpf.c
@@ -793,6 +793,16 @@ int bpf_link_create(int prog_fd, int target_fd,
 		if (!OPTS_ZEROED(opts, tracing))
 			return libbpf_err(-EINVAL);
 		break;
+	case BPF_TRACE_FENTRY_MULTI:
+	case BPF_TRACE_FEXIT_MULTI:
+	case BPF_MODIFY_RETURN_MULTI:
+		attr.link_create.tracing_multi.btf_ids = ptr_to_u64(OPTS_GET(opts, tracing_multi.btf_ids, 0));
+		attr.link_create.tracing_multi.tgt_fds = ptr_to_u64(OPTS_GET(opts, tracing_multi.tgt_fds, 0));
+		attr.link_create.tracing_multi.cookies = ptr_to_u64(OPTS_GET(opts, tracing_multi.cookies, 0));
+		attr.link_create.tracing_multi.cnt = OPTS_GET(opts, tracing_multi.cnt, 0);
+		if (!OPTS_ZEROED(opts, tracing_multi))
+			return libbpf_err(-EINVAL);
+		break;
 	case BPF_NETFILTER:
 		attr.link_create.netfilter.pf = OPTS_GET(opts, netfilter.pf, 0);
 		attr.link_create.netfilter.hooknum = OPTS_GET(opts, netfilter.hooknum, 0);
diff --git a/tools/lib/bpf/bpf.h b/tools/lib/bpf/bpf.h
index df0db2f0cdb7..e28c88d6cfa4 100644
--- a/tools/lib/bpf/bpf.h
+++ b/tools/lib/bpf/bpf.h
@@ -419,6 +419,12 @@ struct bpf_link_create_opts {
 		struct {
 			__u64 cookie;
 		} tracing;
+		struct {
+			__u32 cnt;
+			const __u32 *btf_ids;
+			const __u32 *tgt_fds;
+			const __u64 *cookies;
+		} tracing_multi;
 		struct {
 			__u32 pf;
 			__u32 hooknum;
diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index fd5428494a7e..821214774941 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -132,6 +132,9 @@ static const char * const attach_type_name[] = {
 	[BPF_TRACE_UPROBE_MULTI]	= "trace_uprobe_multi",
 	[BPF_NETKIT_PRIMARY]		= "netkit_primary",
 	[BPF_NETKIT_PEER]		= "netkit_peer",
+	[BPF_TRACE_FENTRY_MULTI]	= "trace_fentry_multi",
+	[BPF_TRACE_FEXIT_MULTI]		= "trace_fexit_multi",
+	[BPF_MODIFY_RETURN_MULTI]	= "modify_return_multi",
 };
 
 static const char * const link_type_name[] = {
@@ -381,6 +384,8 @@ enum sec_def_flags {
 	SEC_XDP_FRAGS = 16,
 	/* Setup proper attach type for usdt probes. */
 	SEC_USDT = 32,
+	/* attachment target is multi-link */
+	SEC_ATTACH_BTF_MULTI = 64,
 };
 
 struct bpf_sec_def {
@@ -7160,9 +7165,9 @@ static int libbpf_prepare_prog_load(struct bpf_program *prog,
 	if ((def & SEC_USDT) && kernel_supports(prog->obj, FEAT_UPROBE_MULTI_LINK))
 		prog->expected_attach_type = BPF_TRACE_UPROBE_MULTI;
 
-	if ((def & SEC_ATTACH_BTF) && !prog->attach_btf_id) {
+	if ((def & (SEC_ATTACH_BTF | SEC_ATTACH_BTF_MULTI)) && !prog->attach_btf_id) {
 		int btf_obj_fd = 0, btf_type_id = 0, err;
-		const char *attach_name;
+		const char *attach_name, *name_end;
 
 		attach_name = strchr(prog->sec_name, '/');
 		if (!attach_name) {
@@ -7181,7 +7186,27 @@ static int libbpf_prepare_prog_load(struct bpf_program *prog,
 		}
 		attach_name++; /* skip over / */
 
-		err = libbpf_find_attach_btf_id(prog, attach_name, &btf_obj_fd, &btf_type_id);
+		name_end = strchr(attach_name, ',');
+		/* for multi-link tracing, use the first target symbol during
+		 * loading.
+		 */
+		if ((def & SEC_ATTACH_BTF_MULTI) && name_end) {
+			int len = name_end - attach_name + 1;
+			char *first_tgt;
+
+			first_tgt = malloc(len);
+			if (!first_tgt)
+				return -ENOMEM;
+			strncpy(first_tgt, attach_name, len);
+			first_tgt[len - 1] = '\0';
+			err = libbpf_find_attach_btf_id(prog, first_tgt, &btf_obj_fd,
+							&btf_type_id);
+			free(first_tgt);
+		} else {
+			err = libbpf_find_attach_btf_id(prog, attach_name, &btf_obj_fd,
+							&btf_type_id);
+		}
+
 		if (err)
 			return err;
 
@@ -9149,6 +9174,7 @@ static int attach_kprobe_multi(const struct bpf_program *prog, long cookie, stru
 static int attach_uprobe_multi(const struct bpf_program *prog, long cookie, struct bpf_link **link);
 static int attach_lsm(const struct bpf_program *prog, long cookie, struct bpf_link **link);
 static int attach_iter(const struct bpf_program *prog, long cookie, struct bpf_link **link);
+static int attach_trace_multi(const struct bpf_program *prog, long cookie, struct bpf_link **link);
 
 static const struct bpf_sec_def section_defs[] = {
 	SEC_DEF("socket",		SOCKET_FILTER, 0, SEC_NONE),
@@ -9192,6 +9218,13 @@ static const struct bpf_sec_def section_defs[] = {
 	SEC_DEF("fentry.s+",		TRACING, BPF_TRACE_FENTRY, SEC_ATTACH_BTF | SEC_SLEEPABLE, attach_trace),
 	SEC_DEF("fmod_ret.s+",		TRACING, BPF_MODIFY_RETURN, SEC_ATTACH_BTF | SEC_SLEEPABLE, attach_trace),
 	SEC_DEF("fexit.s+",		TRACING, BPF_TRACE_FEXIT, SEC_ATTACH_BTF | SEC_SLEEPABLE, attach_trace),
+	SEC_DEF("tp_btf+",		TRACING, BPF_TRACE_RAW_TP, SEC_ATTACH_BTF, attach_trace),
+	SEC_DEF("fentry.multi+",	TRACING, BPF_TRACE_FENTRY_MULTI, SEC_ATTACH_BTF_MULTI, attach_trace_multi),
+	SEC_DEF("fmod_ret.multi+",	TRACING, BPF_MODIFY_RETURN_MULTI, SEC_ATTACH_BTF_MULTI, attach_trace_multi),
+	SEC_DEF("fexit.multi+",		TRACING, BPF_TRACE_FEXIT_MULTI, SEC_ATTACH_BTF_MULTI, attach_trace_multi),
+	SEC_DEF("fentry.multi.s+",	TRACING, BPF_TRACE_FENTRY_MULTI, SEC_ATTACH_BTF_MULTI | SEC_SLEEPABLE, attach_trace_multi),
+	SEC_DEF("fmod_ret.multi.s+",	TRACING, BPF_MODIFY_RETURN_MULTI, SEC_ATTACH_BTF_MULTI | SEC_SLEEPABLE, attach_trace_multi),
+	SEC_DEF("fexit.multi.s+",	TRACING, BPF_TRACE_FEXIT_MULTI, SEC_ATTACH_BTF_MULTI | SEC_SLEEPABLE, attach_trace_multi),
 	SEC_DEF("freplace+",		EXT, 0, SEC_ATTACH_BTF, attach_trace),
 	SEC_DEF("lsm+",			LSM, BPF_LSM_MAC, SEC_ATTACH_BTF, attach_lsm),
 	SEC_DEF("lsm.s+",		LSM, BPF_LSM_MAC, SEC_ATTACH_BTF | SEC_SLEEPABLE, attach_lsm),
@@ -12300,6 +12333,135 @@ static int attach_trace(const struct bpf_program *prog, long cookie, struct bpf_
 	return libbpf_get_error(*link);
 }
 
+struct bpf_link *bpf_program__attach_trace_multi_opts(const struct bpf_program *prog,
+						      const struct bpf_trace_multi_opts *opts)
+{
+	LIBBPF_OPTS(bpf_link_create_opts, link_opts);
+	__u32 *btf_ids = NULL, *tgt_fds = NULL;
+	struct bpf_link *link = NULL;
+	char errmsg[STRERR_BUFSIZE];
+	int prog_fd, pfd, cnt, err;
+
+	if (!OPTS_VALID(opts, bpf_trace_multi_opts))
+		return libbpf_err_ptr(-EINVAL);
+
+	prog_fd = bpf_program__fd(prog);
+	if (prog_fd < 0) {
+		pr_warn("prog '%s': can't attach before loaded\n", prog->name);
+		return libbpf_err_ptr(-EINVAL);
+	}
+
+	cnt = OPTS_GET(opts, cnt, 0);
+	if (opts->syms) {
+		int btf_obj_fd, btf_type_id, i;
+
+		if (opts->btf_ids || opts->tgt_fds) {
+			pr_warn("can set both opts->syms and opts->btf_ids\n");
+			return libbpf_err_ptr(-EINVAL);
+		}
+
+		btf_ids = malloc(sizeof(*btf_ids) * cnt);
+		tgt_fds = malloc(sizeof(*tgt_fds) * cnt);
+		if (!btf_ids || !tgt_fds) {
+			err = -ENOMEM;
+			goto err_free;
+		}
+		for (i = 0; i < cnt; i++) {
+			btf_obj_fd = btf_type_id = 0;
+
+			err = find_kernel_btf_id(prog->obj, opts->syms[i],
+					 prog->expected_attach_type, &btf_obj_fd,
+					 &btf_type_id);
+			if (err)
+				goto err_free;
+			btf_ids[i] = btf_type_id;
+			tgt_fds[i] = btf_obj_fd;
+		}
+		link_opts.tracing_multi.btf_ids = btf_ids;
+		link_opts.tracing_multi.tgt_fds = tgt_fds;
+	} else {
+		link_opts.tracing_multi.btf_ids = OPTS_GET(opts, btf_ids, 0);
+		link_opts.tracing_multi.tgt_fds = OPTS_GET(opts, tgt_fds, 0);
+	}
+
+	link = calloc(1, sizeof(*link));
+	if (!link) {
+		err = -ENOMEM;
+		goto err_free;
+	}
+	link->detach = &bpf_link__detach_fd;
+
+	link_opts.tracing_multi.cookies = OPTS_GET(opts, cookies, 0);
+	link_opts.tracing_multi.cnt = cnt;
+
+	pfd = bpf_link_create(prog_fd, 0, bpf_program__expected_attach_type(prog), &link_opts);
+	if (pfd < 0) {
+		err = -errno;
+		pr_warn("prog '%s': failed to attach: %s\n",
+			prog->name, libbpf_strerror_r(pfd, errmsg, sizeof(errmsg)));
+		goto err_free;
+	}
+	link->fd = pfd;
+
+	free(btf_ids);
+	free(tgt_fds);
+	return link;
+err_free:
+	free(btf_ids);
+	free(tgt_fds);
+	free(link);
+	return libbpf_err_ptr(err);
+}
+
+static int attach_trace_multi(const struct bpf_program *prog, long cookie, struct bpf_link **link)
+{
+	LIBBPF_OPTS(bpf_trace_multi_opts, opts);
+	int i, err, len, cnt = 1;
+	char **syms, *buf, *name;
+	const char *spec;
+
+	spec = strchr(prog->sec_name, '/');
+	if (!spec || !*(++spec))
+		return -EINVAL;
+
+	len = strlen(spec);
+	buf = malloc(len + 1);
+	if (!buf)
+		return -ENOMEM;
+
+	strcpy(buf, spec);
+	for (i = 0; i < len; i++) {
+		if (buf[i] == ',')
+			cnt++;
+	}
+
+	syms = malloc(sizeof(*syms) * cnt);
+	if (!syms) {
+		err = -ENOMEM;
+		goto out_free;
+	}
+
+	opts.syms = (const char **)syms;
+	opts.cnt = cnt;
+	name = buf;
+	err = -EINVAL;
+	while (name) {
+		if (*name == '\0')
+			goto out_free;
+		*(syms++) = name;
+		name = strchr(name, ',');
+		if (name)
+			*(name++) = '\0';
+	}
+
+	*link = bpf_program__attach_trace_multi_opts(prog, &opts);
+	err = libbpf_get_error(*link);
+out_free:
+	free(buf);
+	free(opts.syms);
+	return err;
+}
+
 static int attach_lsm(const struct bpf_program *prog, long cookie, struct bpf_link **link)
 {
 	*link = bpf_program__attach_lsm(prog);
diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
index c41a909ea4c1..9bca44d5adfa 100644
--- a/tools/lib/bpf/libbpf.h
+++ b/tools/lib/bpf/libbpf.h
@@ -790,6 +790,20 @@ bpf_program__attach_xdp(const struct bpf_program *prog, int ifindex);
 LIBBPF_API struct bpf_link *
 bpf_program__attach_freplace(const struct bpf_program *prog,
 			     int target_fd, const char *attach_func_name);
+struct bpf_trace_multi_opts {
+	/* size of this struct, for forward/backward compatibility */
+	size_t sz;
+	const char **syms;
+	__u32 *btf_ids;
+	__u32 *tgt_fds;
+	__u64 *cookies;
+	size_t cnt;
+};
+#define bpf_trace_multi_opts__last_field cnt
+
+LIBBPF_API struct bpf_link *
+bpf_program__attach_trace_multi_opts(const struct bpf_program *prog,
+				     const struct bpf_trace_multi_opts *opts);
 
 struct bpf_netfilter_opts {
 	/* size of this struct, for forward/backward compatibility */
diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
index 57642b78917f..94933898df44 100644
--- a/tools/lib/bpf/libbpf.map
+++ b/tools/lib/bpf/libbpf.map
@@ -414,4 +414,5 @@ LIBBPF_1.4.0 {
 		btf__new_split;
 		btf_ext__raw_data;
 		bpf_object__free_btfs;
+		bpf_program__attach_trace_multi_opts;
 } LIBBPF_1.3.0;
-- 
2.39.2


