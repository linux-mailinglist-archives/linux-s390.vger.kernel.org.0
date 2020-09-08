Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8760C260CB4
	for <lists+linux-s390@lfdr.de>; Tue,  8 Sep 2020 09:58:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729566AbgIHH6F (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Tue, 8 Sep 2020 03:58:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:25802 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729761AbgIHH5t (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 8 Sep 2020 03:57:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1599551860;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hjajqtvEuISTBRgRpPMUCH8ji6lbeHsCmX5hSQj+D2Q=;
        b=HVFVXNTCn0P8hxdzDQkceEZE95e+2L8CyHiJGAdMFWyTELNh0rCS64n0hyDoSvB+uoXlC2
        as/CK00hPloi+JHHZowUZJFtc47cjpZlZoTF/Q3Touz780mZnTcffk1thObxcy6ig6S2fb
        O4I/8if0CXHx/UFEovyQOwhgHLa9o+Q=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-101-VKrswSg0OESxUFB3e9tIwA-1; Tue, 08 Sep 2020 03:57:38 -0400
X-MC-Unique: VKrswSg0OESxUFB3e9tIwA-1
Received: by mail-ed1-f70.google.com with SMTP id y15so4374467edq.4
        for <linux-s390@vger.kernel.org>; Tue, 08 Sep 2020 00:57:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hjajqtvEuISTBRgRpPMUCH8ji6lbeHsCmX5hSQj+D2Q=;
        b=bjlSr+NN1+F5subN3ahIepmeyJ0QUko3uGUqYSUbQ/NbDBo0G8rk43bx+8WinTKYg3
         nCyNKxrB3AjjX4WsymjYcVIxbbpJyeZ0PrLCRfPWfUDz/V2Kigb05PvQtdXJ5VQztMTj
         xYWQUysrTENAdNETk+d47VbrXDcHwyCrul/nAntDtXzrhNqR4mUswF5EZaJoG5AWmhmM
         aqwP6zFXG+5gmKG3s500CaaxO341YFL7K98725wv4keHgpDw9GJ3L57jEenLNGdARtkP
         S+WhZJa0WfiRV7GBHo2igyDFiEgO5abhFLX2bb+hGyvcGt9fp8S3R8hhYL6Vq4DGwT50
         /u2A==
X-Gm-Message-State: AOAM530NKpkDP+OZ5HNyHH41hoxCHUGw2knp6ggSQ2aH9pKqTrX/Xc3i
        +3Y1rBcezQJzzNTO/DaK1zx/T6dIMqt7ZoCvaTimXZzFuuyqCG5uUevhxwGxO22PERoLDL35cjq
        6KTgfKOPdId97nqHaTqpagg==
X-Received: by 2002:a17:906:4cc6:: with SMTP id q6mr17306532ejt.201.1599551857520;
        Tue, 08 Sep 2020 00:57:37 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxpDLRo1CVGFPV8s2mB7FGn6jr+cgUVgJN/ozC0WS4OAeawUnu+/98JbXILSr3J/Bhzu7egLw==
X-Received: by 2002:a17:906:4cc6:: with SMTP id q6mr17306516ejt.201.1599551857341;
        Tue, 08 Sep 2020 00:57:37 -0700 (PDT)
Received: from redhat.com ([147.161.9.118])
        by smtp.gmail.com with ESMTPSA id e4sm16024501edk.38.2020.09.08.00.57.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2020 00:57:36 -0700 (PDT)
Date:   Tue, 8 Sep 2020 03:57:30 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Halil Pasic <pasic@linux.ibm.com>
Cc:     Pierre Morel <pmorel@linux.ibm.com>, linux-kernel@vger.kernel.org,
        borntraeger@de.ibm.com, frankja@linux.ibm.com, jasowang@redhat.com,
        cohuck@redhat.com, kvm@vger.kernel.org, linux-s390@vger.kernel.org,
        virtualization@lists.linux-foundation.org, thomas.lendacky@amd.com,
        david@gibson.dropbear.id.au, linuxram@us.ibm.com,
        hca@linux.ibm.com, gor@linux.ibm.com
Subject: Re: [PATCH v11 0/2] s390: virtio: let arch validate VIRTIO features
Message-ID: <20200908035506-mutt-send-email-mst@kernel.org>
References: <1599471547-28631-1-git-send-email-pmorel@linux.ibm.com>
 <20200908003951.233e47f3.pasic@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200908003951.233e47f3.pasic@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Tue, Sep 08, 2020 at 12:39:51AM +0200, Halil Pasic wrote:
> On Mon,  7 Sep 2020 11:39:05 +0200
> Pierre Morel <pmorel@linux.ibm.com> wrote:
> 
> > Hi all,
> > 
> > The goal of the series is to give a chance to the architecture
> > to validate VIRTIO device features.
> 
> Michael, is this going in via your tree?

I guess so. Still not really happy about second-guessing
the hypervisor, but this got acks from others
so maybe I'm wrong in this instance. Won't be the first time.

-- 
MST

