Return-Path: <linux-s390+bounces-262-lists+linux-s390=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B859800140
	for <lists+linux-s390@lfdr.de>; Fri,  1 Dec 2023 02:52:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E6A521F20226
	for <lists+linux-s390@lfdr.de>; Fri,  1 Dec 2023 01:52:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72B0617CF;
	Fri,  1 Dec 2023 01:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="boT7pveg"
X-Original-To: linux-s390@vger.kernel.org
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9994CA0
	for <linux-s390@vger.kernel.org>; Thu, 30 Nov 2023 17:52:40 -0800 (PST)
Received: by mail-pj1-x1049.google.com with SMTP id 98e67ed59e1d1-2859052aed9so1826297a91.3
        for <linux-s390@vger.kernel.org>; Thu, 30 Nov 2023 17:52:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701395560; x=1702000360; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=jDAo7xcaTB61zqktCfZGe7MT3u57tuHVzlhp9HQUcu0=;
        b=boT7pvegiLKGSOyot5VpydIoDnTrvslBe3SilXkVSDVar4Z6FRP+Qi0VNOzkjTQhEf
         ZOQ8/HniHu7QLU4RRsPT4bF09fhZOD1F/yvwUWHuBpR/lqFJu0X1irXsBxIhrpchZX7i
         hOooRFkOBjt8sIMGSeVLBrY33HKp4jY2wTl9tfq1VWsnFIh31h4uVKLIFeGMa5z41S1g
         7o7Cswl8pP/MlnaPX9ipx8c1Rhy1Hp8C0Fg8+xPdMHimQbuekEqDySOiIcEceAHe16UT
         1aB43CsT03I25QewZaxBAdI3t05hXJklt57jT2Q89OZ6I4zGxFUbcVT1wouPu6f5hhB9
         /qTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701395560; x=1702000360;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jDAo7xcaTB61zqktCfZGe7MT3u57tuHVzlhp9HQUcu0=;
        b=LCIvofQ0befo+SiKV1VFOhkdmeutspcHRsWdeqOj626cle0HeVAfvqH6MSGabqbmUc
         ZfAlaCPD6YYn8W0JYE/HZjOeH6gQ1M40H8bLtIMjUFx2XsxjmxSUG3GO8Ap8u9UllzlY
         lnuYkXQs20sS32WpDyeJPhECI3bT+2ptcsOLRsGoiGTlQNI3EEOU+k9gbE545L1w25zo
         1s9OWczKqHzReS8RmGEEmDm6ePtb8CfGgGAEihPeGLp6Wej1ouRhASX3u3nuJQo6dcP6
         5qODi59sIswVJkhW2yYGez2BwmJCnL+YtIO63gHH6sFARxcrGa5aZU2O7+IbnkEsn3RU
         vAAw==
X-Gm-Message-State: AOJu0Yyu4DViwtcAan1W8z6Wb9o8+kVb0AHVj7AhzKzIR/2Km1XIIotj
	iLZ154PMqg5EgTR64+tJ87tTkttgfOA=
X-Google-Smtp-Source: AGHT+IEFnK9rSPjSkAn46Nn/t6rQBkPoX0sBJ20OTRSbHUu03F9XcWeU9PActP7gt9A8pR2PCANU8Fv1ej4=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:90b:143:b0:281:37ae:df69 with SMTP id
 em3-20020a17090b014300b0028137aedf69mr4741858pjb.4.1701395560050; Thu, 30 Nov
 2023 17:52:40 -0800 (PST)
Date: Thu, 30 Nov 2023 17:52:06 -0800
In-Reply-To: <20231102181526.43279-1-pstanner@redhat.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231102181526.43279-1-pstanner@redhat.com>
X-Mailer: git-send-email 2.43.0.rc2.451.g8631bc7472-goog
Message-ID: <170137909771.669092.7450781639631347445.b4-ty@google.com>
Subject: Re: [PATCH 0/3] Use new wrappers to copy userspace arrays
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Janosch Frank <frankja@linux.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, 
	David Hildenbrand <david@redhat.com>, Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
	"H. Peter Anvin" <hpa@zytor.com>, Philipp Stanner <pstanner@redhat.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, 
	linux-kernel@vger.kernel.org, x86@kernel.org
Content-Type: text/plain; charset="utf-8"

On Thu, 02 Nov 2023 19:15:23 +0100, Philipp Stanner wrote:
> Linus recently merged [1] the wrapper functions memdup_array_user() and
> vmemdup_array_user() in include/linux/string.h for Kernel v6.7
> 
> I am currently adding them to all places where (v)memdup_user() had been
> used to copy arrays.
> 
> The wrapper is different to the wrapped functions only in that it might
> return -EOVERFLOW. So this new error code might get pushed up to
> userspace. I hope this is fine.
> 
> [...]

Applied to kvm-x86 generic.  Claudio (or anyone else from s390), holler if
you want to take the s390 patch through the s390 tree.

I massaged the shortlogs to use KVM's standard scopes, and to make it clear
that these are hardening patches, i.e. that there is no unsafe/buggy behavior
that is being fixed.  I also added a note at the end of each changelog to call
out that KVM pre-checks the sizes before copying, again to make it clear that
using the safer helper isn't expected to actually change KVM's behavior.

[1/3] KVM: x86: Harden copying of userspace-array against overflow
      https://github.com/kvm-x86/linux/commit/573cc0e5cf14
[2/3] KVM: s390: Harden copying of userspace-array against overflow
      https://github.com/kvm-x86/linux/commit/8b81a8d7c6b7
[3/3] KVM: Harden copying of userspace-array against overflow
      https://github.com/kvm-x86/linux/commit/bc2cad56094c

--
https://github.com/kvm-x86/linux/tree/next

