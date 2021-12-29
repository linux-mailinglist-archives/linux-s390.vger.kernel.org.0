Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47AEB4813CE
	for <lists+linux-s390@lfdr.de>; Wed, 29 Dec 2021 15:06:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239340AbhL2OGg (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Wed, 29 Dec 2021 09:06:36 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:42474 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239840AbhL2OGd (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 29 Dec 2021 09:06:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1640786793;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=aO/4Yp6T43XLmNMDQP+OwTqaYv7whlIlyBDq4dbPFsg=;
        b=H4uN9kuFYKp06DXETLs651CfCfMow5IxU1wso1WjUjemw+q+GszkuqbBaRHdFqRJfqqWGr
        MI2bpyBE0SmetWDmhcD93tlcZfxtVftbYE6NOfcNysHSFFWCWS9Wek9upKsTV+L2xR0Wos
        ZyHDbWLh2sVqDfFTa5QcqlrWVLJd6rs=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-539-zrEq1HLYNUa_HiS34Wu7ow-1; Wed, 29 Dec 2021 09:06:31 -0500
X-MC-Unique: zrEq1HLYNUa_HiS34Wu7ow-1
Received: by mail-qt1-f198.google.com with SMTP id p7-20020a05622a00c700b002b2f6944e7dso15530386qtw.10
        for <linux-s390@vger.kernel.org>; Wed, 29 Dec 2021 06:06:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=aO/4Yp6T43XLmNMDQP+OwTqaYv7whlIlyBDq4dbPFsg=;
        b=Ed1K2mkxnh+b88vo0C2LibI2PGhOkcZSexL+IjQYeRJ6CN2LZ1ywq+TQWTIqcDnjcb
         exzyKMEn0tl+i2E9FNaiV4dBXmTvGtkIeE/oeKdGTm74SInKgLszbeMA9StVWRPklFzx
         DM/rNiUxsl7H/E9TZCl5MUlAq7uy7f0LnYPi+3O+JTGf6Po9XsnyLMWIcpCmt4+i6R8E
         fbFAmEYxCNCw+IXabTzfzy1GTKJz4u4QNn86Hq1fF9PbjcCqo4/vVgeIoSjdp2kOq/l0
         3oKjzUveyRHq3W2RJvSjqUktkRQ0EBcKLmxRsV3Xxh0knb8zs8rJCWw84l1XoglH0R8W
         tJPw==
X-Gm-Message-State: AOAM531K75oalzPZf5ADT/jzq37kBm5MvOQ6uLI8GylG/Iz6QyZgtVxt
        oKmqyKmoFW+No3+rkKbrMQKDiHT887GvzOueYIyO1Gymw0hBHuoESJp6gzMzoKvT8IKAGMzx11O
        fGNyAqhgkRhto3ibVT+qUsA==
X-Received: by 2002:a05:620a:4003:: with SMTP id h3mr18549154qko.153.1640786790494;
        Wed, 29 Dec 2021 06:06:30 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyimHrQiLRtzxiuwvtJVztliA6HApJnsXsaqWdLb9ltPripN76oNC87N68Zld9IushfHCBQfg==
X-Received: by 2002:a05:620a:4003:: with SMTP id h3mr18549076qko.153.1640786790152;
        Wed, 29 Dec 2021 06:06:30 -0800 (PST)
Received: from steredhat (host-87-10-236-9.retail.telecomitalia.it. [87.10.236.9])
        by smtp.gmail.com with ESMTPSA id h2sm18124352qkn.136.2021.12.29.06.06.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Dec 2021 06:06:29 -0800 (PST)
Date:   Wed, 29 Dec 2021 15:05:57 +0100
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     ast@kernel.org, daniel@iogearbox.net, bpf@vger.kernel.org,
        netdev@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>,
        marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
        dledford@redhat.com, jgg@ziepe.ca, mustafa.ismail@intel.com,
        shiraz.saleem@intel.com, leon@kernel.org, ap420073@gmail.com,
        wg@grandegger.com, woojung.huh@microchip.com, andrew@lunn.ch,
        vivien.didelot@gmail.com, f.fainelli@gmail.com, olteanv@gmail.com,
        george.mccollister@gmail.com, michael.chan@broadcom.com,
        jesse.brandeburg@intel.com, anthony.l.nguyen@intel.com,
        hawk@kernel.org, john.fastabend@gmail.com, tariqt@nvidia.com,
        saeedm@nvidia.com, ecree.xilinx@gmail.com,
        habetsm.xilinx@gmail.com, jreuter@yaina.de, dsahern@kernel.org,
        kvalo@codeaurora.org, pkshih@realtek.com,
        trond.myklebust@hammerspace.com, anna.schumaker@netapp.com,
        viro@zeniv.linux.org.uk, andrii@kernel.org, mcgrof@kernel.org,
        keescook@chromium.org, yzaikin@google.com, nikolay@nvidia.com,
        jiri@nvidia.com, wintera@linux.ibm.com, wenjia@linux.ibm.com,
        pablo@netfilter.org, kadlec@netfilter.org, fw@strlen.de,
        ralf@linux-mips.org, jhs@mojatatu.com, xiyou.wangcong@gmail.com,
        kgraul@linux.ibm.com, steffen.klassert@secunet.com,
        herbert@gondor.apana.org.au, arnd@arndb.de,
        linux-bluetooth@vger.kernel.org, linux-rdma@vger.kernel.org,
        linux-can@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
        linux-hams@vger.kernel.org, ath11k@lists.infradead.org,
        linux-wireless@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, bridge@lists.linux-foundation.org,
        linux-decnet-user@lists.sourceforge.net,
        linux-s390@vger.kernel.org, netfilter-devel@vger.kernel.org,
        coreteam@netfilter.org, virtualization@lists.linux-foundation.org
Subject: Re: [PATCH bpf-next v2] net: don't include filter.h from net/sock.h
Message-ID: <20211229140557.cuap5jjqz47yevda@steredhat>
References: <20211229004913.513372-1-kuba@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20211229004913.513372-1-kuba@kernel.org>
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Tue, Dec 28, 2021 at 04:49:13PM -0800, Jakub Kicinski wrote:
>sock.h is pretty heavily used (5k objects rebuilt on x86 after
>it's touched). We can drop the include of filter.h from it and
>add a forward declaration of struct sk_filter instead.
>This decreases the number of rebuilt objects when bpf.h
>is touched from ~5k to ~1k.
>
>There's a lot of missing includes this was masking. Primarily
>in networking tho, this time.
>
>Acked-by: Marc Kleine-Budde <mkl@pengutronix.de>
>Signed-off-by: Jakub Kicinski <kuba@kernel.org>
>---
>v2: https://lore.kernel.org/all/20211228192519.386913-1-kuba@kernel.org/
> - fix build in bond on ia64
> - fix build in ip6_fib with randconfig

For AF_VSOCK:
Acked-by: Stefano Garzarella <sgarzare@redhat.com>

