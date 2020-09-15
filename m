Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5A17269B52
	for <lists+linux-s390@lfdr.de>; Tue, 15 Sep 2020 03:41:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726019AbgIOBlR (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Mon, 14 Sep 2020 21:41:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726131AbgIOBlQ (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 14 Sep 2020 21:41:16 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D9DAC06174A
        for <linux-s390@vger.kernel.org>; Mon, 14 Sep 2020 18:41:15 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id f1so484327plo.13
        for <linux-s390@vger.kernel.org>; Mon, 14 Sep 2020 18:41:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=yDZSPGcbAWhnWXgnJkMwrrVMrUS1MAAeaub02b2a/Cs=;
        b=sjaMq31lDCTtBi2xCdrCYcc5Q4TPeIEK/WcS4vMtbiPe/N3axCOA70PZ7MAgVE9Qbq
         fdo3F6Aq534fuc5UUrwkEVOhjR7omgR00Wlp/TflPUfxWdPgPz0AbFopflssDnP4d1zd
         aoyalB8rgPBy6xengBzWxkwrX6TWa72BXtcfGymG+EmDOZ/X2XorXD7Cpj48W5bIYlgS
         IimK/Ciqvvev26qW1jZj7Sq3V+i20byWZdNzmOYPA+nBg8Rn8o3t0qf36wYJAi5OUDwZ
         w/Vu7Kg5u3cRvyXYkIg9YHcr4ODj7ejSjZaXBZZXaZ1Gfd5EXKfzimBEj/6PqpVJJqtu
         hrtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=yDZSPGcbAWhnWXgnJkMwrrVMrUS1MAAeaub02b2a/Cs=;
        b=khOKm3smeNl34j/fg9uEIB3GHVbUcw7lJmNWQo7fFAmnvo/KQfgGpmCHMGbK3sEw0Q
         cLk0dfBVnU/L8NqqDWT+ciqm43SRvwbw+0UFxFV9Ek6zfC/Y3Z8/K83T/SeJr1/PLXp8
         L6WjcJ2qmQm8s/q5ppew3l7CU6y+0YsFR9kHfEPasqXjgIG0m6iGkozM50yKM6UHY/uP
         ivZ50F3bu8dY/C0AGt+RmJJbiGmvY10PXQWKncPHIIoIHGF38mHs7I5d4qwdbjQJKbYk
         CS0mWHxCjLev9h1tJiLBbSC7RreDXAYiQHSPW67M6p9w4thY3wgEUXB2i/8zpK5W2wsd
         HSWQ==
X-Gm-Message-State: AOAM532XZE9BSR5EZbwAvQDOoB0OKODUbBKmHtkxnqV6KFZaTikIHkhN
        Dn1mPbE/1IfH5m0limpSGcUx3g==
X-Google-Smtp-Source: ABdhPJyiJh8JmGd2EliIIIyVMdYRblzxZvUYZbyKH83ACOSvDCExGAClXwXoYTCyKjODsiJhGBBUsA==
X-Received: by 2002:a17:90b:a51:: with SMTP id gw17mr2029405pjb.118.1600134074807;
        Mon, 14 Sep 2020 18:41:14 -0700 (PDT)
Received: from [192.168.1.182] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id e10sm8433163pgb.45.2020.09.14.18.41.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Sep 2020 18:41:14 -0700 (PDT)
Subject: Re: [PATCH 0/1] DASD: fix discard for FBA devices
To:     Stefan Haberland <sth@linux.ibm.com>
Cc:     linux-block@vger.kernel.org, hoeppner@linux.ibm.com,
        linux-s390@vger.kernel.org, heiko.carstens@de.ibm.com,
        gor@linux.ibm.com, borntraeger@de.ibm.com
References: <20200914115647.94062-1-sth@linux.ibm.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <8c3ae063-8e19-d2ab-f0cb-88014df65e66@kernel.dk>
Date:   Mon, 14 Sep 2020 19:41:12 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200914115647.94062-1-sth@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 9/14/20 5:56 AM, Stefan Haberland wrote:
> Hi Jens,
> 
> please see the following patch that fixes zero writes for DASD FBA devices under certain conditions.
> 
> Do you mind to take this for 5.9?

Applied, thanks.

-- 
Jens Axboe

