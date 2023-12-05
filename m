Return-Path: <linux-s390+bounces-328-lists+linux-s390=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F58F8058F1
	for <lists+linux-s390@lfdr.de>; Tue,  5 Dec 2023 16:39:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE39F281C81
	for <lists+linux-s390@lfdr.de>; Tue,  5 Dec 2023 15:39:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39C1C5F1E8;
	Tue,  5 Dec 2023 15:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="PPdXiABo"
X-Original-To: linux-s390@vger.kernel.org
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27CAC1B1
	for <linux-s390@vger.kernel.org>; Tue,  5 Dec 2023 07:39:26 -0800 (PST)
Received: by mail-il1-x133.google.com with SMTP id e9e14a558f8ab-35d4dea7c1eso5410505ab.0
        for <linux-s390@vger.kernel.org>; Tue, 05 Dec 2023 07:39:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1701790765; x=1702395565; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aV5Z40IgGgSyP4gennpB4QDX5F9cf6j/NtRFHTtIS+E=;
        b=PPdXiABoSCmPznzGiuGd2+AE4Rkjx+GyykgPV9ZyODUzUMGQkJGo62DwHmxPgJkmhW
         PG8QuErsveafm1zOndTBKN5dnqyeGvku0CQZtLJZv75w+Lr2xzTOv0JW3LqmLY/Y6cuf
         g5JFguds1QuhjhmbYmjdBBtc3xzb1sRg6a1Ps=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701790765; x=1702395565;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aV5Z40IgGgSyP4gennpB4QDX5F9cf6j/NtRFHTtIS+E=;
        b=mhSiQC/PX1ZCw3eB6egu2FKV1VpViITAvapVo/rII3IqwVMAtHoQzvMvrj4GYXD9Hl
         xLpr8xoij/zJhdED9q81G4CB5DfLUGXQGf6tsP7m16upRTGVsIlwaxY0tG3cwTjQdBeW
         nU3vf6ABuLu86X9Jo2vhm+hZ6JRtAWePac9VRMDWveUivNi6H/wjuIXbtui2dCYI0/HO
         ijAlZzYNUgFEuvyzkVn+91pJNRIZwK9ptjdOKxEhKnZsjDzLama8KYXqg/viSCzW2BJZ
         av4d5hS11UO27g903QREHh89g+RV1Qkfq4A0gq7KFxSkn/rPIwD+/V2CFE6CUCzSiX4h
         iMZw==
X-Gm-Message-State: AOJu0YyhKyAuBmmlmyhfUT7j20y33YIt4ZQSI/noBTd9yaKvT5VtV3hL
	EyNvyxvd4nzAMvf7mSHtkDFp4g==
X-Google-Smtp-Source: AGHT+IGGIK7VmkmKbUZWPfpCs9Qu0YmShDMC4ewlN8DMCRGgedjCEC4PT7fS1c1otbxjLibq6uZaDg==
X-Received: by 2002:a05:6e02:170f:b0:35d:6600:fceb with SMTP id u15-20020a056e02170f00b0035d6600fcebmr10728184ill.0.1701790765411;
        Tue, 05 Dec 2023 07:39:25 -0800 (PST)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id t6-20020a92dc06000000b0035ae9f62692sm639954iln.88.2023.12.05.07.39.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Dec 2023 07:39:25 -0800 (PST)
Message-ID: <76c4b967-1cb6-4f77-9402-f835b15adb10@linuxfoundation.org>
Date: Tue, 5 Dec 2023 08:39:23 -0700
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] selftests: livepatch: Test livepatching a heavily
 called syscall
To: mpdesouza@suse.com, Marcos Paulo de Souza <mpdesouza@suse.de>
Cc: Shuah Khan <shuah@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
 Alexander Gordeev <agordeev@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>, Josh Poimboeuf <jpoimboe@kernel.org>,
 Jiri Kosina <jikos@kernel.org>, Miroslav Benes <mbenes@suse.cz>,
 Petr Mladek <pmladek@suse.com>, Joe Lawrence <joe.lawrence@redhat.com>,
 linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
 live-patching@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20231031-send-lp-kselftests-v3-0-2b1655c2605f@suse.com>
 <20231031-send-lp-kselftests-v3-3-2b1655c2605f@suse.com>
 <f9d82fa6-08d7-4ab6-badc-691987b37a82@linuxfoundation.org>
 <unpg4z7eig6qbudgulnr6sog65fq7s2dy4u2vp2dgkdrq5csdw@dltnxuw6kw5b>
 <8b95b96c-6aeb-4bf0-8ee9-2ba62330c672@linuxfoundation.org>
 <12a9ec1bc84dc6d4b461e5c780ba7d3c3aa91740.camel@suse.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <12a9ec1bc84dc6d4b461e5c780ba7d3c3aa91740.camel@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/5/23 05:52, mpdesouza@suse.com wrote:
> On Fri, 2023-12-01 at 16:38 +0000, Shuah Khan wrote:

> 0003-selftests-livepatch-Test-livepatching-a-heavily-call.patch has
> style problems, please review.
> 
> NOTE: If any of the errors are false positives, please report
>        them to the maintainer, see CHECKPATCH in MAINTAINERS.
> 
> I couldn't find any mention about "missing module name". Is your script
> showing more warnings than these ones? Can you please share your
> output?
> 
> I'll fix MAINTAINERS file but I'll wait until I understand what's
> missing in your checkpatch script to resend the patchset.
> 

Looks like it is coming a script - still my question stands on
whether or not you would need a module name for this module?

I am not too concerned about MAINTAINERS file warns.

I am assuming you will be sending a new version to address
Joe Lawrence's comments?

thanks,
-- Shuah




