Return-Path: <linux-s390+bounces-21962-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id WoM6I4DBT2qknwIAu9opvQ
	(envelope-from <linux-s390+bounces-21962-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Thu, 09 Jul 2026 17:42:56 +0200
X-Original-To: lists+linux-s390@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ACC57330C7
	for <lists+linux-s390@lfdr.de>; Thu, 09 Jul 2026 17:42:55 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=eyutX1GF;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-s390+bounces-21962-lists+linux-s390=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="linux-s390+bounces-21962-lists+linux-s390=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id ABDA1307D01A
	for <lists+linux-s390@lfdr.de>; Thu,  9 Jul 2026 15:24:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7779F36920F;
	Thu,  9 Jul 2026 15:24:35 +0000 (UTC)
X-Original-To: linux-s390@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 663ED364943;
	Thu,  9 Jul 2026 15:24:34 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783610675; cv=none; b=FDLym5zYkuy3yKv2/T010ySWfeES57o2u4Vp77cFFag/vQzSG7/IVtivHPOvvAWKf3TrmkA1fci4ClRLJ8JC7r1Zt9QD4yDkCezTqzbXEDgr58c4fI1xA+Ju3iBU2EFLe51q0GVQ7aWQJIXIEIEVyJaYmVmaxvGLuwvW7bEJ4V8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783610675; c=relaxed/simple;
	bh=W8SO31V8xUOf45PJlAmABNrfzovD5P4lFYjslpvXefs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ZDPr+z16uXekCrCpu3g+kYak64MJ8TISZN9fW6YEd8Sz97B2gLqLm1frmJjWV7W2uVGc4wjf+JIhz7ymfTHNzpvXpdClUKdvPPxCRW1sZ5I0UqYq9JtgFz7XHg7BxCuEQ25aPE9Klk6qb99jOgV1q7XMoBVTVzGlZAr2cF4isDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eyutX1GF; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CBA51F000E9;
	Thu,  9 Jul 2026 15:24:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783610674;
	bh=W8SO31V8xUOf45PJlAmABNrfzovD5P4lFYjslpvXefs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=eyutX1GFw4Hhk8rxKaDa51o4J28/OuVH0wuJVj29/LZvaryyTLqIz6loQKjiD5ZYA
	 5ovdRvhBKdWoJfSFdo4gZL/XfKmLm90vTfAnc8aFY8kgigXuLEAwO6trEMZM1yIju3
	 ubSjMXFNfKTp1IA5tvda/JH1QYfVpC324Ts0XygtDQjJLcrlq7JUvRAkF6QNcnBoml
	 g3ecljuRCzBF9vkQb43QpHj+g+fjaBwsUMwDUT4Ie0Ve3O9vpL5022UOwgS4RFsVKR
	 Bgn2oy2LX5epWlkNZnAqjjJZvvkGEVlU/5dWaBDEWyzqlDlNhFPiXu+fc2aN4QOTvd
	 d6Pxrhw2ASkDg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 07/21] KVM: s390: vsie: Add ssca_block and ssca_entry
 structs for vsie_ie
Reply-To: sashiko-reviews@lists.linux.dev
To: "Christoph Schlameuss" <schlameuss@linux.ibm.com>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org
In-Reply-To: <20260709-vsie-sigpi-v1-7-ea9f12066408@linux.ibm.com>
References: <20260709-vsie-sigpi-v1-0-ea9f12066408@linux.ibm.com>
 <20260709-vsie-sigpi-v1-7-ea9f12066408@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 09 Jul 2026 15:24:32 +0000
Message-Id: <20260709152433.9CBA51F000E9@smtp.kernel.org>
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
	TAGGED_FROM(0.00)[bounces-21962-lists,linux-s390=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,smtp.kernel.org:mid,lists.linux.dev:replyto];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,linux-s390@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:schlameuss@linux.ibm.com,m:hca@linux.ibm.com,m:agordeev@linux.ibm.com,m:gor@linux.ibm.com,m:linux-s390@vger.kernel.org,m:kvm@vger.kernel.org,s:lists@lfdr.de];
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
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6ACC57330C7

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Meaningful code and commit message mismatch regarding `vsie_page=
` modifications.
--

--- Patch [7]: [PATCH 07/21] KVM: s390: vsie: Add ssca_block and ssca_entry=
 structs for vsie_ie ---
commit 62a4a049329b153db252c516ebc9d4ec4ac9f106
Author: Christoph Schlameuss <schlameuss@linux.ibm.com>

KVM: s390: vsie: Add ssca_block and ssca_entry structs for vsie_ie

This commit adds the ssca_block and ssca_entry structures to represent the
shadow state description and original SIGP entries. It also updates the SIE
control block definition to include the original state description address.

> KVM: s390: vsie: Add ssca_block and ssca_entry structs for vsie_ie
>
> Add the required guest-1 structures for the vsie_sigpif to the SIE
> control block and vsie_page for use in later patches.

[Severity: Medium]
Is struct vsie_page supposed to be updated in this patch?

The commit message mentions adding structures to vsie_page, but looking
at arch/s390/kvm/vsie.c where struct vsie_page is defined, there are no
changes to it in this diff.

Could a chunk of the patch have been accidentally omitted during a rebase
or patch split, or does the commit message just need to be updated to
reflect the current patch boundaries?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260709-vsie-sigpi=
-v1-0-ea9f12066408@linux.ibm.com?part=3D7

