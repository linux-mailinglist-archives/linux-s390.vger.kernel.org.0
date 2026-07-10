Return-Path: <linux-s390+bounces-22017-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id xonoOmqlUGpa2wIAu9opvQ
	(envelope-from <linux-s390+bounces-22017-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Fri, 10 Jul 2026 09:55:22 +0200
X-Original-To: lists+linux-s390@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5955673831D
	for <lists+linux-s390@lfdr.de>; Fri, 10 Jul 2026 09:55:22 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=dqIAlwWg;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "linux-s390+bounces-22017-lists+linux-s390=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-s390+bounces-22017-lists+linux-s390=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 40BD93051734
	for <lists+linux-s390@lfdr.de>; Fri, 10 Jul 2026 07:53:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 816503E073D;
	Fri, 10 Jul 2026 07:52:55 +0000 (UTC)
X-Original-To: linux-s390@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3389A3E1D08
	for <linux-s390@vger.kernel.org>; Fri, 10 Jul 2026 07:52:54 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783669975; cv=none; b=h4NpINW07bTY9qBN1mg51/fWQuszUFULy2ZSToLN+Gkh0zW8GVdPymVhHK2ryS3bazJq3XW7Se4PzKbsHYzTKa7ZMzxNf1oY/oBTzChblY4oIve649m3w1wn5lI1amjbgZhQO6HQTz7kvqIpEfxg1AvbJD6jpblBoNtbcvDkb44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783669975; c=relaxed/simple;
	bh=Ag5hF8rTf0X6/MPKP15IB3NYCgooifLcPCObkTtH1N0=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=mrNNrWHi12sa6vhufkfJ0monPN7jCrkreku6HCtdsuGteI6R42038/rU/tVlYWmGo2uziatCWCn+bJetSNXZnRYb7j9OAN4PO9S0xvJqZxv3sAvFbpLIZebeb0oIiv5acmGHbdytcjLOrQPQwqFHjYO3eAIG6N9B8PWGwkuUMGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dqIAlwWg; arc=none smtp.client-ip=209.85.216.47
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-36b9d265355so626690a91.2
        for <linux-s390@vger.kernel.org>; Fri, 10 Jul 2026 00:52:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783669973; x=1784274773; darn=vger.kernel.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=1vKA4/E3v7W7bFn4qyJsED7Lacs/12A597rqBVPmfww=;
        b=dqIAlwWgLhPzaOtMkQ+6uZyiI9GlCBUzHCB6oFOnMhsvlq+ZXClcFipitD6q3onyDH
         wz2FAJGx14X0PZO1uOXj9mk/U+x1DKmms5Y7lRskrADZVVEwtoirIp7mIs29HLfxlP6i
         Kp1zaR0z+zMAdMZNpk2cD/tTtTce+9Vk2Echnxn91jBW5TUQN59TNhA94DapmI1ELJkK
         TdPtFx9wv4Tis8KmipIg5uRsDUHJKhu+qwFcJGyGdR0Eze1UDBgQC0JCm7DcpE+biIb1
         3bsUuz7s+inWfZQ4h/9haq+NkQ9rGqSWCs2RiIvm1fpzhx7ablXN54wwibKz7NrPmtxm
         alYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783669973; x=1784274773;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1vKA4/E3v7W7bFn4qyJsED7Lacs/12A597rqBVPmfww=;
        b=W+fibGLz9ol58fihrszrUOdnIlm80B14/Hc8QGOVSv5PYsgyLHItAAwNRpU3rDegk4
         oVr1CooueH8cw9v+kZBpXbynUYWpug2eCCyHrZTUXqOLdhTlYAroRUd+JFCVRUmF0V6G
         rYMa//1KPed/H5pXEmMWg4t8EpUDv8tO1av8Ohg/UTUzcnfucrs8O437XutX520NAvwV
         G/9H9R/Xo2Ebf2O+tv8TWR7JH6Zzqvla6K8kUAvKZOcvYkMpqj+owVpE/NwbzGg7X1m6
         McRxQ4sBjl806sGKjNoXPRSJlydPVjsCFvEc04YWNXbC/mD9c/KDEwGqqC4K5E1saeOh
         3cVw==
X-Forwarded-Encrypted: i=1; AHgh+Ro/Rg+na/wbyJ6c9YVCWDDM1kF7b/dPYNN9SVpjSfpSQzsY6XAR3t8ILFfh7kj326QgMBLNVbHdLHgu@vger.kernel.org
X-Gm-Message-State: AOJu0YyJ3RvdVed6a1OeSp0Pj/o4ekJ6rWyMSgr3M/v/TKdSyn8hhgpp
	37FT5zo7ttwHwSvTU8i6ngX8Ck4bA6QeLe7BQ9ooRANXpCqvAzTmkJZT
X-Gm-Gg: AfdE7cmDRm1Lc3KzlcC+DgwhCI51kq96u6w7745dZjbMfG5tZg01xOWxLtY6VFIxCXH
	daOdaWh6clXQ+U5PkKcsLuDxX1ms94A3sz2caQqThqwsVpNj9AIczANHZ6eVAacH2aZ4jYzf0QN
	Xwuy/c29TmNVW9ECYIEUuwAbH+I5QzBo6qY1yPGAplLSZh9ZNZkR9q6JJDVevEqWZ4PLjc8+sfv
	ziOobJpuDpEFdfPF20lVHACGSLXc+/ZvrtPf9C1fhO16vH5f0HJ/GpX2Cb9Uw6i3uGV/1I3WjC5
	caoiXgERTHyPiVtAo1EHOrkYXoBUrKRx5gALOurW3z7DmY16W2cCEr93Qrp7KpkOkx43eiuZpr/
	vCS/Hpejz7PsBfzlMmcynEnFrNNowNi7dCzkAw+A812be3VsmiKoXZadeIA/ZlfmnjvTNB5lmSz
	dWhFXI8tlNcKsMMUNLwTSbGkwfKLVqUWKEy/KENxpQ
X-Received: by 2002:a17:90b:4a0a:b0:37f:464d:ea38 with SMTP id 98e67ed59e1d1-3893d530961mr9707655a91.0.1783669973502;
        Fri, 10 Jul 2026 00:52:53 -0700 (PDT)
Received: from [10.0.0.65] ([2601:647:6700:64d0::94ac])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31174839f89sm38555369eec.10.2026.07.10.00.52.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 00:52:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v5 8/8] futex: Use runtime constants for __futex_hash()
 hot path
From: Charlie Jenkins <thecharlesjenkins@gmail.com>
To: K Prateek Nayak <kprateek.nayak@amd.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Thomas Gleixner <tglx@kernel.org>, 
 Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
 x86@kernel.org, Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Paul Walmsley <pjw@kernel.org>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
 Alexander Gordeev <agordeev@linux.ibm.com>, 
 Darren Hart <dvhart@infradead.org>, Davidlohr Bueso <dave@stgolabs.net>, 
 =?utf-8?q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>, 
 linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Samuel Holland <samuel.holland@sifive.com>, 
 Charlie Jenkins <thecharlesjenkins@gmail.com>, 
 linux-arm-kernel@lists.infradead.org, linux-riscv@lists.infradead.org, 
 linux-s390@vger.kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
 Thomas Huth <thuth@redhat.com>, Sean Christopherson <seanjc@google.com>, 
 Jisheng Zhang <jszhang@kernel.org>, Alexandre Ghiti <alex@ghiti.fr>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Sven Schnelle <svens@linux.ibm.com>
In-Reply-To: <20260630045531.3939-9-kprateek.nayak@amd.com>
References: <20260630045531.3939-1-kprateek.nayak@amd.com>
 <20260630045531.3939-9-kprateek.nayak@amd.com>
Date: Fri, 10 Jul 2026 00:52:39 -0700
Message-Id: <178366995932.1208691.13530053283560063106.b4-review@b4>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783669964; l=632;
 i=thecharlesjenkins@gmail.com; s=20260605; h=from:subject:message-id;
 bh=Ag5hF8rTf0X6/MPKP15IB3NYCgooifLcPCObkTtH1N0=;
 b=XRTUMqEADW+KZk3nC8Ii+QzcGXzNTGq2bntuuyEk/nB+Q7Rjvlcqlgu4/3V3dHA5sGTlOTVXe
 qfXYMGUnVW7DGepiw3HKFoSXdft6CODFk3hsmUjcgJE6PD6p4836N0A
X-Developer-Key: i=thecharlesjenkins@gmail.com; a=ed25519;
 pk=ajnnRQ98PIdwKp4HeMkq9U32okYbnh6Zb4G3o5XXvkg=
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-22017-lists,linux-s390=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[thecharlesjenkins@gmail.com,linux-s390@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_RECIPIENTS(0.00)[m:kprateek.nayak@amd.com,m:arnd@arndb.de,m:tglx@kernel.org,m:mingo@redhat.com,m:peterz@infradead.org,m:bigeasy@linutronix.de,m:bp@alien8.de,m:dave.hansen@linux.intel.com,m:x86@kernel.org,m:catalin.marinas@arm.com,m:will@kernel.org,m:pjw@kernel.org,m:palmer@dabbelt.com,m:aou@eecs.berkeley.edu,m:hca@linux.ibm.com,m:gor@linux.ibm.com,m:agordeev@linux.ibm.com,m:dvhart@infradead.org,m:dave@stgolabs.net,m:andrealmeid@igalia.com,m:linux-arch@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:samuel.holland@sifive.com,m:thecharlesjenkins@gmail.com,m:linux-arm-kernel@lists.infradead.org,m:linux-riscv@lists.infradead.org,m:linux-s390@vger.kernel.org,m:hpa@zytor.com,m:thuth@redhat.com,m:seanjc@google.com,m:jszhang@kernel.org,m:alex@ghiti.fr,m:borntraeger@linux.ibm.com,m:svens@linux.ibm.com,s:lists@lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[34];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[arndb.de,kernel.org,redhat.com,infradead.org,linutronix.de,alien8.de,linux.intel.com,arm.com,dabbelt.com,eecs.berkeley.edu,linux.ibm.com,stgolabs.net,igalia.com,vger.kernel.org,sifive.com,gmail.com,lists.infradead.org,zytor.com,google.com,ghiti.fr];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,amd.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5955673831D

On Tue, 30 Jun 2026 04:55:31 +0000, K Prateek Nayak <kprateek.nayak@amd.com> wrote:
> Runtime constify the read-only after init data  __futex_shift(shift_32),
> __futex_mask(mask_32), and __futex_queues(ptr) used in __futex_hash()
> hot path to avoid referencing global variable.
> 
> This also allows __futex_queues to be allocated dynamically to
> "nr_node_ids" slots instead of reserving config dependent MAX_NUMNODES
> (1 << CONFIG_NODES_SHIFT) worth of slots upfront.
> 
> [...]

Reviewed-by: Charlie Jenkins <thecharlesjenkins@gmail.com>
Tested-by: Charlie Jenkins <thecharlesjenkins@gmail.com>

-- 
- Charlie


