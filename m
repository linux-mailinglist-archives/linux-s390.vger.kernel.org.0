Return-Path: <linux-s390+bounces-922-lists+linux-s390=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D60A382AFCB
	for <lists+linux-s390@lfdr.de>; Thu, 11 Jan 2024 14:37:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 867B228AC0E
	for <lists+linux-s390@lfdr.de>; Thu, 11 Jan 2024 13:37:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E65FF179A9;
	Thu, 11 Jan 2024 13:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="ZOCZCaqp"
X-Original-To: linux-s390@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A49C18025
	for <linux-s390@vger.kernel.org>; Thu, 11 Jan 2024 13:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a2c375d2430so109203166b.1
        for <linux-s390@vger.kernel.org>; Thu, 11 Jan 2024 05:36:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1704980218; x=1705585018; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jZJk/zGzcW9P8tv4ZwjNAa3xZGwDose/eLLHnMc+PRQ=;
        b=ZOCZCaqpvYZ3bBY5TBOaLdxkjUu0Y1M4qGDH2C54y64OKSEa8QfUguYNkfgPVtJro0
         db/17QZmRTuwebhcRRnaTbj5InvAOEypdWtkCeWZkR3+vQRlu5UoOFFToqq/eDoZ4XGj
         BrNEHry11dHIIh3S5LQUjyG+XDf+zJApF7Q9Z6AZ0+z00sbPlJOkuqgZaMhCUvnq1hEa
         VKdqMYvzFVJnOsw7jiTm2JD3ke+pooTpjpG9yI4NYfe+p4nDy55RCopow29acp6vyVY1
         Ik2fBVHId/o752TjMiKIZRHNYMw/ashOTOzN2dgKaWmy0vgx7Q4ST0AsH4stfnOcUf8F
         B7hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704980218; x=1705585018;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jZJk/zGzcW9P8tv4ZwjNAa3xZGwDose/eLLHnMc+PRQ=;
        b=lEUyeRl5JFWD9SYbINcFTbL0DBMNkb5df4lqPxSwbpjc2mHo3S8QpnGLMQNE6zHCDw
         fRq/MZGCEB9WITXFxEekzhPjs1SCmiH2BWokWc/hW1tvdvYDqwP4sfS8w6ppxONKXQcD
         Cy1eALChBKkKd8i7QMyDzVCQh8V1zmD5CTIT2wx2wB6hle4C4yXUOnRH16K6rlLhv0Qm
         8H2fV/zeVyWzJ/phejWMPvRk5av5+uAEZf9mPZ9FaCDQB2/3xWU7gcztJbpfcEbzfyfe
         k+Vn8PG+6xmHsSJehGvAssCVfSGFPqddUXhD7UU09nIQT9L885IHZ6GJB+aC3mM2+TGS
         CmgQ==
X-Gm-Message-State: AOJu0YxpDCB9gqHxAYsVXr7mRM519BaW+ww+r87eJCQ4K8p9cFibxHmr
	s4jwVzEJKnoKICyXs4vBqLi77zhE9U74xA==
X-Google-Smtp-Source: AGHT+IGEU7aZg/2yhXR+7vRPuvW+00xt0POJADrekQintDzFcawk6SkTP6e5ed5ccxxZAhl88qmNuA==
X-Received: by 2002:a17:906:71d4:b0:a28:e67e:9b36 with SMTP id i20-20020a17090671d400b00a28e67e9b36mr624635ejk.102.1704980218518;
        Thu, 11 Jan 2024 05:36:58 -0800 (PST)
Received: from alley ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id c6-20020a17090603c600b00a2a4a6e1bc5sm583798eja.204.2024.01.11.05.36.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jan 2024 05:36:58 -0800 (PST)
Date: Thu, 11 Jan 2024 14:36:56 +0100
From: Petr Mladek <pmladek@suse.com>
To: Marcos Paulo de Souza <mpdesouza@suse.com>
Cc: Shuah Khan <shuah@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Jiri Kosina <jikos@kernel.org>, Miroslav Benes <mbenes@suse.cz>,
	Joe Lawrence <joe.lawrence@redhat.com>,
	linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
	live-patching@vger.kernel.org
Subject: Re: [PATCH v5 3/3] selftests: livepatch: Test livepatching a heavily
 called syscall
Message-ID: <ZZ_u-ChoLo2AW_DE@alley>
References: <20240109-send-lp-kselftests-v5-0-364d59a69f12@suse.com>
 <20240109-send-lp-kselftests-v5-3-364d59a69f12@suse.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240109-send-lp-kselftests-v5-3-364d59a69f12@suse.com>

On Tue 2024-01-09 21:24:56, Marcos Paulo de Souza wrote:
> The test proves that a syscall can be livepatched. It is interesting
> because syscalls are called a tricky way. Also the process gets
> livepatched either when sleeping in the userspace or when entering
> or leaving the kernel space.
> 
> The livepatch is a bit tricky:
>   1. The syscall function name is architecture specific. Also
>      ARCH_HAS_SYSCALL_WRAPPER must be taken in account.
> 
>   2. The syscall must stay working the same way for other processes
>      on the system. It is solved by decrementing a counter only
>      for PIDs of the test processes. It means that the test processes
>      has to call the livepatched syscall at least once.
> 
> The test creates one userspace process per online cpu. The processes
> are calling getpid in a busy loop. The intention is to create random
> locations when the livepatch gets enabled. Nothing is guarantted.
> The magic is in the randomness.
> 
> Reviewed-by: Joe Lawrence <joe.lawrence@redhat.com>
> Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr

