Return-Path: <linux-s390+bounces-9871-lists+linux-s390=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF565A80FA2
	for <lists+linux-s390@lfdr.de>; Tue,  8 Apr 2025 17:18:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0CA608820EB
	for <lists+linux-s390@lfdr.de>; Tue,  8 Apr 2025 15:15:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A2F122ACE7;
	Tue,  8 Apr 2025 15:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="TB19qP6W"
X-Original-To: linux-s390@vger.kernel.org
Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0D6122A7E0
	for <linux-s390@vger.kernel.org>; Tue,  8 Apr 2025 15:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744125311; cv=none; b=IxbuPYvXeNJClq6yd9kd13ac/yY8ad3IuLeyFmsEBXdVMhQrl9TOBz3PDKUBcNrUgmCTi16ccUR5ZqKg9ITPPGEIxui6Y5y69q2vpH4ASsVCwi2Aa4P3zDeRasgQxPkUYFsCiUH3BGEiT8ExKyQyYXL6fUvLjikyQSiaVQXqOGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744125311; c=relaxed/simple;
	bh=3HhnmiRuLz1M5Qj5NXBbxG42T6BiHz78XH6n147Dls8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dzl5a3TUJxZo4HCPpDYeBGFNpsmUh59dseb786pIRVlru8g9RTr1XHRo3o2HfUc1F3I60WqujQm5HcOHutG/Sr+YbW684VVGnPIoFMvo2sUpN4+wVj7X+440qbBbSDzXilgB7EErgx9aiaLDn4tIqPy9HmD5rjBnaDUanalWCyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=TB19qP6W; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 8 Apr 2025 17:15:00 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1744125308;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qQDjU0c2FbbyMqE7EvnqvZnYPTTk0XjInWyGR5u9l98=;
	b=TB19qP6W0TSkS/JzrH/dfnjAIyMyKp0E32t7zyl3dQmRzp7svN2DWXRoM0L+FuOLwJOv8t
	wlqHm4njHEv2lNIAcoLYkfo2nvZjtS/pnWFsI8JzpzKOZO3gi0lDsqO6RyaTjZZlQEKKfl
	xNTL3KPDwoli7i0CO5a8F3ad/BM4jGk=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Andrew Jones <andrew.jones@linux.dev>
To: kvm@vger.kernel.org, kvmarm@lists.linux.dev, 
	kvm-riscv@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org
Cc: pbonzini@redhat.com, thuth@redhat.com, alexandru.elisei@arm.com, 
	eric.auger@redhat.com, lvivier@redhat.com, frankja@linux.ibm.com, 
	imbrenda@linux.ibm.com, nrb@linux.ibm.com
Subject: Re: [kvm-unit-tests PATCH v2] Makefile: Use CFLAGS in cc-option
Message-ID: <20250408-f7b9cefc2e8b16bad04debc3@orel>
References: <20250307091828.57933-2-andrew.jones@linux.dev>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250307091828.57933-2-andrew.jones@linux.dev>
X-Migadu-Flow: FLOW_OUT

On Fri, Mar 07, 2025 at 10:18:29AM +0100, Andrew Jones wrote:
> When cross compiling with clang we need to specify the target in
> CFLAGS and cc-option will fail to recognize target-specific options
> without it. Add CFLAGS to the CC invocation in cc-option.
> 
> The introduction of the realmode_bits variable is necessary to
> avoid make failing to build x86 due to CFLAGS referencing itself.
> 
> Signed-off-by: Andrew Jones <andrew.jones@linux.dev>
> ---
> v2:
>  - Fixed x86 builds with the realmode_bits variable
> 
>  Makefile            | 2 +-
>  x86/Makefile.common | 3 ++-
>  2 files changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/Makefile b/Makefile
> index 78352fced9d4..9dc5d2234e2a 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -21,7 +21,7 @@ DESTDIR := $(PREFIX)/share/kvm-unit-tests/
>  
>  # cc-option
>  # Usage: OP_CFLAGS+=$(call cc-option, -falign-functions=0, -malign-functions=0)
> -cc-option = $(shell if $(CC) -Werror $(1) -S -o /dev/null -xc /dev/null \
> +cc-option = $(shell if $(CC) $(CFLAGS) -Werror $(1) -S -o /dev/null -xc /dev/null \
>                > /dev/null 2>&1; then echo "$(1)"; else echo "$(2)"; fi ;)
>  
>  libcflat := lib/libcflat.a
> diff --git a/x86/Makefile.common b/x86/Makefile.common
> index 0b7f35c8de85..e97464912e28 100644
> --- a/x86/Makefile.common
> +++ b/x86/Makefile.common
> @@ -98,6 +98,7 @@ tests-common = $(TEST_DIR)/vmexit.$(exe) $(TEST_DIR)/tsc.$(exe) \
>  ifneq ($(CONFIG_EFI),y)
>  tests-common += $(TEST_DIR)/realmode.$(exe) \
>  		$(TEST_DIR)/la57.$(exe)
> +realmode_bits := $(if $(call cc-option,-m16,""),16,32)
>  endif
>  
>  test_cases: $(tests-common) $(tests)
> @@ -108,7 +109,7 @@ $(TEST_DIR)/realmode.elf: $(TEST_DIR)/realmode.o
>  	$(LD) -m elf_i386 -nostdlib -o $@ \
>  	      -T $(SRCDIR)/$(TEST_DIR)/realmode.lds $^
>  
> -$(TEST_DIR)/realmode.o: bits = $(if $(call cc-option,-m16,""),16,32)
> +$(TEST_DIR)/realmode.o: bits = $(realmode_bits)
>  
>  $(TEST_DIR)/access_test.$(bin): $(TEST_DIR)/access.o
>  
> -- 
> 2.48.1
>

Merged through arm/queue.

Thanks,
drew

