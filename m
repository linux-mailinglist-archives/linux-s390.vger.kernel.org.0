Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5E8E314339
	for <lists+linux-s390@lfdr.de>; Mon,  8 Feb 2021 23:52:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230161AbhBHWvs (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Mon, 8 Feb 2021 17:51:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229729AbhBHWvn (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 8 Feb 2021 17:51:43 -0500
Received: from mail-oo1-xc2e.google.com (mail-oo1-xc2e.google.com [IPv6:2607:f8b0:4864:20::c2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F3F1C06178C
        for <linux-s390@vger.kernel.org>; Mon,  8 Feb 2021 14:51:03 -0800 (PST)
Received: by mail-oo1-xc2e.google.com with SMTP id x23so3846986oop.1
        for <linux-s390@vger.kernel.org>; Mon, 08 Feb 2021 14:51:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=2jaIFVPMabgNRI/gSMsENX64xR0X2GpzOOyOdGUnNRo=;
        b=pBScR02E5r0TkgIM7R/gTKUoLt7Z0j2l+KmGEUVvzVD6iJ+rV1NRqIGbxRSCpN/xF9
         6ECzsWEtkMBYUHsLOW6EmRZvwcz50tmS4Z4kiMiTfHKdQVnDJR9wum99SFr67PJhCEhZ
         LIAGh6+XAHdhQB9YQkWu+PZsyD1WTPyCGPQIOOzymGPNz3Zg/acuqdTbeBlHqgHqbB9X
         QenXmEk9IGatt+KNlyRpsbxQe1sY+gcou4x4VQREJS7Wkxn/y9p8kt/wMxSfTAPAzsFj
         ohqYM+FW7JqUugev+5lDjtz30gnXn9A1GT2uGo8yxHk2lR3kD335idp9Ai8G83c7Ni6B
         LKbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=2jaIFVPMabgNRI/gSMsENX64xR0X2GpzOOyOdGUnNRo=;
        b=cSgbZ6H7BEehTrXistJ2AIanuH+gDOjLXOiDp4ICi0erJLkvMJvyxVX8RMQ8j3KEOt
         PhT89jTmFH/4/OSVU9MY2Uc+7hWYUMQN4ADt7Eq6o6JZMpm5GhYmXw1LUVY1y10XSS6e
         O5L37pSLxvGb568X5FTPkFeGqUTel0FPOHFB/6VTXTrn6I7JXhkv6fOI8jf9KUvVRykj
         HwsZPJocfgVs1yv719WL9Y9hCYpdtuxM6wXK4paLf+YVp+TVby3w4Z7wkvEoOkdH7/BK
         HyHsD6UtUgsEKNpjhDfY3ECT2DZmHBC4vIxHQTPvhE4Roq60kYcs76SlrDLHDoqaQmWt
         e9aA==
X-Gm-Message-State: AOAM532Dcao0QExvsOpI9OKqdjWBr9MmQ3CHsgOI8gIjPqJGrUz86F4c
        brCvzLNMLOhkxgez3mAUP8w9wQ==
X-Google-Smtp-Source: ABdhPJwKMs+R/f6Grt4JROunZj+IRHTQeNwBZcyQQGNO0b5W18rmchqi31uaPJUE+MthD6a4Uan95Q==
X-Received: by 2002:a4a:870c:: with SMTP id z12mr13898102ooh.15.1612824662639;
        Mon, 08 Feb 2021 14:51:02 -0800 (PST)
Received: from eggly.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id r25sm1079478ota.42.2021.02.08.14.50.59
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Mon, 08 Feb 2021 14:51:01 -0800 (PST)
Date:   Mon, 8 Feb 2021 14:50:47 -0800 (PST)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     Seth Forshee <seth.forshee@canonical.com>
cc:     Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Chris Down <chris@chrisdown.name>,
        Amir Goldstein <amir73il@gmail.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-mm@kvack.org, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tmpfs: Disallow CONFIG_TMPFS_INODE64 on s390
In-Reply-To: <20210205160551.cf57c4293ba5ccb8eb648c11@linux-foundation.org>
Message-ID: <alpine.LSU.2.11.2102081446340.4656@eggly.anvils>
References: <20210205230620.518245-1-seth.forshee@canonical.com> <20210205160551.cf57c4293ba5ccb8eb648c11@linux-foundation.org>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Fri, 5 Feb 2021, Andrew Morton wrote:
> On Fri,  5 Feb 2021 17:06:20 -0600 Seth Forshee <seth.forshee@canonical.com> wrote:
> 
> > This feature requires ino_t be 64-bits, which is true for every
> > 64-bit architecture but s390, so prevent this option from being
> > selected there.
> > 
> 
> The previous patch nicely described the end-user impact of the bug. 
> This is especially important when requesting a -stable backport.
> 
> Here's what I ended up with:
> 
> 
> From: Seth Forshee <seth.forshee@canonical.com>
> Subject: tmpfs: disallow CONFIG_TMPFS_INODE64 on s390
> 
> Currently there is an assumption in tmpfs that 64-bit architectures also
> have a 64-bit ino_t.  This is not true on s390 which has a 32-bit ino_t. 
> With CONFIG_TMPFS_INODE64=y tmpfs mounts will get 64-bit inode numbers and
> display "inode64" in the mount options, but passing the "inode64" mount
> option will fail.  This leads to the following behavior:
> 
>  # mkdir mnt
>  # mount -t tmpfs nodev mnt
>  # mount -o remount,rw mnt
>  mount: /home/ubuntu/mnt: mount point not mounted or bad option.
> 
> As mount sees "inode64" in the mount options and thus passes it in the
> options for the remount.
> 
> 
> So prevent CONFIG_TMPFS_INODE64 from being selected on s390.
> 
> Link: https://lkml.kernel.org/r/20210205230620.518245-1-seth.forshee@canonical.com
> Fixes: ea3271f7196c ("tmpfs: support 64-bit inums per-sb")
> Signed-off-by: Seth Forshee <seth.forshee@canonical.com>
> Cc: Chris Down <chris@chrisdown.name>
> Cc: Hugh Dickins <hughd@google.com>

Thank you Seth: now that you've fixed Kirill's alpha observation too,
Acked-by: Hugh Dickins <hughd@google.com>

> Cc: Amir Goldstein <amir73il@gmail.com>
> Cc: Heiko Carstens <hca@linux.ibm.com>
> Cc: Vasily Gorbik <gor@linux.ibm.com>
> Cc: Christian Borntraeger <borntraeger@de.ibm.com>
> Cc: <stable@vger.kernel.org>	[5.9+]
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> ---
> 
>  fs/Kconfig |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> --- a/fs/Kconfig~tmpfs-disallow-config_tmpfs_inode64-on-s390
> +++ a/fs/Kconfig
> @@ -203,7 +203,7 @@ config TMPFS_XATTR
>  
>  config TMPFS_INODE64
>  	bool "Use 64-bit ino_t by default in tmpfs"
> -	depends on TMPFS && 64BIT
> +	depends on TMPFS && 64BIT && !S390
>  	default n
>  	help
>  	  tmpfs has historically used only inode numbers as wide as an unsigned
> _
> 
> 
