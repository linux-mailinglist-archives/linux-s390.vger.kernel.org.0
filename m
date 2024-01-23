Return-Path: <linux-s390+bounces-1089-lists+linux-s390=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 445DD8387AA
	for <lists+linux-s390@lfdr.de>; Tue, 23 Jan 2024 07:45:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 73BFA1C22C37
	for <lists+linux-s390@lfdr.de>; Tue, 23 Jan 2024 06:45:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B7935103A;
	Tue, 23 Jan 2024 06:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2VOooJ6E"
X-Original-To: linux-s390@vger.kernel.org
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 660C05025F
	for <linux-s390@vger.kernel.org>; Tue, 23 Jan 2024 06:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705992340; cv=none; b=fwTpQHhOpm/s9k+MufFTkqOvNWGkjKdheALth8IJckN1xLFFALjCGnQqjWk9yvEnFkj5wmsobSRwb5Uwj4cXg5VjIVT4hCniI78GwjpqFHApJcqH5t0YuPJvljBUpkumoEHgPHyNExoVh1KEeVb3hDWMB0PrRPWH901hX1n1zd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705992340; c=relaxed/simple;
	bh=t/tQhqebbJMtWe/6w66DZ1En16T5xwr2Nkyq3Ik6suU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rSlk+pgev3jFi3yexRrZmErsMfYANuW8ZMV7iufVe18mqHmQF/Gni0stDUvf/8kUJ/cnGuvfR/OFnDkxcWaohE6VEoKiQPVFCS3F5JgbRBPE6t6k4N0gp9eT6ygoaENHY+1ROPNPMoswtoOhrjoeGwt4DrCC0xKqIUDnRp5FfTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2VOooJ6E; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-5f254d1a6daso40339787b3.2
        for <linux-s390@vger.kernel.org>; Mon, 22 Jan 2024 22:45:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1705992336; x=1706597136; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PoTQEe2OLzexfh/hP6idvwNfJdYn+1MZAqnZalpJe8M=;
        b=2VOooJ6EcUCx5pm0KE2TqQWKNMyWHeA0Xo6lW6zHPOn9KEawo2dmbUs9jcCH6/ywbg
         wL1WPNOeCHnVK3r0+lBdg1wdAivNnaFaXI7JzAcw3fg36SJMhG8t1I4BZ2sMvCwYnSME
         f18rQO7hxspvPSjmNC6MO5kapVorHn6wT4OubUvZ/QRzVCRXuEQxvmzwHlApzognYDeP
         /RGIdmjlm/4M/MUR11B22zCrcJWWLsmg8p/LxlDK0HZyEln4WGarjckOAv/2S1MnTQyU
         SOLJtm63HEFgKiUYiVAE8KEmsbqRKc4EVU7cu3rTzZvgD3XytBJ73rCvw58nrcJeqWSr
         ZQ9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705992336; x=1706597136;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PoTQEe2OLzexfh/hP6idvwNfJdYn+1MZAqnZalpJe8M=;
        b=rwkhba+7w8tehDceWUD1TgsBDXABr3dWJ2KMBh+zMNN7IXcDH1R2c7O4ez95XWsCAU
         +GptHnP7S487zUSy5IQlroH+ofV2u/z5spW6KX4I74dK7aQYS/SN8f/kduR0VaVTgzK+
         9UOl9iJGJ5naFs69z8RJvry3Ut4BN7P1W4ShOBfEQLXAIKouA8Od8/zV5yWazz40clpC
         Lr36PNqTLsQ3qvTblcR9EFANxVwEBTfPGSp6m/+zx9sLYRM7Hmp5vUVEorBJz8idN2OH
         1ufErtOPqsysG8ePSq7YaNzWdn7V9GIK+EhVJVKjWWgQWFRqcCunnqKYQKCsCJQxmLqw
         UPMg==
X-Gm-Message-State: AOJu0YytJsToRp3LZxjGY+tLt0lkpk5zMb6iBdEce11swbkFuEMvZ79p
	iSoLiDiOQNLKdoqVDg1WyxLfRx+F815rm+MuJCTpaBK0HceMN2CuRtvYvDSN1RHt4xEAzvbKNqp
	ZK+IA5MIgAyaYMy1DH/dbDkYnHb7sdBi02q9L
X-Google-Smtp-Source: AGHT+IEBqXVQUIfO9mccqsYMSFKUq4apywgfGuA1NVIzT8EfPN/xT4990ujq0TPyyxp+o6U+5W7GppWF3JfUAOUZ4Rs=
X-Received: by 2002:a81:a090:0:b0:5ff:ae75:fe6f with SMTP id
 x138-20020a81a090000000b005ffae75fe6fmr3254872ywg.44.1705992336083; Mon, 22
 Jan 2024 22:45:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231226214610.109282-1-surenb@google.com> <170578498755.24348.16166096320323933297.git-patchwork-notify@kernel.org>
 <Zaw31DVa9q3JZASo@shell.armlinux.org.uk> <CAJuCfpGV_CwQm+PuiqRz3L1x7QnpgE9LQb4PPChqFv0mzbYeBw@mail.gmail.com>
In-Reply-To: <CAJuCfpGV_CwQm+PuiqRz3L1x7QnpgE9LQb4PPChqFv0mzbYeBw@mail.gmail.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Mon, 22 Jan 2024 22:45:25 -0800
Message-ID: <CAJuCfpHVCLB0+G0amOk8tC=+--aX39n_ZRbKfhqhvJjdqjTVag@mail.gmail.com>
Subject: Re: [PATCH 1/1] arch/mm/fault: fix major fault accounting when
 retrying under per-VMA lock
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: patchwork-bot+linux-riscv@kernel.org, linux-riscv@lists.infradead.org, 
	akpm@linux-foundation.org, willy@infradead.org, will@kernel.org, 
	catalin.marinas@arm.com, palmer@dabbelt.com, mpe@ellerman.id.au, 
	christophe.leroy@csgroup.eu, agordeev@linux.ibm.com, 
	gerald.schaefer@linux.ibm.com, dave.hansen@linux.intel.com, luto@kernel.org, 
	peterz@infradead.org, x86@kernel.org, linux-arm-kernel@lists.infradead.org, 
	linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 21, 2024 at 11:38=E2=80=AFPM Suren Baghdasaryan <surenb@google.=
com> wrote:
>
> On Sat, Jan 20, 2024 at 1:15=E2=80=AFPM Russell King (Oracle)
> <linux@armlinux.org.uk> wrote:
> >
> > On Sat, Jan 20, 2024 at 09:09:47PM +0000, patchwork-bot+linux-riscv@ker=
nel.org wrote:
> > > Hello:
> > >
> > > This patch was applied to riscv/linux.git (fixes)
> > > by Andrew Morton <akpm@linux-foundation.org>:
> > >
> > > On Tue, 26 Dec 2023 13:46:10 -0800 you wrote:
> > > > A test [1] in Android test suite started failing after [2] was merg=
ed.
> > > > It turns out that after handling a major fault under per-VMA lock, =
the
> > > > process major fault counter does not register that fault as major.
> > > > Before [2] read faults would be done under mmap_lock, in which case
> > > > FAULT_FLAG_TRIED flag is set before retrying. That in turn causes
> > > > mm_account_fault() to account the fault as major once retry complet=
es.
> > > > With per-VMA locks we often retry because a fault can't be handled
> > > > without locking the whole mm using mmap_lock. Therefore such retrie=
s
> > > > do not set FAULT_FLAG_TRIED flag. This logic does not work after [2=
]
> > > > because we can now handle read major faults under per-VMA lock and
> > > > upon retry the fact there was a major fault gets lost. Fix this by
> > > > setting FAULT_FLAG_TRIED after retrying under per-VMA lock if
> > > > VM_FAULT_MAJOR was returned. Ideally we would use an additional
> > > > VM_FAULT bit to indicate the reason for the retry (could not handle
> > > > under per-VMA lock vs other reason) but this simpler solution seems
> > > > to work, so keeping it simple.
> > > >
> > > > [...]
> > >
> > > Here is the summary with links:
> > >   - [1/1] arch/mm/fault: fix major fault accounting when retrying und=
er per-VMA lock
> > >     https://git.kernel.org/riscv/c/46e714c729c8
> > >
> > > You are awesome, thank you!
> >
> > Now that 32-bit ARM has support for the per-VMA lock, does that also
> > need to be patched?
>
> Yes, I think so. I missed the ARM32 change that added support for
> per-VMA locks. Will post a similar patch for it tomorrow.

Fix for ARM posted at
https://lore.kernel.org/all/20240123064305.2829244-1-surenb@google.com/

> Thanks,
> Suren.
>
> >
> > --
> > RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
> > FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

