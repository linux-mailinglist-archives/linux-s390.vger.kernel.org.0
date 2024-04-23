Return-Path: <linux-s390+bounces-3547-lists+linux-s390=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 446628AF479
	for <lists+linux-s390@lfdr.de>; Tue, 23 Apr 2024 18:42:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1F8BCB22A22
	for <lists+linux-s390@lfdr.de>; Tue, 23 Apr 2024 16:42:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5E6413D880;
	Tue, 23 Apr 2024 16:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ravnborg.org header.i=@ravnborg.org header.b="Tw8FQkWz";
	dkim=permerror (0-bit key) header.d=ravnborg.org header.i=@ravnborg.org header.b="MCt7cKSc"
X-Original-To: linux-s390@vger.kernel.org
Received: from mailrelay5-1.pub.mailoutpod2-cph3.one.com (mailrelay5-1.pub.mailoutpod2-cph3.one.com [46.30.211.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5315013D635
	for <linux-s390@vger.kernel.org>; Tue, 23 Apr 2024 16:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.30.211.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713890500; cv=none; b=f8vy5cGxvTujxzCZMqXwb8Yd069yGasgc1sxk5s+GQ2oArca5Sf57YItBV/SGSBOlfir/yFODGIoIe1hT7RAtLOSxdv4kd3uhw1BaEilJFAF7JnRp5Np5Lw8ft1HK549N9zIKogga0QW+QTH4ouE2mKTf6VMXjV5K96XQEQRr+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713890500; c=relaxed/simple;
	bh=Ew4ZwP340aTNrveQuDNc86ipPLYtcqn5HIz7uAO7cFI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qNvsXaT91chuq/dYVCPur7XOGwYE7htYWKUljxfwLB+SxkrqWf9MKu1L4HdegIWIZob7BW3sX9uTqUwYEJ0i4Uxo3Q1/jEtV2vUed1AXo02Y50+MT4ns4IfCUFjalRTevsxG3lN5mDD8j1eV3cc37Bgk4CGQblAisWuVZqnqDnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ravnborg.org; spf=none smtp.mailfrom=ravnborg.org; dkim=pass (2048-bit key) header.d=ravnborg.org header.i=@ravnborg.org header.b=Tw8FQkWz; dkim=permerror (0-bit key) header.d=ravnborg.org header.i=@ravnborg.org header.b=MCt7cKSc; arc=none smtp.client-ip=46.30.211.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ravnborg.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ravnborg.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=ravnborg.org; s=rsa1;
	h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
	 from:date:from;
	bh=ce+ZqFlarA8IAt5zfwbr2hxRLFQAtI7f0O/GFL7QRfQ=;
	b=Tw8FQkWzueJByde49pf2Etw1JNd+9Cs/a8VSdP4sAjZamDT998lpGJ8OUSXZPgdnq9YK80Ld79By0
	 E1ZePxzkIVPPM3w68Ti2ki86ZQSTo/Qengh+ox/5EsZdMfGxT/LtyRbZzNkl+eBPCbtoD00qByBVfh
	 QlogVQorbOUCuNhfuDWjsPIOEK757mimusKghDsKCrDlzJS1s6Psw/PaVE8r407gkh53FMLrF7D1dO
	 uDYiPtxot3rmREDV43Zw4JTzOwK/+pqOJcBE6+tKyTzcGurjSzSuf0Roh28MmUDSp64HXkjpWwAEu0
	 fCub6cvUfUdVz3Rx5TFyQR6t2+r0Tlw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
	d=ravnborg.org; s=ed1;
	h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
	 from:date:from;
	bh=ce+ZqFlarA8IAt5zfwbr2hxRLFQAtI7f0O/GFL7QRfQ=;
	b=MCt7cKScu1j54dhTCuf6RoKzDR6Pxv4AhcExl3aouinnY7Cygl2lgVcGjoVORGMB/icOvVzGnLV0S
	 zdG43KuBQ==
X-HalOne-ID: 4e317c2c-0190-11ef-8c96-edf132814434
Received: from ravnborg.org (2-105-2-98-cable.dk.customer.tdc.net [2.105.2.98])
	by mailrelay5.pub.mailoutpod2-cph3.one.com (Halon) with ESMTPSA
	id 4e317c2c-0190-11ef-8c96-edf132814434;
	Tue, 23 Apr 2024 16:41:22 +0000 (UTC)
Date: Tue, 23 Apr 2024 18:41:17 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Mike Rapoport <rppt@kernel.org>
Cc: linux-kernel@vger.kernel.org, Alexandre Ghiti <alexghiti@rivosinc.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	=?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	"David S. Miller" <davem@davemloft.net>,
	Dinh Nguyen <dinguyen@kernel.org>,
	Donald Dutile <ddutile@redhat.com>,
	Eric Chanudet <echanude@redhat.com>,
	Heiko Carstens <hca@linux.ibm.com>, Helge Deller <deller@gmx.de>,
	Huacai Chen <chenhuacai@kernel.org>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nadav Amit <nadav.amit@gmail.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Russell King <linux@armlinux.org.uk>, Song Liu <song@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Thomas Gleixner <tglx@linutronix.de>, Will Deacon <will@kernel.org>,
	bpf@vger.kernel.org, linux-arch@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org,
	linux-mm@kvack.org, linux-modules@vger.kernel.org,
	linux-parisc@vger.kernel.org, linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, loongarch@lists.linux.dev,
	netdev@vger.kernel.org, sparclinux@vger.kernel.org, x86@kernel.org
Subject: Re: [PATCH v5 04/15] sparc: simplify module_alloc()
Message-ID: <20240423164117.GA897977@ravnborg.org>
References: <20240422094436.3625171-1-rppt@kernel.org>
 <20240422094436.3625171-5-rppt@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240422094436.3625171-5-rppt@kernel.org>

Hi Mike,
On Mon, Apr 22, 2024 at 12:44:25PM +0300, Mike Rapoport wrote:
> From: "Mike Rapoport (IBM)" <rppt@kernel.org>
> 
> Define MODULES_VADDR and MODULES_END as VMALLOC_START and VMALLOC_END
> for 32-bit and reduce module_alloc() to
> 
> 	__vmalloc_node_range(size, 1, MODULES_VADDR, MODULES_END, ...)
> 
> as with the new defines the allocations becames identical for both 32
> and 64 bits.
> 
> While on it, drop unsed include of <linux/jump_label.h>
> 
> Suggested-by: Sam Ravnborg <sam@ravnborg.org>
> Signed-off-by: Mike Rapoport (IBM) <rppt@kernel.org>

Looks good.
Reviewed-by: Sam Ravnborg <sam@ravnborg.org>

