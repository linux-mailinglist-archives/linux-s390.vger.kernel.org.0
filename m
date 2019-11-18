Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BC735100E85
	for <lists+linux-s390@lfdr.de>; Mon, 18 Nov 2019 23:00:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727014AbfKRWAm (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Mon, 18 Nov 2019 17:00:42 -0500
Received: from mail-qv1-f65.google.com ([209.85.219.65]:38078 "EHLO
        mail-qv1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726272AbfKRWAk (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 18 Nov 2019 17:00:40 -0500
Received: by mail-qv1-f65.google.com with SMTP id q19so7252411qvs.5
        for <linux-s390@vger.kernel.org>; Mon, 18 Nov 2019 14:00:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+uM3O9HqQgWRtXj1MLGone+IZFlYy7CPeRUTYOQhw/4=;
        b=gicUrqAkCdjKCwj3Ptmg69zLTOzebuZgKNBzETv9wjPrq20r7+YpZ45ldOYxZT3LID
         kIz4yQrGsBKcxltE8wCDCKVynU6p+ky1lAFkNYgpXTl1CWJa1l5L38vNDbFjWSnIqGi1
         UHnpa4BNXi40A0+f0VJlu1GLMw5uGEHlSVKvRxabyAEvuLFGPoMPChN5WdCVI00MRk28
         8BgQmrURpMzh9ls/Pt/P+n9IzSb+rxiGwhDCN9O01S3zC0W3/TenKSfafoUjQlOMKFOQ
         RB0UZlFywQIm9qRAUcKiWCpOGYkDY+qwkBsF796C8uNGL1EBX+AmNyhWdn9CnIyt6f8Z
         t1nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+uM3O9HqQgWRtXj1MLGone+IZFlYy7CPeRUTYOQhw/4=;
        b=IRyxXz+WZj9hB9Iq2ZtXTGDQ9tQ6erWftmZIfXuBTqxJMf3lNr2VpEf5k76MDEYxsL
         h2jpdG+QcWPuCbZwoWA+MLUsbX8ttww2oI3uOjsqdu3bwfvWJd3LEb+/tP4t1MAFpZ9U
         0gEkFVDH4nhn7jgx8F2gurIrKLHYevJcl6QfNsu5cp3kwCvTDTff1RaoPQNTqicsa3L8
         xoUPzIZG62wBkPAUgSUzaJhUb+4sgg4Yis0IWAlLuTxaaODH7lQlSny/k+NlJriJ2aZW
         BtrJ8gMWTIRcPc8ZB9/u721q8NYOHHZM6p/OyWb/5GZmSv2dkEDM7uAZfdHMghwd1SSI
         w2nQ==
X-Gm-Message-State: APjAAAWqg7YkAai0dxzDJhArXljkUTkEowWwIQB6kOpA+HrB7U2oNFHd
        00BplF5arBDbSC29xEvR7EMt/w==
X-Google-Smtp-Source: APXvYqwPcEqu5wYXBpQ8TuHfZ6/MKcfmBVgT8xSFaNfUnv/7d5jJQYrcCvVqVOrz5AlFpKEDx82Qqw==
X-Received: by 2002:a0c:be82:: with SMTP id n2mr28164023qvi.70.1574114438227;
        Mon, 18 Nov 2019 14:00:38 -0800 (PST)
Received: from localhost ([2620:10d:c091:500::1:1113])
        by smtp.gmail.com with ESMTPSA id 8sm9097265qkr.29.2019.11.18.14.00.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2019 14:00:37 -0800 (PST)
Date:   Mon, 18 Nov 2019 17:00:36 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Qian Cai <cai@lca.pw>
Cc:     Suren Baghdasaryan <surenb@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: PSI: use-after-free in collect_percpu_times()
Message-ID: <20191118220036.GA382712@cmpxchg.org>
References: <1574113159.5937.148.camel@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1574113159.5937.148.camel@lca.pw>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Hi Qian,

On Mon, Nov 18, 2019 at 04:39:19PM -0500, Qian Cai wrote:
> Since a few days ago, s390 starts to crash on linux-next while reading some
> sysfs. It is not always reproducible but seems pretty reproducible after running
> the whole MM test suite here,
> https://github.com/cailca/linux-mm/blob/master/test.sh
> 
> the config:
> https://raw.githubusercontent.com/cailca/linux-mm/master/s390.config
> 
> The stack trace on s390 is not particular helpful as both gdb and faddr2line are
> unable to point out which line causes the issue.
> 
> # ./scripts/faddr2line vmlinux collect_percpu_times+0x2d6/0x798
> bad symbol size: base: 0x00000000002076f8 end: 0x00000000002076f8
> 
> (gdb) list *(collect_percpu_times+0x2d6)
> 0x2079ce is in collect_percpu_times (./include/linux/compiler.h:199).
> 194	})
> 195	
> 196	static __always_inline
> 197	void __read_once_size(const volatile void *p, void *res, int size)
> 198	{
> 199		__READ_ONCE_SIZE;
> 200	}
> 201	
> 202	#ifdef CONFIG_KASAN
> 203	/*
> 
> Could it be some race conditions in PSI?

psi doesn't do much lifetime management in itself: the psi_group is
embedded in the cgroup and the per-cpu data is freed right before the
cgroup itself is freed. An open file descriptor on the pressure files
will pin the cgroup and prevent it from being deleted.

As it's reproducible, would you be able to bisect this problem?
