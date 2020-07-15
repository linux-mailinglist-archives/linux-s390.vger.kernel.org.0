Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5EE3220FC7
	for <lists+linux-s390@lfdr.de>; Wed, 15 Jul 2020 16:48:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728767AbgGOOra (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Wed, 15 Jul 2020 10:47:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728857AbgGOOra (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 15 Jul 2020 10:47:30 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04A03C08C5DB
        for <linux-s390@vger.kernel.org>; Wed, 15 Jul 2020 07:47:30 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id q74so2533493iod.1
        for <linux-s390@vger.kernel.org>; Wed, 15 Jul 2020 07:47:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=8/+EAaTSL958bPqZxiLU3U5YE27iqRWLLeLwwKJY03w=;
        b=tRmHKfqUB1iU35dX7xxXreXQMMclZdLayOOEbVy9fMLGSR5E9efg00gpYDzCWjNHUf
         5/XjkDGj4Jc85qnlpZpSs1r5riEvKg0Gh1sRK/N7uJcBOJ8+oTJ+eXR5sa6O5ZhpD0Rv
         X72xtNYrsBcypMsjeQ4gU4F0+2bm6Ih5Y1FXlKwX8HoONxdVp/BvEMMXX8v+iU7NV9+M
         xxC9dLSTfcVHmF7NyTg1BuhJfbfV3yGXwKcB4roEhWRrmMHk5VWal+rnPrNNaYRRDree
         Yxp9PzndOBW0qSnmP+8HEpDTI/rj2LE50wrfiEV4qdGyFqN9lS9QiletPHxQl3QhTRI/
         Sujg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8/+EAaTSL958bPqZxiLU3U5YE27iqRWLLeLwwKJY03w=;
        b=aK10RV5wGFckyrbYsmn2ES1LwZGp4MeYprdyg3YErOy4aRN4cNpiER37nHnVcrHH6z
         GvaRguBO/effGUoyl4sj+3B7n66PF0GXvLQGWFcbhmNzSGLR5YsWivzlj7eBkiYGfBpJ
         R7OSouARr6v2UxIR47VLnKgBtlWRFJbZxb8jbnwhusU0paVvwFJ9cBOWIJSMLcC5BATc
         B1grRHhP54Dd9PrKFptv8GSv7JEtjr2c3OjNaZD6hwazgWyq9LqlVa/utMkb8eeieWnl
         mMWzzPAlW+1jEomgoA81HhX5ymnxltPAiXbqNcxXBIhkq6MLRad6wzuUv1VQ6xsmKW/U
         WIuA==
X-Gm-Message-State: AOAM533ZKIwTnnQkxZKGn9WJduHomemfjWQAdG+YQbQmOkM832urtmON
        KpKvIpY39YVNFl1+xBjpWIoeDA==
X-Google-Smtp-Source: ABdhPJzqYEfIJ8HsQhrrlGd6mAZFVljzOA3UseWj+JG8YzQxyN3UrVxOr2vMtQuRgPWYhzoElaKnKw==
X-Received: by 2002:a02:6381:: with SMTP id j123mr11764464jac.103.1594824449331;
        Wed, 15 Jul 2020 07:47:29 -0700 (PDT)
Received: from [192.168.1.58] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id b6sm1290114iow.35.2020.07.15.07.47.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Jul 2020 07:47:28 -0700 (PDT)
Subject: Re: [PATCH 0/2] DASD DIAG patches
To:     Stefan Haberland <sth@linux.ibm.com>
Cc:     linux-block@vger.kernel.org, hoeppner@linux.ibm.com,
        linux-s390@vger.kernel.org, heiko.carstens@de.ibm.com,
        gor@linux.ibm.com, borntraeger@de.ibm.com
References: <20200714200327.40927-1-sth@linux.ibm.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <e45950a7-a452-e7f0-f066-e1465cd97a4d@kernel.dk>
Date:   Wed, 15 Jul 2020 08:47:27 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200714200327.40927-1-sth@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 7/14/20 2:03 PM, Stefan Haberland wrote:
> Hi Jens,
> 
> please see the following two patches that fix and improve the DASD DIAG driver.
> 
> Regards,
> Stefan
> 
> Gustavo A. R. Silva (1):
>   s390/dasd: Use struct_size() helper
> 
> Stefan Haberland (1):
>   s390/dasd: fix inability to use DASD with DIAG driver
> 
>  drivers/s390/block/dasd_diag.c | 33 ++++++++++++++++++++-------------
>  1 file changed, 20 insertions(+), 13 deletions(-)

Applied, thanks.

-- 
Jens Axboe

