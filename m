Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7F762AF5E7
	for <lists+linux-s390@lfdr.de>; Wed, 11 Nov 2020 17:13:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725984AbgKKQNK (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Wed, 11 Nov 2020 11:13:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725949AbgKKQNJ (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 11 Nov 2020 11:13:09 -0500
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E44DC0617A6
        for <linux-s390@vger.kernel.org>; Wed, 11 Nov 2020 08:13:08 -0800 (PST)
Received: by mail-il1-x134.google.com with SMTP id y9so2481952ilb.0
        for <linux-s390@vger.kernel.org>; Wed, 11 Nov 2020 08:13:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=7yS21c4EDamv1N5jFFAli/djfW/+Q3U+ZJfbXcDD9kI=;
        b=0mdj8CtO/R56ulgEDkoqOJkeoWn//omJtQsjKRxVAfyHMuD/i84TcxrzvRmjPiwu8d
         5QHIjv1vEPSxJ7oTOr3oXq08szlvpuUQyhdRv82dm8eKD6yeTe6aZ6F47Ab+TgA8euaS
         uCAQOWouzIbjPJKUwWzjNHJhlRh+SAuaCVGBS6zxaeSmTlcD93GvFMRBY2JS+rvj9/71
         62v/XE93mWLRdieAXrh+wRWHWhL/1mkIIJYsWWeoVEyvPFkHo6lRccH7n6CWyIJQ4DnD
         LGdZYCEGD4DexxHWKSV8QfZBXsJhbXqpD26FOUoZ7CLbUXUFw/+F2whGdyrKEEu1f005
         +RFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7yS21c4EDamv1N5jFFAli/djfW/+Q3U+ZJfbXcDD9kI=;
        b=fSd2z6m2qV1wu4w7hMmGa1xuK3hFNnRVO/dqDI8o6LPIW/8Ks0HESkvzwI8Ewg2FhF
         qv49rMWD/9T7bAWd5XBkCR0wzx4auYhwxIUNt2XcF5uBgxK5iaXlEDuzpAPivV4Vzl6x
         DoVENtlQM/9PGmkg/f2ACeZPhzsiL1wr81tpp6Q/h6UkcqzA3xPG/zqiVkx15BbI7Xjn
         SzY/owgZDFFP7I+F6S8VOWU7u7k1Tgy91kU8KzBsjLJJncVw9H49m3Pt0CoRkjDm3M7P
         Fe+tqVDB2QA3TrhQ4Fo/vLiCLR8Pe3lbygOLlpSdGwjqufJzFAC5YSNSKgmSgLRScESx
         EP+g==
X-Gm-Message-State: AOAM532IVssai8EJuswakNkrAFKc8x2FSFW41fAFxz60o7V6XT+LmnGu
        h+aVULJixS0T1gE/dgey5ljTufsOqbcK0g==
X-Google-Smtp-Source: ABdhPJzwILifX5tSP9gqWXbZq1R8Jv1w+MiHneN+v+U9u5cRPw2dSbsLytSjWr9uVfmYJHN8DBeLZw==
X-Received: by 2002:a92:8541:: with SMTP id f62mr20043826ilh.9.1605111187075;
        Wed, 11 Nov 2020 08:13:07 -0800 (PST)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id j85sm1478517ilg.82.2020.11.11.08.13.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Nov 2020 08:13:06 -0800 (PST)
Subject: Re: block ioctl cleanups v2
To:     Christoph Hellwig <hch@lst.de>
Cc:     Ilya Dryomov <idryomov@gmail.com>, Song Liu <song@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Stefan Haberland <sth@linux.ibm.com>,
        Jan Hoeppner <hoeppner@linux.ibm.com>,
        linux-block@vger.kernel.org, ceph-devel@vger.kernel.org,
        linux-bcache@vger.kernel.org, linux-raid@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-s390@vger.kernel.org
References: <20201103100018.683694-1-hch@lst.de>
 <20201111075802.GB23010@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <92a7c6e5-fe8b-e291-0dce-ecd727262a2e@kernel.dk>
Date:   Wed, 11 Nov 2020 09:13:05 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201111075802.GB23010@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 11/11/20 12:58 AM, Christoph Hellwig wrote:
> Jens, can you take a look and possibly pick this series up?

Looks good to me - but what is the final resolution on the BLKROSET
propagation?

-- 
Jens Axboe

