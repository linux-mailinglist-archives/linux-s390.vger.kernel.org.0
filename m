Return-Path: <linux-s390+bounces-21231-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 6LjUOH/DO2rocQgAu9opvQ
	(envelope-from <linux-s390+bounces-21231-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Wed, 24 Jun 2026 13:46:07 +0200
X-Original-To: lists+linux-s390@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C6FA6BDC78
	for <lists+linux-s390@lfdr.de>; Wed, 24 Jun 2026 13:46:07 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=EIJa6Tkh;
	spf=pass (mail.lfdr.de: domain of "linux-s390+bounces-21231-lists+linux-s390=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-s390+bounces-21231-lists+linux-s390=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 802BE30DEE33
	for <lists+linux-s390@lfdr.de>; Wed, 24 Jun 2026 11:42:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0826C33A9FE;
	Wed, 24 Jun 2026 11:42:36 +0000 (UTC)
X-Original-To: linux-s390@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C25AA2E7393;
	Wed, 24 Jun 2026 11:42:34 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782301355; cv=none; b=YQXYO6BWbGHj7oDn/Q7x+ZngsYonWzBgbHFfEtlCuFfvQrLRQrfBGGu+QtnPh0fOhYQNCVThuSfBdURYJ7k+mZfuL10d68W1l78FLZo7pKXIWLb+mDIGt3NNcs8bThlQhe0kwmbkqDis6HE9bsd/W8JOX1mOTh2R+63kHex0zpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782301355; c=relaxed/simple;
	bh=h623UEDfapL4GJxlFUPp5951xsVK3JCa5/q54rYUR38=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=m+3mEFNmXcyP3aZ8CNugS0NTRvff0k5SJQYSF1WCdmoy48yXOYHC2mVsJh2chVSt46JihuuEdgIDfRn36N4L2wKvFCgtX42dnNUDb6ono71z7ln6u++hKShgbMDn7rT5+A0pGclt0WmUz/MB5SAybZJPLhbmqg4YapvJWhlLfyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EIJa6Tkh; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30D871F00A3A;
	Wed, 24 Jun 2026 11:42:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782301354;
	bh=5UG1piZ984bT9bClz0ChcR2PnJ9Rq3r1loi053dwaHc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=EIJa6Tkhih7bgy+ZHYr84+VHn7ay48ZXxgZlUNyEk9CTaolXTdhBUPt15cw3UxKjQ
	 41H8cBXWYjSlA8DnpfQBUvjo7f4gc7STvk6ZToh/TDxbyexz4chG/TW0iB+J4ENKGG
	 puynJ69kZ1WcRzVSvCUKZLw+POqeu3rUaBQu6rUBd7rdEMyPnYNQOP2BnLu8lzk45Z
	 ud/M2d8lY7+5cQXiFuxz4XlL6F57V1E1Ovs+w5BOli+Wab+n5tHWej2mdvJfNJSzTw
	 DjCyILY06dpIhQRPVswMxeNVkxFOIKaI0H5hxoUbs6ccJqw1tdXcqPVQDid5MgdPLp
	 eGqU6wXA0wF7g==
From: sashiko-bot@kernel.org
Subject: Re: [GIT PULL v1 04/12] s390/mm: Fix handling of _PAGE_UNUSED pte
 bit
Reply-To: sashiko-reviews@lists.linux.dev
To: "Claudio Imbrenda" <imbrenda@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Vasily Gorbik" <gor@linux.ibm.com>, "Heiko
 Carstens" <hca@linux.ibm.com>, kvm@vger.kernel.org, "Alexander Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260624111928.144283-5-imbrenda@linux.ibm.com>
References: <20260624111928.144283-1-imbrenda@linux.ibm.com>
 <20260624111928.144283-5-imbrenda@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 24 Jun 2026 11:42:32 +0000
Message-Id: <20260624114233.30D871F00A3A@smtp.kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21231-lists,linux-s390=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,smtp.kernel.org:mid,vger.kernel.org:from_smtp,lists.linux.dev:replyto];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,linux-s390@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:imbrenda@linux.ibm.com,m:linux-s390@vger.kernel.org,m:gor@linux.ibm.com,m:hca@linux.ibm.com,m:kvm@vger.kernel.org,m:agordeev@linux.ibm.com,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3C6FA6BDC78

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [Medium] The KVM unused page discard optimization is completely defeated =
by page aging.

Pre-existing issues:
- [Critical] Guest memory corruption because hardware memory access does no=
t clear `_PAGE_UNUSED`.
--

commit 4123a9573ff29d2fd29637723b6e4e5841aed14e
Author: Claudio Imbrenda <imbrenda@linux.ibm.com>

s390/mm: Fix handling of _PAGE_UNUSED pte bit

The _PAGE_UNUSED softbit should not really be lying around. Its sole
purpose is to signal to try_to_unmap_one() and try_to_migrate_one()
that the page can be discarded instead of being moved / swapped.

> diff --git a/arch/s390/include/asm/pgtable.h b/arch/s390/include/asm/pgta=
ble.h
> index 2c6cee8241e04..4740c75649ebb 100644
> --- a/arch/s390/include/asm/pgtable.h
> +++ b/arch/s390/include/asm/pgtable.h
> @@ -980,6 +980,8 @@ static inline void set_pmd(pmd_t *pmdp, pmd_t pmd)
> =20
>  static inline void set_pte(pte_t *ptep, pte_t pte)
>  {
> +	if (pte_present(pte))
> +		pte =3D clear_pte_bit(pte, __pgprot(_PAGE_UNUSED));

[Severity: Critical]
This is a pre-existing issue, but does moving the clearing logic into
set_pte() fully resolve the guest memory corruption?

When the guest resumes using a page, the s390 hardware transparently updates
the referenced and dirty bits in the hardware Storage Key without triggering
a host page fault. Because no software page fault occurs, set_pte() is never
invoked, leaving _PAGE_UNUSED erroneously set on the active host PTE.

If memory compaction occurs, try_to_migrate_one() checks pte_unused() and
drops the page without first validating the Storage Key:

mm/rmap.c:try_to_migrate_one() {
    ...
    } else if (likely(pte_present(pteval)) && pte_unused(pteval) &&
               !userfaultfd_armed(vma)) {
        /*
         * The guest indicated that the page content is of no
         * interest anymore. Simply discard the pte, vmscan
         * will take care of the rest.
         */
    ...
}

Could this lead to the silent loss of active guest data since the migration
path incorrectly assumes the page is discardable?

[Severity: Medium]
Does clearing _PAGE_UNUSED unconditionally here in set_pte() defeat the KVM
unused page discard optimization during page aging?

When the system is under memory pressure, shrink_page_list() calls
folio_referenced(), which invokes ptep_test_and_clear_young() to inspect the
Storage Key and clear the young bit.

On s390, ptep_test_and_clear_young() writes the updated PTE back via an
unconditional call to set_pte(). This would permanently destroy the
KVM-provided _PAGE_UNUSED marker.

Immediately after aging, try_to_unmap_one() checks the unused status:

mm/rmap.c:try_to_unmap_one() {
    ...
    } else if (likely(pte_present(pteval)) && pte_unused(pteval) &&
               !userfaultfd_armed(vma)) {
        /*
         * The guest indicated that the page content is of no
         * interest anymore. Simply discard the pte
         */
    ...
}

Because the bit was just cleared by the aging process, won't this evaluate
to false, causing truly unused guest pages to be unnecessarily swapped out
instead of efficiently discarded?

>  	WRITE_ONCE(*ptep, pte);
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260624111928.1442=
83-1-imbrenda@linux.ibm.com?part=3D4

