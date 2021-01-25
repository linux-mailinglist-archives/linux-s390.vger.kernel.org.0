Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F160D3027BA
	for <lists+linux-s390@lfdr.de>; Mon, 25 Jan 2021 17:24:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730748AbhAYQXj (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Mon, 25 Jan 2021 11:23:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730721AbhAYQXY (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 25 Jan 2021 11:23:24 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 757F6C0613D6
        for <linux-s390@vger.kernel.org>; Mon, 25 Jan 2021 08:22:43 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id e9so7937900plh.3
        for <linux-s390@vger.kernel.org>; Mon, 25 Jan 2021 08:22:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=muZDljTxthO8gQv9zsP/8NViE/9Cv3HjXLRFiNSkxF8=;
        b=jR0FVc9+lbi0iukikOxfz6mRSyOWNNUZZQ8bJmctXjFhUnIk3IirPJzx0Cx/MaZdoW
         IaLJgnlfmtEGeRAf1HB4BQkAZAuRA1qJuGKmfeT2pSGqZI2KYo/plbx16x4cqwgjku57
         Ih95jCuWHI7UwXYVFp3+fpRRkCc49X+jFBE0F0DfQAcY6RRTUODbHxHiwzKQlM4oMVV8
         XnFle7KlM2N0W3k42IpIJN6DYaTYUGvAW76y0FhASQyR3aK6LI6TNjZdMB/k1lnXaS19
         fr4VhiILCU7RVUSX5dIEr/XgN8xgioj5HN756VS9qN3iYP1z8NmzzS/txAo01xxNFOdx
         PV2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=muZDljTxthO8gQv9zsP/8NViE/9Cv3HjXLRFiNSkxF8=;
        b=MmK1JH7bMlZJ61nRBDWpq5amqINVwj07RmBvi2hs8bzMP3ut8hTg23Nb4dTsnbi+NS
         f3McpwCOvXvKgWBs9iFikUj735+Bnpfon/++8wUD6yqz51uTXfZ3fjlrHP7e+hiqiml2
         F7J9uWaMXWJ/TFlVXpbEd2+TxGOWdZOzRBM/GBj+Xg/FK/jeRdChoz4+xu5AYvlCiYS2
         DKwgzkiVJ9tA7aCOJM5x3EXGEeJ+7FeokCnV+vqEbfKfqTG6c/AHIfA+zwbZ+Zt2PaU3
         EFRwcYcH2nVcz380O+c379tenK+WXYtssdDyjGK18H5AlBHHAQiliebuv4uy2j7jGcen
         Speg==
X-Gm-Message-State: AOAM533tg0ahqiCuLB5FFa6iQGbtCLb0JmJjUAKS00l/RBzL4zIjMj3B
        qavibj1PqVyXWk8YM9CSaPEVwA==
X-Google-Smtp-Source: ABdhPJz4OBoHAKG4vNHgo7pprDARimABOOGHyLnkPLgOAp1mqihuHs/+0DFzP9RJLGa7A2wiZp/h3Q==
X-Received: by 2002:a17:90a:701:: with SMTP id l1mr1006377pjl.154.1611591762812;
        Mon, 25 Jan 2021 08:22:42 -0800 (PST)
Received: from [192.168.4.41] (cpe-72-132-29-68.dc.res.rr.com. [72.132.29.68])
        by smtp.gmail.com with ESMTPSA id y11sm9726970pff.93.2021.01.25.08.22.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Jan 2021 08:22:42 -0800 (PST)
Subject: Re: [PATCH 0/1] s390/dasd: fix kobject removal
To:     Stefan Haberland <sth@linux.ibm.com>
Cc:     linux-block@vger.kernel.org, Jan Hoeppner <hoeppner@linux.ibm.com>,
        linux-s390@vger.kernel.org,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>
References: <20210118165518.14578-1-sth@linux.ibm.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <74ac02e3-11e3-75a3-520b-47b0f35b711d@kernel.dk>
Date:   Mon, 25 Jan 2021 09:22:40 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210118165518.14578-1-sth@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 1/18/21 9:55 AM, Stefan Haberland wrote:
> Hi Jens,
> 
> please apply the following patch that fixes inconsistent kobject removal.

Queued for 5.11, thanks.

-- 
Jens Axboe

