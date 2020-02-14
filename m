Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 888E215F7CA
	for <lists+linux-s390@lfdr.de>; Fri, 14 Feb 2020 21:35:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387753AbgBNUfs (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Fri, 14 Feb 2020 15:35:48 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:28524 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2387526AbgBNUfr (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 14 Feb 2020 15:35:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581712546;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gKGSem1dzrqQDUCpnIBkoTFM/3tiLutlhEzCn0ZVwrI=;
        b=Xumm3s1WKeNN/uFQyOtdkGtQww/zJgE/8TONNnKwgOkBglN8g/fZRt2uC51VCMbMtNS2v+
        mWca26Y3ZyGMXFlJAzFEhbEHkNvijXlJIGRiOHTa5e1KBZXVD9MOYyHDClTEoDaw/G5N7A
        S8LiZWnTf6psTqrsxJ9VNslgvQk/ulA=
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com
 [209.85.210.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-391-AEwRzq5gPhiYChCQg61gNQ-1; Fri, 14 Feb 2020 15:35:41 -0500
X-MC-Unique: AEwRzq5gPhiYChCQg61gNQ-1
Received: by mail-ot1-f72.google.com with SMTP id q13so5845399otm.18
        for <linux-s390@vger.kernel.org>; Fri, 14 Feb 2020 12:35:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=gKGSem1dzrqQDUCpnIBkoTFM/3tiLutlhEzCn0ZVwrI=;
        b=Ej6fga5MQBx2Q9Qwtep/JomQhRvSc+0It88WFou0g6kXnU2UfY6jUGrw/4oCeS7NE4
         oIEVNeeRM9Qwdupr2/gvkSG/4PiIVpMkPvlujNbntn/xbe0r1F2e39NhBkbEomnGXQz5
         CmyBXEUIL2Pt8zuSSW3QS6acpOpuu3+gQCfYzCqKojhNOVU23vIqBLQmUD2yD6jzpDip
         sSZyb1+bHv/L1f+ytXdXKvMNe73o/TWL92MMDcOX2ukdfizk/sHJaCKcMn2Ga0KJTaT0
         21lDQ3hnosEKr9ppSAp/42Vp6pd1dv2AUdomD4jLxPte3gr450IVzjJ+lg5RxHZbd41e
         WaSA==
X-Gm-Message-State: APjAAAVaac8lqAuFVwm+bjsNnZHNUMnnHAlVGrJIIqeXOJg8koqOZvbi
        PYl1bbPiyYWdVxHHi1Sru35vJwejiK2Fd0z0HU124ams5NaL+Liivs3T+2/cSmwTzYrmfG183nL
        jyUzyCeNs/6SpnEVt2kkd7Q==
X-Received: by 2002:a9d:4e99:: with SMTP id v25mr3826992otk.363.1581712540437;
        Fri, 14 Feb 2020 12:35:40 -0800 (PST)
X-Google-Smtp-Source: APXvYqwxMKspHpRTfCVBpbXvOLfHx1q8SGCvwZDA++Ohy6zq9CnfmhQPlRhGlpxgFHd5TUPaaSMiGA==
X-Received: by 2002:a9d:4e99:: with SMTP id v25mr3826964otk.363.1581712540000;
        Fri, 14 Feb 2020 12:35:40 -0800 (PST)
Received: from laptop.jcline.org (108-197-12-186.lightspeed.rlghnc.sbcglobal.net. [108.197.12.186])
        by smtp.gmail.com with ESMTPSA id c123sm2085384oib.34.2020.02.14.12.35.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2020 12:35:39 -0800 (PST)
Date:   Fri, 14 Feb 2020 15:35:36 -0500
From:   Jeremy Cline <jcline@redhat.com>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Philipp Rudo <prudo@linux.ibm.com>,
        Michal Kubecek <mkubecek@suse.cz>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        linux-s390 <linux-s390@vger.kernel.org>
Subject: Re: s390 depending on cc-options makes it difficult to configure
Message-ID: <20200214203536.GA133402@laptop.jcline.org>
References: <20191209164155.GA78160@dev.jcline.org>
 <20191210090108.GA22512@unicorn.suse.cz>
 <20191211171822.GA36366@dev.jcline.org>
 <20200210194936.511ef603@laptop2-ibm.local>
 <CAK7LNATL3Oyn=FLKm0TcB9SkJLuCOWV06a_t-FRtFiFp9Vda1g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK7LNATL3Oyn=FLKm0TcB9SkJLuCOWV06a_t-FRtFiFp9Vda1g@mail.gmail.com>
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Fri, Feb 14, 2020 at 12:31:05PM +0900, Masahiro Yamada wrote:
> Hi.
> 
> On Tue, Feb 11, 2020 at 3:49 AM Philipp Rudo <prudo@linux.ibm.com> wrote:
> >
> > Hey Jeremy,
> > Hey Michal,
> >
> > sorry for the late response. The mail got lost in the pre-xmas rush...
> >
> > In my opinion the problem goes beyond s390 and the commit you mentioned. So I'm
> > also adding Masahiro as Kconfig maintainer and author of cc-option.
> 
> 
> I did not notice the former discussion.
> Thanks for CC'ing me.
> 
> 
> 
> 
> > On Wed, 11 Dec 2019 12:18:22 -0500
> > Jeremy Cline <jcline@redhat.com> wrote:
> >
> > > On Tue, Dec 10, 2019 at 10:01:08AM +0100, Michal Kubecek wrote:
> > > > On Mon, Dec 09, 2019 at 11:41:55AM -0500, Jeremy Cline wrote:
> > > > > Hi folks,
> > > > >
> > > > > Commit 5474080a3a0a ("s390/Kconfig: make use of 'depends on cc-option'")
> > > > > makes it difficult to produce an s390 configuration for Fedora and Red
> > > > > Hat kernels.
> > > > >
> > > > > The issue is I have the following configurations:
> > > > >
> > > > > CONFIG_MARCH_Z13=y
> > > > > CONFIG_TUNE_Z14=y
> > > > > # CONFIG_TUNE_DEFAULT is not set
> > > > >
> > > > > When the configuration is prepared on a non-s390x host without a
> > > > > compiler with -march=z* it changes CONFIG_TUNE_DEFAULT to y which, as
> > > > > far as I can tell, leads to a kernel tuned for z13 instead of z14.
> > > > > Fedora and Red Hat build processes produce complete configurations from
> > > > > snippets on any available host in the build infrastructure which very
> > > > > frequently is *not* s390.
> > > >
> > > > We have exactly the same problem. Our developers need to update config
> > > > files for different architectures and different kernel versions on their
> > > > machines which are usually x86_64 but that often produces different
> > > > configs than the real build environment.
> > > >
> > > > This is not an issue for upstream development as one usually updates
> > > > configs on the same system where the build takes place but it's a big
> > > > problem for distribution maintainers.
> >
> > If I recall correct the goal was to avoid trouble with clang, as it does not
> > support all processor types with -march. But yeah, in the original
> > consideration we only thought about upstream development and forgot the
> > distros.
> > > > > I did a quick search and couldn't find any other examples of Kconfigs
> > > > > depending on march or mtune compiler flags and it seems like it'd
> > > > > generally problematic for people preparing configurations.
> >
> > True, but not the whole story. Power and Arm64 use cc-option to check for
> > -mstack-protector*, which do not exist on s390. So you have the same problem
> > when you prepare a config for any of them on s390. Thus simply reverting the
> > commit you mentioned above does not solve the problem but merely hides one
> > symptom. Which also means that the original problem will return over and over
> > again in the future.
> >
> > An other reason why I don't think it makes sens to revert the commit is that it
> > would make cc-option as a whole useless. What's the benefit in having cc-option
> > when you are not allowed to use it? Or less provocative, in which use cases is
> > allowed to use cc-option?
> 
> 
> You are right.
> Reverting the particular s390 commit is not the solution.
> 
> 
> > > > There are more issues like this. In general, since 4.17 or 4.18, the
> > > > resulting config depends on both architecture and compiler version.
> > > > Earlier, you could simply run "ARCH=... make oldconfig" (or menuconfig)
> > > > to update configs for all architectures and distribution versions.
> > > > Today, you need to use the right compiler version (results with e.g.
> > > > 4.8, 7.4 and 9.2 differ) and architecture.
> > > >
> > >
> > > Yeah, that's also troublesome. This is by no means the first problem
> > > related to the environment at configuration time, but it the most
> > > bothersome to work around (at least for Fedora kernel configuration).
> > >
> > > > At the moment, I'm working around the issue by using chroot environments
> > > > with target distributions (e.g. openSUSE Tumbleweed) and set of cross
> > > > compilers for supported architectures but it's far from perfect and even
> > > > this way, there are problemantic points, e.g. BPFILTER_UMH which depends
> > > > on gcc being able to not only compile but also link.
> > > >
> > > > IMHO the key problem is that .config mixes configuration with
> > > > description of build environment. I have an idea of a solution which
> > > > would consist of
> > > >
> > > >   - an option to extract "config" options which describe build
> > > >     environment (i.e. their values are determined by running some
> > > >     command, rather than reading from a file or asking user) into
> > > >     a cache file
> > > >   - an option telling "make *config" to use such cache file for these
> > > >     environment "config" options instead of running the test scripts
> > > >     (and probably issue an error if an environment option is missing)
> > > >
> > >
> > > I agree that the issue is mixing kernel configuration with build
> > > environment. I suppose a cache file would work, but it still sounds like
> > > a difficult process that is working around that fact that folks are
> > > coupling the configuration step with the build step.
> >
> > An other solution would be a "I know better" switch which simply disables
> > cc-option for that run. That would allow the use of cc-option for upstream
> > development and provide a simple way for distros to turn it off.
> >
> > > I would advocate that this patch be reverted and an effort made to not
> > > mix build environment checks into the configuration. I'm much happier
> > > for the build to fail because the configuration can't be satisfied by
> > > the environment than I am for the configuration to quietly change or for
> > > the tools to not allow me to make the configuration in the first place.
> > > Ideally the tools would warn the user if their environment won't build
> > > the configuration, but that's a nice-to-have.
> >
> > I too would prefer to have a warning instead of the config being silently
> > changed. But again, the problem goes beyond what was reported.
> >
> > @Masahiro: What do you think about it?
> >
> > Thanks
> > Philipp
> >
> 
> 
> The problem for Jeremy and Michal is,
> it is difficult to get a full-feature cross-compiler
> for every arch.
> 

Indeed.

> One idea to workaround this is
> to use a fake script that accepts any flag,
> and use it as $(CC) in Kconfig.
> 
> RFC patch is attached.
> 
> This is not a perfect solution, of course.
> 

The attached patch doesn't looks like it'd work for what we need,
although I wonder if it's easier to just check when cc-options is
defined for an environment variable or something and always return y
instead of calling out to $(CC) at all. Comes to the same thing, I
suppose.

> 
> Evaluating the compiler in the Kconfig stage
> conceptually has a conflict with the workflow
> of distro maintainers.
> 
> I think the only way to solve it completely is,
> ultimately, go back to pre 4.18 situation.
> But, I am not sure if upstream people want to do it.
> At least, Linus was happy to do compiler-tests
> in Kconfig.
> 
> I already got several criticism about the
> new feature in Kconfig because it broke the
> workflow of distro maintainers. Sorry about that.
> 

No worries, it's a tough balancing act between upstream users and
distros. It's not caused me *that* much bother.

> 
> The idea from Michal, separation of the build environment
> description, would work too.
> IIRC, the crosstool-ng project generates some
> Kconfig files based on the environment.
> In hindsight, Kconfig did not need to have cc-option
> but it was how I implemented. I just thought it would be cleaner to
> put cc-option and the CONFIG option depending on it very close.
> 
> Anyway, comments to the attachment are appreciated.
> 

I believe it would solve our problem so from that perspective, it looks
good to me.

Thanks,
Jeremy

