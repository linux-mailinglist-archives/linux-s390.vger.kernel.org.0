Return-Path: <linux-s390+bounces-272-lists+linux-s390=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DAAD800EEA
	for <lists+linux-s390@lfdr.de>; Fri,  1 Dec 2023 17:02:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF2BF1C209BD
	for <lists+linux-s390@lfdr.de>; Fri,  1 Dec 2023 16:02:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65D804BA84;
	Fri,  1 Dec 2023 16:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wzhU+QJh"
X-Original-To: linux-s390@vger.kernel.org
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F13981A6
	for <linux-s390@vger.kernel.org>; Fri,  1 Dec 2023 08:02:24 -0800 (PST)
Received: by mail-pj1-x1049.google.com with SMTP id 98e67ed59e1d1-2859d83dfafso2569835a91.3
        for <linux-s390@vger.kernel.org>; Fri, 01 Dec 2023 08:02:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701446544; x=1702051344; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=X3hs2qH305J95vA9xH6FvvT52csNtm3q7CZMstOlCn4=;
        b=wzhU+QJh6ioARn2wP5Xg4LpZV8ehA0zuvk9RrbgcW/4a7Q5e9kEjafCSJAo7t+LC9g
         l5ygF4E3s8WsdtOVYfrAzE9QZg1KUrQd3BQDAO+juxuvKXteYbzSXG2R6PfMCQHwAUAU
         LuXOCzxvhvsvXWUA8567lTA0h3mTwXMVcfj23aRkHVGjqUbudQ/SBw/rPBkKwWWpP4I0
         mkgQZu3/K7UPtwsBA8eK6vySMwC89evnJ6Yn/TuPUWAz8zrDQ7JGN/YWxQrxRzP5GIFw
         gxKFZN1C+xF+JIxjxv2L38BSQ6/EL543TgwNPs8h8mUCAUbxraFbJQC5m/hqhq50Xc8/
         K28A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701446544; x=1702051344;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=X3hs2qH305J95vA9xH6FvvT52csNtm3q7CZMstOlCn4=;
        b=hjYIwRHySZ+K7B+fXihDWktmmqlYMGb1vnFMCgm893x/U7DItxwT7jNRRTCHd76l7c
         xcrGMKJIt/NYMAz159tgPnf+75v2JceUm4YWKJbelLiw7gjunLeeG1/ogACFkm8suuof
         lUC2zaWKAAQSZZwY/cQLbd7SSSSNri1MEUdYQ7cr+6uC0AREuNlKtTKIyLWnYxx0mAdu
         6HoxNJ7kRrP+zXyZ/SBnHkfErIYma/WkLUPHcwaHd0vgb6D0IDkOKhn1c1xeue6Dfm7d
         bIWTOuMDG6IR1oLPqT4P7oFw6THYvVM6+77hXKiTRyAW/4GcfDIHjSVbNuDWK4SJrGhV
         SzsQ==
X-Gm-Message-State: AOJu0YxKoKPGAUW/KYS+MBoWklA9AkNDUy+2Fm0N/9gdHX9rnJQxsJui
	bFxsJ8p4XLJ6YbwxmelGt1nLdFWVI+c=
X-Google-Smtp-Source: AGHT+IEpUbv0T/gt1sVRKPuzXtWSD98mloMjenlAiXI7AYK7YPwkoC3QS0B+PDUjf4cAW1GXD/+uAHSj5Vw=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:90a:974a:b0:285:7b66:7fd0 with SMTP id
 i10-20020a17090a974a00b002857b667fd0mr4768430pjw.0.1701446544420; Fri, 01 Dec
 2023 08:02:24 -0800 (PST)
Date: Fri, 1 Dec 2023 08:02:22 -0800
In-Reply-To: <fc436fea-b9af-5649-0b4e-ef6c0ef37ce9@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231102181526.43279-1-pstanner@redhat.com> <170137909771.669092.7450781639631347445.b4-ty@google.com>
 <fc436fea-b9af-5649-0b4e-ef6c0ef37ce9@linux.ibm.com>
Message-ID: <ZWoDjmcbYk5pfXlI@google.com>
Subject: Re: [PATCH 0/3] Use new wrappers to copy userspace arrays
From: Sean Christopherson <seanjc@google.com>
To: Christian Borntraeger <borntraeger@linux.ibm.com>
Cc: Janosch Frank <frankja@linux.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, 
	David Hildenbrand <david@redhat.com>, Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
	"H. Peter Anvin" <hpa@zytor.com>, Philipp Stanner <pstanner@redhat.com>, kvm@vger.kernel.org, 
	linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, x86@kernel.org
Content-Type: text/plain; charset="us-ascii"

On Fri, Dec 01, 2023, Christian Borntraeger wrote:
> 
> 
> Am 01.12.23 um 02:52 schrieb Sean Christopherson:
> > On Thu, 02 Nov 2023 19:15:23 +0100, Philipp Stanner wrote:
> > > Linus recently merged [1] the wrapper functions memdup_array_user() and
> > > vmemdup_array_user() in include/linux/string.h for Kernel v6.7
> > > 
> > > I am currently adding them to all places where (v)memdup_user() had been
> > > used to copy arrays.
> > > 
> > > The wrapper is different to the wrapped functions only in that it might
> > > return -EOVERFLOW. So this new error code might get pushed up to
> > > userspace. I hope this is fine.
> > > 
> > > [...]
> > 
> > Applied to kvm-x86 generic.  Claudio (or anyone else from s390), holler if
> > you want to take the s390 patch through the s390 tree.
> 
> I think this is fine via your tree.
> 
> Feel free to add
> Acked-by: Christian Borntraeger <borntraeger@linux.ibm.com>
> to patch 2 if the commit id is not yet final.

Done, thanks much!  New hashes if anyone cares:

[1/3] KVM: x86: Harden copying of userspace-array against overflow
      https://github.com/kvm-x86/linux/commit/573cc0e5cf14
[2/3] KVM: s390: Harden copying of userspace-array against overflow
      https://github.com/kvm-x86/linux/commit/8c4976772d9b
[3/3] KVM: Harden copying of userspace-array against overflow
      https://github.com/kvm-x86/linux/commit/1f829359c8c3

