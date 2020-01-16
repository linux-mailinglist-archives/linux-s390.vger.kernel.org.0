Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9B31B13D6D1
	for <lists+linux-s390@lfdr.de>; Thu, 16 Jan 2020 10:26:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730599AbgAPJ0L (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Thu, 16 Jan 2020 04:26:11 -0500
Received: from mail-il1-f196.google.com ([209.85.166.196]:35945 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729619AbgAPJ0K (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 16 Jan 2020 04:26:10 -0500
Received: by mail-il1-f196.google.com with SMTP id b15so17562192iln.3
        for <linux-s390@vger.kernel.org>; Thu, 16 Jan 2020 01:26:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5+T2+f3YUqy/mz/g0zqdHuyixNv3uIRSRLqHpYCvIA8=;
        b=YNsZvqMC3qBwhA390kR+0O1+Z775NXpgorZ1Uj0LTNfhunlCVnboeL+hdbdTD7zPyj
         cO4YdefQbXLyr/t0viYTQNIs2/R9znJRs+JPdwF+zlywPmjg5MJOT97iGih9buKS3tvr
         detFCcSpM8To0oU1Jp0ON3jtZma7mcyCUwQck=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5+T2+f3YUqy/mz/g0zqdHuyixNv3uIRSRLqHpYCvIA8=;
        b=c4R0nNsbeiNuivPO4dHmM7xuXbAsXljCFnCnxD135i/yLMk/1R6HtO4TnIG6mQomO+
         CQbLafpZxa1/Nnmhm3o8yAu7yNG8NINAY82+0FHCes8yPngb65Z22L647QNv0CCsPeRP
         TwSMW9ZK4pXO9KGXXjorRdzdgxf6NGgltT1mpWfvhL/91zJPbzxXhxEiH57SdLGN7k9I
         adBkqrd9J7tpkN4/Ynxy1wh8hZyZiNmyYyRI45qE1r2GQa5sIN0SYv6DM0YZrosPi9/w
         ha8pNtpiF+X/k9XqfWoTyds3u5jTv4YeMUHtYwG2WrTSUJH8tSc3J4S+x8MB/B9iafRD
         Nx2A==
X-Gm-Message-State: APjAAAWUYPmlKgmwteRNa8lJC/rGkDOpv170r0S/+biY6lrIJ4pyeTxc
        1pIdjAbVdKbVS5w78UXJ7xi59TgjDmlfHisgoE6FeQ==
X-Google-Smtp-Source: APXvYqzcJuvwLp0x5+fMsP13ADUUEVQCs/aLETOB1GPnAQGr8kZxelM+YUGAkJZnZhbBbnQ8HdB5j4UwUbclM7dRrHw=
X-Received: by 2002:a92:8851:: with SMTP id h78mr2599028ild.308.1579166769584;
 Thu, 16 Jan 2020 01:26:09 -0800 (PST)
MIME-Version: 1.0
References: <20200115063410.131692-1-hsinyi@chromium.org> <20200115114112.GA3663@bogus>
In-Reply-To: <20200115114112.GA3663@bogus>
From:   Hsin-Yi Wang <hsinyi@chromium.org>
Date:   Thu, 16 Jan 2020 17:25:43 +0800
Message-ID: <CAJMQK-ip7C71=K+CViEKcc3ed4GPY_Uknm5uNgLJTzZb2aQOcA@mail.gmail.com>
Subject: Re: [PATCH v5] reboot: support offline CPUs before reboot
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Jiri Kosina <jkosina@suse.cz>,
        Pavankumar Kondeti <pkondeti@codeaurora.org>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Aaro Koskinen <aaro.koskinen@nokia.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Will Deacon <will@kernel.org>,
        Fenghua Yu <fenghua.yu@intel.com>,
        James Morse <james.morse@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Guenter Roeck <groeck@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        lkml <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>, linux-csky@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-parisc@vger.kernel.org,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-s390@vger.kernel.org,
        Linux-sh list <linux-sh@vger.kernel.org>,
        sparclinux@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Wed, Jan 15, 2020 at 7:41 PM Sudeep Holla <sudeep.holla@arm.com> wrote:
>
> On Wed, Jan 15, 2020 at 02:34:10PM +0800, Hsin-Yi Wang wrote:
> > Currently system reboots uses architecture specific codes (smp_send_stop)
> > to offline non reboot CPUs. Most architecture's implementation is looping
> > through all non reboot online CPUs and call ipi function to each of them. Some
> > architecture like arm64, arm, and x86... would set offline masks to cpu without
> > really offline them. This causes some race condition and kernel warning comes
> > out sometimes when system reboots.
> >
> > This patch adds a config ARCH_OFFLINE_CPUS_ON_REBOOT, which would offline cpus in
> > migrate_to_reboot_cpu(). If non reboot cpus are all offlined here, the loop for
> > checking online cpus would be an empty loop. If architecture don't enable this
> > config, or some cpus somehow fails to offline, it would fallback to ipi
> > function.
> >
>
> What's the timing impact on systems with large number of CPUs(say 256 or
> more) ? I remember we added some change to reduce the wait times for
> offlining CPUs in system suspend path on arm64, still not negligible.
>

This is not the final solution, but I would still provided some data
points here:

Tested on my arm64 with 4 cpu: 2 a53 and 2 a72.
Offlining 3 cpu takes about 60~65 ms
Offlining 2 cpu(a53+a72 or a72+a72) takes about 42~47 ms
Offlining 1 cpu(a53 or a72) takes about 23~25 ms.

It would take longer time for systems with large number of CPUs.
