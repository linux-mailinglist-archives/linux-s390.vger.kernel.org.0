Return-Path: <linux-s390+bounces-22054-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id eclzCIgQUWqo+wIAu9opvQ
	(envelope-from <linux-s390+bounces-22054-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Fri, 10 Jul 2026 17:32:24 +0200
X-Original-To: lists+linux-s390@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 112EC73C461
	for <lists+linux-s390@lfdr.de>; Fri, 10 Jul 2026 17:32:23 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=eNojz+Ec;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-s390+bounces-22054-lists+linux-s390=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="linux-s390+bounces-22054-lists+linux-s390=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 35FFD3004D02
	for <lists+linux-s390@lfdr.de>; Fri, 10 Jul 2026 15:29:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88C53214812;
	Fri, 10 Jul 2026 15:29:22 +0000 (UTC)
X-Original-To: linux-s390@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6107623BCF7
	for <linux-s390@vger.kernel.org>; Fri, 10 Jul 2026 15:29:21 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783697362; cv=none; b=i0ntUUk/EeI7M1t+GGk+RWRIJ3tTdnQcP+c5EV7NOEY3ih09oRafhJKMg3cjrvA2LkxHeGdl8iFOPJUiMz07oNYvxOucPBLdeJQFOGeXKApf7UwJ6vhLucsaIx3uKwzvOsGda1hlJSIzH4CKcPj6+DmMSEiI5UaKUSAj3eLR7UQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783697362; c=relaxed/simple;
	bh=9or+SXkJ/CXH/A9+Wh0yCcNWqMiLNf3q1zgH3d+w8pk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=TI2H0p30QtjdnlC43Yw/yWVATFXChUgQIPmwLm4+41JMx0rjUn/CkL6iELiA5arnchSkNBzF5vw0Gz/5y2I95+vIHHpNeQJ8TtJll48m8YlBZnUmldPBhums883dx9SMs+dllnVhi2a1KF2uGsFFs7mtmEUVHRonhYXmLosKh9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eNojz+Ec; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9826E1F000E9;
	Fri, 10 Jul 2026 15:29:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783697360;
	bh=aR//PLd7mNq9ZiyEzJc2cpvzO993ApC//JKgLNw51RQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=eNojz+EckGkkrzbKMBfUAj7/5CcMjZ44ZjzhbgtAW8lhtkie1mXmK5UcAHPXZ9PuT
	 T5Xx7nk9atfNBkDHHpf02Pb5JvB7TGagYwVDhen/VqEUtCTmFahlu+unkutgVGTM3Z
	 bc4wOJDCAg9/8oMeDHG0gRLPSXOYHunZdKL2ZKN9Vhfym8fbWGwoGihlOX+Cm9EaZL
	 YEB7+fWQ8hHhKzOyhVJe6Me8TQhTnd9LJ4JuwwARt1wkAMgFp6xDRQjVId5KFcfeHF
	 ZILHr2o9bBO0QJS8PKpVoBNT0EI2gMjefQItThiZAn2GfpuE1ZRFmM00MivMI9bhFf
	 VEqfZShgJ6Wrw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 1/1] s390/zcrypt: Improve zcrypt reply message
 verification checks
Reply-To: sashiko-reviews@lists.linux.dev
To: "Harald Freudenberger" <freude@linux.ibm.com>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>
In-Reply-To: <20260710151005.79765-2-freude@linux.ibm.com>
References: <20260710151005.79765-1-freude@linux.ibm.com>
 <20260710151005.79765-2-freude@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 10 Jul 2026 15:29:20 +0000
Message-Id: <20260710152920.9826E1F000E9@smtp.kernel.org>
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
	TAGGED_FROM(0.00)[bounces-22054-lists,linux-s390=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,lists.linux.dev:replyto,vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,smtp.kernel.org:mid];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,linux-s390@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:freude@linux.ibm.com,m:hca@linux.ibm.com,m:agordeev@linux.ibm.com,m:linux-s390@vger.kernel.org,m:gor@linux.ibm.com,s:lists@lfdr.de];
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
X-Rspamd-Queue-Id: 112EC73C461

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [Medium] Uninitialized memory usage and buffer reuse leading to kernel he=
ap information leak
--

--- Patch [1]: [PATCH v5 1/1] s390/zcrypt: Improve zcrypt reply message ver=
ification checks ---
commit 52b1c279b5cba2ecec495171bd1e75b2e86fc109
Author: Harald Freudenberger <freude@linux.ibm.com>

s390/zcrypt: Improve zcrypt reply message verification checks

This commit improves reply message verification checks for CCA and EP11
messages in the zcrypt device driver. It updates length field checking to u=
se
size_t and ensures bounds checking before using values to invoke memcpy.

Cc: stable@vger.kernel.org

> diff --git a/drivers/s390/crypto/zcrypt_msgtype6.c b/drivers/s390/crypto/=
zcrypt_msgtype6.c
> index 40f72cdf284d3..8252fd1856638 100644
> --- a/drivers/s390/crypto/zcrypt_msgtype6.c
> +++ b/drivers/s390/crypto/zcrypt_msgtype6.c
> @@ -853,7 +860,7 @@ static void zcrypt_msgtype6_receive(struct ap_queue *=
aq,
>  	};
>  	struct ap_response_type *resp_type =3D &msg->response;
>  	struct type86x_reply *t86r;
> -	int len;
> +	size_t len, len1, len2 =3D 0;
> =20
>  	/* Copy the reply message to the request message buffer. */
>  	if (!reply)
> @@ -863,7 +870,8 @@ static void zcrypt_msgtype6_receive(struct ap_queue *=
aq,
>  	    t86r->cprbx.cprb_ver_id =3D=3D 0x02) {

[Severity: Medium]
This is a pre-existing issue, but is it possible for a short reply to cause
an out-of-bounds read here? The cprb_ver_id field is accessed before verify=
ing
that reply->len is large enough to contain the CPRBX header.

Additionally, if the hardware returns a response that hits the else branch
in zcrypt_msgtype6_receive():

drivers/s390/crypto/zcrypt_msgtype6.c:zcrypt_msgtype6_receive() {
	...
	} else {
		memcpy(msg->msg, reply->msg, sizeof(error_reply));
		msg->len =3D sizeof(error_reply);
	}
	...
}

Only 8 bytes (sizeof(error_reply)) are copied, and the rest of msg->msg
remains user-controlled from the original request.

Could a malicious user craft a request via ZSECSENDCPRB embedding specific
values for cprb_ver_id and fmt2.offset2/count2, and if a short response
forces the else branch, bypass verification?

If convert_response_xcrb() reads the mixed buffer, sees TYPE86_RSP_CODE,
and validates cprb_ver_id =3D=3D 0x02 from the user's data, it would call
convert_type86_xcrb(), which then copies arbitrary kernel heap memory to
user space using the user-controlled offsets:

drivers/s390/crypto/zcrypt_msgtype6.c:convert_type86_xcrb() {
	...
		if (z_copy_to_user(userspace, xcrb->reply_data_addr,
				   data + msg->fmt2.offset2, msg->fmt2.count2))
			return -EFAULT;
	...
}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260710151005.7976=
5-2-freude@linux.ibm.com?part=3D1

