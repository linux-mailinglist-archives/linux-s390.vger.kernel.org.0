Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55AA155D111
	for <lists+linux-s390@lfdr.de>; Tue, 28 Jun 2022 15:08:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239485AbiF0Qf5 (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Mon, 27 Jun 2022 12:35:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235069AbiF0Qf5 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 27 Jun 2022 12:35:57 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7525FDEB0
        for <linux-s390@vger.kernel.org>; Mon, 27 Jun 2022 09:35:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656347755;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ajZ6rDuNIkxlTWf9Tu/rlCccLsTD5TfeTqcQISFWLfw=;
        b=aL0JQ/8XmzmSj0GUZgT3V969XHM0+qy5GoaZblqIRe0U1YEb0b6fN3lHUqsm0Z4tWd530U
        eLDQMB/jvpxHXAXHjw0Yw6IBLm/TZVZDNaZOAl0DkxKGJFlcMbHIYicjXmenMWqkSjSVwH
        sJuTClQwIghQdAUQVU7IoqL4i+Corxc=
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com
 [209.85.166.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-141-35DaHwMkNbCrZklgWCTg-A-1; Mon, 27 Jun 2022 12:35:54 -0400
X-MC-Unique: 35DaHwMkNbCrZklgWCTg-A-1
Received: by mail-il1-f200.google.com with SMTP id h5-20020a056e021b8500b002d8f50441a2so5926652ili.13
        for <linux-s390@vger.kernel.org>; Mon, 27 Jun 2022 09:35:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=ajZ6rDuNIkxlTWf9Tu/rlCccLsTD5TfeTqcQISFWLfw=;
        b=1LMOibOxx1YgWT5WSRG0c1x6k0ypOf1AFDL5XqB8RryGv+6+I23YOrSk0gBinpksBp
         QRdMvK8epP7CO2TV1F953GQrlwQvyQTPBSMjXGU8cGslHb7Ve5KeVAsX6LVv7snXuhw7
         kq1wQV2mcSAS89SyWMBvTJnfD4LL9rtxw4gQswHUGJ8R1hd8Iyn3Wfx1fGdfpHnwupe1
         tDj6VKn6gXwtthNJ7lzyXpLcCQ5AqpGtykC/awVk/FCGTroFTpl0UEq9B92ih1dJwwUx
         7ox2XqbOBr7iQ1wiYXvLIVa9O9N6+N3wHdviJoFow+mCDXMm8OnTfX1wKmgg5vBNOG80
         uD+Q==
X-Gm-Message-State: AJIora82QDjYbFcui3Dx/ixHkfU+4Y4eyShb57HgcYrZ3wtDJ/4KMk+/
        A0XnGy+/nkZFXNu59Npus94JXhv0Ua01DMtVQ3+NStej08maeu3dynzXBFwahAntdpL62Hjy04s
        L2lJ6Yxezm+tJvEP3l7D4ag==
X-Received: by 2002:a05:6638:dc6:b0:332:3565:397a with SMTP id m6-20020a0566380dc600b003323565397amr7957166jaj.312.1656347753688;
        Mon, 27 Jun 2022 09:35:53 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1vv1JOb9B1ol8/IGTBQLrpbIC5YwburDgiT1ESupNJ64ipmLjowP6AySpptuL2gZYgDyI57hw==
X-Received: by 2002:a05:6638:dc6:b0:332:3565:397a with SMTP id m6-20020a0566380dc600b003323565397amr7957152jaj.312.1656347753485;
        Mon, 27 Jun 2022 09:35:53 -0700 (PDT)
Received: from redhat.com ([38.15.36.239])
        by smtp.gmail.com with ESMTPSA id p20-20020a02b014000000b00339c015fd84sm4957144jah.59.2022.06.27.09.35.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jun 2022 09:35:52 -0700 (PDT)
Date:   Mon, 27 Jun 2022 10:35:51 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     kwankhede@nvidia.com, farman@linux.ibm.com, mjrosato@linux.ibm.com,
        pasic@linux.ibm.com, diana.craciun@oss.nxp.com, cohuck@redhat.com,
        eric.auger@redhat.com, kvm@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, yishaih@nvidia.com, hch@lst.de
Subject: Re: [PATCH] vfio: de-extern-ify function prototypes
Message-ID: <20220627103551.48b34517.alex.williamson@redhat.com>
In-Reply-To: <20220610164407.25feeb23.alex.williamson@redhat.com>
References: <165471414407.203056.474032786990662279.stgit@omen>
        <20220610000434.GE1343366@nvidia.com>
        <20220610164407.25feeb23.alex.williamson@redhat.com>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Fri, 10 Jun 2022 16:44:07 -0600
Alex Williamson <alex.williamson@redhat.com> wrote:

> On Thu, 9 Jun 2022 21:04:34 -0300
> Jason Gunthorpe <jgg@nvidia.com> wrote:
> 
> > On Wed, Jun 08, 2022 at 12:55:13PM -0600, Alex Williamson wrote:  
> > > The use of 'extern' in function prototypes has been disrecommended in
> > > the kernel coding style for several years now, remove them from all vfio
> > > related files so contributors no longer need to decide between style and
> > > consistency.
> > > 
> > > Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
> > > ---
> > > 
> > > A patch in the same vein was proposed about a year ago, but tied to an ill
> > > fated series and forgotten.  Now that we're at the beginning of a new
> > > development cycle, I'd like to propose kicking off the v5.20 vfio next
> > > branch with this patch and would kindly ask anyone with pending respins or
> > > significant conflicts to rebase on top of this patch.  Thanks!    
> > 
> > Can you stick it in your branch please?  
> 
> Thanks for the R-b, it was my plan today to put it in my next branch,
> but I can't currently test vfio on mainline due to:
> 
> https://lore.kernel.org/all/165490039431.944052.12458624139225785964.stgit@omen/
> 
> I'll get this in once there's a mainline base where vfio still works.  Thanks,

This has now been resolved in rc4 via 034e5afad921 ("mm: re-allow
pinning of zero pfns").  I've rebased to rc4 and pushed this patch out
to the vfio next branch.  Thanks,

Alex

