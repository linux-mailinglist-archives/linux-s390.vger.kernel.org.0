Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F35365CCDF
	for <lists+linux-s390@lfdr.de>; Tue,  2 Jul 2019 11:48:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726768AbfGBJsy (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Tue, 2 Jul 2019 05:48:54 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:39856 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726455AbfGBJsu (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 2 Jul 2019 05:48:50 -0400
Received: by mail-wr1-f66.google.com with SMTP id x4so17009465wrt.6
        for <linux-s390@vger.kernel.org>; Tue, 02 Jul 2019 02:48:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=UdYCIZGQ7tAt7A88vWqWA422Qpx5IuQReKn9P3m3xX8=;
        b=PZuM9EJbQb3YhMp+qaw+VF6BwkhSSyYMquhljCcVZSO+tjIcy06ofVIGPbwYNmREXi
         pRcuGFWqgU+nSlEobDVIi97m26fD20LGHZVCL/m/+eGewb0yAO7NlvlF/9gBYN5Rgy0B
         UVcUnIeulg2Ui8pzjNF76wVB55J/p/3pN/YrI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=UdYCIZGQ7tAt7A88vWqWA422Qpx5IuQReKn9P3m3xX8=;
        b=LpC/vgNnAXdsPRAkfNebD+I7xAQo9Qs8uDpYJJQAA+BpuR6w6TYPSzzu7MTNdOFuyN
         4JWO822LgYEY57gK7wzt+e2sJVGHSwXXJcX1qppMu+7vK2swewQhc7PZstRR0y4f3b0k
         ypmtaWrqVo9I4EIH4ReYMkKI+wuYdfIHxa0mvx+BDhazWpMK3oYRoyzX41dO7kwN3InJ
         YL5J5uOFk/NMR+kBt2GyG/UjlpGHRTxUW1p+rjXcPZQgKtp6o78LKd0bMWWIFxtMP3Mm
         Rsqe1pvi6oBurnt6y4EgyEXAOHz0U32VW5Wo9e5/M8J8Kz7N1rAi0YRmitEqK9dr5qew
         kfUQ==
X-Gm-Message-State: APjAAAWugJ9MHKUH17NNRAtpquBXwVkRhI5FXkSG7uoHXApqYyJQBsjC
        Xcr5ddWCMZ9yjnIY9+GF0toFmg==
X-Google-Smtp-Source: APXvYqw+cs3wphtlInYiqa/iYYLL5YBkbuaWsrCFwdpkqDK8kfUrPvl8YI8TNOvUo+26MvPNs1E1Ng==
X-Received: by 2002:adf:9487:: with SMTP id 7mr9588274wrr.114.1562060928176;
        Tue, 02 Jul 2019 02:48:48 -0700 (PDT)
Received: from [10.176.68.244] ([192.19.248.250])
        by smtp.gmail.com with ESMTPSA id l124sm2421987wmf.36.2019.07.02.02.48.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Jul 2019 02:48:47 -0700 (PDT)
Subject: Re: use exact allocation for dma coherent memory
To:     Christoph Hellwig <hch@lst.de>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Ian Abbott <abbotti@mev.co.uk>,
        H Hartley Sweeten <hsweeten@visionengravers.com>
Cc:     devel@driverdev.osuosl.org, linux-s390@vger.kernel.org,
        Intel Linux Wireless <linuxwifi@intel.com>,
        linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
        intel-gfx@lists.freedesktop.org, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-mm@kvack.org, iommu@lists.linux-foundation.org,
        "moderated list:ARM PORT" <linux-arm-kernel@lists.infradead.org>,
        linux-media@vger.kernel.org
References: <20190614134726.3827-1-hch@lst.de> <20190701084833.GA22927@lst.de>
From:   Arend Van Spriel <arend.vanspriel@broadcom.com>
Message-ID: <74eb9d99-6aa6-d1ad-e66d-6cc9c496b2f3@broadcom.com>
Date:   Tue, 2 Jul 2019 11:48:44 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190701084833.GA22927@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org



On 7/1/2019 10:48 AM, Christoph Hellwig wrote:
> On Fri, Jun 14, 2019 at 03:47:10PM +0200, Christoph Hellwig wrote:
>> Switching to a slightly cleaned up alloc_pages_exact is pretty easy,
>> but it turns out that because we didn't filter valid gfp_t flags
>> on the DMA allocator, a bunch of drivers were passing __GFP_COMP
>> to it, which is rather bogus in too many ways to explain.  Arm has
>> been filtering it for a while, but this series instead tries to fix
>> the drivers and warn when __GFP_COMP is passed, which makes it much
>> larger than just adding the functionality.
> 
> Dear driver maintainers,
> 
> can you look over the patches touching your drivers, please?  I'd
> like to get as much as possible of the driver patches into this
> merge window, so that it can you through your maintainer trees.

You made me look ;-) Actually not touching my drivers so I'm off the 
hook. However, I was wondering if drivers could know so I decided to 
look into the DMA-API.txt documentation which currently states:

"""
The flag parameter (dma_alloc_coherent() only) allows the caller to
specify the ``GFP_`` flags (see kmalloc()) for the allocation (the
implementation may choose to ignore flags that affect the location of
the returned memory, like GFP_DMA).
"""

I do expect you are going to change that description as well now that 
you are going to issue a warning on __GFP_COMP. Maybe include that in 
patch 15/16 where you introduce that warning.

Regards,
Arend
