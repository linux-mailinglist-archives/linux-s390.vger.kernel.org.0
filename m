Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 06D2811B9E2
	for <lists+linux-s390@lfdr.de>; Wed, 11 Dec 2019 18:18:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730586AbfLKRS3 (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Wed, 11 Dec 2019 12:18:29 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:26193 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729996AbfLKRS3 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 11 Dec 2019 12:18:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576084707;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2nTzNvMQwFVLRqcJ75m4aP3oWlJJo/C7EdSanIk3aBw=;
        b=JTBZ6IrvjMSO+CUpvs2csCCOqw95RlvK4nZJRbUP7/7nReZohDJyu3Dkm8vqjp8wh3qD7z
        pDMCpbfj9Ma1Cagnwvev6XLBxGrYiD5WhsmdmUzpjxD0dJxBr6iuAIcFmuOGqZb61hu+QL
        4Dn7XlWtDU6F+E0h5kZJla1vZQqj3KY=
Received: from mail-yb1-f199.google.com (mail-yb1-f199.google.com
 [209.85.219.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-432-gCXcPsVgNKO-687LvMto_g-1; Wed, 11 Dec 2019 12:18:26 -0500
X-MC-Unique: gCXcPsVgNKO-687LvMto_g-1
Received: by mail-yb1-f199.google.com with SMTP id n80so16978037ybf.18
        for <linux-s390@vger.kernel.org>; Wed, 11 Dec 2019 09:18:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2nTzNvMQwFVLRqcJ75m4aP3oWlJJo/C7EdSanIk3aBw=;
        b=YbrIrp7XZ4Eb1eMMTTToQ/tEWDgmfIkLFDCs7JC4QvLEivxatR1T0r0QZf8Kuw7vpq
         SufbEdsaMgrCAk94z/43wNcTmtSROjRZdWQDlOfT+kb5iNLL4GpCij21hv/WMupC3aVN
         lVeXnAmBOTgOgHIfn3F+olpyzHj/CT6n+9V0fKqftjhHHhThOXgDBzSfFqh3rnWTF51x
         /BbeSnQvgpddMdrGIjphH1e4FXuygk8KfGo9zswFsCuzkecFAVHD8j447QGQtyXBL2Ka
         CjxrYkDS/SJP5ZY7dXOxMD/9uWp5oWLlUbgVCSsaocJZTmOklgpS8Sdqo/LLIhDnsT/k
         bFnA==
X-Gm-Message-State: APjAAAW+C5/X+TZO5OWnTo5/9W2+Dr27iOvHdraH8Dn1OVtvfnD4YEUM
        cahsVNQ++Ea59PsNnOIjV4ce0UAQD9f1iHzigAyjDKeoWUhvgktrzWHJmDQCc3W4ywxIjUVM1L4
        FhMuBWKk0niHaeh7q0YjaTA==
X-Received: by 2002:a81:a7c9:: with SMTP id e192mr635682ywh.421.1576084705479;
        Wed, 11 Dec 2019 09:18:25 -0800 (PST)
X-Google-Smtp-Source: APXvYqwt+UYeo0zuJ1KMsCLoS6DGAXGbzz8Q9mFTJZamJRJYD6ILLm3YjsLzwVptVerayvJ6H+gEcA==
X-Received: by 2002:a81:a7c9:: with SMTP id e192mr635653ywh.421.1576084705117;
        Wed, 11 Dec 2019 09:18:25 -0800 (PST)
Received: from dev.jcline.org ([136.56.87.133])
        by smtp.gmail.com with ESMTPSA id a22sm1235547ywh.93.2019.12.11.09.18.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2019 09:18:24 -0800 (PST)
Date:   Wed, 11 Dec 2019 12:18:22 -0500
From:   Jeremy Cline <jcline@redhat.com>
To:     Michal Kubecek <mkubecek@suse.cz>
Cc:     linux-kernel@vger.kernel.org,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>, linux-s390@vger.kernel.org
Subject: Re: s390 depending on cc-options makes it difficult to configure
Message-ID: <20191211171822.GA36366@dev.jcline.org>
References: <20191209164155.GA78160@dev.jcline.org>
 <20191210090108.GA22512@unicorn.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191210090108.GA22512@unicorn.suse.cz>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Tue, Dec 10, 2019 at 10:01:08AM +0100, Michal Kubecek wrote:
> On Mon, Dec 09, 2019 at 11:41:55AM -0500, Jeremy Cline wrote:
> > Hi folks,
> > 
> > Commit 5474080a3a0a ("s390/Kconfig: make use of 'depends on cc-option'")
> > makes it difficult to produce an s390 configuration for Fedora and Red
> > Hat kernels.
> > 
> > The issue is I have the following configurations:
> > 
> > CONFIG_MARCH_Z13=y
> > CONFIG_TUNE_Z14=y
> > # CONFIG_TUNE_DEFAULT is not set
> > 
> > When the configuration is prepared on a non-s390x host without a
> > compiler with -march=z* it changes CONFIG_TUNE_DEFAULT to y which, as
> > far as I can tell, leads to a kernel tuned for z13 instead of z14.
> > Fedora and Red Hat build processes produce complete configurations from
> > snippets on any available host in the build infrastructure which very
> > frequently is *not* s390.
> 
> We have exactly the same problem. Our developers need to update config
> files for different architectures and different kernel versions on their
> machines which are usually x86_64 but that often produces different
> configs than the real build environment.
> 

Glad (or sad?) to hear we're not the only ones hitting this.

> This is not an issue for upstream development as one usually updates
> configs on the same system where the build takes place but it's a big
> problem for distribution maintainers.
> 
> > I did a quick search and couldn't find any other examples of Kconfigs
> > depending on march or mtune compiler flags and it seems like it'd
> > generally problematic for people preparing configurations.
> 
> There are more issues like this. In general, since 4.17 or 4.18, the
> resulting config depends on both architecture and compiler version.
> Earlier, you could simply run "ARCH=... make oldconfig" (or menuconfig)
> to update configs for all architectures and distribution versions.
> Today, you need to use the right compiler version (results with e.g.
> 4.8, 7.4 and 9.2 differ) and architecture.
> 

Yeah, that's also troublesome. This is by no means the first problem
related to the environment at configuration time, but it the most
bothersome to work around (at least for Fedora kernel configuration).

> At the moment, I'm working around the issue by using chroot environments
> with target distributions (e.g. openSUSE Tumbleweed) and set of cross
> compilers for supported architectures but it's far from perfect and even
> this way, there are problemantic points, e.g. BPFILTER_UMH which depends
> on gcc being able to not only compile but also link.
> 
> IMHO the key problem is that .config mixes configuration with
> description of build environment. I have an idea of a solution which
> would consist of
> 
>   - an option to extract "config" options which describe build
>     environment (i.e. their values are determined by running some
>     command, rather than reading from a file or asking user) into
>     a cache file
>   - an option telling "make *config" to use such cache file for these
>     environment "config" options instead of running the test scripts
>     (and probably issue an error if an environment option is missing)
> 

I agree that the issue is mixing kernel configuration with build
environment. I suppose a cache file would work, but it still sounds like
a difficult process that is working around that fact that folks are
coupling the configuration step with the build step.

I would advocate that this patch be reverted and an effort made to not
mix build environment checks into the configuration. I'm much happier
for the build to fail because the configuration can't be satisfied by
the environment than I am for the configuration to quietly change or for
the tools to not allow me to make the configuration in the first place.
Ideally the tools would warn the user if their environment won't build
the configuration, but that's a nice-to-have.

- Jeremy

