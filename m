Return-Path: <linux-s390+bounces-21124-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id cG2eGzMZOmq71QcAu9opvQ
	(envelope-from <linux-s390+bounces-21124-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Tue, 23 Jun 2026 07:27:15 +0200
X-Original-To: lists+linux-s390@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BC0E66B42C3
	for <lists+linux-s390@lfdr.de>; Tue, 23 Jun 2026 07:27:14 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=fpkGsgiY;
	spf=pass (mail.lfdr.de: domain of "linux-s390+bounces-21124-lists+linux-s390=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-s390+bounces-21124-lists+linux-s390=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 89762303C00D
	for <lists+linux-s390@lfdr.de>; Tue, 23 Jun 2026 05:26:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A8EF3A8FF6;
	Tue, 23 Jun 2026 05:26:06 +0000 (UTC)
X-Original-To: linux-s390@vger.kernel.org
Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 036303A8758
	for <linux-s390@vger.kernel.org>; Tue, 23 Jun 2026 05:26:04 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782192366; cv=none; b=qlQ1ORb80UMcAMnEf4ymPXrby+Ig1V0ncUhhVPyX6BqVsfmLdeV6cYFRnxY8M1RnDe0GHWOPm5FRjORcSzrSFpdKhjJwaQJjxIs9rM55uPKuVLUY5HO22LYs7l6JyFm0YpljJUIE/nYwPzSQ/K1tCoFCLKEOWrQrC2HWDF7Jcok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782192366; c=relaxed/simple;
	bh=zWdKKKHIRtfVkf/fFEjrVdv3jvJPJQtdRvuIlBkFkhk=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=Gs1Y7Tqp4lD/bAn52KgX6bOFy37s7Ve/t1DE2bk1FOa/PcbKkViVLq+/oZPwgpktcam36XJvOk8saFr4r1zADLOJ4Ab40kPPC1M669GygmStpm2JFcWXf5NbxlWBcchctLnvL5O41o48ghCIQ3idt25APk+NnPN0wjkFhGdro08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fpkGsgiY; arc=none smtp.client-ip=74.125.82.170
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-30bc871ecdfso6164231eec.1
        for <linux-s390@vger.kernel.org>; Mon, 22 Jun 2026 22:26:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782192364; x=1782797164; darn=vger.kernel.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9P+/X0AgS9w9pvMplF3SoP81B1eDd+b9FueSg0/UkAs=;
        b=fpkGsgiYTuT33XwJK6vBndFtBq3BnK+gYXsqdqkQ5M5Dmtzb//vqRW+nLE+VVLax0z
         GSf/RdVDwMujApK6MQb7bBKhurWXk9EwBoburqVSvPCcQqZMf/EI0BNCJeKZRj8z8OHr
         F8PafNHCVMkFrje/cEYMU1elBDXJaW5yprLLf5QsCNt1en6NgoTrrpWhIZuIVIZyFTAc
         0eShmLfxF5JZ+SOJyVko+LXLQvcGpre+hsbilB9bKwBsBi9b3AGOgM0omkIJCID91K5l
         5MF5VkRnlVKt7XUP7eTP1n5RpCaPv222/T2d5BeX8BFZCETr1aS9iPWoKdwlpiZbuIWH
         i2Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782192364; x=1782797164;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9P+/X0AgS9w9pvMplF3SoP81B1eDd+b9FueSg0/UkAs=;
        b=SWlQLuRzkk4npFicWUvZO1buVaYfnbK3t7rYMhffqcoGgSaoZCdqj59JYQBzJ3ksPt
         bsqHH4ztBOdEBjEN0ebsfnrGgF8xtAVGhGObjgbpWAAmWvYyxGqOWkjvyvpBDPmOP2kv
         Cj2jTpFTKiXZMYc2suYWwrRgDjOpb75fJAvEV04PThqDteR9FqsGdsftX9kvk7NJEUhD
         1rJmiloOAPE4t/U96Q3LpoJbpvgXIH+O3H8QuUEG5fFPPH7LAGEccW3Yn8KC6a9axQrG
         Qb8iVsKcoJjcswAPknD72BC0nWImMMjkZQEW1F0qUiR/D+N2Fm5zFFPuPh6bydEBm0uU
         g+ug==
X-Forwarded-Encrypted: i=1; AHgh+Rpp8Gz9ghkYaOwPRg9z/t0AeQQHYzfcH7RVv7b8xsbGi1syWceEdG9z2uHqXnpPjrbhUrqtMhFixBHz@vger.kernel.org
X-Gm-Message-State: AOJu0Yyvtepswcov1XzprjDZSg3hQTYGzmYZtjr48apmiZm4vtGyorC8
	z+IE7ss3mX1dY1DdbIULsOduAXtUYn8rEXYthXMwBtJ0PuGZXWugXzeM
X-Gm-Gg: AfdE7clUJCqV0Ba+VEqzHRH4jZn62icBJOHAgKcVaB09eEr4iAcdfxPEnUm9rMUZOhG
	9nr8JeuxzyXMphlKr0wti+G4gPYFlrOBz3RJpIywD7O61o9TUnJ68GunWe0jyPNwmB3mjh/QdLi
	cOgRB628VCEu4mpxQw0wbgYD7FyRUVLIXvhjhY0Diiw66MNbApdT1s1E0oOy19JQAwjkIaa+l88
	eEgGli5k6oI/Y9eBHa14UANliRQ7QKcUjjZKRQnrA9hjBSGHVWVdaGn4KdhC6uGLNOUy4OEZ9eZ
	kFAT83AXqk+HVLKMXcywZnDgrQ6UpM+Cd+pZz/8Llf3y2CigbVs3YkpgwWvWe4STmY4zA3uuoU+
	Ii0bVrnwMoKlesGUpRQlIDzlTaYGPfu9sLG5AsXTrWqK1SPH3RIFyIPxHVs1DsD3asGiebPIziK
	OKkBzedOnx8byn/gwYRQ==
X-Received: by 2002:a05:7301:3c8d:b0:2ef:83d4:647f with SMTP id 5a478bee46e88-30c07035e2fmr11143910eec.25.1782192363998;
        Mon, 22 Jun 2026 22:26:03 -0700 (PDT)
Received: from [10.0.0.65] ([2601:647:6700:64d0::92d1])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30c1be4967fsm13102455eec.26.2026.06.22.22.26.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2026 22:26:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v4 3/8] arm64/runtime-const: Introduce
 runtime_const_mask_32()
From: Charlie Jenkins <thecharlesjenkins@gmail.com>
To: K Prateek Nayak <kprateek.nayak@amd.com>
Cc: Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
 Peter Zijlstra <peterz@infradead.org>, 
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
 Darren Hart <dvhart@infradead.org>, Davidlohr Bueso <dave@stgolabs.net>, 
 =?utf-8?q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>, 
 linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-s390@vger.kernel.org, linux-riscv@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, Jisheng Zhang <jszhang@kernel.org>
In-Reply-To: <20260430094730.31624-4-kprateek.nayak@amd.com>
References: <20260430094730.31624-1-kprateek.nayak@amd.com>
 <20260430094730.31624-4-kprateek.nayak@amd.com>
Date: Mon, 22 Jun 2026 22:24:56 -0700
Message-Id: <178219229641.10927.2049980053557313152.b4-review@b4>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782192362; l=1037;
 i=thecharlesjenkins@gmail.com; s=20260605; h=from:subject:message-id;
 bh=zWdKKKHIRtfVkf/fFEjrVdv3jvJPJQtdRvuIlBkFkhk=;
 b=khN498z1aQ+psInrw6bQE5qRH/XIMR5tlYyp2iaj4Ympn7B3JrTIKQzNY2a80lC+XUaqLeiEQ
 hj75XonHxMsDBmZroa63UpdTmgS+Vn0VIF2BvLYDbWtudqioAYh6PlP
X-Developer-Key: i=thecharlesjenkins@gmail.com; a=ed25519;
 pk=ajnnRQ98PIdwKp4HeMkq9U32okYbnh6Zb4G3o5XXvkg=
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[thecharlesjenkins@gmail.com,linux-s390@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:kprateek.nayak@amd.com,m:tglx@kernel.org,m:mingo@redhat.com,m:peterz@infradead.org,m:bigeasy@linutronix.de,m:catalin.marinas@arm.com,m:will@kernel.org,m:dvhart@infradead.org,m:dave@stgolabs.net,m:andrealmeid@igalia.com,m:linux-arch@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-s390@vger.kernel.org,m:linux-riscv@lists.infradead.org,m:linux-arm-kernel@lists.infradead.org,m:jszhang@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21124-lists,linux-s390=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[thecharlesjenkins@gmail.com,linux-s390@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-s390];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: BC0E66B42C3

On Thu, 30 Apr 2026 09:47:25 +0000, K Prateek Nayak <kprateek.nayak@amd.com> wrote:
> [...]
> is intentiaonally placed outside of asm block to allow compilers to
> further optimize it if possible.
> 
> __runtime_fixup_ptr() already patches a "movz, + movk lsl #16" sequence
> which has been reused to patch the same sequence for
> __runtime_fixup_mask().

I think we should opt to do power of 2 masks instead of arbitrary masks
since that is what the usecase is and we can reduce these three
instructions into a single instruction for arm (and benefit riscv as
well). It is convenient to have this function as arbitrary masks, but
since we are going down the route of hyper optimizations already with
runtime constants here (and we can always add an arbitrary mask later if
there becomes a usecase), I feel like we should go all the way :)

The and immediate instruction for arm supports all power of 2 masks so
you can do:

and     w0, w0, #0xMASK

- Charlie

-- 
Charlie Jenkins <thecharlesjenkins@gmail.com>

