Return-Path: <linux-s390+bounces-20866-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 4wPCGOYrMGq5PQUAu9opvQ
	(envelope-from <linux-s390+bounces-20866-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Mon, 15 Jun 2026 18:44:22 +0200
X-Original-To: lists+linux-s390@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B1965688806
	for <lists+linux-s390@lfdr.de>; Mon, 15 Jun 2026 18:44:21 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=WGci6GuM;
	spf=pass (mail.lfdr.de: domain of "linux-s390+bounces-20866-lists+linux-s390=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-s390+bounces-20866-lists+linux-s390=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3BEC23034BF6
	for <lists+linux-s390@lfdr.de>; Mon, 15 Jun 2026 16:40:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 053BF40B6F4;
	Mon, 15 Jun 2026 16:40:22 +0000 (UTC)
X-Original-To: linux-s390@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F35E240BCD8;
	Mon, 15 Jun 2026 16:40:20 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781541621; cv=none; b=MeQ6bKoyLGat43FTYZPsXLhjIfhzu3DmPsvmq4eYgEymmIgNyNHpU2Mz6BRYVjo+RsQ0I6eEGq1ttR5J9rFUEAWIkliogPQGjGdHNkW9B8QkWDAl4aKgqmmIwfrVGjgkT/DiyEivMyh92SvWkRwBaBI7F82lYTJBduRAM1T0rZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781541621; c=relaxed/simple;
	bh=fMataVjVawB4LuTgNwBuwtbEgT0ewSM13MLu+YUD/ZU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eWfRLvEuxHQxODs+QdN2mxMP1s1VWprHRR1jviXKwqvyekUsPMAqymg5uJlrGZVd+iOIU1Ts2EeRFqteJqjqpA64lEeUERG39Gp/p1/dsYK2L4AiDmZxcFlLq3AsGkeex4yOXwnqri4OmzDA2yDaCyaT4ivR4UQ1JNfn+vKP1Mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WGci6GuM; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53B691F000E9;
	Mon, 15 Jun 2026 16:40:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781541620;
	bh=vHty5W1wLqvhVA3NeN6Yxjt6mgiQU3qRuLgqXzcXCXU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=WGci6GuMdB0mo+nUhnNFMwQrhgskGSaFTvcoQLVPEZJJW73YRzmg7gIFIRLY0S8po
	 99tFzKc05fpHL/jgia6n2n9qZiymdXvJCVHpIQxcywP7m7CfWu1XSeVQVIugIUXQ3f
	 tlSAJMjKeEAHbdbHUzd1T1E9p05hepObfQfc6WBcqtkdD9fcu5pMB3IjSOB4dqJSVU
	 8I2DuxyL9rdZOuWkXAujxIAREGV2OorauQfkMfcCbgMK7lskRRTVgzDY+8LrJXa5QN
	 ttveTzCA5x8akcW40vqsv0JuullEh7MchJhB0hK9v7xR6/NAotAxakaZyON0f9phSu
	 ValGSIoNExDSg==
Date: Mon, 15 Jun 2026 12:40:13 -0400
From: Nathan Chancellor <nathan@kernel.org>
To: Jan Polensky <japo@linux.ibm.com>
Cc: hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
	ojeda@kernel.org, peterz@infradead.org, jpoimboe@kernel.org,
	jbaron@akamai.com, aliceryhl@google.com, borntraeger@linux.ibm.com,
	svens@linux.ibm.com, boqun@kernel.org, gary@garyguo.net,
	bjorn3_gh@protonmail.com, lossin@kernel.org, a.hindborg@kernel.org,
	tmgross@umich.edu, dakr@kernel.org, rostedt@goodmis.org,
	ardb@kernel.org, linux-s390@vger.kernel.org,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 6/6] s390: Enable Rust support
Message-ID: <20260615164013.GA249489@ax162>
References: <20260608181451.3734956-1-japo@linux.ibm.com>
 <20260608181451.3734956-7-japo@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260608181451.3734956-7-japo@linux.ibm.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:japo@linux.ibm.com,m:hca@linux.ibm.com,m:gor@linux.ibm.com,m:agordeev@linux.ibm.com,m:ojeda@kernel.org,m:peterz@infradead.org,m:jpoimboe@kernel.org,m:jbaron@akamai.com,m:aliceryhl@google.com,m:borntraeger@linux.ibm.com,m:svens@linux.ibm.com,m:boqun@kernel.org,m:gary@garyguo.net,m:bjorn3_gh@protonmail.com,m:lossin@kernel.org,m:a.hindborg@kernel.org,m:tmgross@umich.edu,m:dakr@kernel.org,m:rostedt@goodmis.org,m:ardb@kernel.org,m:linux-s390@vger.kernel.org,m:rust-for-linux@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	FORGED_SENDER(0.00)[nathan@kernel.org,linux-s390@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-20866-lists,linux-s390=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nathan@kernel.org,linux-s390@vger.kernel.org];
	FREEMAIL_CC(0.00)[linux.ibm.com,kernel.org,infradead.org,akamai.com,google.com,garyguo.net,protonmail.com,umich.edu,goodmis.org,vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-s390];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,ax162:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B1965688806

Hi all,

On Mon, Jun 08, 2026 at 08:14:51PM +0200, Jan Polensky wrote:
> Enable building Rust code on s390 by wiring the architecture into the
> kernel Rust infrastructure.
> 
> Add s390 to the Rust arch support documentation, provide the s390 Rust
> target and required compiler flags, and set the bindgen target for
> arch/s390. Adjust the Rust target generation and minimum rustc version
> gating so the s390 setup is handled explicitly.
> 
> The Rust toolchain uses the "s390x" triple naming for the 64 bit target.
> 
> Rust support is currently incompatible with CONFIG_EXPOLINE, which
> relies on compiler support for the -mindirect-branch= and
> -mfunction_return= options. Therefore, select HAVE_RUST only when
> EXPOLINE is disabled.
> 
> Acked-by: Miguel Ojeda <ojeda@kernel.org>
> Acked-by: Heiko Carstens <hca@linux.ibm.com>
> Signed-off-by: Jan Polensky <japo@linux.ibm.com>
...
> diff --git a/arch/s390/Makefile b/arch/s390/Makefile
> index 297976b41088..8b712cd85fcd 100644
> --- a/arch/s390/Makefile
> +++ b/arch/s390/Makefile
> @@ -35,25 +35,31 @@ KBUILD_CFLAGS_DECOMPRESSOR += $(if $(CONFIG_DEBUG_INFO),-g)
>  KBUILD_CFLAGS_DECOMPRESSOR += $(if $(CONFIG_DEBUG_INFO_DWARF4), $(call cc-option, -gdwarf-4,))
>  KBUILD_CFLAGS_DECOMPRESSOR += $(if $(CONFIG_CC_NO_ARRAY_BOUNDS),-Wno-array-bounds)
>  
> +KBUILD_RUSTFLAGS += --target=s390x-unknown-none-softfloat -Zpacked-stack -Ctarget-feature=+backchain

With Rust 1.96.0, I see the following warning several times when
building Rust code in -next:

  warning: unstable feature specified for `-Ctarget-feature`: `backchain`
    |
    = note: this feature is not stably supported; its behavior can change in the future

  warning: 1 warning emitted

I assume this is expected? If so, is there a way to silence this warning?

-- 
Cheers,
Nathan

