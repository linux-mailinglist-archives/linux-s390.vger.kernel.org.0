Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AE00260DA9
	for <lists+linux-s390@lfdr.de>; Tue,  8 Sep 2020 10:35:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729799AbgIHIfl (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Tue, 8 Sep 2020 04:35:41 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:31274 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730118AbgIHIfj (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 8 Sep 2020 04:35:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1599554138;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+MY+j0iaLoq2hQdX3yS+SdSeiGMuMtARblbd8qJTfIk=;
        b=JaoXJsrrWraH09iE+aSoMRTF0oZlkTQYta9yli6UGJoTgnepKwqWQKQ96af2eegwa91aD8
        uOtTZ78LT63Iw6EhpSMbVw2H6rnu3JAp2ixaeN6vE8HWjL4yr9VmqUv3r1Xvsu14Fg0u5w
        g4vT4cJb1Gs/IntNCJv28Q7zXhYJcKI=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-6-3vaViM-AOX6ADVct86oCKg-1; Tue, 08 Sep 2020 04:35:34 -0400
X-MC-Unique: 3vaViM-AOX6ADVct86oCKg-1
Received: by mail-wr1-f70.google.com with SMTP id v12so6714557wrm.9
        for <linux-s390@vger.kernel.org>; Tue, 08 Sep 2020 01:35:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+MY+j0iaLoq2hQdX3yS+SdSeiGMuMtARblbd8qJTfIk=;
        b=pCoPvXVcIXXq49PP/PjNUqpMdOdoo6vQPfbmmfS1X8hMi6eQjjh6tmZIKfK3Fr4D5N
         +d3zDYbeKJ4O66t7WpnUPmy6OQxIfDSWJct4VZtYquHIt1yyAsLXTlQcJAwGYcW7NoS2
         EAJMnSd1p0MYq+Npm+0IB4gnYIxOTnr4xvJqHRQsYJCVmMyefBhKiMdh6I138CoXGtpN
         LzsKtKxL91mA40Qrt/gIcsFI1HLHTWotRx4CdfaFJAlYIWsP7+8rcCALnxGEPT4RyBwF
         KMEmeY+wkz7z+gAPU7cIYpdXbTCsp+tV7DUzwXlyLh9an5gbj5fDN72cxdv2OyOtNOdT
         RbAQ==
X-Gm-Message-State: AOAM532qXJkL7KvrcCTNtKaO50wRZdT3Yd8X+AgD2eb+dtFZR4JL3bY4
        jPsGeCSnmu6oNL+2SwnFcc4Scj8tuoC/iv43sPB7FGTjljRWq6hpNPxkpT69mmwaU4ebUknHrM2
        37mCkNwtpPZ/ix9PJHtCPaA==
X-Received: by 2002:a7b:c059:: with SMTP id u25mr3173540wmc.103.1599554133719;
        Tue, 08 Sep 2020 01:35:33 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxI7qjqWRvqDDMKuSEyexs2ZtKt48S7kwb/PYSoSmDiwm5Mm57vBJ7GtHojpCcdWEA5RCWEdA==
X-Received: by 2002:a7b:c059:: with SMTP id u25mr3173527wmc.103.1599554133531;
        Tue, 08 Sep 2020 01:35:33 -0700 (PDT)
Received: from redhat.com ([147.161.15.98])
        by smtp.gmail.com with ESMTPSA id z203sm34774917wmc.31.2020.09.08.01.35.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2020 01:35:32 -0700 (PDT)
Date:   Tue, 8 Sep 2020 04:35:25 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Cornelia Huck <cohuck@redhat.com>
Cc:     Halil Pasic <pasic@linux.ibm.com>,
        Pierre Morel <pmorel@linux.ibm.com>,
        linux-kernel@vger.kernel.org, borntraeger@de.ibm.com,
        frankja@linux.ibm.com, jasowang@redhat.com, kvm@vger.kernel.org,
        linux-s390@vger.kernel.org,
        virtualization@lists.linux-foundation.org, thomas.lendacky@amd.com,
        david@gibson.dropbear.id.au, linuxram@us.ibm.com,
        hca@linux.ibm.com, gor@linux.ibm.com
Subject: Re: [PATCH v11 0/2] s390: virtio: let arch validate VIRTIO features
Message-ID: <20200908043503-mutt-send-email-mst@kernel.org>
References: <1599471547-28631-1-git-send-email-pmorel@linux.ibm.com>
 <20200908003951.233e47f3.pasic@linux.ibm.com>
 <20200908085521.4db22680.cohuck@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200908085521.4db22680.cohuck@redhat.com>
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Tue, Sep 08, 2020 at 08:55:21AM +0200, Cornelia Huck wrote:
> On Tue, 8 Sep 2020 00:39:51 +0200
> Halil Pasic <pasic@linux.ibm.com> wrote:
> 
> > On Mon,  7 Sep 2020 11:39:05 +0200
> > Pierre Morel <pmorel@linux.ibm.com> wrote:
> > 
> > > Hi all,
> > > 
> > > The goal of the series is to give a chance to the architecture
> > > to validate VIRTIO device features.  
> > 
> > Michael, is this going in via your tree?
> > 
> 
> I believe Michael's tree is the right place for this, but I can also
> queue it if I get an ack on patch 1.

I think Halil pointed out some minor issues, so a new version is in
order.

-- 
MST

