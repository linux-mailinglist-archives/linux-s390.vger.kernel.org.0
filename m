Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1DCE2177986
	for <lists+linux-s390@lfdr.de>; Tue,  3 Mar 2020 15:49:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729572AbgCCOta (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Tue, 3 Mar 2020 09:49:30 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:43359 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729372AbgCCOta (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 3 Mar 2020 09:49:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583246968;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZAMz9trEBbggImBzI8TwjqrfBpm7beP6aWAuQ0+PcZA=;
        b=YiOZvSuO/Zp1J4xcyp+/mA32N2z+JZvWP3fUltBdcsz7KVZ/rFrDr8P47LwJ997j44SEjv
        bR2Qx2iyCg6nln6LtH+2FzhLSLHcEYcKnbcApEMd+UZyB6XJVqJirdRxZlONljJekT6Bnw
        IjLcChTocLHB5wdsajCy7LLM9C6FWww=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-425-HP3P2ahsPNG9-cif7h_CJQ-1; Tue, 03 Mar 2020 09:49:27 -0500
X-MC-Unique: HP3P2ahsPNG9-cif7h_CJQ-1
Received: by mail-qv1-f72.google.com with SMTP id s2so1421202qvt.16
        for <linux-s390@vger.kernel.org>; Tue, 03 Mar 2020 06:49:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ZAMz9trEBbggImBzI8TwjqrfBpm7beP6aWAuQ0+PcZA=;
        b=shmDRykBdSy0Snibi1QQWkw4yZBh4USRhhSxTZ8YMex/gK62ChunKz5IxxVcyLH/w3
         A6GIdowLrxSdJ2F83fXNTEk1EiThzdfh7PeboaKwLQFyHkh1h3CdbjpoFnqhQ8/MO8lJ
         N2/XpbdiB+QayjR25Zo8Sd+W9cBOuL4pfoWx1zIJGRuqNOuAr2glx+aiq93Xz3QurBKi
         c8GsNtkf4b3sYGNc+Z15TDzu8+vxrDFPAOdUtaefAotgXt1GNCsR4tjCg4R7NvpAZNo4
         IiKsr+w2nRueloUiUmwS8RXEhhjRKMTLfSB84Km87fqkatgEM3GBwrkwbcQOHOdGEqhZ
         3cgg==
X-Gm-Message-State: ANhLgQ0fCIrlF6vQe04ZpdKYqD7u3SBVjDtzIouL645GC433FKnC6QiK
        8aUccIjL/ViNyxMh1O/jgTDGz2fEeI9cnqrkKYAsDG6w/nyyU6JPhsN6b01qkb7Q4OlBg+o76wT
        7kBms0A7r9siA/aTwFNDYAQ==
X-Received: by 2002:a0c:f692:: with SMTP id p18mr4372501qvn.61.1583246967039;
        Tue, 03 Mar 2020 06:49:27 -0800 (PST)
X-Google-Smtp-Source: ADFU+vsyjBrEg2YMLlS4Ny5GGY4zKEspwxCc/KeO/4ULBZu3vu5BQGOxB/vGW3jXL4KM69SWf9Bpkw==
X-Received: by 2002:a0c:f692:: with SMTP id p18mr4372474qvn.61.1583246966856;
        Tue, 03 Mar 2020 06:49:26 -0800 (PST)
Received: from redhat.com (bzq-79-180-48-224.red.bezeqint.net. [79.180.48.224])
        by smtp.gmail.com with ESMTPSA id g8sm3079010qke.1.2020.03.03.06.49.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2020 06:49:26 -0800 (PST)
Date:   Tue, 3 Mar 2020 09:49:21 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Halil Pasic <pasic@linux.ibm.com>
Cc:     Jason Wang <jasowang@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Jens Axboe <axboe@kernel.dk>,
        virtualization@lists.linux-foundation.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Viktor Mihajlovski <mihajlov@linux.ibm.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Ram Pai <linuxram@us.ibm.com>,
        Thiago Jung Bauermann <bauerman@linux.ibm.com>,
        "Lendacky, Thomas" <Thomas.Lendacky@amd.com>
Subject: Re: [PATCH 0/2] virtio-blk: improve handling of DMA mapping failures
Message-ID: <20200303094909-mutt-send-email-mst@kernel.org>
References: <20200213123728.61216-1-pasic@linux.ibm.com>
 <20200303151252.59d45e86.pasic@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200303151252.59d45e86.pasic@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Tue, Mar 03, 2020 at 03:12:52PM +0100, Halil Pasic wrote:
> On Thu, 13 Feb 2020 13:37:26 +0100
> Halil Pasic <pasic@linux.ibm.com> wrote:
> 
> > Two patches are handling new edge cases introduced by doing DMA mappings
> > (which can fail) in virtio core.
> > 
> > I stumbled upon this while stress testing I/O for Protected Virtual
> > Machines. I deliberately chose a tiny swiotlb size and have generated
> > load with fio. With more than one virtio-blk disk in use I experienced
> > hangs.
> > 
> > The goal of this series is to fix those hangs.
> > 
> > Halil Pasic (2):
> >   virtio-blk: fix hw_queue stopped on arbitrary error
> >   virtio-blk: improve virtqueue error to BLK_STS
> > 
> >  drivers/block/virtio_blk.c | 17 ++++++++++++-----
> >  1 file changed, 12 insertions(+), 5 deletions(-)
> > 
> > 
> > base-commit: 39bed42de2e7d74686a2d5a45638d6a5d7e7d473
> 
> ping
> 
> Hi Michael, hi Jason,
> 
> I got some favorable reviews for this, but AFAIK I got nothing form the
> maintainers yet.
> 
> Is some of you going to pick these?
> 
> Regards,
> Halil

I've queued this, thanks!

