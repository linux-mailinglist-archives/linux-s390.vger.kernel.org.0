Return-Path: <linux-s390+bounces-5967-lists+linux-s390=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BBA5C97225A
	for <lists+linux-s390@lfdr.de>; Mon,  9 Sep 2024 21:07:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A4271F2499D
	for <lists+linux-s390@lfdr.de>; Mon,  9 Sep 2024 19:07:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7C02189B98;
	Mon,  9 Sep 2024 19:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="zt1diLUK"
X-Original-To: linux-s390@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 128CF189B8B
	for <linux-s390@vger.kernel.org>; Mon,  9 Sep 2024 19:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725908855; cv=none; b=AOuRCnc1ed6OGO5M3vGyMmU0h5I8b7dwbutbaMnY6WMQ3AdlQuxX4UxBW5xlXsegNAMWDqGYB4bkBov4y9Hnfoh6YNHMvM3ie6Jn381bnhPRIg6mJE8IHJCx7G6HgChSlLml0L3CIvTVtY3ayR6DMzfu0UhQifpH8XeUXWtV4Xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725908855; c=relaxed/simple;
	bh=b5qblVINKWpCxCCHs3yo0m2YOZxorXz/O91qn7T/Zoo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iCcgt1ozzdROahWC9ei8B6Te9dNjPhXN/SIU2rR3NYAejUFto7S53y5gWVZfPI6o6GkoVhPcSZujZOzHithHYdCCJuubvIkscYnk/HBXRt4Ox9/rHNIYPQ5Nm9Yz5GT5IZQBZsuor4Qx4dCyvVnC1uLsJkKMzc0T9PJQjqvu7wQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=zt1diLUK; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-207115e3056so17409815ad.2
        for <linux-s390@vger.kernel.org>; Mon, 09 Sep 2024 12:07:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1725908852; x=1726513652; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KeQ2Et/fFCRS76/RDVc52ODWIM932uTGcPwA4XQOW3E=;
        b=zt1diLUKBRzBgAAhuaS3c65B403jJ1PIWUnGUl7eLQcBXezTKo/zOEjDsLVBcXivZm
         hC6VwfUcRBGNGsO2vpWaquCMchhsO1SduftMewCg1y8Ps9A74s6zd1z8oT/bL8BcvVGm
         fib4NpZAv18x27QuJtV0noRd2jBa01UgFAXYQLPl/GFvj9IxJuZprEzq8zAFhSIBsIt7
         Z9mWsue5sSu/wNGgECRZn/0nCn+zVG3ZPaXK62oEBZEKJidnwr7n6SzUvKYU3a5WGQIK
         sMSRoRQU9ZA+lDqyO/c5Tedb/FVLXgx16VBvJDNoahWQaZtv+ovKIv/4gyPl4VXgNWgR
         xJXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725908852; x=1726513652;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KeQ2Et/fFCRS76/RDVc52ODWIM932uTGcPwA4XQOW3E=;
        b=EwbRX4YBLyqjs2WDwUDwWv5o6bt4mD3qolh+55+biNC7r+WN1NnvsN+AqNp68sAD7d
         3aEcd2u6JzP++/BmZ8kIYXGXO23D1e8l/89HtxphUvp3nhgOlCEt/sC3La14ehSRKrli
         hM3LygZnrW4uwoQH7Nln3EwokHyQfWppqI9ue7orQpsnxrZtiqoUBPXRbi4Y5PcqXHF/
         4BlfGmffcpudI33e/0p4ivh7I6ZV6y5rgs+IOoxTIsl6KPD7Rm2qZ+ehZPeEh4NBxlmJ
         giZs84Zs1D1rmKOrsncHJpCmgr1cWzTdQNbfYvXB8MwvR471jp4RiTQQQxzR6dlFku/r
         teTg==
X-Forwarded-Encrypted: i=1; AJvYcCWDHR+OVDB4RyLJ6GomQRV2s0uKjoTALceb/lEsn9u0fKzpJxx27elO6zgQ28xPAfiiM+I7fOu/KweA@vger.kernel.org
X-Gm-Message-State: AOJu0YwPxIY8Te2SEGazCjPmhglGZVAsQezIwqwfwC5wYbhUZ/ax22Yn
	jyxEaB5jU6SEghq9KN1B4H6WItNy57UPzpCczlSA+XUpF8bPCLVJ9/2KwwdY3q8=
X-Google-Smtp-Source: AGHT+IFr8qMBk49qQaWgQwdEeSwPNLRpIJ6+/NqAAdbEE2n6wWPI3+1ojCwWs7k3VHGjnw2a54FzLg==
X-Received: by 2002:a17:903:22c9:b0:205:5fb6:2aba with SMTP id d9443c01a7336-206f0539d1amr123273675ad.30.1725908851946;
        Mon, 09 Sep 2024 12:07:31 -0700 (PDT)
Received: from ghost ([50.145.13.30])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20710f31729sm37014315ad.261.2024.09.09.12.07.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2024 12:07:31 -0700 (PDT)
Date: Mon, 9 Sep 2024 12:07:26 -0700
From: Charlie Jenkins <charlie@rivosinc.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Richard Henderson <richard.henderson@linaro.org>,
	Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
	Matt Turner <mattst88@gmail.com>, Vineet Gupta <vgupta@kernel.org>,
	Russell King <linux@armlinux.org.uk>, Guo Ren <guoren@kernel.org>,
	Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
	Helge Deller <deller@gmx.de>, Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Naveen N Rao <naveen@kernel.org>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Yoshinori Sato <ysato@users.sourceforge.jp>,
	Rich Felker <dalias@libc.org>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	"David S. Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Muchun Song <muchun.song@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Shuah Khan <shuah@kernel.org>,
	Christoph Hellwig <hch@infradead.org>,
	Michal Hocko <mhocko@suse.com>,
	"Kirill A. Shutemov" <kirill@shutemov.name>,
	Chris Torek <chris.torek@gmail.com>, linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org,
	linux-snps-arc@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org,
	loongarch@lists.linux.dev, linux-mips@vger.kernel.org,
	linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
	sparclinux@vger.kernel.org, linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	linux-abi-devel@lists.sourceforge.net
Subject: Re: [PATCH RFC v3 1/2] mm: Add personality flag to limit address to
 47 bits
Message-ID: <Zt9HboH/PmPlRPmH@ghost>
References: <20240905-patches-below_hint_mmap-v3-0-3cd5564efbbb@rivosinc.com>
 <20240905-patches-below_hint_mmap-v3-1-3cd5564efbbb@rivosinc.com>
 <87zfol468z.fsf@mail.lhotse>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87zfol468z.fsf@mail.lhotse>

On Fri, Sep 06, 2024 at 04:59:40PM +1000, Michael Ellerman wrote:
> Charlie Jenkins <charlie@rivosinc.com> writes:
> > Create a personality flag ADDR_LIMIT_47BIT to support applications
> > that wish to transition from running in environments that support at
> > most 47-bit VAs to environments that support larger VAs. This
> > personality can be set to cause all allocations to be below the 47-bit
> > boundary. Using MAP_FIXED with mmap() will bypass this restriction.
> >
> > Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
> > ---
> >  include/uapi/linux/personality.h | 1 +
> >  mm/mmap.c                        | 3 +++
> >  2 files changed, 4 insertions(+)
> >
> > diff --git a/include/uapi/linux/personality.h b/include/uapi/linux/personality.h
> > index 49796b7756af..cd3b8c154d9b 100644
> > --- a/include/uapi/linux/personality.h
> > +++ b/include/uapi/linux/personality.h
> > @@ -22,6 +22,7 @@ enum {
> >  	WHOLE_SECONDS =		0x2000000,
> >  	STICKY_TIMEOUTS	=	0x4000000,
> >  	ADDR_LIMIT_3GB = 	0x8000000,
> > +	ADDR_LIMIT_47BIT = 	0x10000000,
> >  };
> 
> I wonder if ADDR_LIMIT_128T would be clearer?
> 

I don't follow, what does 128T represent?

> Have you looked at writing an update for the personality(2) man page? :)

I will write an update to the man page if this patch is approved!

> 
> cheers

- Charlie


