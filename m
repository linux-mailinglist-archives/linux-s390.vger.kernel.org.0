Return-Path: <linux-s390+bounces-21641-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id pydnFjKcS2qjWwEAu9opvQ
	(envelope-from <linux-s390+bounces-21641-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Mon, 06 Jul 2026 14:14:42 +0200
X-Original-To: lists+linux-s390@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A22A47105E2
	for <lists+linux-s390@lfdr.de>; Mon, 06 Jul 2026 14:14:41 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=W797Ck1G;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-s390+bounces-21641-lists+linux-s390=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-s390+bounces-21641-lists+linux-s390=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6F589372F00A
	for <lists+linux-s390@lfdr.de>; Mon,  6 Jul 2026 10:13:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 123C13FB7DE;
	Mon,  6 Jul 2026 10:07:37 +0000 (UTC)
X-Original-To: linux-s390@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C589B3F39C8;
	Mon,  6 Jul 2026 10:07:35 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783332457; cv=none; b=QS/NOmFurik4QUmyoF5sS8D/mSptjD2Wqlf7NvVRfrGLi1H3mYYFukVIWp/bMauKFuzy+7xrx72jDkgr/T4AiM/zTZ4GTPeX2Ny+4HUzRhoPm4DKCGxM2b+4YkGWc9dD8TECGN9WcK6d5r5LREqkJ6RCrImq8v2+frC+KmI8pp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783332457; c=relaxed/simple;
	bh=0mARI9NqBr02u9MtA9QTXVlxvz3ySYlgX0OoHlqtSOY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=RqdmYzyPsLUb8lhT4280r4Yf01xeYcvVj1GD+8QkanqWWvDlakw16KcPDXxbKjiIxeoTAC+Dfi3Kv6NOVDuu6VaHRnXiA2uTdkXiX2Nu1jeAo1rcsbM5cFGl/O6d4JWRu9aBb1YJtsqmya3246tHiKz8N4mL3UCxj8z61P1M4QM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W797Ck1G; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE9C41F00A3A;
	Mon,  6 Jul 2026 10:07:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783332455;
	bh=ptmLlOsc1w2hJGNQWmd+hjRLZLNTLKwKwXMBTdraPdY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=W797Ck1GN5g3caXofpI2g66b3VsbdIGxTdSgFPK4H7PNkC31shLFQrJlTtRHH1AuK
	 prrLueXW2RsE6jjBUT9B5uPpyZ24FWBnAYuKy5lvJ7dE8voGa5SOtuvGZs7uCif42g
	 jvM9jfKtfyeL+BEubyeP4KNeG18ILUrTrSHQx0VRGzp68d2ejAI+vBFWz7OCU6ivg3
	 U0yPY5H+kpW8usQVFEW5wEvocyfspfMbe304ATb0DVqbQiDq3lpOpQStWsAdik8dvW
	 fFHxhNHEWBvtp3kzH8TUqkqOIFAPn2DyC3HdbX1adN3uu6ad7qcIdAGRtGz0knMwq/
	 0j7+qaL/rLO/w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 27/27] KVM: s390: arm64: Enable KVM_ARM64 config and
 Kbuild
Reply-To: sashiko-reviews@lists.linux.dev
To: "Steffen Eiden" <seiden@linux.ibm.com>
Cc: kvm@vger.kernel.org, "Vasily Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org, kvmarm@lists.linux.dev, "Oliver
 Upton" <oupton@kernel.org>, "Heiko Carstens" <hca@linux.ibm.com>, "Marc
 Zyngier" <maz@kernel.org>, "Alexander Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260706085229.979525-28-seiden@linux.ibm.com>
References: <20260706085229.979525-1-seiden@linux.ibm.com>
 <20260706085229.979525-28-seiden@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 06 Jul 2026 10:07:34 +0000
Message-Id: <20260706100734.DE9C41F00A3A@smtp.kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-21641-lists,linux-s390=lfdr.de];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashiko-bot@kernel.org,linux-s390@vger.kernel.org];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,linux-s390@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:seiden@linux.ibm.com,m:kvm@vger.kernel.org,m:gor@linux.ibm.com,m:linux-s390@vger.kernel.org,m:kvmarm@lists.linux.dev,m:oupton@kernel.org,m:hca@linux.ibm.com,m:maz@kernel.org,m:agordeev@linux.ibm.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-s390];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[smtp.kernel.org:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,lists.linux.dev:replyto,sashiko.dev:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A22A47105E2

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [High] Recompiling virt/kvm core code creates duplicate exported symbols,=
 causing modpost failures or type confusion.
- [High] Concurrent execution of generic KVM initialization by two separate=
 modules will clash on singleton resources like /dev/kvm.
- [High] The Makefile uses `nm -jU` and `objcopy -O default`, which are inv=
alid for standard GNU binutils, breaking the build.
- [High] Core KVM files compiled for the arm64 module will incorrectly incl=
ude the s390 architecture headers instead of arm64 headers.
--

commit 2fa0a606e2ea5038c2f6e6df6ba70d3165729ce4
Author: Steffen Eiden <seiden@linux.ibm.com>

KVM: s390: arm64: Enable KVM_ARM64 config and Kbuild

Add all Kbuild/Makefile configurations to build a second KVM module on
s390 implementing the arm64-KVM API. To prevent symbol conflicts with
kvm-s390 all internal symbols in kvm-arm64 are mangled if compiled as
built-in.

> diff --git a/arch/s390/kvm/arm64/Makefile b/arch/s390/kvm/arm64/Makefile
> new file mode 100644
> index 0000000000000..566040725ab57
> --- /dev/null
> +++ b/arch/s390/kvm/arm64/Makefile
> @@ -0,0 +1,94 @@
[ ... ]
> +include $(src)/Makefile.gen
> +
> +ccflags-y +=3D -I $(src) -I $(objtree)/$(obj) -I$(srctree)/arch/s390/kvm=
/gmap -I$(srctree)/arch/arm64/include -I$(srctree)/arch/arm64/kvm -DKVM_S39=
0_ARM64

[Severity: High]
Does this successfully override the architecture include path?

Kbuild places LINUXINCLUDE (which contains -I$(srctree)/arch/$(SRCARCH)/inc=
lude
pointing to s390) before ccflags-y in the compiler invocation.

When the generic KVM code includes <asm/kvm_host.h>, will it incorrectly
resolve to the s390 header instead of the arm64 header, leading to compilat=
ion
errors or ABI mismatches?

> +
> +kvm-arm64-obj :=3D \
> +	arm.o \

[Severity: High]
Will compiling a second copy of the core KVM logic into the system duplicate
static resource registrations?

The generic KVM initialization code in kvm_init() assumes it is a singleton
per kernel and attempts to register the /dev/kvm misc device with a fixed
minor number. If both kvm-s390 and kvm-arm64 are loaded, will the second
module's initialization fail with -EBUSY when registering the misc device?

> +	guest.o \
> +	handle_exit.o \
> +	inject_fault.o \
> +	mmu.o \
> +	mmio.o \
> +	reset.o \
> +
> +kvm-arm64-obj +=3D $(patsubst %.o,%-arm64.o,$(kvm-y))

[Severity: High]
Does recompiling the virt/kvm core code here create duplicate exported
symbols?

When configured as modules, compiling the generic KVM core a second time
results in modpost fatal errors for exported twice symbols. When configured
as built-in, objcopy --localize-symbols modifies the symbol table but fails
to strip __ksymtab data sections, leaving duplicate KVM exports in vmlinux.

Could this lead to unpredictable symbol resolution for modules like vfio?

[ ... ]
> +LDFLAGS_kvm-unnamespaced.o :=3D -r --whole-archive
> +$(obj)/kvm-unnamespaced.o: $(addprefix $(obj)/,$(kvm-arm64-obj)) FORCE
> +	$(call if_changed_rule,ld_o_o)
> +
> +# Make list of symbols to localize.
> +# Collect normal/exported symbols. Use dict as set for deduplication.
> +# TODO extract do script
> +quiet_cmd_nm_filter =3D NMFLTR  $@
> +	cmd_nm_filter =3D $(NM) -jU $< | sort -u > $@

[Severity: High]
Are the nm flags -jU supported by standard GNU binutils?

GNU nm lacks -j and -U, which are widely used in kernel builds. Will this
cause build failures when CONFIG_KVM_ARM64=3Dy?

> +
> +$(obj)/kvm_symbol_list: $(obj)/kvm-unnamespaced.o FORCE
> +	$(call if_changed,nm_filter)
> +
> +define rule_oc_o_o
> +	$(call cmd_and_savecmd,objcopy)
> +	$(call cmd,gen_objtooldep)
> +	$(call cmd,gen_symversions_o)
> +endef
> +
> +OBJCOPYFLAGS_kvm-namespaced.o :=3D -O default --localize-symbols=3D$(obj=
)/kvm_symbol_list

[Severity: High]
Is the -O default flag valid for GNU objcopy?

GNU objcopy rejects default as an invalid BFD target, which may break the
build when localizing these symbols.

> +$(obj)/kvm-namespaced.o: $(obj)/kvm-unnamespaced.o $(obj)/kvm_symbol_lis=
t FORCE
> +	$(call if_changed_rule,oc_o_o)

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260706085229.9795=
25-1-seiden@linux.ibm.com?part=3D27

