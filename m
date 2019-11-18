Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8939C100E8F
	for <lists+linux-s390@lfdr.de>; Mon, 18 Nov 2019 23:05:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726272AbfKRWF6 (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Mon, 18 Nov 2019 17:05:58 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:46815 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726647AbfKRWF6 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 18 Nov 2019 17:05:58 -0500
Received: by mail-qk1-f196.google.com with SMTP id h15so15925774qka.13
        for <linux-s390@vger.kernel.org>; Mon, 18 Nov 2019 14:05:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=utEgIIdXyuvjiU+wCZAIV77AFxFDu+8dYTt1kGjwZok=;
        b=Gd08kSNGTcxarbjtgrLof1smG+W5/gVLZm33699Y1iV7U4pC1M/I8+Gnrc2ue88x16
         xD3dM+AA5uH8bNnV3TBbn8oPA3ldzxpzKOhwNfiaKxVlBpKHBMk97ttWZCF7+p/+Y2gB
         mFhWB29X7oXaEXXEClUllQzfzXdSZaAUNWBeiw6Wb0+6uhDzFS/N84zh3H3GgK4UQs4E
         zEIrddIjpwZSKtAr35V4i128Sy5YfSzs5FIb92RGpNyPuVNKKrwCW2HaC9fE6q18Ezsi
         0sjPE2b1TI+Ja4nzHtnpmfU58O9GmEQn7yOl+dXvYNh+8SstT+QQuTmeleTpCxNAWYu1
         lk9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=utEgIIdXyuvjiU+wCZAIV77AFxFDu+8dYTt1kGjwZok=;
        b=lUWcPQ597M+pD+1JddGrf+5WvvGZSSXMZdca30I1O3hJGgPbD19lxKDdl8K+AkCIs6
         vF3TCMO3wReoxyJn4GknfFEAc/36belwqw3IxKHV6NLjNY7bKaEbf3XfpeYqhJyY8dwo
         66RbfOvQQHRd5bqS4Y1BhzmN2TyYYW2c+XaBcxl7UzBmhGC4/T/MZrgIkzxZeWHsrFpq
         Mc6sAkYPMBwYZ44dFBZXMzv4rrlFio2WqDPpImXdxpzeiUD0XZamkgHRFsp3pWxMkIfs
         ecbz1+0JRC0xX93pJMEOH272XmGeiMHmP9Pm/V9fd7OGpODmUm5/iHFkEeTNhH+QY+Vd
         uNVw==
X-Gm-Message-State: APjAAAVE07WuBVJ4J9Kk8ds00zqRYBtt8NbBq9xsJNgHKpPazIGnVigs
        NM1+U+Si10SVXX8xkVXWa3kGAw==
X-Google-Smtp-Source: APXvYqzM+peUo1lSKOoXz6fiecEmuZPTfjshOjkVtJi6CoTBSW5F+j67GNIWkslvpWsyjf947G+iDg==
X-Received: by 2002:a05:620a:113a:: with SMTP id p26mr26642626qkk.479.1574114756674;
        Mon, 18 Nov 2019 14:05:56 -0800 (PST)
Received: from dhcp-41-57.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id j10sm11040243qtb.34.2019.11.18.14.05.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Nov 2019 14:05:56 -0800 (PST)
Message-ID: <1574114754.5937.154.camel@lca.pw>
Subject: Re: PSI: use-after-free in collect_percpu_times()
From:   Qian Cai <cai@lca.pw>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Suren Baghdasaryan <surenb@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Mon, 18 Nov 2019 17:05:54 -0500
In-Reply-To: <20191118220036.GA382712@cmpxchg.org>
References: <1574113159.5937.148.camel@lca.pw>
         <20191118220036.GA382712@cmpxchg.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 (3.22.6-10.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Mon, 2019-11-18 at 17:00 -0500, Johannes Weiner wrote:
> Hi Qian,
> 
> On Mon, Nov 18, 2019 at 04:39:19PM -0500, Qian Cai wrote:
> > Since a few days ago, s390 starts to crash on linux-next while reading some
> > sysfs. It is not always reproducible but seems pretty reproducible after running
> > the whole MM test suite here,
> > https://github.com/cailca/linux-mm/blob/master/test.sh
> > 
> > the config:
> > https://raw.githubusercontent.com/cailca/linux-mm/master/s390.config
> > 
> > The stack trace on s390 is not particular helpful as both gdb and faddr2line are
> > unable to point out which line causes the issue.
> > 
> > # ./scripts/faddr2line vmlinux collect_percpu_times+0x2d6/0x798
> > bad symbol size: base: 0x00000000002076f8 end: 0x00000000002076f8
> > 
> > (gdb) list *(collect_percpu_times+0x2d6)
> > 0x2079ce is in collect_percpu_times (./include/linux/compiler.h:199).
> > 194	})
> > 195	
> > 196	static __always_inline
> > 197	void __read_once_size(const volatile void *p, void *res, int size)
> > 198	{
> > 199		__READ_ONCE_SIZE;
> > 200	}
> > 201	
> > 202	#ifdef CONFIG_KASAN
> > 203	/*
> > 
> > Could it be some race conditions in PSI?
> 
> psi doesn't do much lifetime management in itself: the psi_group is
> embedded in the cgroup and the per-cpu data is freed right before the
> cgroup itself is freed. An open file descriptor on the pressure files
> will pin the cgroup and prevent it from being deleted.
> 
> As it's reproducible, would you be able to bisect this problem?

Yes, it is going to time-consuming though as I have not found a quick reproducer
yet.
