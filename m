Return-Path: <linux-s390+bounces-21480-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id C9kEF0h0RWo8AgsAu9opvQ
	(envelope-from <linux-s390+bounces-21480-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Wed, 01 Jul 2026 22:10:48 +0200
X-Original-To: lists+linux-s390@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CD6BF6F1515
	for <lists+linux-s390@lfdr.de>; Wed, 01 Jul 2026 22:10:47 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linutronix.de header.s=2020 header.b=RAJ3Efqo;
	dkim=pass header.d=linutronix.de header.s=2020e header.b=1SUZz5LD;
	spf=pass (mail.lfdr.de: domain of "linux-s390+bounces-21480-lists+linux-s390=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-s390+bounces-21480-lists+linux-s390=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linutronix.de;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A468A30DB787
	for <lists+linux-s390@lfdr.de>; Wed,  1 Jul 2026 19:58:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D03F38F93B;
	Wed,  1 Jul 2026 19:58:48 +0000 (UTC)
X-Original-To: linux-s390@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DD473815E3;
	Wed,  1 Jul 2026 19:58:46 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782935928; cv=none; b=kewiYcim5VFRf0U7B5o/HSxkZnT70GefgDS7aO0z94ShJ1aq6RYFiSwkyZGMNpLou+7AZQYFxvxRCfAr2rKgfcBlwP+xrHVLNieTsQONJfs0syrc53kW6CDS6etxfK7lKFPakO/uZQbmPU5Jax+G5AvV1tQ4+X0CYIVutH0xcUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782935928; c=relaxed/simple;
	bh=cC3grrbtW7yIMNoaBOflGzRt/Nk2jP+A2DZ0a6yP4kc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fnlIikAwtOPjKkyySQo8pf0VS16O/268WLkM3edXRsNmlMry+xg8wreJHTQ+UkPc1axXn5+OiuKR5EPvy3K5E0RoPWvvdvB8d/1YrD1EajrBYGWvzBibPjNZQhYl59Cys84cJd6astFcraal6g6TSvkjESFkBD3Jz2IHn/02ZGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=RAJ3Efqo; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1SUZz5LD; arc=none smtp.client-ip=193.142.43.55
Date: Wed, 1 Jul 2026 21:58:42 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1782935924;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HGRGPG5nxs0MWmKVH1XE9+ETMnAwiphDMI53H6S+Wgo=;
	b=RAJ3EfqoP6AG9c1WaCNIITbaruiAfTva7N92jqjyzHz99/OruOfTsQ9TCd5norcqHnFuwa
	K9sh09kmJbujZbohmQiFhoRumZZlkBpyLFNp1xSsQHibl5CYF+m/TJNK1JhQMyAn4LmeYK
	vdaEeUVaGAU+fb3jPhlEJA3GzYYBti4GYIH1mbLCU4yq2vg0A1P6iRNphahOyuLvRiQCzs
	G1ZivJCtGVTCUncdkOK4rty08ys6o4EvaF5DGpYcDpyLTW6lNjZo45NVlQ3WiTzvV04wgl
	nuZ/G2Tc5emil0fKKVXCMNNGwnTOt8sLqOwW9B3eQ381vduezgRl0dPzG4QrFg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1782935924;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HGRGPG5nxs0MWmKVH1XE9+ETMnAwiphDMI53H6S+Wgo=;
	b=1SUZz5LD4PErOtj5qqBP0NkzivGmhqyBp9E8O8FyVIUjOEo15F26+TZGAU3SxaFSaSBgu/
	gXmhX52PlPw+fiAA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: K Prateek Nayak <kprateek.nayak@amd.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Darren Hart <dvhart@infradead.org>,
	Davidlohr Bueso <dave@stgolabs.net>,
	=?utf-8?B?QW5kcsOp?= Almeida <andrealmeid@igalia.com>,
	linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
	Samuel Holland <samuel.holland@sifive.com>,
	Charlie Jenkins <thecharlesjenkins@gmail.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, Thomas Huth <thuth@redhat.com>,
	Sean Christopherson <seanjc@google.com>,
	Jisheng Zhang <jszhang@kernel.org>, Alexandre Ghiti <alex@ghiti.fr>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>
Subject: Re: [PATCH v5 8/8] futex: Use runtime constants for __futex_hash()
 hot path
Message-ID: <20260701195842.GKzb73-i@linutronix.de>
References: <20260630045531.3939-1-kprateek.nayak@amd.com>
 <20260630045531.3939-9-kprateek.nayak@amd.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20260630045531.3939-9-kprateek.nayak@amd.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21480-lists,linux-s390=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:kprateek.nayak@amd.com,m:arnd@arndb.de,m:tglx@kernel.org,m:mingo@redhat.com,m:peterz@infradead.org,m:bp@alien8.de,m:dave.hansen@linux.intel.com,m:x86@kernel.org,m:catalin.marinas@arm.com,m:will@kernel.org,m:pjw@kernel.org,m:palmer@dabbelt.com,m:aou@eecs.berkeley.edu,m:hca@linux.ibm.com,m:gor@linux.ibm.com,m:agordeev@linux.ibm.com,m:dvhart@infradead.org,m:dave@stgolabs.net,m:andrealmeid@igalia.com,m:linux-arch@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:samuel.holland@sifive.com,m:thecharlesjenkins@gmail.com,m:linux-arm-kernel@lists.infradead.org,m:linux-riscv@lists.infradead.org,m:linux-s390@vger.kernel.org,m:hpa@zytor.com,m:thuth@redhat.com,m:seanjc@google.com,m:jszhang@kernel.org,m:alex@ghiti.fr,m:borntraeger@linux.ibm.com,m:svens@linux.ibm.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[bigeasy@linutronix.de,linux-s390@vger.kernel.org];
	FREEMAIL_CC(0.00)[arndb.de,kernel.org,redhat.com,infradead.org,alien8.de,linux.intel.com,arm.com,dabbelt.com,eecs.berkeley.edu,linux.ibm.com,stgolabs.net,igalia.com,vger.kernel.org,sifive.com,gmail.com,lists.infradead.org,zytor.com,google.com,ghiti.fr];
	RCPT_COUNT_TWELVE(0.00)[33];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bigeasy@linutronix.de,linux-s390@vger.kernel.org];
	DKIM_TRACE(0.00)[linutronix.de:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-s390];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,linutronix.de:dkim,linutronix.de:mid,linutronix.de:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CD6BF6F1515

On 2026-06-30 04:55:31 [+0000], K Prateek Nayak wrote:
> --- a/kernel/futex/core.c
> +++ b/kernel/futex/core.c
> @@ -395,13 +391,13 @@ __futex_hash(union futex_key *key, struct futex_pri=
vate_hash *fph, struct futex_
>  		 * NOTE: this isn't perfectly uniform, but it is fast and
>  		 * handles sparse node masks.
>  		 */
> -		node =3D (hash >> futex_hashshift) % nr_node_ids;
> +		node =3D runtime_const_shift_right_32(hash, __futex_shift) % nr_node_i=
ds;
>  		if (!node_possible(node)) {
>  			node =3D find_next_bit_wrap(node_possible_map.bits, nr_node_ids, node=
);
>  		}

I replaced this with:

diff --git a/kernel/futex/core.c b/kernel/futex/core.c
index 79e770d4d166..30d8622958d2 100644
--- a/kernel/futex/core.c
+++ b/kernel/futex/core.c
@@ -382,6 +382,7 @@ __futex_hash(union futex_key *key, struct futex_private=
_hash *fph, struct futex_
 		      key->both.offset);
=20
 	if (node =3D=3D FUTEX_NO_NODE) {
+		u32 node_limit =3D nr_node_ids;
 		/*
 		 * In case of !FLAGS_NUMA, use some unused hash bits to pick a
 		 * node -- this ensures regular futexes are interleaved across
@@ -391,9 +392,9 @@ __futex_hash(union futex_key *key, struct futex_private=
_hash *fph, struct futex_
 		 * NOTE: this isn't perfectly uniform, but it is fast and
 		 * handles sparse node masks.
 		 */
-		node =3D runtime_const_shift_right_32(hash, __futex_shift) % nr_node_ids;
-		if (!node_possible(node)) {
-			node =3D find_next_bit_wrap(node_possible_map.bits, nr_node_ids, node);
+		node =3D reciprocal_scale(hash, node_limit);
+		if (!node_possible(node)) {
+			node =3D find_next_bit_wrap(node_possible_map.bits, node_limit, node);
 		}
 	}
=20
I don't think it is worse, I hardly see a change perf wise. Sometimes
op/s is reported almost unchanged, sometimes it improves a bit.

What it does it reads nr_node_ids only once (which has no effect here
because I have no sparse node) and it replaces the shift + divl with
imulq + shift.

perf was pointing me to the divl but now it points to the imulq.
=C2=AF\_(=E3=83=84)_/=C2=AF

But having that div gone, can't be bad, can it?

Sebastian

