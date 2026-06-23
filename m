Return-Path: <linux-s390+bounces-21134-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id yBshJRs+Ompr4gcAu9opvQ
	(envelope-from <linux-s390+bounces-21134-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Tue, 23 Jun 2026 10:04:43 +0200
X-Original-To: lists+linux-s390@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E16496B5141
	for <lists+linux-s390@lfdr.de>; Tue, 23 Jun 2026 10:04:42 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=FklgZfZv;
	spf=pass (mail.lfdr.de: domain of "linux-s390+bounces-21134-lists+linux-s390=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-s390+bounces-21134-lists+linux-s390=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 68ED43028F07
	for <lists+linux-s390@lfdr.de>; Tue, 23 Jun 2026 08:02:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6428F3C7DF5;
	Tue, 23 Jun 2026 08:02:53 +0000 (UTC)
X-Original-To: linux-s390@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5926E3C4B93;
	Tue, 23 Jun 2026 08:02:52 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782201773; cv=none; b=N6IjYTLcLZSa3aQEa8hGf+SYbxeM7EwoaCuRc+GVXboNFivUsb4pWPdoDVRnyf4Gf1zLISsANsP/a++g/dSwKT68OMcHLR7vrIOn0LZhzDhPdeFB6yDliKYk38caTPISFAqdBduLNXV0CJ8X719SQ0SyTlboUyi3cNCnRLSh5R8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782201773; c=relaxed/simple;
	bh=qKSmb2rf/MYen8UjnYMNdVit/7nvn1RbEp4Fg6ok5LQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b5HKyg4u5F0d9qlFqjla/k8yYuY34zkvO6SX+iYjP5vJ/YmeinVH5Qx3bmIjI/j2ZVKNRBKLtarxs4kpRzeJgcc8yKom5IjFsmFsP8hUKGMvR4M3kdeWSxkDJSE2mWxl3VSYjnGBRLOtKiXkjXZAef3PFHnMnQ90QVuTCuio2gA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FklgZfZv; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 986D81F000E9;
	Tue, 23 Jun 2026 08:02:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782201771;
	bh=uGXAbbvDtMgdseoEBMP4tUzRSWv2MJSuTR3Me0ClWC8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=FklgZfZvf9emq2gmny2eGq6EMuPFgTPg3jmwAxmLaYfdeYYOx9o/LUsxGSyhC90Aj
	 wyT19RvXdWlMCbyU9x5qRfWKwzHtDUwLyiTaRdHPzlhCnqASxByUiH+reBxZa6dm6/
	 2eUrKJ7Sl3Ard2QCWFs5RMYz0cEIAQCf+F3cTsedtE8mzwpzHancQo4aEImHF0L8cr
	 Fy0cEII7dznV9is/6QM/nYIXsQ76KUnc8J3lz0n9fEPXD9BgbtOHKKHco2unHFN5KT
	 hMyDhDgPqCuk0aLgK7toBqI2XUvKRYcOcAAOK274SYOnvXU30gUDeEG5XgOjyI10Dd
	 19K+31feZDQsg==
Message-ID: <d04f745d-eb3e-4d2c-8ea2-5fdcf2cf27b8@kernel.org>
Date: Tue, 23 Jun 2026 10:02:40 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/5] mm: reduce mmap_lock contention and improve page
 fault performance
To: Hongru Zhang <zhanghongru06@gmail.com>
Cc: akpm@linux-foundation.org, baohua@kernel.org, bhe@redhat.com,
 chentao@kylinos.cn, chrisl@kernel.org, jack@suse.cz, kasong@tencent.com,
 kunwu.chan@gmail.com, liam@infradead.org, lianux.mm@gmail.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, linux-riscv@lists.infradead.org,
 linux-s390@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 liyangouwen1@oppo.com, ljs@kernel.org, loongarch@lists.linux.dev,
 mhocko@suse.com, nphamcs@gmail.com, nzzhao@126.com, pfalcato@suse.de,
 rppt@kernel.org, shikemeng@huaweicloud.com, surenb@google.com,
 vbabka@kernel.org, wanglian@kylinos.cn, willy@infradead.org,
 youngjun.park@lge.com
References: <3be9475b-0e8a-4df8-a130-4262f993973d@kernel.org>
 <20260623075805.466317-1-zhanghongru@xiaomi.com>
From: "David Hildenbrand (Arm)" <david@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 xsFNBFXLn5EBEAC+zYvAFJxCBY9Tr1xZgcESmxVNI/0ffzE/ZQOiHJl6mGkmA1R7/uUpiCjJ
 dBrn+lhhOYjjNefFQou6478faXE6o2AhmebqT4KiQoUQFV4R7y1KMEKoSyy8hQaK1umALTdL
 QZLQMzNE74ap+GDK0wnacPQFpcG1AE9RMq3aeErY5tujekBS32jfC/7AnH7I0v1v1TbbK3Gp
 XNeiN4QroO+5qaSr0ID2sz5jtBLRb15RMre27E1ImpaIv2Jw8NJgW0k/D1RyKCwaTsgRdwuK
 Kx/Y91XuSBdz0uOyU/S8kM1+ag0wvsGlpBVxRR/xw/E8M7TEwuCZQArqqTCmkG6HGcXFT0V9
 PXFNNgV5jXMQRwU0O/ztJIQqsE5LsUomE//bLwzj9IVsaQpKDqW6TAPjcdBDPLHvriq7kGjt
 WhVhdl0qEYB8lkBEU7V2Yb+SYhmhpDrti9Fq1EsmhiHSkxJcGREoMK/63r9WLZYI3+4W2rAc
 UucZa4OT27U5ZISjNg3Ev0rxU5UH2/pT4wJCfxwocmqaRr6UYmrtZmND89X0KigoFD/XSeVv
 jwBRNjPAubK9/k5NoRrYqztM9W6sJqrH8+UWZ1Idd/DdmogJh0gNC0+N42Za9yBRURfIdKSb
 B3JfpUqcWwE7vUaYrHG1nw54pLUoPG6sAA7Mehl3nd4pZUALHwARAQABzS5EYXZpZCBIaWxk
 ZW5icmFuZCAoQ3VycmVudCkgPGRhdmlkQGtlcm5lbC5vcmc+wsGQBBMBCAA6AhsDBQkmWAik
 AgsJBBUKCQgCFgICHgUCF4AWIQQb2cqtc1xMOkYN/MpN3hD3AP+DWgUCaYJt/AIZAQAKCRBN
 3hD3AP+DWriiD/9BLGEKG+N8L2AXhikJg6YmXom9ytRwPqDgpHpVg2xdhopoWdMRXjzOrIKD
 g4LSnFaKneQD0hZhoArEeamG5tyo32xoRsPwkbpIzL0OKSZ8G6mVbFGpjmyDLQCAxteXCLXz
 ZI0VbsuJKelYnKcXWOIndOrNRvE5eoOfTt2XfBnAapxMYY2IsV+qaUXlO63GgfIOg8RBaj7x
 3NxkI3rV0SHhI4GU9K6jCvGghxeS1QX6L/XI9mfAYaIwGy5B68kF26piAVYv/QZDEVIpo3t7
 /fjSpxKT8plJH6rhhR0epy8dWRHk3qT5tk2P85twasdloWtkMZ7FsCJRKWscm1BLpsDn6EQ4
 jeMHECiY9kGKKi8dQpv3FRyo2QApZ49NNDbwcR0ZndK0XFo15iH708H5Qja/8TuXCwnPWAcJ
 DQoNIDFyaxe26Rx3ZwUkRALa3iPcVjE0//TrQ4KnFf+lMBSrS33xDDBfevW9+Dk6IISmDH1R
 HFq2jpkN+FX/PE8eVhV68B2DsAPZ5rUwyCKUXPTJ/irrCCmAAb5Jpv11S7hUSpqtM/6oVESC
 3z/7CzrVtRODzLtNgV4r5EI+wAv/3PgJLlMwgJM90Fb3CB2IgbxhjvmB1WNdvXACVydx55V7
 LPPKodSTF29rlnQAf9HLgCphuuSrrPn5VQDaYZl4N/7zc2wcWM7BTQRVy5+RARAA59fefSDR
 9nMGCb9LbMX+TFAoIQo/wgP5XPyzLYakO+94GrgfZjfhdaxPXMsl2+o8jhp/hlIzG56taNdt
 VZtPp3ih1AgbR8rHgXw1xwOpuAd5lE1qNd54ndHuADO9a9A0vPimIes78Hi1/yy+ZEEvRkHk
 /kDa6F3AtTc1m4rbbOk2fiKzzsE9YXweFjQvl9p+AMw6qd/iC4lUk9g0+FQXNdRs+o4o6Qvy
 iOQJfGQ4UcBuOy1IrkJrd8qq5jet1fcM2j4QvsW8CLDWZS1L7kZ5gT5EycMKxUWb8LuRjxzZ
 3QY1aQH2kkzn6acigU3HLtgFyV1gBNV44ehjgvJpRY2cC8VhanTx0dZ9mj1YKIky5N+C0f21
 zvntBqcxV0+3p8MrxRRcgEtDZNav+xAoT3G0W4SahAaUTWXpsZoOecwtxi74CyneQNPTDjNg
 azHmvpdBVEfj7k3p4dmJp5i0U66Onmf6mMFpArvBRSMOKU9DlAzMi4IvhiNWjKVaIE2Se9BY
 FdKVAJaZq85P2y20ZBd08ILnKcj7XKZkLU5FkoA0udEBvQ0f9QLNyyy3DZMCQWcwRuj1m73D
 sq8DEFBdZ5eEkj1dCyx+t/ga6x2rHyc8Sl86oK1tvAkwBNsfKou3v+jP/l14a7DGBvrmlYjO
 59o3t6inu6H7pt7OL6u6BQj7DoMAEQEAAcLBfAQYAQgAJgIbDBYhBBvZyq1zXEw6Rg38yk3e
 EPcA/4NaBQJonNqrBQkmWAihAAoJEE3eEPcA/4NaKtMQALAJ8PzprBEXbXcEXwDKQu+P/vts
 IfUb1UNMfMV76BicGa5NCZnJNQASDP/+bFg6O3gx5NbhHHPeaWz/VxlOmYHokHodOvtL0WCC
 8A5PEP8tOk6029Z+J+xUcMrJClNVFpzVvOpb1lCbhjwAV465Hy+NUSbbUiRxdzNQtLtgZzOV
 Zw7jxUCs4UUZLQTCuBpFgb15bBxYZ/BL9MbzxPxvfUQIPbnzQMcqtpUs21CMK2PdfCh5c4gS
 sDci6D5/ZIBw94UQWmGpM/O1ilGXde2ZzzGYl64glmccD8e87OnEgKnH3FbnJnT4iJchtSvx
 yJNi1+t0+qDti4m88+/9IuPqCKb6Stl+s2dnLtJNrjXBGJtsQG/sRpqsJz5x1/2nPJSRMsx9
 5YfqbdrJSOFXDzZ8/r82HgQEtUvlSXNaXCa95ez0UkOG7+bDm2b3s0XahBQeLVCH0mw3RAQg
 r7xDAYKIrAwfHHmMTnBQDPJwVqxJjVNr7yBic4yfzVWGCGNE4DnOW0vcIeoyhy9vnIa3w1uZ
 3iyY2Nsd7JxfKu1PRhCGwXzRw5TlfEsoRI7V9A8isUCoqE2Dzh3FvYHVeX4Us+bRL/oqareJ
 CIFqgYMyvHj7Q06kTKmauOe4Nf0l0qEkIuIzfoLJ3qr5UyXc2hLtWyT9Ir+lYlX9efqh7mOY
 qIws/H2t
In-Reply-To: <20260623075805.466317-1-zhanghongru@xiaomi.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:zhanghongru06@gmail.com,m:akpm@linux-foundation.org,m:baohua@kernel.org,m:bhe@redhat.com,m:chentao@kylinos.cn,m:chrisl@kernel.org,m:jack@suse.cz,m:kasong@tencent.com,m:kunwu.chan@gmail.com,m:liam@infradead.org,m:lianux.mm@gmail.com,m:linux-arm-kernel@lists.infradead.org,m:linux-kernel@vger.kernel.org,m:linux-mm@kvack.org,m:linux-riscv@lists.infradead.org,m:linux-s390@vger.kernel.org,m:linuxppc-dev@lists.ozlabs.org,m:liyangouwen1@oppo.com,m:ljs@kernel.org,m:loongarch@lists.linux.dev,m:mhocko@suse.com,m:nphamcs@gmail.com,m:nzzhao@126.com,m:pfalcato@suse.de,m:rppt@kernel.org,m:shikemeng@huaweicloud.com,m:surenb@google.com,m:vbabka@kernel.org,m:wanglian@kylinos.cn,m:willy@infradead.org,m:youngjun.park@lge.com,m:kunwuchan@gmail.com,m:lianuxmm@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-21134-lists,linux-s390=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[31];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[david@kernel.org,linux-s390@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[david@kernel.org,linux-s390@vger.kernel.org];
	FREEMAIL_CC(0.00)[linux-foundation.org,kernel.org,redhat.com,kylinos.cn,suse.cz,tencent.com,gmail.com,infradead.org,lists.infradead.org,vger.kernel.org,kvack.org,lists.ozlabs.org,oppo.com,lists.linux.dev,suse.com,126.com,suse.de,huaweicloud.com,google.com,lge.com];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-s390];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E16496B5141

On 6/23/26 09:58, Hongru Zhang wrote:
>> On 5/20/26 23:15, Matthew Wilcox wrote:
>>>
>>> all of the applications i run are either single threaded or don't fork.
>>> what multithreaded applications call fork?
>>
>> Traditionally the problem was random libraries using fork+execve to launch other
>> programs ... instead of using alternatives like posix_spwan (some use cases
>> require more work done before execve and cannot yet switch to that). I'd hope
>> that that is less of a problem on Android.
>>
>> I assume Android zygote might be multi threaded? Maybe sshd as well? Systemd?
>> But I'd be surprised if there are really performance implications.
>>
>> Not sure about webbroswers .... I think most of them switched to fork servers,
>> where I would assume fork servers would be single-threaded.
>>
>> So, yeah, getting a clear understanding how this ends up being a problem on
>> Android would be great.
> 
> Barry asked me to share observations on fork() usage across Android
> applications.
> 
> I wrote a BPF-based tracing tool (kprobe on copy_process, checking
> CLONE_VM to distinguish process creation from thread creation) and ran
> it against the top 200 Android applications in the China market during
> normal usage scenarios.
> 
> Results:
> - 82 out of 200 apps (41%) call fork() during normal operation

Crazy. Thanks for these numbers.

> - Among these, some call fork() from multiple threads
> 
> These are not zygote forks — they are fork() calls initiated by app
> threads at runtime. Examples by category:
> 
>   Browsers:     com.quark.browser, com.UCMobile, com.xunlei.browser
>   Shopping:     com.taobao.taobao, com.tmall.wireless, com.achievo.vipshop
>   Video:        com.youku.phone, com.qiyi.video, com.hunantv.imgo.activity
>   Social/IM:    com.alibaba.android.rimet, com.ss.android.lark
>   News:         com.ss.android.article.news, com.ss.android.article.lite
>   Navigation:   com.autonavi.minimap, com.sdu.didi.psnger
>   Finance:      com.eg.android.AlipayGphone, com.chinamworld.main

I know that especially browser usually use fork servers: a tiny
(single-threaded) process just to create new child processes. Any information
regarding the apps above that use fork() on small vs. large processes?

> 
> This confirms that fork() is widely used in real-world multi-threaded
> Android applications.

Above you write "some call fork() from multiple threads". Any further
information on that?

-- 
Cheers,

David

