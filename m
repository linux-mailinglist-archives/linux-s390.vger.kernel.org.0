Return-Path: <linux-s390+bounces-22286-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id NZjYLApVVmov3gAAu9opvQ
	(envelope-from <linux-s390+bounces-22286-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Tue, 14 Jul 2026 17:26:02 +0200
X-Original-To: lists+linux-s390@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AB7A175667D
	for <lists+linux-s390@lfdr.de>; Tue, 14 Jul 2026 17:26:01 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=FdSCPFJz;
	spf=pass (mail.lfdr.de: domain of "linux-s390+bounces-22286-lists+linux-s390=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="linux-s390+bounces-22286-lists+linux-s390=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9A85B30719C1
	for <lists+linux-s390@lfdr.de>; Tue, 14 Jul 2026 15:18:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62A8C49550C;
	Tue, 14 Jul 2026 15:16:22 +0000 (UTC)
X-Original-To: linux-s390@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3702E481FC2
	for <linux-s390@vger.kernel.org>; Tue, 14 Jul 2026 15:16:20 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784042182; cv=none; b=lb+xmExSumJ6skCnbLIWhhx5NSaZkLDwLEyefs8qLBsGB+8ZhItV+6QzVQqfq3ZRM36mIDv8V0ihobMPg60uWJJNLfw9Usfa/0wWEJ1875vMB9GSSX++2ZWXfCaj1EY03eApu8BkPSuApI9BSIMc6xKRu0LjzALLoZ9HA7V93Co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784042182; c=relaxed/simple;
	bh=o7hURUuAt70VCatcY5UGK/VRPRr8EET6XQJEPt1Q+kY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ntfvimnlFvRWbrmtJj8nK11WBGw9sPiQzGwsLz4VcgM4neHmU005MTdW6z8yeH1TpXD3JBMsU7b1RscIC7mCWaqD5BN1Yd4AgBTC8SWVJn60GlHbZLRhr0cOex0+Q/zSBzMtYiORDtVRC/rP44iKsNIxi3aQ473tcYx4lJdCnHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FdSCPFJz; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AE201F00A3A;
	Tue, 14 Jul 2026 15:16:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784042180;
	bh=M4SrV2ySetwsjrR+SDWe/QeoycmENZRAECtCVY2xSDA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FdSCPFJzK7voFRtAS2laNgrGfe/cEANrxuFsywkBsB46VvRI1wlzDifoEaIH5CWPB
	 bdWcVTfbxjry345XEkDB9aMGq+FkEnguevyvv1os2j4gHU3UOK1OP3o/AFbhFr2kr4
	 WXqMKOeRYaeOOUUxnHB0uzlHCd+tWyUUcGGyvzskBFqvR/zZv1w+nTg7YjcZsMb04Y
	 JCHhrF7GXFaEwNy1i8ZV5vfdI+uedNKYa7gSKegkAOPS5ft8hn/OvmB/sG35A6WEiG
	 3QolvGb+DuK1BMmCrwR73Ny+YTRNZvu4bVYH6EfuFP2kgvqqkHD9JIQv+5Y7Fptpvn
	 QAhVySy8Koj1Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 16/22] efi: mark efi_mm as a kernel mm
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kevin Brodsky" <kevin.brodsky@arm.com>
Cc: "Alexander Gordeev" <agordeev@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>
In-Reply-To: <20260714-remove_pgtable_cdtor-v1-16-44be8a7685d7@arm.com>
References: <20260714-remove_pgtable_cdtor-v1-0-44be8a7685d7@arm.com>
 <20260714-remove_pgtable_cdtor-v1-16-44be8a7685d7@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 14 Jul 2026 15:16:19 +0000
Message-Id: <20260714151620.8AE201F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	MISSING_MIME_VERSION(2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-22286-lists,linux-s390=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,sashiko.dev:url,arm.com:email,smtp.kernel.org:mid,lists.linux.dev:replyto];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,linux-s390@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:kevin.brodsky@arm.com,m:agordeev@linux.ibm.com,m:gor@linux.ibm.com,m:linux-s390@vger.kernel.org,m:hca@linux.ibm.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashiko-bot@kernel.org,linux-s390@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-s390];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: AB7A175667D

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Incomplete implementation: split page table locks are still init=
ialized for efi_mm on ARM64 and RISC-V.
--

--- Patch [16]: [PATCH 16/22] efi: mark efi_mm as a kernel mm ---
commit ebd104815a1ccc8b9a1160dde0da2bdd7e88ce96
Author: Kevin Brodsky <kevin.brodsky@arm.com>

efi: mark efi_mm as a kernel mm

This commit marks efi_mm with the MMF_KERNEL flag, treating it as a
kernel-owned address space. This avoids unnecessary complications by skippi=
ng
split page table lock initialization and constructor/destructor calls.

> diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
> index 0327a39d31fa5..e5ca45bdc890c 100644
> --- a/drivers/firmware/efi/efi.c
> +++ b/drivers/firmware/efi/efi.c
> @@ -69,6 +69,7 @@ struct mm_struct efi_mm =3D {
>  	.mm_mt			=3D MTREE_INIT_EXT(mm_mt, MM_MT_FLAGS, efi_mm.mmap_lock),
>  	.mm_users		=3D ATOMIC_INIT(2),
>  	.mm_count		=3D ATOMIC_INIT(1),
> +	.flags			=3D MM_FLAGS_INIT(MMF_KERNEL_MASK),

[Severity: Medium]
The commit message notes that split page table locks are no longer initiali=
zed
for efi_mm's page tables. Is this accurate for all architectures?

On ARM64 and RISC-V, the EFI page table allocation paths pass NULL instead =
of
the mm_struct to the generic page table constructors:

arch/arm64/mm/mmu.c:pgd_pgtable_alloc_special_mm() {
    ...
    return __pgd_pgtable_alloc(NULL, GFP_PGTABLE_KERNEL, pgtable_level);
}

arch/riscv/mm/init.c:alloc_pte_late() {
    ...
    BUG_ON(!ptdesc || !pagetable_pte_ctor(NULL, ptdesc));
    ...
}

Because NULL is passed instead of &efi_mm, the constructors cannot check the
MMF_KERNEL flag, meaning the split page table locks will still be
unconditionally initialized.

Does this optimization require updating the architecture-specific EFI alloc=
ation
paths to pass the mm_struct instead of NULL?

>  	.write_protect_seq      =3D SEQCNT_ZERO(efi_mm.write_protect_seq),
>  	MMAP_LOCK_INITIALIZER(efi_mm)
>  	.page_table_lock	=3D __SPIN_LOCK_UNLOCKED(efi_mm.page_table_lock),

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260714-remove_pgt=
able_cdtor-v1-0-44be8a7685d7@arm.com?part=3D16

