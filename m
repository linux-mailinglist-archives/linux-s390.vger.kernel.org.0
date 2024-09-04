Return-Path: <linux-s390+bounces-5883-lists+linux-s390=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9985B9697AD
	for <lists+linux-s390@lfdr.de>; Tue,  3 Sep 2024 10:48:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DCBBCB21E01
	for <lists+linux-s390@lfdr.de>; Tue,  3 Sep 2024 08:47:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 047051C9863;
	Tue,  3 Sep 2024 08:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="eBaPbLcZ"
X-Original-To: linux-s390@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E7591C986A
	for <linux-s390@vger.kernel.org>; Tue,  3 Sep 2024 08:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725353077; cv=none; b=afees3f3bGNHjLZa2S0SkYN0NNfsi/u7TPQAh7pSSrJQgFhqKVYapIWMpvrppZYg7cDItfKmF1+nvl1vNCXnSQwa4a9429vqoRGGqUOR713QjFXtbgHQPiHBfzXPBqXG8uCS5q8hOMbiAjnnt48gxK8ehjGTZVTSQllnnfCEvA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725353077; c=relaxed/simple;
	bh=FylgyOwq14Qsy2hkaZjp9Qg7WlZxSe0pWmI+6hs5XKY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p8euvbiA8fk3C9Q+r7v2Z4yXuWBpASKrn87GeM933PqY6or+yPlvQ6KlX1R5SssFcO1nS/wusbTcFK9v8mcR2ZJlzO6HsYE4C+fFWzegprM8SdKkSPpScR99GEJ7TSwbYF0t9NvZF1No5cna0185zsbLXLpC5T51yaOkozOFIf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=eBaPbLcZ; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a83562f9be9so463768166b.0
        for <linux-s390@vger.kernel.org>; Tue, 03 Sep 2024 01:44:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1725353074; x=1725957874; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DZlZAQzsLSUE2kbM2Ozq+ZCTE7DVngzemuZ7Ob/TXXo=;
        b=eBaPbLcZj1QpjtCTxIlveYA9NjAMBat3LfV2VMZqRQEkxDggQlVltFrgdhlwojjtCz
         LOdrUlbhopWw9KppBfUB8i0pdAZChfI9QG/Ct/MJ+hWhNkwWbSEZ0O4nwHVVTKVR6+Xk
         dQqleV4X75UIT0UjMQQEh8WbLV/APCh8TZcpLo2ap+Z1tSKBOadFaZCXw0rS0tk0yOFx
         aQmLFVcm2Zj8RkLZONc4LQVZk8fRnwBTXnYpWYKftfVcv/E9rGNlAn5gILtH1eTnH278
         dAt3oPlozi/junFhSnm2zigmTiE9luwZBDjykGjFkWSTIdv7w8Mfx3JnEH9s34x3MChx
         0PWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725353074; x=1725957874;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DZlZAQzsLSUE2kbM2Ozq+ZCTE7DVngzemuZ7Ob/TXXo=;
        b=Jvd2kD5H2m6GPRSdArIEw2guZke1E4XsJWIQvwhnHR0P1rhQgrcTu681s9lNhqotmi
         yW0bOtU3wn/Zyi8LfqtmUPDw5ySD0BTZC0NnQOOk2TUi0GLflY1mMB2smLrXtzuvvHcz
         y+35so3+YqLBowfSMfeXjEO5Veq+Jq2YQu5KbxmTK3OA96u4uvB7fW59NRnQazdmIPeJ
         dw0njGglS6frgTX2kp9uCP+5hF9IjR7v0m2btzpoiJ1R2w+W8rMNkWfv5uLu9vyFoPKS
         M6tdhqTkPybOlqMS/K+yUdfj5w873LfmCTInX9GbMt562SJ+/1fo/DmacjQH9XcKRyiK
         wg6g==
X-Forwarded-Encrypted: i=1; AJvYcCUVjcZyh0jaqAFgjRnZEq/cl+2NXR8qYhzsCZrYuudWb3FDE4kzaB3b19je7KNRib45nX2otb6PoLTG@vger.kernel.org
X-Gm-Message-State: AOJu0YyT6ggft0GFG1soyT9s8aLoS/omzQPD+rB8OyM8k9PBfiEisNEQ
	e7qxbQsRlbCSwRs+P2KIGhaRaORiP7XkxCrINYrHZqtAj7XDbClr/wc2tWMiKvs=
X-Google-Smtp-Source: AGHT+IHxwo9IPQ3UzoYFwfDhkPsGqhCSjCzcHlJOoBuRWzF1gLxd2R9P128YTojI0aYfG8i4cNsStA==
X-Received: by 2002:a17:907:2cc3:b0:a86:9058:c01b with SMTP id a640c23a62f3a-a89b9729542mr798530966b.65.1725353073684;
        Tue, 03 Sep 2024 01:44:33 -0700 (PDT)
Received: from localhost ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8989221e15sm653868266b.193.2024.09.03.01.44.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2024 01:44:33 -0700 (PDT)
Date: Tue, 3 Sep 2024 10:44:32 +0200
From: Michal Hocko <mhocko@suse.com>
To: Charlie Jenkins <charlie@rivosinc.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Richard Henderson <richard.henderson@linaro.org>,
	Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
	Matt Turner <mattst88@gmail.com>, Vineet Gupta <vgupta@kernel.org>,
	Russell King <linux@armlinux.org.uk>, Guo Ren <guoren@kernel.org>,
	Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
	Helge Deller <deller@gmx.de>, Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
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
	Shuah Khan <shuah@kernel.org>, linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org,
	linux-snps-arc@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org,
	loongarch@lists.linux.dev, linux-mips@vger.kernel.org,
	linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
	sparclinux@vger.kernel.org, linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH RFC v2 0/4] mm: Introduce MAP_BELOW_HINT
Message-ID: <ZtbMcN3vK-Ih1gpN@tiehlicka>
References: <20240829-patches-below_hint_mmap-v2-0-638a28d9eae0@rivosinc.com>
 <ZtAxwJFH_hAh1BPG@tiehlicka>
 <ZtCw4vgonbJzV1xs@ghost>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZtCw4vgonbJzV1xs@ghost>

On Thu 29-08-24 10:33:22, Charlie Jenkins wrote:
> On Thu, Aug 29, 2024 at 10:30:56AM +0200, Michal Hocko wrote:
> > On Thu 29-08-24 00:15:57, Charlie Jenkins wrote:
> > > Some applications rely on placing data in free bits addresses allocated
> > > by mmap. Various architectures (eg. x86, arm64, powerpc) restrict the
> > > address returned by mmap to be less than the 48-bit address space,
> > > unless the hint address uses more than 47 bits (the 48th bit is reserved
> > > for the kernel address space).
> > > 
> > > The riscv architecture needs a way to similarly restrict the virtual
> > > address space. On the riscv port of OpenJDK an error is thrown if
> > > attempted to run on the 57-bit address space, called sv57 [1].  golang
> > > has a comment that sv57 support is not complete, but there are some
> > > workarounds to get it to mostly work [2].
> > > 
> > > These applications work on x86 because x86 does an implicit 47-bit
> > > restriction of mmap() address that contain a hint address that is less
> > > than 48 bits.
> > > 
> > > Instead of implicitly restricting the address space on riscv (or any
> > > current/future architecture), a flag would allow users to opt-in to this
> > > behavior rather than opt-out as is done on other architectures. This is
> > > desirable because it is a small class of applications that do pointer
> > > masking.
> > 
> > IIRC this has been discussed at length when 5-level page tables support
> > has been proposed for x86. Sorry I do not have a link handy but lore
> > should help you. Linus was not really convinced and in the end vetoed it
> > and prefer that those few applications that benefit from greater address
> > space would do that explicitly than other way around.
> 
> I believe I found the conversation you were referring to. Ingo Molnar
> recommended a flag similar to what I have proposed [1]. Catalin
> recommended to make 52-bit opt-in on arm64 [2]. Dave Hansen brought up
> MPX [3].
> 
> However these conversations are tangential to what I am proposing. arm64
> and x86 decided to have the default address space be 48 bits. However
> this was done on a per-architecture basis with no way for applications
> to have guarantees between architectures. Even this behavior to restrict
> to 48 bits does not even appear in the man pages, so would require
> reading the kernel source code to understand that this feature is
> available. Then to opt-in to larger address spaces, applications have to
> know to provide a hint address that is greater than 47 bits, mmap() will
> then return an address that contains up to 56 bits on x86 and 52 bits on
> arm64. This difference of 4 bits causes inconsistency and is part of the
> problem I am trying to solve with this flag.

Yes, I guess I do understand where you are heading. Our existing model
assumes that anybody requiring more address space know what they are
doing and deal with the reality. This is the way Linus has pushed this
and I am not really convinced it is the right way TBH. On the other hand
it is true that this allows a safe(r) transition to larger address
spaces.

> I am not proposing to change x86 and arm64 away from using their opt-out
> feature, I am instead proposing a standard ABI for applications that
> need some guarantees of the bits used in pointers.

Right, but this is not really different from earlier attempts to achieve
this IIRC. Extentind mmap for that purpose seems quite tricky as already
pointed out in other sub-threads. Quite honestly I am not really sure
what is the right and backwards compatible way. I just wanted to make
you aware this has been discussed at lenght in the past.
-- 
Michal Hocko
SUSE Labs

