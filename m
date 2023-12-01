Return-Path: <linux-s390+bounces-276-lists+linux-s390=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D8E3801061
	for <lists+linux-s390@lfdr.de>; Fri,  1 Dec 2023 17:39:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CDB4A281C90
	for <lists+linux-s390@lfdr.de>; Fri,  1 Dec 2023 16:39:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F15E25747;
	Fri,  1 Dec 2023 16:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="eCPvVuKU"
X-Original-To: linux-s390@vger.kernel.org
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F61A1707
	for <linux-s390@vger.kernel.org>; Fri,  1 Dec 2023 08:38:26 -0800 (PST)
Received: by mail-io1-xd2e.google.com with SMTP id ca18e2360f4ac-7b05e65e784so15042339f.1
        for <linux-s390@vger.kernel.org>; Fri, 01 Dec 2023 08:38:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1701448706; x=1702053506; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=F4bReDtBqdZ7CQBg8UmEdVvEuIGOtXfeTpzV766B0GQ=;
        b=eCPvVuKUtcUML6PCcMRbRoVs9nIim4eBXq2DOUW6ltIoOSMN0LBgO83FAf+eQdrBDq
         A/PmkuhmUd7P/48s+UEf27F2Mcv2+uZTPpLM6X1n6JWoCdpMkNuT4GtaZDIrhfzxjz/p
         M4x1KAD0TWPjWfqQjKrbI4r6eByvIohNQ8quo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701448706; x=1702053506;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=F4bReDtBqdZ7CQBg8UmEdVvEuIGOtXfeTpzV766B0GQ=;
        b=pqlig8ruDFzct6y20tEwfFHOBmKAeLFJuNXwzOxBK6xxWRizNioVPdt9zJREoQmrmy
         DMYBGrIo95eIft0mbvQDIUwZUJ/GZn5wYbKdW1hhDvrGVlxBnu6Z/YRW9zBC5Vvumczo
         88FaW0NCxGmczAJiC1drH1czRYeFPm0ApMsD53zOatEueoQSAeybs5cH0lRKXCIqbMZ2
         YxE4jsseYbE7lLBRZVWSjESFhAkYr+rEwlz4Ahe9kiY12wOh/W2l2CT4YicY6b77rcDf
         ezLIWGTC7t0eh63e2xff81GmJkddA0hx33MCcoX4/3MaRzSwTW1/L+d5RujSsxospn1U
         9neg==
X-Gm-Message-State: AOJu0YytuZZ/2/MenplS2tLraNA3EZ/QfXV2pcNaEwKXR5xBbViCCF/l
	4HhHSCswCatDz/C3oIKAPDylbg==
X-Google-Smtp-Source: AGHT+IHG40EFSnt4Yz6Knhpd28geD95aKAGL4h+gRV294CYt5W7hXqom/+d8jZtbFp7xj3MCvp4Ghw==
X-Received: by 2002:a05:6602:489a:b0:7b3:95a4:de9c with SMTP id ee26-20020a056602489a00b007b395a4de9cmr22727490iob.1.1701448706259;
        Fri, 01 Dec 2023 08:38:26 -0800 (PST)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id u1-20020a6be901000000b007b3e503d59csm1046219iof.47.2023.12.01.08.38.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Dec 2023 08:38:25 -0800 (PST)
Message-ID: <8b95b96c-6aeb-4bf0-8ee9-2ba62330c672@linuxfoundation.org>
Date: Fri, 1 Dec 2023 09:38:24 -0700
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] selftests: livepatch: Test livepatching a heavily
 called syscall
Content-Language: en-US
To: Marcos Paulo de Souza <mpdesouza@suse.de>
Cc: Marcos Paulo de Souza <mpdesouza@suse.com>, Shuah Khan
 <shuah@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
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
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <unpg4z7eig6qbudgulnr6sog65fq7s2dy4u2vp2dgkdrq5csdw@dltnxuw6kw5b>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/1/23 06:13, Marcos Paulo de Souza wrote:
> On Thu, Nov 30, 2023 at 04:24:26PM -0700, Shuah Khan wrote:

>>
>> Missing module name? Is there a reason to not name this module?
> 
> Can you please elaborate? This new module use the same MODULE_ macros used by
> the current livepatch selftests. What do you mean by module name?
> 

Pre-commit checpatch script spdx check complained about the module name.
Please run it to see the message.

thanks,
-- Shuah


