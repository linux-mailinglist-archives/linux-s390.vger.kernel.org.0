Return-Path: <linux-s390+bounces-16430-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WP7nKmpunWk9QAQAu9opvQ
	(envelope-from <linux-s390+bounces-16430-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Tue, 24 Feb 2026 10:24:58 +0100
X-Original-To: lists+linux-s390@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id D194B184854
	for <lists+linux-s390@lfdr.de>; Tue, 24 Feb 2026 10:24:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0A0F4304F1BB
	for <lists+linux-s390@lfdr.de>; Tue, 24 Feb 2026 09:22:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A8AB36C0CF;
	Tue, 24 Feb 2026 09:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lVfvXqIR"
X-Original-To: linux-s390@vger.kernel.org
Received: from mail-pl1-f196.google.com (mail-pl1-f196.google.com [209.85.214.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F168C36BCD8
	for <linux-s390@vger.kernel.org>; Tue, 24 Feb 2026 09:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771924958; cv=none; b=Sjj4TmPepLgFBZ2W4mOx6hmyufZVgBYZlGTdEyvo8CYjpUlGZJoPtneebY2fguc68e8HvC07a5GgAsEhc+cAcvPFeSgrbs4nJ195U/tWHyoSFK6bbZD4dSPD1EAjWdiKD5OLw9/Jdh+rK6+otHwiufHT3V0IsRtCp4tnGGKpSzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771924958; c=relaxed/simple;
	bh=//m8dH3bHSjki//i9VjUuOHfUAtffvLarIX5CXsBeds=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KJi7LTR5vIXlPM3vc+YDHEij7bZ/5KksXK6kirER22vZ4A5ZcI+4eaAUeFk/SoQZxvS42FEnHyncj34yyDFGLjTIRsGA9AGueZyIKXSzcCAOkse9lBG7E3wXuqNXtOzuud3GmWToqavQMO2OLdO52HmpPX9t58O//LuD17tKXh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lVfvXqIR; arc=none smtp.client-ip=209.85.214.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f196.google.com with SMTP id d9443c01a7336-2ad20007c73so25041355ad.2
        for <linux-s390@vger.kernel.org>; Tue, 24 Feb 2026 01:22:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771924956; x=1772529756; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dpLKOE0cSQ+70LbrawdOonDNbKPUoXYYa3UgZRxOrKk=;
        b=lVfvXqIR/kNBvdjwiRF/wycVqVRkYyad2JExmTTCItTm+AJ+CvPkRExMgiwTgj7c58
         qygeSR5CjMKa9RNyAxFkKhzdzH2e1rsAjATXbAHX09e65KQZbLdBImChgowNnz+fzTBm
         c3Nq/Yd3uy1yiIHac7JBgwE/KHYdCG6OruP9DBAexv7h0s4FsHSOkpOLw4+afxdRqBme
         9NRd+XI8BqXuD7iKYWOR9oGBCBUZXJaNzSf0WydbWS5QPVC8qrj9W9XJGfV3jh52yqxT
         HnG1KiYTJzWpGXM1anVCq8WAGGWcU9Fm0sNO3TaIrK3Vi6gzdnQBYidsZgnop2WAhVLr
         0JPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771924956; x=1772529756;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dpLKOE0cSQ+70LbrawdOonDNbKPUoXYYa3UgZRxOrKk=;
        b=Dn/gYDu4K1JBDVuvi8kbwCZppQQrDfRIlXQ0pRy5MM2NW3z1fcLY8/xPbxHL6F3SzL
         8rz4f6DHRsN0ty8bKU/3AKyUPpTA4/eLG/vxs9ErXZNvJzA4jA+dLjOc6zFw6j492vky
         BkT6MKOpK2bWv8mU9xiXQaXcm9MSuraiDqkMXn71jynzTnhHKOgrYhto1c9pg9nVkxpX
         rWxruhTE/B4STc3GdDX7DGmHjRZElrsfutMZln4K7sE7QFUcgr3urrH9bJUeh0Ir86RY
         HNxHxxwsrSgpLy20D376wynefcY3XLtM9Vj0wcIheIJ71Efzk9F6nJbLxzBWB9XVA9iH
         kz2Q==
X-Forwarded-Encrypted: i=1; AJvYcCUes0JCl+SsiexK8Qjcs5yPsYG3jlwqYwMBupIbwyIok1R4sOLKwljTRETJkuIeKc2M6SaLcD6zTpcL@vger.kernel.org
X-Gm-Message-State: AOJu0YxYL1Nn1YzLEP+V1PxV7odeywBhryECf0KnWCllbld9stqTfZJ2
	H6MKyPgRifQqNbt3O9SJhsDGdw+Tj+bO1OILEVSQQqsd8tGNmcoURpqa
X-Gm-Gg: ATEYQzzPhfZ32OND77UDk+p44vUv2ArtdtENUmcmJ4xqQgj/A48a7p5ztIt/gjVKzUr
	YQ+CAR5aBEoQoxslMxSMpaD9ibXSB3HSE3S5ga9VxnEd6IQC/2wh5JHg3Z+b9AlADyfRroPZfxx
	91LnrShfgyTCqbYXmW+dVPRbHfGnwzCJ/JJQwptBCwzlUmzjacLBAu7LOF/rjTAECYzp2NnQKLE
	2d1PR5cz1gVWWpEuQoW8xkDwG4pxVCO0ccYW47iyRfE+8MCEprQOOhB1dwB6BC7ywC+FnN/w3TW
	BDi2BmvM983Ic+ZkbFxxkdvJRFYaaBgslns0zf/Jhm7pBGMAfFqbwqd0h9ewcr/ZuztOGTEc5IK
	f8ARgzg8gQ1mj0KCdegVia7BibZmtt7H1IO9AMmP1h16dkCxrGnALetajZZf9Q1Ipl1ADrjBIgI
	B1PAVkDukrfQCc+4Mk2+1j
X-Received: by 2002:a17:902:ecc6:b0:2aa:f469:fa23 with SMTP id d9443c01a7336-2ad74419efemr91872495ad.4.1771924956249;
        Tue, 24 Feb 2026 01:22:36 -0800 (PST)
Received: from 7940hx ([103.173.155.241])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ad7500e2b2sm97181695ad.52.2026.02.24.01.22.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Feb 2026 01:22:35 -0800 (PST)
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
Subject: [PATCH bpf-next v2 1/3] bpf,s390: introduce emit_store_stack_imm64() for trampoline
Date: Tue, 24 Feb 2026 17:22:06 +0800
Message-ID: <20260224092208.1395085-2-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260224092208.1395085-1-dongml2@chinatelecom.cn>
References: <20260224092208.1395085-1-dongml2@chinatelecom.cn>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16430-lists,linux-s390=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,chinatelecom.cn:mid,chinatelecom.cn:email]
X-Rspamd-Queue-Id: D194B184854
X-Rspamd-Action: no action

Introduce a helper to store 64-bit immediate on the trampoline stack with
a help of a register.

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
Acked-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
v2:
- keep LGHI as it was
---
 arch/s390/net/bpf_jit_comp.c | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/arch/s390/net/bpf_jit_comp.c b/arch/s390/net/bpf_jit_comp.c
index 579461d471bb..76c80d75184f 100644
--- a/arch/s390/net/bpf_jit_comp.c
+++ b/arch/s390/net/bpf_jit_comp.c
@@ -2506,6 +2506,13 @@ static void load_imm64(struct bpf_jit *jit, int dst_reg, u64 val)
 	EMIT6_IMM(0xc00d0000, dst_reg, val);
 }
 
+static void emit_store_stack_imm64(struct bpf_jit *jit, int tmp_reg, int stack_off, u64 imm)
+{
+	load_imm64(jit, tmp_reg, imm);
+	/* stg %tmp_reg,stack_off(%r15) */
+	EMIT6_DISP_LH(0xe3000000, 0x0024, tmp_reg, REG_0, REG_15, stack_off);
+}
+
 static int invoke_bpf_prog(struct bpf_tramp_jit *tjit,
 			   const struct btf_func_model *m,
 			   struct bpf_tramp_link *tlink, bool save_ret)
@@ -2520,10 +2527,7 @@ static int invoke_bpf_prog(struct bpf_tramp_jit *tjit,
 	 * run_ctx.cookie = tlink->cookie;
 	 */
 
-	/* %r0 = tlink->cookie */
-	load_imm64(jit, REG_W0, tlink->cookie);
-	/* stg %r0,cookie_off(%r15) */
-	EMIT6_DISP_LH(0xe3000000, 0x0024, REG_W0, REG_0, REG_15, cookie_off);
+	emit_store_stack_imm64(jit, REG_W0, cookie_off, tlink->cookie);
 
 	/*
 	 * if ((start = __bpf_prog_enter(p, &run_ctx)) == 0)
@@ -2743,13 +2747,8 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im,
 	 * arg_cnt = m->nr_args;
 	 */
 
-	if (flags & BPF_TRAMP_F_IP_ARG) {
-		/* %r0 = func_addr */
-		load_imm64(jit, REG_0, (u64)func_addr);
-		/* stg %r0,ip_off(%r15) */
-		EMIT6_DISP_LH(0xe3000000, 0x0024, REG_0, REG_0, REG_15,
-			      tjit->ip_off);
-	}
+	if (flags & BPF_TRAMP_F_IP_ARG)
+		emit_store_stack_imm64(jit, REG_0, tjit->ip_off, (u64)func_addr);
 	/* lghi %r0,nr_bpf_args */
 	EMIT4_IMM(0xa7090000, REG_0, nr_bpf_args);
 	/* stg %r0,arg_cnt_off(%r15) */
-- 
2.53.0


