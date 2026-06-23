Return-Path: <linux-s390+bounces-21125-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id IoI2OUsZOmq/1QcAu9opvQ
	(envelope-from <linux-s390+bounces-21125-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Tue, 23 Jun 2026 07:27:39 +0200
X-Original-To: lists+linux-s390@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4317D6B42C9
	for <lists+linux-s390@lfdr.de>; Tue, 23 Jun 2026 07:27:39 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b="mYcGli/P";
	spf=pass (mail.lfdr.de: domain of "linux-s390+bounces-21125-lists+linux-s390=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-s390+bounces-21125-lists+linux-s390=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 286F13066195
	for <lists+linux-s390@lfdr.de>; Tue, 23 Jun 2026 05:26:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A9113A9625;
	Tue, 23 Jun 2026 05:26:08 +0000 (UTC)
X-Original-To: linux-s390@vger.kernel.org
Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF7093A9612
	for <linux-s390@vger.kernel.org>; Tue, 23 Jun 2026 05:26:06 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782192368; cv=none; b=LU8jBY4XInwu9NF75DAOQ1jNNd5s5DdxlP4x52Mcke2IZkwE6k9HN75qx1yXpEDrUIXOs08H94S6smz5WfTdH8BUAcOj5r6Iyxx1hhs/C5JBNcPYORNy7eJlBu2iVG6rR+ntXvfLFs0VU7GztijdA0NRxraYaRms1v45lP9Mo9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782192368; c=relaxed/simple;
	bh=n+I3lxePERllHyfwEWyDEAhZnniet1N62LffQ9iv1A4=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=eLDWuPe/sb7nwj1B8fyRqeU/8mxzfxxgxLP+NgXY6xKnEiF+f21f6Ad5T89nDjKE7g8extjtAzpu5O0yUP3FuzpdPM5JhbGQyRK98vk/OM2YmJZ8A+9VU7R6AADbbhzgGyIyoRLNY9EJA1U4wUYzWZDh22vs79wXoHrodp51fCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mYcGli/P; arc=none smtp.client-ip=74.125.82.180
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-3078e0dcd67so6170872eec.0
        for <linux-s390@vger.kernel.org>; Mon, 22 Jun 2026 22:26:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782192366; x=1782797166; darn=vger.kernel.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=euxUr99gVRmTKzYrxOsYTZTBpKcYj3aY+Du6bnH69fU=;
        b=mYcGli/P1lJ69hPdMg+UpqSD8tXOmM95KZ2M03D4tDHK9HJBW6oa723omPDh/LDHLT
         HaP305+JZb1qBBLghQTd2fIl/DlV+5kVPnKgQ9ggaJBhEQPMeV121rcAWMqpMJVmBBGQ
         lwqw2u0Z6WCJdD1bNVENJOEP4kEw966Y72KsovZrO4ODgjYMIgK50eZHg2l23IaxwlKX
         4hw3/qdl+qg0WLA6wz4X7x6MrlSMk2Q4crfX4UvzrBPy6mqHxTurizOUkyQV0V8Hlz7o
         1U0uGtyr3IiNVPiy+4KCLJH8s+MRlBSl3YdnxqEvqCQy/IMrAWfI3AKr1JXlyk2IYzf9
         qTsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782192366; x=1782797166;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=euxUr99gVRmTKzYrxOsYTZTBpKcYj3aY+Du6bnH69fU=;
        b=BoL5PMge4sNRinzO4oM6fYUEKgEXib3g6dddwFIQ2b93MnQ0jocJo4O8p4MClzOab2
         98FsK4gm+bSRboigy6NEKxJk2osooaVk9aQx2WLB/F1K/tccIKVHB1itm+KzBhT27pyS
         7KvXWihhP/mgfbZfkTj14fQ6MrEByznzD0wJqUYjaj3dlBJZUFPmk2czKEtPSq3cwHsr
         q5LLi7BzysXVs58NFvrt6KGD4aeamnZD8L6vB9Ur+JLjsOIz6IPtficYeiRkxwJzN8NU
         XWBDJZ273eSKcBQKxqwZ5KE24hrfN8fK6fRcBrkVj5SRUGRFFuexqCvZKKY+dN21ObyX
         VdWw==
X-Forwarded-Encrypted: i=1; AHgh+RqpHdlnw4SovZ4OuU/3dNPzIGh9mOnSk4Ce6+Ni28XvtvDP6wdQVzg51FmDBHqKZ+bZs9sGBc4tNt07@vger.kernel.org
X-Gm-Message-State: AOJu0YzuVfgh5joRmCGZGm8PdT/rA2UvQeZl5EcRL7AzGLNrJVpWowwl
	bIBBgRjSnqDO0fQTzPzisxsMjlb8w5n+PFhxOaR7nQ/+oW29SLlFe0Z8
X-Gm-Gg: AfdE7ckFr9/CK4WtVEHQ1q2ORQ3F/EiSXeQml4yfHalpmkXqDqMDFeCPBDAd9lf2pxY
	CT/a5jB9/fiGi/b1pv9sPK9jZuOn/nBv/B84yeZa7hNTIEAkdRgnLeFG6UgavzX8OdDn4WJgoaE
	CGFZTE0QxOxuS6gz5H14hfIzeFaeTveVX7Pe/EVLpOIuwXxr5UCqpjpMdzn/8qNBwK01nsnaGxr
	ZnpPajrdGfLSRHsek0HgHEETkYaA3YzkyHHDb+L4qrYk9phlB8pbtTK0JKOU0lgdrCTc5s0Kqe/
	JVRLwFLAosM7toHnmE1uk33/bfsgEgXrGnZR9aToDRptc9Lrn1pmIHWuF4kj8WIrOxFT88b2Tv+
	A2mNmXBJzdhQxKaGlAjYdG/pq8pmNM1Tr2xJPur2rf53XRTdQVB4b4bOIGmVKjdUwxN5INtrejb
	z13Ele2Cw=
X-Received: by 2002:a05:7300:fd04:b0:2ea:c085:44b1 with SMTP id 5a478bee46e88-30c5b87a4c0mr708300eec.19.1782192366092;
        Mon, 22 Jun 2026 22:26:06 -0700 (PDT)
Received: from [10.0.0.65] ([2601:647:6700:64d0::92d1])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30c1be4967fsm13102455eec.26.2026.06.22.22.26.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2026 22:26:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v4 4/8] riscv/runtime-const: Replace open-coded
 placeholder with RUNTIME_MAGIC
From: Charlie Jenkins <thecharlesjenkins@gmail.com>
To: K Prateek Nayak <kprateek.nayak@amd.com>
Cc: Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
 Peter Zijlstra <peterz@infradead.org>, 
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
 Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Albert Ou <aou@eecs.berkeley.edu>, Guo Ren <guoren@kernel.org>, 
 Darren Hart <dvhart@infradead.org>, Davidlohr Bueso <dave@stgolabs.net>, 
 =?utf-8?q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>, 
 linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-s390@vger.kernel.org, linux-riscv@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, Alexandre Ghiti <alex@ghiti.fr>, 
 Charlie Jenkins <charlie@rivosinc.com>, Jisheng Zhang <jszhang@kernel.org>, 
 Charles Mirabile <cmirabil@redhat.com>
In-Reply-To: <20260430094730.31624-5-kprateek.nayak@amd.com>
References: <20260430094730.31624-1-kprateek.nayak@amd.com>
 <20260430094730.31624-5-kprateek.nayak@amd.com>
Date: Mon, 22 Jun 2026 22:24:56 -0700
Message-Id: <178219229642.10927.5804159175321604816.b4-review@b4>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782192362; l=610;
 i=thecharlesjenkins@gmail.com; s=20260605; h=from:subject:message-id;
 bh=n+I3lxePERllHyfwEWyDEAhZnniet1N62LffQ9iv1A4=;
 b=BbyI070isif1KhCepDopyZNJYOc01bHzD6A+jVT3UijnT3HrwXWLYOswSXorRMeV+HlI4Inun
 OKgODIqIXrUAHVTJFNoyMxYBsj+Slz8Acjz3vKWxwe3qbx4eUZs6N2L
X-Developer-Key: i=thecharlesjenkins@gmail.com; a=ed25519;
 pk=ajnnRQ98PIdwKp4HeMkq9U32okYbnh6Zb4G3o5XXvkg=
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[thecharlesjenkins@gmail.com,linux-s390@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:kprateek.nayak@amd.com,m:tglx@kernel.org,m:mingo@redhat.com,m:peterz@infradead.org,m:bigeasy@linutronix.de,m:pjw@kernel.org,m:palmer@dabbelt.com,m:aou@eecs.berkeley.edu,m:guoren@kernel.org,m:dvhart@infradead.org,m:dave@stgolabs.net,m:andrealmeid@igalia.com,m:linux-arch@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-s390@vger.kernel.org,m:linux-riscv@lists.infradead.org,m:linux-arm-kernel@lists.infradead.org,m:alex@ghiti.fr,m:charlie@rivosinc.com,m:jszhang@kernel.org,m:cmirabil@redhat.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21125-lists,linux-s390=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4317D6B42C9

On Thu, 30 Apr 2026 09:47:26 +0000, K Prateek Nayak <kprateek.nayak@amd.com> wrote:
> Define the placeholder used for lui + addi[w] patching sequence as
> RUNTIME_MAGIC and use that instead of open coding the constants in the
> inline assembly.
> 
> No functional changes intended.
> 
> Suggested-by: Guo Ren <guoren@kernel.org>
> Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>

This is a great addition, thank you!

Reviewed-by: Charlie Jenkins <thecharlesjenkins@gmail.com>
Tested-by: Charlie Jenkins <thecharlesjenkins@gmail.com>

-- 
Charlie Jenkins <thecharlesjenkins@gmail.com>

