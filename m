Return-Path: <linux-s390+bounces-21258-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id MT6CHogYPmou/wgAu9opvQ
	(envelope-from <linux-s390+bounces-21258-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Fri, 26 Jun 2026 08:13:28 +0200
X-Original-To: lists+linux-s390@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 69C346CA931
	for <lists+linux-s390@lfdr.de>; Fri, 26 Jun 2026 08:13:27 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=NfLycTYN;
	spf=pass (mail.lfdr.de: domain of "linux-s390+bounces-21258-lists+linux-s390=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="linux-s390+bounces-21258-lists+linux-s390=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C157A300C395
	for <lists+linux-s390@lfdr.de>; Fri, 26 Jun 2026 06:13:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C07643D25D2;
	Fri, 26 Jun 2026 06:13:18 +0000 (UTC)
X-Original-To: linux-s390@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7F2B79CD
	for <linux-s390@vger.kernel.org>; Fri, 26 Jun 2026 06:13:17 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782454398; cv=none; b=LlxTgzlKmnZFxJFZ0yKPpv+HZde/I5C3km1Q492FfuJtZu199lmnie9iOaNKILPabMgyN9SUG3yY/cReVu91TcJqmSSq+Bkq3i8qLBE1u9d8q0Mh8aDDSxeiRAaWI9qZke3EBKvqp1JOiDoz7EZ0C02NgimAXzMzrarUAOsRJ8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782454398; c=relaxed/simple;
	bh=q/yZLEULRJ2ItsNKZfVl32MEQiQJl4UP6Q8dRtWQsBM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=K6UykjLCFzY/UBsHmw/4iSPjhUkMa3M70GA0XOBuYzPYeQ3/aqszc54DmEazJKqYnbv3XET8JS9TKwWVGVhM8a5JYXzITaOM1UG6L5WT9aw5BMO8nOyJOMoVj0ROFxcRVIhn70PLgqL01oAW79FXqPiwQiMPpDfn3/l+G93PdzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NfLycTYN; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13BF91F000E9;
	Fri, 26 Jun 2026 06:13:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782454397;
	bh=hlixBa+c+vjqCRSjgogsXB7pJHWBWQ159ph8trOOqpk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NfLycTYN2Z2/W5+GeE37ZC8ksRuL5b4Zl6+p2Cfx1zebVsWzp6C3kZuv28vp2gRma
	 jQ+nT4Bc9WZiagYKl/mk5/nVzBGOj2l6i72hAYZVef1upUO0K4Tt6yht7ICmzq1Mo5
	 8q+uVmP9LBHbaZoBCrP75IJ0PwTuPbfBYpjt2l7lUD+eC+XfMFBdwUzRnSsvWdR7NC
	 w8GZXWqr5fWaCgQ022lwfsbIY0vzg/FNC0hgM/7PrPDYU60O6DqR+yj3LpXh2fptnk
	 UTOXHSWJtW0cq6KmmRnPNb70UX9vR5pXzuhtZKwa4Lyh+Md6z0+xp+LpuZjEN/KUqk
	 CPXwUrGvEUe7g==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH] net/iucv: Descend into net/iucv when AFIUCV is
 enabled
Reply-To: sashiko-reviews@lists.linux.dev
To: "Pengpeng Hou" <pengpeng@iscas.ac.cn>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260625061303.36326-1-pengpeng@iscas.ac.cn>
References: <20260625061303.36326-1-pengpeng@iscas.ac.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 26 Jun 2026 06:13:16 +0000
Message-Id: <20260626061317.13BF91F000E9@smtp.kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21258-lists,linux-s390=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,linux-s390@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:pengpeng@iscas.ac.cn,m:gor@linux.ibm.com,m:linux-s390@vger.kernel.org,m:hca@linux.ibm.com,m:agordeev@linux.ibm.com,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 69C346CA931

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Undefined reference to `iucv_if` when linking `vmlinux` if `CONFIG_=
AFIUCV=3Dy` and `CONFIG_IUCV=3Dm`.
--

commit f5dfba2251234de82ea8d770ca96db4b3b823733
Author: Pengpeng Hou <pengpeng@iscas.ac.cn>
net/iucv: Descend into net/iucv when AFIUCV is enabled

This commit modifies the top-level network Makefile to unconditionally desc=
end
into the net/iucv directory. It allows af_iucv.o to be evaluated when
CONFIG_AFIUCV is selected without the base IUCV object.

> diff --git a/net/Makefile b/net/Makefile
> index 5b2dd7f07a85e..c0da946b281e1 100644
> --- a/net/Makefile
> +++ b/net/Makefile
> @@ -45,7 +45,7 @@ obj-$(CONFIG_WIRELESS)		+=3D wireless/
>  obj-$(CONFIG_MAC80211)		+=3D mac80211/
>  obj-$(CONFIG_TIPC)		+=3D tipc/
>  obj-$(CONFIG_NETLABEL)		+=3D netlabel/
> -obj-$(CONFIG_IUCV)		+=3D iucv/
> +obj-y				+=3D iucv/

[Severity: Low]
Does this create a linker error when CONFIG_AFIUCV=3Dy and CONFIG_IUCV=3Dm?

Because of this unconditional descent, af_iucv.o can be evaluated and built
into vmlinux even when IUCV is configured as a module.

In afiucv_init(), if CONFIG_IUCV=3Dm, IS_ENABLED(CONFIG_IUCV) evaluates to =
1:

net/iucv/af_iucv.c:afiucv_init() {
	...
	if (machine_is_vm() && IS_ENABLED(CONFIG_IUCV)) {
		cpcmd("QUERY USERID", iucv_userid, sizeof(iucv_userid), &err);
		if (unlikely(err)) {
			WARN_ON(err);
			err =3D -EPROTONOSUPPORT;
			goto out;
		}

		pr_iucv =3D &iucv_if;
	} else {
	...
}

Will this cause an undefined reference to the module-bound iucv_if symbol w=
hen
linking vmlinux?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260625061303.3632=
6-1-pengpeng@iscas.ac.cn?part=3D1

