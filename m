Return-Path: <linux-s390+bounces-21967-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id dwnQLD/AT2pQnwIAu9opvQ
	(envelope-from <linux-s390+bounces-21967-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Thu, 09 Jul 2026 17:37:35 +0200
X-Original-To: lists+linux-s390@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 052F673300D
	for <lists+linux-s390@lfdr.de>; Thu, 09 Jul 2026 17:37:35 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b="D/E0QMsG";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-s390+bounces-21967-lists+linux-s390=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-s390+bounces-21967-lists+linux-s390=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B3FC730EDAFE
	for <lists+linux-s390@lfdr.de>; Thu,  9 Jul 2026 15:30:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC9B9312836;
	Thu,  9 Jul 2026 15:30:50 +0000 (UTC)
X-Original-To: linux-s390@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD6C6385D8B;
	Thu,  9 Jul 2026 15:30:48 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783611050; cv=none; b=UYRVjnGK+gIodQ7bznD1RqKeCMpJAdcJBY5AvmZOnkcvDXuyyBiCPu963xzlxrEyYCrvIpti1YT7SRANyXysF/w9vrhnp9LydXcK/PMFH60maSZtIo9UgpEAUsgeZ3FJkIkHHcGJP/TWjeBvZYSXxFE72nGGLKfpHC7aznYZon0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783611050; c=relaxed/simple;
	bh=B+8Ylx9liHwg2gc+xRTqxaYjeOkWwakA571ZWjDPcQo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=XHLmxEPL2cFwblas9Wt8xKK8VzfIbbnJURbcYLSLw4zNgyhitMC45xR4cBHEsgllsoqRPNoxxVAnCojVF5tVCigE/UApBh7nyalpbBK3eJmvQfW3J+KpbjazmPdXYbdBGKSdEW8RaYGzzH2Q0mQeUuGODPwDjLJ3w0n2VLWLOx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D/E0QMsG; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4925F1F000E9;
	Thu,  9 Jul 2026 15:30:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783611047;
	bh=PqT4s10dmSYYhmw50Pq2eN/J80XKy84EM2qgLDSdA2w=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=D/E0QMsGb4XPuB6FxP3OXZ8gBfM6rD+k2sK97/YksG9sqHccIUH/SdAFTzkwBxH90
	 xG9V3SJ6AE8Fil7d+k96XIEXt3EkzD3j82I+EcLKfBRIPxXJyE65vHvUEaQIA9a+yT
	 J/N/fK1IAcmbgBrKLSRnfr+B9qDqrv5o/pACy2VwhptJUWzYGlRNQgK9yMCStsnTJL
	 jk9ezlwuA4YN1oczQDsSkU95gmP9pp2MAj6C1FSD5k2vbPOq+xTnfG4/HIo1z7+77J
	 LIIUro4hM7PmvIHSRcG/9ugiFxCDD0VfrgWNkHMNKPskb9Ht42INMrhRfsFtBJRlqJ
	 eAPe4hmGNcZdg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 19/21] KVM: s390: vsie: Add VSIE shadow stat counters
Reply-To: sashiko-reviews@lists.linux.dev
To: "Christoph Schlameuss" <schlameuss@linux.ibm.com>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>
In-Reply-To: <20260709-vsie-sigpi-v1-19-ea9f12066408@linux.ibm.com>
References: <20260709-vsie-sigpi-v1-0-ea9f12066408@linux.ibm.com>
 <20260709-vsie-sigpi-v1-19-ea9f12066408@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 09 Jul 2026 15:30:46 +0000
Message-Id: <20260709153047.4925F1F000E9@smtp.kernel.org>
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
	TAGGED_FROM(0.00)[bounces-21967-lists,linux-s390=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,sashiko.dev:url,lists.linux.dev:replyto,smtp.kernel.org:mid];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,linux-s390@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:schlameuss@linux.ibm.com,m:hca@linux.ibm.com,m:agordeev@linux.ibm.com,m:linux-s390@vger.kernel.org,m:kvm@vger.kernel.org,m:gor@linux.ibm.com,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 052F673300D

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The vsie_shadow_scb stat counter overcounts allocations during r=
aces, and vsie_shadow_scb_reuse incorrectly counts cache hits rather than r=
esource repurposing.
--

--- Patch [19]: [PATCH 19/21] KVM: s390: vsie: Add VSIE shadow stat counter=
s ---
commit b0e742d7460b00786ba09124150753300ba413ad
Author: Christoph Schlameuss <schlameuss@linux.ibm.com>

KVM: s390: vsie: Add VSIE shadow stat counters

This patch adds new statistics counters to VSIE shadowing to monitor
functionality, specifically tracking the allocations and reuses of SIE
control block and system control area shadows.

> diff --git a/arch/s390/kvm/vsie.c b/arch/s390/kvm/vsie.c
> index c392f7afe130c..80050376eaab1 100644
> --- a/arch/s390/kvm/vsie.c
> +++ b/arch/s390/kvm/vsie.c

[ ... ]

> @@ -2002,6 +2006,7 @@ static struct vsie_page *get_vsie_page_cpu_nr(struc=
t kvm_vcpu *vcpu, struct vsie
>  				vsie_page =3D vsie_page_new;
>  			}
>  		}
> +		vcpu->kvm->stat.vsie_shadow_scb++;

[Severity: Medium]
Does this increment the vsie_shadow_scb counter even when we lose the race
and subsequently free the newly allocated page? It looks like this might
cause the counter to overcount and increment beyond the configured maximum
value when concurrent allocations occur.

>  	}
>  	if (vsie_page !=3D vsie_page_new) {
>  		if (vsie_page_new)
> @@ -2011,6 +2016,7 @@ static struct vsie_page *get_vsie_page_cpu_nr(struc=
t kvm_vcpu *vcpu, struct vsie
>  		if (!try_get_vsie_page(vsie_page))
>  			return ERR_PTR(-EAGAIN);
>  		vsie_page->vsie_sca =3D vsie_sca;
> +		vcpu->kvm->stat.vsie_shadow_scb_reuse++;

[Severity: Medium]
Does this increment vsie_shadow_scb_reuse on every cache hit rather than
just on evictions or repurposing?=20

The guest-2 path appears to only count actual resource repurposing, whereas
counting every cache hit here will cause the metric to increase continuously
during normal execution.

>  	}
>  	if (vsie_page->scb_gpa !=3D scb_gpa || vsie_page->sca_gpa !=3D vsie_sca=
->sca_gpa) {
>  		scoped_guard(mutex, &vcpu->kvm->arch.vsie.mutex) {

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260709-vsie-sigpi=
-v1-0-ea9f12066408@linux.ibm.com?part=3D19

