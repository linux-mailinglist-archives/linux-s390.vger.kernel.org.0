Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F51C1C75B1
	for <lists+linux-s390@lfdr.de>; Wed,  6 May 2020 18:05:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729993AbgEFQFz (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Wed, 6 May 2020 12:05:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729589AbgEFQFz (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 6 May 2020 12:05:55 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2D8DC0610D5
        for <linux-s390@vger.kernel.org>; Wed,  6 May 2020 09:05:54 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id g185so2489422qke.7
        for <linux-s390@vger.kernel.org>; Wed, 06 May 2020 09:05:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=nrpp2T2sh7pMsL3PvoDrM5y2fqkhAxlK1sJUOu9QA9o=;
        b=Tr83kb/F9G2VBLcHu7x37pNyprDcqbHUZZYB0zOv2RBd+1BHPvHEVKPvXuZIqMslJt
         WRxGZOJikpMi5eBYxtKo6yrCLuOJLq7J+DscjOjKTQnnrd1h3WeKKt2DEqB7XbQZtVAL
         HjYOHAHRL+9QCK2KRb/fFvNSoqI3wQyv9hUkPCYhePvKjEIK1pVf4JsL1DBCueLXJJOL
         n3UuzknRW57RSsLv47vAxS4EZIkUvB4yn9aPp6niVhcBLpY/PAfsvJL15u7Cnwdkb1Dd
         2SzCfTuoD4Kp2AXjh5L2+oXey2AyrWZ8VC4q2ZxpUBuGIddwsFS8rNWnuZ5sOm5uYuVr
         5Zbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=nrpp2T2sh7pMsL3PvoDrM5y2fqkhAxlK1sJUOu9QA9o=;
        b=Ei0RmqyuBB2nizQX3QOWEAaqKZ443ypjI73mdIoAHdQLmYXlneAekOFM3jQj/DifR4
         MCsA1U5FffxsKSV6PYga/rQHb7/eXk1iNXIOL97NNgP+FULCRIU3SM8dFd0Dm2z8SuRf
         Goh6GzOj3+H0yg8PN1aMhE3MYwX5k3CrWuXZjSXB5HL5dDo215cKLitkJFDM1znELg8e
         EXhst1QKI1UrZv9d65G1JjvTWUGruUt6EgIBx+mA+TSTaFYB6xuincNW2iZdD8r1XPzg
         XNI2/UsG3Dh+cQVFBay7JGet7lQcHMkeLDaXENRijU9fmMgDwhf8vwLdjVUP+RqedRo4
         C+HA==
X-Gm-Message-State: AGi0PuZAEXMlDF1+sCWjDRleScHJV+jHq/JnLEVfpu7RbCvtoKwnCP5J
        WAkhEr5DR2vUsz/GzUpfR2AtwQ==
X-Google-Smtp-Source: APiQypLzPtnV2MpsE+MV+xNWnkm78v9QYjriPWAQthkfamFRT+pYJFignvWriiKBLQ0XkQ6F6UKvgw==
X-Received: by 2002:a05:620a:219a:: with SMTP id g26mr9661209qka.228.1588781153930;
        Wed, 06 May 2020 09:05:53 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id q9sm1879221qkm.130.2020.05.06.09.05.53
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 06 May 2020 09:05:53 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1jWMYS-0002c7-Qa; Wed, 06 May 2020 13:05:52 -0300
Date:   Wed, 6 May 2020 13:05:52 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>,
        Bart Van Assche <bvanassche@acm.org>,
        "David S. Miller" <davem@davemloft.net>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Karsten Graul <kgraul@linux.ibm.com>,
        linux-rdma@vger.kernel.org, linux-s390@vger.kernel.org,
        netdev@vger.kernel.org,
        Niranjana Vishwanathapura <niranjana.vishwanathapura@intel.com>,
        rds-devel@oss.oracle.com,
        Santosh Shilimkar <santosh.shilimkar@oracle.com>,
        target-devel@vger.kernel.org, Ursula Braun <ubraun@linux.ibm.com>
Subject: Re: [PATCH rdma-next] RDMA: Allow ib_client's to fail when add() is
 called
Message-ID: <20200506160552.GA9993@ziepe.ca>
References: <20200421172440.387069-1-leon@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200421172440.387069-1-leon@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Tue, Apr 21, 2020 at 08:24:40PM +0300, Leon Romanovsky wrote:
> From: Jason Gunthorpe <jgg@mellanox.com>
> 
> When a client is added it isn't allowed to fail, but all the client's have
> various failure paths within their add routines.
> 
> This creates the very fringe condition where the client was added, failed
> during add and didn't set the client_data. The core code will then still
> call other client_data centric ops like remove(), rename(), get_nl_info(),
> and get_net_dev_by_params() with NULL client_data - which is confusing and
> unexpected.
> 
> If the add() callback fails, then do not call any more client ops for the
> device, even remove.
> 
> Remove all the now redundant checks for NULL client_data in ops callbacks.
> 
> Update all the add() callbacks to return error codes
> appropriately. EOPNOTSUPP is used for cases where the ULP does not support
> the ib_device - eg because it only works with IB.
> 
> Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
> Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
> Acked-by: Ursula Braun <ubraun@linux.ibm.com>
> ---
>  drivers/infiniband/core/cm.c                  | 24 ++++++++++--------
>  drivers/infiniband/core/cma.c                 | 23 +++++++++--------
>  drivers/infiniband/core/device.c              | 16 ++++++++++--
>  drivers/infiniband/core/mad.c                 | 17 ++++++++++---
>  drivers/infiniband/core/multicast.c           | 12 ++++-----
>  drivers/infiniband/core/sa_query.c            | 22 ++++++++--------
>  drivers/infiniband/core/user_mad.c            | 22 ++++++++--------
>  drivers/infiniband/core/uverbs_main.c         | 24 +++++++++---------
>  drivers/infiniband/ulp/ipoib/ipoib_main.c     | 15 ++++-------
>  .../infiniband/ulp/opa_vnic/opa_vnic_vema.c   | 12 ++++-----
>  drivers/infiniband/ulp/srp/ib_srp.c           | 21 ++++++++--------
>  drivers/infiniband/ulp/srpt/ib_srpt.c         | 25 ++++++++-----------
>  include/rdma/ib_verbs.h                       |  2 +-
>  net/rds/ib.c                                  | 21 ++++++++++------
>  net/smc/smc_ib.c                              | 10 +++-----
>  15 files changed, 142 insertions(+), 124 deletions(-)

Applied to for-next

Jason
