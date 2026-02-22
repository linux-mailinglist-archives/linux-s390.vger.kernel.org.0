Return-Path: <linux-s390+bounces-16393-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uLIOOxN4m2mzzwMAu9opvQ
	(envelope-from <linux-s390+bounces-16393-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Sun, 22 Feb 2026 22:41:39 +0100
X-Original-To: lists+linux-s390@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 896BB1707F0
	for <lists+linux-s390@lfdr.de>; Sun, 22 Feb 2026 22:41:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A32F53008C2C
	for <lists+linux-s390@lfdr.de>; Sun, 22 Feb 2026 21:34:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC2E235B62B;
	Sun, 22 Feb 2026 21:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F3kE5G5Y"
X-Original-To: linux-s390@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85C2414EC73;
	Sun, 22 Feb 2026 21:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771796070; cv=none; b=sQYUOqorpg6PdfpIERBzTU647XMMy8LDXC5znKDDcxKJ67umxC/jSAmqvGbO73E7UgAZ16xeZUz4Z0sUch7893fVBCRD9ARtos2pkZe2KUPzjV7JG12Ne/QWjREBanv4kw/XHcgAsXGm+bng04JsDviEKvzJ8VrntsMgZ0VzlK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771796070; c=relaxed/simple;
	bh=MoM4gAfGlJ1ngKCroMgt6s8hQQRUOv2GP6lsvWBTYTk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=VYGCdeAwCHH9NFzgn1qL0deKb5V2bt1QnvnLM89HwIZqSB21gNnNLmNFFRRov5gHxJHJUoF6AMrkaIQiEhmGCcgueYbKIiRj/LfNjujvghy967I4AYAuhzU+NPApSw3Owyu7j3vlDarhvJdRTp0ktBSUb2VleM4xM3OcdihlWl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F3kE5G5Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3118FC116D0;
	Sun, 22 Feb 2026 21:34:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771796070;
	bh=MoM4gAfGlJ1ngKCroMgt6s8hQQRUOv2GP6lsvWBTYTk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=F3kE5G5YSHiCVZ5mOwWBQ1EmkdZUUxri8FWvUUe1+bPk6Car0R0kut2uvNuYHVkAa
	 g8IvAYcI7E8/6hHCb/jrPziQTKClMwrJ6H0Y/aYHLJyimbtr/frfU8CLViovCDA9UV
	 HIObLbqEucr9FrLIbWX5/hRoPhPnR0+zxQyrVmCTdNaMIGloFGLnnqKAP5W6Ewm6w7
	 I/owa0GiWqAQBaI4TmPdDfE67f10RHZ+BDAgtt/1JTGJALkdfXpJeUzGxFHrjR/KHe
	 NiTE6uiB4kCm6q8SZrGgK2AZmAXo4GAErDwos4utQpdh9gKlK0o0vXjumdP0UVYmSi
	 KhiPc2AZqyPxQ==
From: Thomas Gleixner <tglx@kernel.org>
To: Ryan Roberts <ryan.roberts@arm.com>, Catalin Marinas
 <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Huacai Chen
 <chenhuacai@kernel.org>, Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Paul Walmsley <pjw@kernel.org>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
 Alexander Gordeev <agordeev@linux.ibm.com>, Ingo Molnar
 <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
 <dave.hansen@linux.intel.com>, Kees Cook <kees@kernel.org>, "Gustavo A. R.
 Silva" <gustavoars@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Mark
 Rutland <mark.rutland@arm.com>, "Jason A. Donenfeld" <Jason@zx2c4.com>,
 Ard Biesheuvel <ardb@kernel.org>, Jeremy Linton <jeremy.linton@arm.com>,
 David Laight <david.laight.linux@gmail.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, loongarch@lists.linux.dev,
 linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
 linux-s390@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v4 3/3] randomize_kstack: Unify random source across arches
In-Reply-To: <20260119130122.1283821-4-ryan.roberts@arm.com>
References: <20260119130122.1283821-1-ryan.roberts@arm.com>
 <20260119130122.1283821-4-ryan.roberts@arm.com>
Date: Sun, 22 Feb 2026 22:34:26 +0100
Message-ID: <87ecmcwjh9.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [4.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-16393-lists,linux-s390=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[31];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	GREYLIST(0.00)[pass,body];
	FREEMAIL_TO(0.00)[arm.com,kernel.org,linux.ibm.com,ellerman.id.au,dabbelt.com,eecs.berkeley.edu,redhat.com,alien8.de,linux.intel.com,arndb.de,zx2c4.com,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tglx@kernel.org,linux-s390@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-s390];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 896BB1707F0
X-Rspamd-Action: no action

On Mon, Jan 19 2026 at 13:01, Ryan Roberts wrote:
> I tested an earlier version of this change on x86 bare metal and it
> showed a smaller but still significant improvement. The bare metal
> system wasn't available this time around so testing was done in a VM
> instance. I'm guessing the cost of rdtsc is higher for VMs.

No it's not, unless the hypervisor traps RDTSC, which would be insane as
that would cause massive regressions all over the place.

So guessing is not really helpful if you want to argue performance.

Thanks,

        tglx

