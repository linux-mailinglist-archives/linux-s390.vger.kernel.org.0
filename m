Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1CED2A1F9C
	for <lists+linux-s390@lfdr.de>; Sun,  1 Nov 2020 17:45:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726938AbgKAQp1 (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Sun, 1 Nov 2020 11:45:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726902AbgKAQp0 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Sun, 1 Nov 2020 11:45:26 -0500
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11F2AC061A49
        for <linux-s390@vger.kernel.org>; Sun,  1 Nov 2020 08:45:25 -0800 (PST)
Received: by mail-pf1-x444.google.com with SMTP id 72so2253251pfv.7
        for <linux-s390@vger.kernel.org>; Sun, 01 Nov 2020 08:45:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=JA2Mrg1CETiakxbFSgknGwTSjNWYLI4LI30te6RUQlo=;
        b=C6/CfdYPKDaybjemy7ROjgbyGvqWB8u46p2B5eG/nr68U2TGp2xvaVgp2iM+RQBZ+e
         vV4TDjQS6iV2HmZeWPg2tXHrVpg8bNCvWcTGkRCyfQM4VmTSm7ZkoYxM8E9U4qNpDugu
         Qax0PNfE8SJPPsu0S6mBjDQwFfvGp10HHDOlsLWe/na8mnnzwk9wfgZdtm/9swmogTuN
         MzUs4wDSAKQ84FXYmaRgT4XRnKdOog9fc8vkJy7193hpA168Vg4RCSDycjU8LT4CkDLf
         psgPKi8H66LLmuMPHcpmP2gIuP2Gy0GJ+RoHYRYrDqDnw+YBKkZKLYUYa5o/LThczwuA
         1PPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=JA2Mrg1CETiakxbFSgknGwTSjNWYLI4LI30te6RUQlo=;
        b=JJJtigsS3jcf1RL18yudP+ERtNIx9EmNa96SSi2NjQHvsbyKzYvIQQSqYlvTfeqaJk
         ja+lkYB46z7//AtbvoVvBd9xs/yiKJ6xCX1+3Ytpsahj1xDbwNe8jzy0r4gq8oKrFypw
         r+Wbn8RfC4vU9gFVKh/swTTePlRT4NW4tQVMSZ8rompGdt3bCsoDYqwngwnw+iMJSuVu
         Sn22G7Q7O4nDDOGNwCgZ8Kcm0Gv2AviBh/JBLC5AtoXZhJoHYxn/L5TTu+pB5y16gUz6
         cOs0+U1j4P2Fj/x62SIvaErXBCIK5urpHMrdrRzJskGH/fAP76g73SSzHC1DMTyGg6LP
         FWfw==
X-Gm-Message-State: AOAM5328qzUhftUUrzhFKlnKImoHSwxeCNbuOlae8DADpUqP7ESLxgJh
        PQnaztMcVwhT27e2RRlQ5Ttj9NvyAD57Xw==
X-Google-Smtp-Source: ABdhPJxoCG9gkDR5+SPv2EwBLd3ow0z0XlOgH7pokFA9cV+UVH6OXY3zdVqqdFKxBkTD88zb7corAQ==
X-Received: by 2002:a63:5046:: with SMTP id q6mr10223402pgl.373.1604249124121;
        Sun, 01 Nov 2020 08:45:24 -0800 (PST)
Received: from [192.168.1.134] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id gf17sm3763037pjb.15.2020.11.01.08.45.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 01 Nov 2020 08:45:23 -0800 (PST)
Subject: Re: [PATCH 02/11] mtip32xx: return -ENOTTY for all unhanled ioctls
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
References: <20201031085810.450489-1-hch@lst.de>
 <20201031085810.450489-3-hch@lst.de>
 <f128e8bb-7ce4-b8f4-80cb-1afab503887c@kernel.dk>
 <20201101102735.GA26447@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <842f4d23-b8c2-8ade-caf3-50b7cb9542cb@kernel.dk>
Date:   Sun, 1 Nov 2020 09:45:21 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201101102735.GA26447@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 11/1/20 3:27 AM, Christoph Hellwig wrote:
> On Sat, Oct 31, 2020 at 08:58:52AM -0600, Jens Axboe wrote:
>> On 10/31/20 2:58 AM, Christoph Hellwig wrote:
>>> -ENOTTY is the convention for "driver does not support this ioctl".
>>> Use it properly in mtip32xx instead of the bogys -EINVAL.
>>
>> While that's certainly true, there is a risk in making a change like this
>> years after the fact. Not that I expect there are any mtip32xx users
>> left at this point, but...
> 
> -ENOTTY is what most drivers return.  That being said we can keep the
> old behavior, so if you prepfer that I can respin to do that.

Yeah I know that -ENOTTY is what they all should use (and most of course
does), just saying that this change carries some risk. Given that
mtip32xx can probably be retired in the not-too-distant future, I say we
just keep the -EINVAL here.

-- 
Jens Axboe

