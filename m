Return-Path: <linux-s390+bounces-21792-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id srJRAYciTmpnDwIAu9opvQ
	(envelope-from <linux-s390+bounces-21792-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Wed, 08 Jul 2026 12:12:23 +0200
X-Original-To: lists+linux-s390@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C5F4724181
	for <lists+linux-s390@lfdr.de>; Wed, 08 Jul 2026 12:12:22 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=suse.com header.s=google header.b="cX/uMt1R";
	dmarc=pass (policy=quarantine) header.from=suse.com;
	spf=pass (mail.lfdr.de: domain of "linux-s390+bounces-21792-lists+linux-s390=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-s390+bounces-21792-lists+linux-s390=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B828E301DD09
	for <lists+linux-s390@lfdr.de>; Wed,  8 Jul 2026 10:10:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7A8F38B7C3;
	Wed,  8 Jul 2026 10:10:51 +0000 (UTC)
X-Original-To: linux-s390@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A6F4389DE8
	for <linux-s390@vger.kernel.org>; Wed,  8 Jul 2026 10:10:50 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783505451; cv=none; b=XNOC763Y1+ZGKQufAeVHd5HgZRnLUcKJOG263m/lyvttG6X6jTUSVIoouXc2GEQhRPO9CuenhBOXCE7uZHFhmL7BkmlYiWJqMtwzldIq6bB0HCIfei1m1B0OYWtty7CzDjeU2PIAIHCwrv/EgQw1RU3kNLs75D01SIiyjC0NPs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783505451; c=relaxed/simple;
	bh=ecF2cTn5AYhAAM68s9B/PAUIJM5SNBc7WXxDZmZ73mo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kGS5PG08oVs7QbyN7BarsaOL3Y4K87l0P6KCo3IBxAxG6p+PwVIRbB2O7NapC8tUyI4zmCC3xalwsVCu8AU3dEgPonlLoWD2wmWv7aWzjrZJau7xCHDfY06QtMmeUfkTWDp+zloXVzkYvpS+iIlQJgw2BYYogakPI367bKPDOM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=cX/uMt1R; arc=none smtp.client-ip=209.85.128.48
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-493b786d6c0so2489525e9.2
        for <linux-s390@vger.kernel.org>; Wed, 08 Jul 2026 03:10:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1783505449; x=1784110249; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JNhfZKXmPDIRApTD3u3cceCo1e7KoMWEMGSpd5WD324=;
        b=cX/uMt1RSfp0n/7y9fyGVoExl7JnbjQQtYqyosKI6Up334zNll97aeFqpf/AJARIzp
         KOXS4t3NsVDjNslte7VDW4gVwbMPOm3f/OUfySnXs4WIsd0dbSQWhP+SqmXEEToeir1S
         D1G3PMLsJgmYQD9a5WTxu7ARw2xrorFuXb/GWZtKNOi1q5dTQpgn/mURcdmE2lYgmPSQ
         iQ64J2GQ/jUX6jlbvjmUVT+DQiZfh02bTJEhRdHBJNM+4N8Yyl/eh8z8YASKgKc+Om7i
         3CSZFxq4G54qEoYLRWwXSCm5iY8BZU3r8IYXKeIz4eLc30AmBYuxp1jFUO90Hi/OXwjP
         xunQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783505449; x=1784110249;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JNhfZKXmPDIRApTD3u3cceCo1e7KoMWEMGSpd5WD324=;
        b=KIUP5FWYFDd4Zxu22STSt+Ww0zd4BqbYf3XCHKziHeq6ojC74Zz/Vx6SRTI3ZcaSEv
         NANtYsMH6QLWPXAZdg4LWzmppRnbr/ZamfhFFPP00kdy1Bv6MquTJNwgLMXxudhWeTVX
         cXd3Wu262o/rmxyY/yorSldsPitIInym51eH9hHRKnekZshIKqcdPY3EjDCpf0mjvarK
         rr2pufa3TFPyK6+s3/dkFvRCLgN6MU+1T+E6tqaTWe2254C4hroHGx8yYyRNDxfFhmGN
         1gCuhJTju68F5PglMFsn7XKi0XRwsFHj0aV8W2hvkKTx0CiXLM14wWYQ2s6g/Iy5R4mL
         bpnA==
X-Forwarded-Encrypted: i=1; AHgh+RpagMnmtv3KiWgN/4Qooy/6gbD/NiC7fGIIG5QjoMuSY4zoahVUU2Zq3olS57xN7jlmrCXNpmj6uDww@vger.kernel.org
X-Gm-Message-State: AOJu0YzWrUN13+ee61Qj1t7wOMkM8w6OHkh80SPoFKgOL7JADnSi4D+Y
	+gUpdAgL5mgo1XKWeB23JhHDREKfmn64cLkwh87htIHSQ7Ox6X6Y3M1cWvt02c2B4RXnIXuPNB7
	XdtMvsSY=
X-Gm-Gg: AfdE7ckvadoctSnMFST7LeBVDynZz49SR0akgTUuwVH77uNP99aUGLE4hH4WK+U4pz+
	7E9gEWNTM3kS6UvJpVzmReYLeuoACDWAaJSuLtTb7O9J5ptSnHDqEPn6GQymJ7sO+uAmyOScuRl
	XywFH8ShZYIURl5Xhp3bvcPjhRttaokaHBWncuAS5Gbu//+DR0r2W21LMgpPTrxf0Ct4WYSABXS
	nvTp6Sq34pwJk1uVsFVl4PIK/2PpV0x5L8fQaVbewzN4Y8a/G0adYqnwKJsacLsWN7nbYPM5E5r
	mLT8bqZ7jG2uks71h6KUvyPG/sy3vcgpqTSFLfDU/+Ege9yxdFMB+9vmNkfFTiR3EbdZifYBWn9
	iQ/0rH+zBK0C73N48xNYyRldAZJ/TWRJYDTvCPa6nIWvXJ7X9f+A8oUYLaQneA9LeJbNd/rvgNp
	4lzEzilN42wHREs/C2ZKj9ExhZ3CFDok66iQ==
X-Received: by 2002:a05:600c:4f91:b0:490:be14:bfda with SMTP id 5b1f17b1804b1-493e6859a48mr17703585e9.6.1783505448853;
        Wed, 08 Jul 2026 03:10:48 -0700 (PDT)
Received: from [192.168.42.79] (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493e0fbb410sm130766595e9.12.2026.07.08.03.10.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jul 2026 03:10:48 -0700 (PDT)
Message-ID: <883098de-dc3c-4c72-abf4-75b67c0c3351@suse.com>
Date: Wed, 8 Jul 2026 12:10:47 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] tpm_crb_ffa: Include linux/slab.h for kzalloc_obj()
 and kfree()
To: sashiko-reviews@lists.linux.dev
Cc: kvm@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
 linux-modules@vger.kernel.org, Alexander Gordeev <agordeev@linux.ibm.com>,
 linux-s390@vger.kernel.org, Vasily Gorbik <gor@linux.ibm.com>
References: <20260707153819.4172541-1-petr.pavlu@suse.com>
 <20260707153819.4172541-4-petr.pavlu@suse.com>
 <20260707154337.CE2901F000E9@smtp.kernel.org>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <20260707154337.CE2901F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[suse.com:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-21792-lists,linux-s390=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[petr.pavlu@suse.com,linux-s390@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:sashiko-reviews@lists.linux.dev,m:kvm@vger.kernel.org,m:hca@linux.ibm.com,m:linux-modules@vger.kernel.org,m:agordeev@linux.ibm.com,m:linux-s390@vger.kernel.org,m:gor@linux.ibm.com,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[petr.pavlu@suse.com,linux-s390@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-s390];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,suse.com:from_mime,suse.com:email,suse.com:mid,suse.com:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8C5F4724181

On 7/7/26 5:43 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Low] The commit message incorrectly claims that the file uses `kzalloc_obj()` instead of `kzalloc()`.
> --
> 
> --- Patch [3]: [PATCH 3/4] tpm_crb_ffa: Include linux/slab.h for kzalloc_obj() and kfree() ---
> commit a56e4cf89267d12126bd70f7981a05c846959016
> Author: Petr Pavlu <petr.pavlu@suse.com>
> 
> tpm_crb_ffa: Include linux/slab.h for kzalloc_obj() and kfree()
> 
> This commit adds the missing linux/slab.h inclusion to tpm_crb_ffa.c.
> It removes the reliance on indirect inclusion through linux/module.h.
> This prepares for the eventual removal of linux/elf.h from linux/module.h.
> 
>> tpm_crb_ffa: Include linux/slab.h for kzalloc_obj() and kfree()
> 
> [Severity: Low]
> This isn't a bug, but there appears to be a typo in the commit subject.
> Did you mean kzalloc() instead of kzalloc_obj()? Looking at
> tpm_crb_ffa_probe() in the driver, it correctly calls kzalloc().
> 
>> The drivers/char/tpm/tpm_crb_ffa.c file uses kzalloc_obj() and kfree(),
> 
> [Severity: Low]
> This isn't a bug, but the same typo is also present here in the commit
> description.
> 

I don't see a typo here. The code uses the kzalloc_obj() macro:

https://github.com/torvalds/linux/blob/v7.2-rc2/drivers/char/tpm/tpm_crb_ffa.c#L339

