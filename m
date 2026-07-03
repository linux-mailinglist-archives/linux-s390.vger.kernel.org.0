Return-Path: <linux-s390+bounces-21533-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id epp+F7mJR2oMagAAu9opvQ
	(envelope-from <linux-s390+bounces-21533-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Fri, 03 Jul 2026 12:06:49 +0200
X-Original-To: lists+linux-s390@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A507B700F89
	for <lists+linux-s390@lfdr.de>; Fri, 03 Jul 2026 12:06:48 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=ipV9hQ6Q;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-s390+bounces-21533-lists+linux-s390=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-s390+bounces-21533-lists+linux-s390=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DD0FA313645A
	for <lists+linux-s390@lfdr.de>; Fri,  3 Jul 2026 09:58:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0866037D114;
	Fri,  3 Jul 2026 09:57:14 +0000 (UTC)
X-Original-To: linux-s390@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8381D2D5C68
	for <linux-s390@vger.kernel.org>; Fri,  3 Jul 2026 09:57:09 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783072633; cv=none; b=h7dXuC83h5dDLadoz8pdgofqWtft/aZta+ig6N8VydkzHRuix1PwfTIm2OGSk18oOdGOR5vJcP+gCY79oW2hLxTQpITOfpb4NA1fk/igk+R5Erw+P6W6oeLwIponkfi6UanzyGa1eZWzLF013c9lWr/SbSvM7Oze8lQ8aCR8RfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783072633; c=relaxed/simple;
	bh=M8mLWvMzRI7P4CH9mmJCgeH4HKbc93YSByk3bpp1/5Q=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=nPJmqR8eqHeoF7UgPrZSkzLkwgRpHplWR4+p3jahjKuOUdNpwu/tLXriPc1PTpRbpbx/j3slYRvEaDf+HlUGsWFdFZy5UMRZKDFcwDTNqFapCWQaVMyVWwq5wKhOS8YgkZdoh3EkumzAwVFzr9DGLo57d8QN9mV5earafukKNSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ipV9hQ6Q; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2382B1F000E9;
	Fri,  3 Jul 2026 09:57:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783072626;
	bh=M8mLWvMzRI7P4CH9mmJCgeH4HKbc93YSByk3bpp1/5Q=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ipV9hQ6QKyHXzdU0dVA1MdmOGR/x8C3KpSSSG9PmY4frr3SUhzONiBCHGy+fNqR5Q
	 Y3AEyG6tVaU0kH1lN495PtMjLOCJFe+D9/elSIkF53YbYthW+a8J9Q7lsqRhloMSm1
	 8oRgXlWjst3uYtWXiNvLg2nahPpX1w8lx3x2aBVdWUWOWpKmxpA3SmuWVD/HoM6Wng
	 Zkrk0utgacdtbSL+NaaoCnrIyR8kwhGJnVoH0uua/5yRfsw7wQQG8aS0EANXHH7sl6
	 ur6JdBZRF1xzrQzet0GSUZy/n1gzCdi2kcEyLaxcqzfkrh836bgGcbA8mwbrOCFkz2
	 3vccWWmHM9Tow==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/1] s390/pkey: Rework ioctl functions error pathes
Reply-To: sashiko-reviews@lists.linux.dev
To: "Harald Freudenberger" <freude@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260703094618.5916-2-freude@linux.ibm.com>
References: <20260703094618.5916-1-freude@linux.ibm.com>
 <20260703094618.5916-2-freude@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 03 Jul 2026 09:57:05 +0000
Message-Id: <20260703095706.2382B1F000E9@smtp.kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21533-lists,linux-s390=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,sashiko.dev:url,smtp.kernel.org:mid];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,linux-s390@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:freude@linux.ibm.com,m:linux-s390@vger.kernel.org,m:hca@linux.ibm.com,m:gor@linux.ibm.com,m:agordeev@linux.ibm.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashiko-bot@kernel.org,linux-s390@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	TAGGED_RCPT(0.00)[linux-s390];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A507B700F89

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Critical] Passing ERR_PTR values from `_copy_key_from_user` or `_copy_ap=
qns_from_user` to `kfree()` and `kfree_sensitive()` causes a deterministic =
kernel panic.
- [Critical] Accidental removal of the `ktp.pkeylen` update in `pkey_ioctl_=
kblob2protk3` breaks the userspace ABI.
--

Note: Due to recitation restrictions, this report does not use the standard
inline quoting format to show the modified code. Instead, I am providing a
free-form summary of the issues found in the patch.

commit 280086862168752a0b3725329891a790006a089e
Author: Harald Freudenberger <freude@linux.ibm.com>
s390/pkey: Rework ioctl functions error pathes

This commit refactors the error handling and free paths in the pkey ioctl
functions. It replaces duplicated cleanup code with centralized goto labels
to handle freeing memory and zeroing operations at the end of each function.


[Severity: Critical]
When _copy_key_from_user() or _copy_apqns_from_user() fails and returns an
ERR_PTR, does the jump to the out label cause kfree() or kfree_sensitive()=
=20
to dereference that ERR_PTR?

In drivers/s390/crypto/pkey_api.c, several ioctl functions check for IS_ERR=
()
after copying from user space. If an error occurs, they assign rc and then=
=20
execute goto out. However, at the out label, the pointer is unconditionally=
=20
passed to the freeing functions. Passing an ERR_PTR (such as -EFAULT) to the
kfree family causes the slab allocator to attempt dereferencing an invalid=
=20
address, resulting in a kernel panic.=20

This pattern appears to be introduced across multiple functions, including
pkey_ioctl_kblob2protk(), pkey_ioctl_clr2seck2(), pkey_ioctl_verifykey2(),
pkey_ioctl_kblob2protk2(), pkey_ioctl_apqns4k(), and
pkey_ioctl_kblob2protk3().


[Severity: Critical]
Was the assignment of ktp.pkeylen intentionally removed in=20
pkey_ioctl_kblob2protk3()?=20

During the refactoring in drivers/s390/crypto/pkey_api.c, the line=20
ktp.pkeylen =3D protkeylen; was dropped right before the final copy_to_user=
()=20
call. Dropping this assignment prevents the kernel from returning the actua=
l=20
size of the derived key back to userspace. Will this break the ABI for=20
applications relying on this size query?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260703094618.5916=
-2-freude@linux.ibm.com?part=3D1

