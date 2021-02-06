Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 906E0311955
	for <lists+linux-s390@lfdr.de>; Sat,  6 Feb 2021 04:03:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231325AbhBFDCY (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Fri, 5 Feb 2021 22:02:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232116AbhBFCvW (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 5 Feb 2021 21:51:22 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16296C08EE7E
        for <linux-s390@vger.kernel.org>; Fri,  5 Feb 2021 16:40:11 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id z22so11065763edb.9
        for <linux-s390@vger.kernel.org>; Fri, 05 Feb 2021 16:40:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=yd9DVs1bpM3Y2tHW1e5fufzslh0L2frolGTr8VlBm1w=;
        b=hIqiPlRCktnGw29D8HqZEwtk/2+4Aty9eo+z/nKC5kuxzTo1rRn9Scus+6sMnqkx+d
         rvpWk0D4qKSZWNKef9hjzewXR+FFFt/YsBLuv7PvF7fLGaD6FRRKta0iB7kcRs7zM9ON
         g+djgut8H9myomPqLUkL1x7bDq1lccMg0mP88=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=yd9DVs1bpM3Y2tHW1e5fufzslh0L2frolGTr8VlBm1w=;
        b=m3vUUbjDwgfAgDg4Cp/QIAy4rqQTN2v9wueCksFXXa13z0yYZ0UTW17kuQJElqQKE2
         kbxfXPytDXiIOTCGOwSYnNzRAQWfY6jFkPmyfAClKYzex75eZAbNvlbgndAjgAlje6DX
         45Sorj+PbfIzFXiThmWO24IKf8qdV45+Kk02k2pCK4g+IcvDtHR8bIYA4A1BhVnEcVWU
         FnzBI6x5zyKeHEOPBG1aVYCtItpEA39ViscmLadqe691l7+J6nStc5s6zd83pNAh1ODz
         XnqpmRz8Jwd6FtsvMwvqrfDvQD6u8q1TGftfoSd1vSkY+DOkkQCkwWg6WTLks06rQsZ+
         dxgg==
X-Gm-Message-State: AOAM530kzybxDiz6TyxLFp29YrSqaCtF88rZKwglvOb/GYxb6SWMHNzN
        kkw3Ar+VcdPL4Dyf75hTF1mLGQ==
X-Google-Smtp-Source: ABdhPJxvlz9VFpro1BoxrP01rQJ4N6XwtZpuwm0SvnsLq5JrqOLFv6Dqdh/ANTeCcvFLAJqw6AsYbg==
X-Received: by 2002:aa7:cfda:: with SMTP id r26mr6033955edy.142.1612572009688;
        Fri, 05 Feb 2021 16:40:09 -0800 (PST)
Received: from localhost ([2620:10d:c093:400::4:4dd1])
        by smtp.gmail.com with ESMTPSA id o4sm4759933edw.78.2021.02.05.16.40.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Feb 2021 16:40:09 -0800 (PST)
Date:   Sat, 6 Feb 2021 00:40:08 +0000
From:   Chris Down <chris@chrisdown.name>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Seth Forshee <seth.forshee@canonical.com>,
        Hugh Dickins <hughd@google.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-mm@kvack.org, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tmpfs: Disallow CONFIG_TMPFS_INODE64 on s390
Message-ID: <YB3laM3HQUM7u/Wo@chrisdown.name>
References: <20210205230620.518245-1-seth.forshee@canonical.com>
 <20210205160551.cf57c4293ba5ccb8eb648c11@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20210205160551.cf57c4293ba5ccb8eb648c11@linux-foundation.org>
User-Agent: Mutt/2.0.5 (da5e3282) (2021-01-21)
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Andrew Morton writes:
>Currently there is an assumption in tmpfs that 64-bit architectures also
>have a 64-bit ino_t.  This is not true on s390 which has a 32-bit ino_t.
>With CONFIG_TMPFS_INODE64=y tmpfs mounts will get 64-bit inode numbers and
>display "inode64" in the mount options, but passing the "inode64" mount
>option will fail.  This leads to the following behavior:
>
> # mkdir mnt
> # mount -t tmpfs nodev mnt
> # mount -o remount,rw mnt
> mount: /home/ubuntu/mnt: mount point not mounted or bad option.
>
>As mount sees "inode64" in the mount options and thus passes it in the
>options for the remount.
>
>
>So prevent CONFIG_TMPFS_INODE64 from being selected on s390.
>
>Link: https://lkml.kernel.org/r/20210205230620.518245-1-seth.forshee@canonical.com
>Fixes: ea3271f7196c ("tmpfs: support 64-bit inums per-sb")
>Signed-off-by: Seth Forshee <seth.forshee@canonical.com>
>Cc: Chris Down <chris@chrisdown.name>
>Cc: Hugh Dickins <hughd@google.com>
>Cc: Amir Goldstein <amir73il@gmail.com>
>Cc: Heiko Carstens <hca@linux.ibm.com>
>Cc: Vasily Gorbik <gor@linux.ibm.com>
>Cc: Christian Borntraeger <borntraeger@de.ibm.com>
>Cc: <stable@vger.kernel.org>	[5.9+]
>Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

Either of the two ways presented looks fine to me, no real preference. Thanks!

Acked-by: Chris Down <chris@chrisdown.name>

>---
>
> fs/Kconfig |    2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>--- a/fs/Kconfig~tmpfs-disallow-config_tmpfs_inode64-on-s390
>+++ a/fs/Kconfig
>@@ -203,7 +203,7 @@ config TMPFS_XATTR
>
> config TMPFS_INODE64
> 	bool "Use 64-bit ino_t by default in tmpfs"
>-	depends on TMPFS && 64BIT
>+	depends on TMPFS && 64BIT && !S390
> 	default n
> 	help
> 	  tmpfs has historically used only inode numbers as wide as an unsigned
>_
>
