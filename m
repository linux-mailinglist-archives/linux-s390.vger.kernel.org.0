Return-Path: <linux-s390+bounces-7075-lists+linux-s390=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6184F9C7B25
	for <lists+linux-s390@lfdr.de>; Wed, 13 Nov 2024 19:30:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 811CBB249CE
	for <lists+linux-s390@lfdr.de>; Wed, 13 Nov 2024 18:24:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D0FC202638;
	Wed, 13 Nov 2024 18:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="P6LI7MTc"
X-Original-To: linux-s390@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B313F1586CB
	for <linux-s390@vger.kernel.org>; Wed, 13 Nov 2024 18:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731522282; cv=none; b=auAsLvP5TyIzW80IteFRmyJ24uJTqoRipuQkdvKj3JF4Tn2j29irosLnJFfx5m3A1LmUcJWdEIcX6yj71v9zpd1I/x6Ltm1UQKzUf5w5UPCLJA5fY12R3wsYLxu5qfcQMbh+Rr5YqxZCig2lb9ANlkVbJarOdDFtfV9MHLbNDOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731522282; c=relaxed/simple;
	bh=/rn6ZkqnF2HEw6yOJpu41ITMbUCacdWlBslD40vWHUM=;
	h=Date:In-Reply-To:Mime-Version:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=rJNHWtCZogXV5QuhGTBfLl5HE+kiFf/OubADN8mmWICDSOLY7wjnV9oZnhKOZgBhRUbnq7INuRiTwN2oNVzhhJwOGXbvVxy3ikLg4z4OS0yihOqqBXIi01boLEbvtADyaGLAeFq7VjkjFWDTNR/QWfnlxH4WE0JMakEc64TVZ2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=P6LI7MTc; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e30d7b4205eso10675611276.2
        for <linux-s390@vger.kernel.org>; Wed, 13 Nov 2024 10:24:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731522280; x=1732127080; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=iHp51deuGbbVdiRm/3lkBsA6sLNGX+gRE7+ejiXPpUI=;
        b=P6LI7MTcVbJzF3QiXUsTgNTrVdVzCN8DwnWjWOI3nnpAYVgMv5NFm2LbcXDfmw+LJu
         wkrraa6REyqX2GK5cv/exGU2VR3y16lpealrxAgH0ArDq0ErEBxJ39WDX/nwkXDmgcG+
         BsyjMj9lq0I1S5TrLqWdJ0dXI0WgCNNkZjuDgczKN7dvD73e68rRl/fRZqsu/WTYigU+
         yLTtqr2fqLPT0uAJpqRMvZF+Nm6U3cAkFDsbGfQmsslafL0isL1c89LOP4A75c5YX4/k
         gHF2+kHFGpOXfc9CN3UmJ5olYK0ubThxMA4zSVEBaWxiW4uYmeK2uyWY4rswVICdw+co
         zqvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731522280; x=1732127080;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iHp51deuGbbVdiRm/3lkBsA6sLNGX+gRE7+ejiXPpUI=;
        b=dWX5nxrlnOfQo1fNP7yvJnwhDfGHm8zxVKoqPiTVaywAXO9WDS3+ZZ6+MlcmONJ0xC
         dEJaNjl0BC6DDi/bQ5odBdKnyEr5zikxLs5fArRsy9VobHCrAwZS876658/KDQ21S7/P
         gXfEQXJZuUXPYqwAr7cOS5J5FNw8/f8OzhoJaAutefnUXLbX6ecXtXuGBdziC9HvgTcy
         XcRKiP+UJCCvA21AtIWGNw2gM7LpQ/k+TpI45QtvF+zPVzVvuzX4muJewXqYUObjrt4L
         89PI8lvqr9P+aMkhfX3fXln0KBWsKSIPgel7aEgyHiGHX+Mb05Vd6/8oNH5NU3mLMr6b
         TCkQ==
X-Forwarded-Encrypted: i=1; AJvYcCXJakP0jRNR3DVQF1kxRtH8M4ffXc3Oiq353LoRIKH2Oea6IGZDl4g5jegHjVau9pj0ku0xMiVXYP5D@vger.kernel.org
X-Gm-Message-State: AOJu0YwMYugq8kkJ+VPw47zzHne3KdVvwCqDZUAxcV2EyzlZGPXHWgjb
	YUcJLcFM8fi8LW25NLSfNXq4LPFJa8fzHrRbB2JOX2gOvdU90PUW6aFMSFcrlHHjEz9NVklJNQO
	s0MPvm7mGikkfaa8pamEPuw==
X-Google-Smtp-Source: AGHT+IESgEUveC8yQTk46ZdY46xE3OFDyejSgTzDblsZ0XI5Dgk48gNFxBwSyDJHjZLKVnBVYwtz3KJTaqWB5c2AfQ==
X-Received: from coltonlewis-kvm.c.googlers.com ([fda3:e722:ac3:cc00:11b:3898:ac11:fa18])
 (user=coltonlewis job=sendgmr) by 2002:a25:6fc1:0:b0:e2b:cd55:11b3 with SMTP
 id 3f1490d57ef6-e35ed246250mr2982276.5.1731522279438; Wed, 13 Nov 2024
 10:24:39 -0800 (PST)
Date: Wed, 13 Nov 2024 18:24:37 +0000
In-Reply-To: <20241108193204.GC38972@noisy.programming.kicks-ass.net> (message
 from Peter Zijlstra on Fri, 8 Nov 2024 20:32:04 +0100)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Message-ID: <gsnt34jv9el6.fsf@coltonlewis-kvm.c.googlers.com>
Subject: Re: [PATCH v7 4/5] x86: perf: Refactor misc flag assignments
From: Colton Lewis <coltonlewis@google.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: kvm@vger.kernel.org, oliver.upton@linux.dev, seanjc@google.com, 
	mingo@redhat.com, acme@kernel.org, namhyung@kernel.org, mark.rutland@arm.com, 
	alexander.shishkin@linux.intel.com, jolsa@kernel.org, irogers@google.com, 
	adrian.hunter@intel.com, kan.liang@linux.intel.com, will@kernel.org, 
	linux@armlinux.org.uk, catalin.marinas@arm.com, mpe@ellerman.id.au, 
	npiggin@gmail.com, christophe.leroy@csgroup.eu, naveen@kernel.org, 
	hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com, 
	borntraeger@linux.ibm.com, svens@linux.ibm.com, tglx@linutronix.de, 
	bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, 
	linux-s390@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes

Peter Zijlstra <peterz@infradead.org> writes:

> On Fri, Nov 08, 2024 at 08:20:44PM +0100, Peter Zijlstra wrote:

>> Isn't the below more or less what you want?

>> static unsigned long misc_flags(struct pt_regs *regs)
>> {
>> 	unsigned long flags = 0;

>> 	if (regs->flags & PERF_EFLAGS_EXACT)
>> 		flags |= PERF_RECORD_MISC_EXACT_IP;

>> 	return flags;
>> }

>> static unsigned long native_flags(struct pt_regs *regs)
>> {
>> 	unsigned long flags = 0;

>> 	if (user_mode(regs))
>> 		flags |= PERF_RECORD_MISC_USER;
>> 	else
>> 		flags |= PERF_RECORD_MISC_KERNEL;

>> 	return flags;
>> }

>> static unsigned long guest_flags(struct pt_regs *regs)
>> {
>> 	unsigned long guest_state = perf_guest_state();
>> 	unsigned long flags = 0;

>> 	if (guest_state & PERF_GUEST_ACTIVE) {
>> 		if (guest_state & PERF_GUEST_USER)
>> 			flags |= PERF_RECORD_MISC_GUEST_USER;
>> 		else
>> 			flags |= PERF_RECORD_MISC_GUEST_KERNEL;
>> 	}

>> 	return flags;
>> }

>> unsigned long perf_arch_guest_misc_flags(struct pt_regs *regs)
>> {
>> 	unsigned long flags;

>> 	flags = misc_flags(regs);
>> 	flags |= guest_flags(regs);

>> 	return flags;
>> }

>> unsigned long perf_arch_misc_flags(struct pt_regs *regs)
>> {
>> 	unsigned long flags;
>> 	unsigned long guest;

>> 	flags = misc_flags(regs);
>> 	guest = guest_flags(regs);
>> 	if (guest)
>> 		flags |= guest;
>> 	else
>> 		flags |= native_flags(regs);

>> 	return flags;
>> }

> This last can be written more concise:

> unsigned long perf_arch_misc_flags(struct pt_regs *regs)
> {
> 	unsigned long flags;

> 	flags = guest_flags(regs);
> 	if (!flags)
> 		flags |= native_flags(regs);

> 	flgs |= misc_flags(regs);

> 	return flags;
> }

This isn't right because it is choosing to return guest or native
flags depending on the presence of guest flags, but that's not what we
want.

See perf_misc_flags in kernel/events/core.c which chooses to return
perf_arch_guest_misc_flags or perf_arch_misc_flags depending on
should_sample_guest which depends on more than current guest state.

But I will take some of your suggestions to split the functions out
more.

