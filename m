Return-Path: <linux-s390+bounces-22148-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 28UjGAEEVWq6iwAAu9opvQ
	(envelope-from <linux-s390+bounces-22148-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Mon, 13 Jul 2026 17:28:01 +0200
X-Original-To: lists+linux-s390@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id E610374D081
	for <lists+linux-s390@lfdr.de>; Mon, 13 Jul 2026 17:28:00 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=IqKOm3ij;
	spf=pass (mail.lfdr.de: domain of "linux-s390+bounces-22148-lists+linux-s390=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-s390+bounces-22148-lists+linux-s390=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6F7E2300CD80
	for <lists+linux-s390@lfdr.de>; Mon, 13 Jul 2026 15:27:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ECFA3E2752;
	Mon, 13 Jul 2026 15:27:40 +0000 (UTC)
X-Original-To: linux-s390@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 239F03DF001;
	Mon, 13 Jul 2026 15:27:39 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783956460; cv=none; b=R5VdPmILmm8s52QOGzWpTJGJN4tlhbWxhGy0xryJqx/2+xe/Kzr0MMLTg2aDh9sD0zUT5PHRvxDkjUufeo6tmE5lj+lvaUUv491tlIoOwbicskhziIQ7Hq1f/UZRJqmhbq6ne1zE+Odhu0NMfoMYzwgNasAD1/OPg2vTkCIVbdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783956460; c=relaxed/simple;
	bh=60JHkZymDI7/1yM4II0B1H9zGPlMeUMUnSgHQVxVMWk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=EYsH2mgg0O9wr+Kg84muK0vS9sHhiAiSUm/QnYM3T3sRx5knOGKiEfhmAHNeGXeBw1Y9HFWlDhJCNb707lYPxIQKqk/QQAOL0gEQNobSYmyhhL89k6t20WL681q4YapqzW6TmzwwFr/24vB6mxyWzbxEJmOxs+36uH48MTtild4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IqKOm3ij; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7C381F000E9;
	Mon, 13 Jul 2026 15:27:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783956459;
	bh=LHsYzUgH5ZMspr7QqHurDGM0StFNMuqAvjcJ+IDUAOE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=IqKOm3ijcUQQ5k5sDOz6QZCSChlnJg1p1jDDupTL9k+6xbY9sBaImBvW+RW2aKOOB
	 tsA2MJXOa5aHKdIaLHCt7wepAxoh/vnFLkQX6NwoywV/sUxCLiTsQSRQfWPrMcs4Uq
	 0MyZ8k6RpVw97YZsgIntQypLPCHrsE0qXDPhqli5G7hciHR2Tn3x/0YKj+pcNGLjgt
	 5NO3CT7tSkTJfmUE2SmeawT9Gj0l05ZEMb6/ZnMQO0ZOz0K8Ph3voah6yuEa5O58t3
	 B9b03gAbigRDn8zEgC+ZTXNM6rvfv8zaER/7HqJFBw+3Pzm9FxnQ9F7ho8adnVM0rc
	 76I+X6lxe2+Ow==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/7] KVM: s390: Return -EFAULT instead of
 PGM_ADDRESSING
Reply-To: sashiko-reviews@lists.linux.dev
To: "Claudio Imbrenda" <imbrenda@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Vasily Gorbik" <gor@linux.ibm.com>, "Heiko
 Carstens" <hca@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, kvm@vger.kernel.org
In-Reply-To: <20260713150857.269954-3-imbrenda@linux.ibm.com>
References: <20260713150857.269954-1-imbrenda@linux.ibm.com>
 <20260713150857.269954-3-imbrenda@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 13 Jul 2026 15:27:38 +0000
Message-Id: <20260713152738.A7C381F000E9@smtp.kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-22148-lists,linux-s390=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,smtp.kernel.org:mid,vger.kernel.org:from_smtp,sashiko.dev:url,lists.linux.dev:replyto];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,linux-s390@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:imbrenda@linux.ibm.com,m:linux-s390@vger.kernel.org,m:gor@linux.ibm.com,m:hca@linux.ibm.com,m:agordeev@linux.ibm.com,m:kvm@vger.kernel.org,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E610374D081

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The patch fails to fix the `KVM_S390_KEYOP` ioctl, which silently =
ignores and leaks positive program exception codes (e.g., `PGM_ADDRESSING`)=
 to userspace in the exact same way as the patched functions.
--

--- Patch [2]: [PATCH v2 2/7] KVM: s390: Return -EFAULT instead of PGM_ADDR=
ESSING ---
commit 4941b5a35b7857c25a5086d12db876b148a9642d
Author: Claudio Imbrenda <imbrenda@linux.ibm.com>

KVM: s390: Return -EFAULT instead of PGM_ADDRESSING

If kvm_s390_set_cmma_bits() is asked to set CMMA values outside of a
memslot, PGM_ADDRESSING (5) is returned, instead of a negative error
value. Same issue with kvm_s390_{g,s}et_skeys().

Fix by returning -EFAULT whenever the return value would be > 0, which
is consistent with the behaviour before the gmap rewrite.

> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
> index 374dae6dae81b..53691aaf6534c 100644
> --- a/arch/s390/kvm/kvm-s390.c
> +++ b/arch/s390/kvm/kvm-s390.c
> @@ -2212,7 +2212,7 @@ static int kvm_s390_get_skeys(struct kvm *kvm, stru=
ct kvm_s390_skeys *args)
>  	}
> =20
>  	kvfree(keys);
> -	return r;
> +	return r <=3D 0 ? r : -EFAULT;
>  }

[Severity: High]
This isn't a bug introduced by this patch, but does the same issue exist in
kvm_s390_keyop() and the KVM_S390_KEYOP ioctl handler?

When memory functions like dat_get_storage_key() return PGM_ADDRESSING (5),
kvm_s390_keyop() passes the positive exception code back to its caller with=
out
converting it to -EFAULT:

arch/s390/kvm/kvm-s390.c:kvm_s390_keyop() {
    ...
	case KVM_S390_KEYOP_ISKE:
		r =3D dat_get_storage_key(asce, gfn, &skey);
		if (!r)
			return skey.skey;
		break;
    ...
	return r;
}

The KVM_S390_KEYOP handler then treats any positive return value from
kvm_s390_keyop() as a success, silently leaking the exception code into
kop.key and returning 0 to userspace:

arch/s390/kvm/kvm-s390.c:kvm_arch_vm_ioctl() {
    ...
		r =3D kvm_s390_keyop(mc, kvm, kop.operation, kop.guest_addr, skey);
		kvm_s390_free_mmu_cache(mc);
		if (r < 0)
			break;

		kop.key =3D r;
		r =3D 0;
		if (copy_to_user(argp, &kop, sizeof(kop)))
    ...
}

Since kvm_s390_keyop() conflates valid storage keys with exception codes,
userspace is fundamentally unable to detect that the memory access failed.

Should KVM_S390_KEYOP be updated to handle positive return codes similarly
to the functions fixed in this patch?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260713150857.2699=
54-1-imbrenda@linux.ibm.com?part=3D2

