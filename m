Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71248692947
	for <lists+linux-s390@lfdr.de>; Fri, 10 Feb 2023 22:30:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233303AbjBJVa4 (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Fri, 10 Feb 2023 16:30:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232057AbjBJVaz (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 10 Feb 2023 16:30:55 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F19F27CC92
        for <linux-s390@vger.kernel.org>; Fri, 10 Feb 2023 13:30:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676064609;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5KH2m/gbD/d3/7qvNcmkVXbmWuAheIBviOQXczWNRY0=;
        b=HUNNem6emFj+qldy2aXpaX6WTvx1zpL0rKN7R8MMxrbzuERS/Tq1tkRv/eNkWQYEL/zD7W
        wfDsgInidAEbERhNNq5d8UKreJo3Gqd6/8xGm3LpOxKpo1btLnhy31wHGO0M8HVKPNHw/c
        V+LavW5Z2mWFjt6F1fitHZTE0VGIt/E=
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com
 [209.85.166.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-339-zhzLG_liO-KWlt9Jvb2vEg-1; Fri, 10 Feb 2023 16:30:07 -0500
X-MC-Unique: zhzLG_liO-KWlt9Jvb2vEg-1
Received: by mail-il1-f199.google.com with SMTP id s12-20020a056e021a0c00b0030efd0ed890so4964179ild.7
        for <linux-s390@vger.kernel.org>; Fri, 10 Feb 2023 13:30:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5KH2m/gbD/d3/7qvNcmkVXbmWuAheIBviOQXczWNRY0=;
        b=tfBeqdav5h8eg74VNn3EK7g9F9+g08COYGgx5CBpwEQo5Q6MvmWPyi47JygSlXJYjQ
         don8Klxr1bmE4UhDdBKHT/qfoGPJWcH7uc18FSv51iGzyOwIYszx7h/z1tJOsmEORolV
         OtRg6jLgI3QGQyvR+d1PKOOuOxRslWyXjtpEZiGWOx5Gscrv7cvRjym6A1MkUUmb1cwB
         KnOLWMdbbi2W7dtdXJDQ9Z/FnXQLSLNLXCpfZypgy/HjRBfk4EXW2IwTaoKAGpId2ZYF
         XaCWNUkmBDgtRaJaVqXiJEj6cO3iNhUfHnp8XGFJyLr+sYVBrRhAOOzbPZOAJKpjd/6M
         z/dQ==
X-Gm-Message-State: AO0yUKV4IdBMZblFJSwjP22l+EC2jxSDiuUgmu7ILRElBcyeWNfZ13se
        RqP34I60G0yysB5nzkyPrYGTg62Tfcong0Q06xufLZ+Cu60njNwAYYQ3PK/Ue0GiJGbV68AONnP
        jLFEWLyYNh/UpHF90Ru6WUA==
X-Received: by 2002:a05:6e02:889:b0:313:f7a6:dfbc with SMTP id z9-20020a056e02088900b00313f7a6dfbcmr7217163ils.16.1676064607158;
        Fri, 10 Feb 2023 13:30:07 -0800 (PST)
X-Google-Smtp-Source: AK7set+gSCbDU/vJ4+zoVa6bkcu1yKE+CAsz/Y6phnk4NyEmHXN56mLwjlc8T1I3/rLGys1LQGG+nw==
X-Received: by 2002:a05:6e02:889:b0:313:f7a6:dfbc with SMTP id z9-20020a056e02088900b00313f7a6dfbcmr7217145ils.16.1676064606897;
        Fri, 10 Feb 2023 13:30:06 -0800 (PST)
Received: from redhat.com ([38.15.36.239])
        by smtp.gmail.com with ESMTPSA id i13-20020a02b68d000000b0038a01eba60fsm1731603jam.69.2023.02.10.13.30.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Feb 2023 13:30:06 -0800 (PST)
Date:   Fri, 10 Feb 2023 14:30:04 -0700
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Eric Farman <farman@linux.ibm.com>
Cc:     Matthew Rosato <mjrosato@linux.ibm.com>,
        Halil Pasic <pasic@linux.ibm.com>,
        Vineeth Vijayan <vneethv@linux.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        linux-s390@vger.kernel.org, kvm@vger.kernel.org
Subject: Re: [PATCH] vfio/ccw: Remove WARN_ON during shutdown
Message-ID: <20230210143004.347b17bc.alex.williamson@redhat.com>
In-Reply-To: <20230210174227.2256424-1-farman@linux.ibm.com>
References: <20230210174227.2256424-1-farman@linux.ibm.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.35; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Fri, 10 Feb 2023 18:42:27 +0100
Eric Farman <farman@linux.ibm.com> wrote:

> The logic in vfio_ccw_sch_shutdown() always assumed that the input
> subchannel would point to a vfio_ccw_private struct, without checking
> that one exists. The blamed commit put in a check for this scenario,
> to prevent the possibility of a missing private.
> 
> The trouble is that check was put alongside a WARN_ON(), presuming
> that such a scenario would be a cause for concern. But this can be
> triggered by binding a subchannel to vfio-ccw, and rebooting the
> system before starting the mdev (via "mdevctl start" or similar)
> or after stopping it. In those cases, shutdown doesn't need to
> worry because either the private was never allocated, or it was
> cleaned up by vfio_ccw_mdev_remove().
> 
> Remove the WARN_ON() piece of this check, since there are plausible
> scenarios where private would be NULL in this path.
> 
> Fixes: 9e6f07cd1eaa ("vfio/ccw: create a parent struct")
> Signed-off-by: Eric Farman <farman@linux.ibm.com>
> ---
>  drivers/s390/cio/vfio_ccw_drv.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/s390/cio/vfio_ccw_drv.c b/drivers/s390/cio/vfio_ccw_drv.c
> index 54aba7cceb33..ff538a086fc7 100644
> --- a/drivers/s390/cio/vfio_ccw_drv.c
> +++ b/drivers/s390/cio/vfio_ccw_drv.c
> @@ -225,7 +225,7 @@ static void vfio_ccw_sch_shutdown(struct subchannel *sch)
>  	struct vfio_ccw_parent *parent = dev_get_drvdata(&sch->dev);
>  	struct vfio_ccw_private *private = dev_get_drvdata(&parent->dev);
>  
> -	if (WARN_ON(!private))
> +	if (!private)
>  		return;
>  
>  	vfio_ccw_fsm_event(private, VFIO_CCW_EVENT_CLOSE);

I see I'm on the To: line here, is this intended to go through the vfio
tree rather than s390?  Thanks,

Alex

