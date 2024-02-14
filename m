Return-Path: <linux-s390+bounces-1778-lists+linux-s390=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 51A2E8554D3
	for <lists+linux-s390@lfdr.de>; Wed, 14 Feb 2024 22:32:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0EEB3283A65
	for <lists+linux-s390@lfdr.de>; Wed, 14 Feb 2024 21:32:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E6B213EFF8;
	Wed, 14 Feb 2024 21:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="h8BmpZ4Z"
X-Original-To: linux-s390@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77FE713EFEE
	for <linux-s390@vger.kernel.org>; Wed, 14 Feb 2024 21:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707946346; cv=none; b=L00UWbm5TjvC4eJQkfdwEKGBxv8U/99CibFlgB7oh+8lfYfvHSFa2mkwQHHKQCh+LLry0pg0lNDApzIDdZjAlvcHKVirc3PtDwbOig5534sjunVq0vjgVArM9G0AbGGv78sDWehFPx4AGND1tayuPxZ83Zvs+itK6IVx0V7IM80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707946346; c=relaxed/simple;
	bh=mzDDSMUcdlm0Up4f4mJcp+HyVxmyqjTrTC7RCdD9z7Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FH3h27kVeYQxWppjGGA9J6NtNFQI0EnW2+3MKOQhfnI1COAXXT1hSXhlhARInJJN+TG5+Mq6g/xnGRBTUpSaw0J6dEeFzoeYz+7+eZ02YT0CJOZWvslRgxGLRVQDG2aCH3G6zXUD0yNpLfnHrJ81/cMs2od8JdhEKEcqoM++5rE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=h8BmpZ4Z; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-410acf9e776so3085e9.1
        for <linux-s390@vger.kernel.org>; Wed, 14 Feb 2024 13:32:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707946343; x=1708551143; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q7jzhXS2LwlH6Na13t2uRB5AnuKFssoLivXgy4Bk1Ws=;
        b=h8BmpZ4Z0stU30SoQgsIP+67tQwaGwKNEwCCgoNFJZcpoxW+as7Me2Bt7XjVbQm6iL
         AgKJDEDBA3XS2O7foQfR7kDeeOCUhjmt6dpYMsrLZOP77b2cuvswX4PAyTg5+8nFqEvg
         C9leQiytaJU5MYudrnzWLyt08XbmrQBxRgCWcf6HQbB9SiOzeB+iRXjj3MICr825V7pM
         v7TQ4M9hg0NrdD5loYofuJ32PBB8GUZK62J9zMjz/h0ZSAKYN088QSCUimIYC/vzeCe4
         ZwvNu8Gb3p0wrwrIaAyJCkcRktiA1mAPpJdgqnvaR1wFEJiYA296oYAJ/n7ZrWMHY6lk
         8G3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707946343; x=1708551143;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q7jzhXS2LwlH6Na13t2uRB5AnuKFssoLivXgy4Bk1Ws=;
        b=DsVIncKxokMSJ9fHsfHiBDLrG2C8bJDppeYF149czxcOZHtyIpuu0Ai14MBvPUv/ZN
         mc0dvajzP+du8NrZUBQJAJSJzVvWw+7Gu+LmEhMqPLXHp1XKTntdSK26WfaveDY+ESMa
         qQHXJ2xbRlsTZlcFLmiDQO/M1WgfZiBvGhXvvPk2RpBqE5SbZIwpIf6PDqI3c7LzOOzU
         GfL6OhQtZYBgFjrStjuLc7GAZ/sWJcSjdsYUKwYJ0BepH6zo23zTXiLkTw4JX7KiMP+K
         rrtEVNuYEuYUjI7fK3GlJIAgLDk9YC3Qa2xkDKfbEBYMxhB3HtdHU+g1dDs7Zv2oKZ4j
         v0Cg==
X-Forwarded-Encrypted: i=1; AJvYcCWXWdc7kVRhUgMAG6l/mnAy6nwkDQTpxqklFDvi+vupPMntF2cxT/tklL9MPK6b4aqCW9ec0C99xEYSj7Q5sOqCWFOQ2tHbIWNqSQ==
X-Gm-Message-State: AOJu0Yzw2VU9AWImvJHa1Bi8TZfyPBDUcQgz70uklJisOu7XvMEXCIky
	MtxW5LjC3BVchueSVc+V8iG7+FEO0ToPEDqg8fqaP2j8zV+JbH1072co9k+Tpm0k0uzH//S4okL
	gou3oqDUAxqdMxA+OEXccqMSd6M1un7e1qd6J
X-Google-Smtp-Source: AGHT+IE5ehL53MTjl/C7JyHdLt/tpxzFhvMTW9TYqxUkVLe03JhGEAREu202kUoVCBnpW7EKcv+ZGc8eHAGUZNCg7gE=
X-Received: by 2002:a05:600c:a01a:b0:411:e72d:e5c9 with SMTP id
 jg26-20020a05600ca01a00b00411e72de5c9mr223035wmb.5.1707946342669; Wed, 14 Feb
 2024 13:32:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240207-s390-lld-and-orphan-warn-v1-0-8a665b3346ab@kernel.org>
 <20240207-s390-lld-and-orphan-warn-v1-6-8a665b3346ab@kernel.org>
 <CAFP8O3+L6Jpgktk50UBKg_SodH-DTAW2syZueUqxdZsxrOT3bg@mail.gmail.com> <20240214121755.6438-C-hca@linux.ibm.com>
In-Reply-To: <20240214121755.6438-C-hca@linux.ibm.com>
From: Fangrui Song <maskray@google.com>
Date: Wed, 14 Feb 2024 13:32:09 -0800
Message-ID: <CAFP8O3+uLO9a2n3NuQd9bhzRtpG4GvzoJyMuasGZuCrkBRqq_A@mail.gmail.com>
Subject: Re: [PATCH 06/11] s390/boot: vmlinux.lds.S: Handle '.rela' sections
To: Heiko Carstens <hca@linux.ibm.com>
Cc: Nathan Chancellor <nathan@kernel.org>, gor@linux.ibm.com, agordeev@linux.ibm.com, 
	borntraeger@linux.ibm.com, svens@linux.ibm.com, ndesaulniers@google.com, 
	linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, 
	llvm@lists.linux.dev, patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 14, 2024 at 4:18=E2=80=AFAM Heiko Carstens <hca@linux.ibm.com> =
wrote:
>
> On Mon, Feb 12, 2024 at 09:18:34PM -0800, Fangrui Song wrote:
> > >         ASSERT(SIZEOF(.plt) =3D=3D 0, "Unexpected run-time procedure =
linkages detected!")
> > > +       .rela.dyn : {
> > > +               *(.rela.*) *(.rela_*)
> > > +       }
> > > +       ASSERT(SIZEOF(.rela.dyn) =3D=3D 0, "Unexpected run-time reloc=
ations (.rela) detected!")
> ...
> > Commit 5354e84598f264793265cc99b4be2a2295826c86 ("x86/build: Add
> > asserts for unwanted sections")
> > specifies `*(.rela.*) *(.rela_*)` but it's not clear why `.rela_*` is
> > included. We only need .rela.* (see also ld.bfd --verbose)
> >
> > This patch LGTM with this changed.
>
> I'll keep it as it is, just to be consistent with x86.

Sent https://lore.kernel.org/all/20240214212929.3753766-1-maskray@google.co=
m/
("[PATCH] x86/build: Simplify patterns for unwanted section")
to simplify the patterns in x86 vmlinux.lds.S:)


--=20
=E5=AE=8B=E6=96=B9=E7=9D=BF

