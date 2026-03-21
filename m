Return-Path: <linux-s390+bounces-17811-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AO+YIvCWvmmTTwMAu9opvQ
	(envelope-from <linux-s390+bounces-17811-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Sat, 21 Mar 2026 14:02:40 +0100
X-Original-To: lists+linux-s390@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D53F52E5646
	for <lists+linux-s390@lfdr.de>; Sat, 21 Mar 2026 14:02:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8A27A300A5AE
	for <lists+linux-s390@lfdr.de>; Sat, 21 Mar 2026 13:02:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76DDE2D77F7;
	Sat, 21 Mar 2026 13:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="kboEZFTO"
X-Original-To: linux-s390@vger.kernel.org
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2DDE3148DD;
	Sat, 21 Mar 2026 13:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774098152; cv=none; b=MMjkoNOnfmRBG5bt3mezfkrjlQ85gCf+rVvu54D8ZUNKpaCtGfn3aJW9mWBtgEskts6+QxjLeivwRakWDIW7gTINwMwJ5en1XhDmlodoYGKsaX5AyjXMe0X2bRvQUgbf7C7NbEWk6JEMJ8S3kijOfpZOu1m7DXT4KP+IxCuuPyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774098152; c=relaxed/simple;
	bh=5v0zGqUELBT0/GD4yR9h1OHerzVmJArJcIKG+p1PNx0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XJK8FmAEwFkARuW6lQHs4c3lBtCnwdeX7WIlEYOP/1cA0oC6PH8XHub7E+igNkajnjjb+nRi3k+3FVE1C9JhQiT3QzsnY3ou1DeovDJF27b1vN55nWSBUSfOZCnTHh3V4dEy+sUGvQWu2EKJ4YFGrjCqFF6sZyjXq6P3zsatmZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=kboEZFTO; arc=none smtp.client-ip=115.124.30.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1774098139; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=NJPULCri2DdVUmJbTlU4Rxn6JWleCj28Q+e1h/YTmMM=;
	b=kboEZFTOz2Rtb9gYmE8IzYE4FS5O7f30QWXHnxnTKG0/sksKd37r6xMUVmqPDb227obki5V4WSkGKavJs8OZNpynbdQCjfDVno9yFG0sAaHzLQKLto20Gu7j+jh7mvZDBd2xH6Zut7cF+TaTfG4ks8lItl5rdGk+QSl+900LAqM=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033032089153;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=18;SR=0;TI=SMTPD_---0X.Ombip_1774098136;
Received: from 30.42.98.36(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0X.Ombip_1774098136 cluster:ay36)
          by smtp.aliyun-inc.com;
          Sat, 21 Mar 2026 21:02:17 +0800
Message-ID: <bf36511a-92de-4668-b83e-08cf6f2a6ace@linux.alibaba.com>
Date: Sat, 21 Mar 2026 21:02:16 +0800
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/6] change young flag check functions to return bool
To: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
 akpm@linux-foundation.org, david@kernel.org
Cc: ljs@kernel.org, Liam.Howlett@oracle.com, vbabka@kernel.org,
 rppt@kernel.org, surenb@google.com, mhocko@suse.com,
 linux-arm-kernel@lists.infradead.org, x86@kernel.org,
 linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
 kvm@vger.kernel.org, open <linux-mm@kvack.org>, linux-kernel@vger.kernel.org
References: <cover.1773890510.git.baolin.wang@linux.alibaba.com>
 <bjghychf.ritesh.list@gmail.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <bjghychf.ritesh.list@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-7.66 / 15.00];
	WHITELIST_DMARC(-7.00)[alibaba.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.alibaba.com,none];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-17811-lists,linux-s390=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,linux-foundation.org,kernel.org];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[baolin.wang@linux.alibaba.com,linux-s390@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-s390];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.alibaba.com:dkim,linux.alibaba.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D53F52E5646
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 3/21/26 1:31 PM, Ritesh Harjani (IBM) wrote:
> Baolin Wang <baolin.wang@linux.alibaba.com> writes:
> 
>> This is a cleanup patchset to change all young flag check functions to
>> return bool, as discussed with David in the previous thread[1]. Since
>> callers only care about whether the young flag was set, returning bool
>> makes the intention clearer. No functional changes intended.
>>
>> Ran mm selftests on Arm64 and x86 machines, and no issues were found.
>>
>> Note that I only CC'd the arch mailing lists to avoid disturbing too
>> many people.
>>
>> [1] https://lore.kernel.org/all/d172d6bf-c60c-4cf5-9da9-f30de38cdfed@kernel.org/
>>
>> Baolin Wang (6):
>>    mm: change to return bool for ptep_test_and_clear_young()
>>    mm: change to return bool for
>>      ptep_clear_flush_young()/clear_flush_young_ptes()
>>    mm: change to return bool for pmdp_test_and_clear_young()
>>    mm: change to return bool for pmdp_clear_flush_young()
>>    mm: change to return bool for pudp_test_and_clear_young()
>>    mm: change to return bool for the MMU notifier's young flag check
>>
>>   arch/arm64/include/asm/pgtable.h             | 29 ++++----
>>   arch/arm64/mm/contpte.c                      |  8 +--
>>   arch/microblaze/include/asm/pgtable.h        |  2 +-
>>   arch/parisc/include/asm/pgtable.h            |  8 +--
>>   arch/parisc/kernel/cache.c                   |  8 +--
>>   arch/powerpc/include/asm/book3s/32/pgtable.h |  4 +-
>>   arch/powerpc/include/asm/book3s/64/pgtable.h | 26 +++----
>>   arch/powerpc/include/asm/nohash/64/pgtable.h |  2 +-
>>   arch/powerpc/include/asm/nohash/pgtable.h    |  4 +-
>>   arch/powerpc/mm/book3s64/pgtable.c           |  8 +--
> 
> I did compile and boot test on powerpc with various configs and overall
> it looks good.

Really appreciate your help with testing!

