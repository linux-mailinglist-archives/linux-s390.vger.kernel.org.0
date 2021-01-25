Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2AC93027C1
	for <lists+linux-s390@lfdr.de>; Mon, 25 Jan 2021 17:25:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730752AbhAYQY4 (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Mon, 25 Jan 2021 11:24:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730743AbhAYQYq (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 25 Jan 2021 11:24:46 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57393C061788
        for <linux-s390@vger.kernel.org>; Mon, 25 Jan 2021 08:24:06 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id b17so1391761plz.6
        for <linux-s390@vger.kernel.org>; Mon, 25 Jan 2021 08:24:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=fXfkMAEQ+Munc2QVdjGnmLY18me6kBjN2JpuXybmej8=;
        b=melUhKvefiahTWBZSTKnTQngCuLKRwnWefzG8XCrqod+qu6V+whvzgVbndvXcGW1nO
         LxBQ+exeD5hag1d5iYB8naQfZY4cxiHbHgkUyoXcpFy3pIyk+EdGzNfiSZmUVzdZu7mR
         8vcZimLHfgSMwehelNQYJnbCqWJ5+aXM1UBAA3pvwyL5o10YuTGKRq1Mb+onVYA5X5eh
         J217+Wc3qyJEBUDkRVfOCj4J44rCBjHroAocrNVibYZ718Gm9WEmExM5pIhjGp2ZCbaE
         yJs/OVNHe6RTrlruJEOrM9kkYU2IHim66Ngv64asDPXaHnH2u0UOtKLzWbptyFjWn/vj
         Fo8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=fXfkMAEQ+Munc2QVdjGnmLY18me6kBjN2JpuXybmej8=;
        b=t36JS8TP/bnXJLuyhcLdrB7XqQ47Yz17tq7ifLj18LcLRRqUabIw+FHYHcx6s26Ofb
         RIKdt3A2A69T6RvbrMC7h4bQbfLlNY+/DUvgbhK+qlwgzgMekoZH07pjEWTd3ngKK3U3
         hwtO3KE8qxQ60DHDHkvxfBgvIhfCyPfNZzVvf62TkAlGKPfaC1wh2kW8Qa2KTISRldyI
         NOcJrCSPi0Yz2QFUEDhFk+k4W8XL9/3vQQD0xyzLlMzhIK0ZJHMVb7LnxcstRi5eT8OB
         ahmjEBkNQ4LAwNOdScMmht/lbU3w0eRnjZhYzUYTfl1xibHB3ZtsSwt7Ilh9NbxfsZU+
         4pbQ==
X-Gm-Message-State: AOAM530z7yzjzBY+JsvsxPCSwQzuoLO4lXHOwnHAo4bbEVhrYBkqkoy3
        lB3Os9KFKR6T3XW5m0hh09HiYQ==
X-Google-Smtp-Source: ABdhPJyZ7TqSW5vYzS6sR2enGCQzoNcpXGNgER6vx3ER9uTn7PeFaeI8bJWpz6MeQxBxo7yasuILmQ==
X-Received: by 2002:a17:90b:908:: with SMTP id bo8mr987716pjb.206.1611591845774;
        Mon, 25 Jan 2021 08:24:05 -0800 (PST)
Received: from [192.168.4.41] (cpe-72-132-29-68.dc.res.rr.com. [72.132.29.68])
        by smtp.gmail.com with ESMTPSA id gd11sm19028097pjb.16.2021.01.25.08.24.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Jan 2021 08:24:05 -0800 (PST)
Subject: Re: store a pointer to the block_device in struct bio (again) v2
To:     Christoph Hellwig <hch@lst.de>
Cc:     Tejun Heo <tj@kernel.org>, Coly Li <colyli@suse.de>,
        Song Liu <song@kernel.org>, dm-devel@redhat.com,
        linux-bcache@vger.kernel.org, linux-raid@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-block@vger.kernel.org
References: <20210124100241.1167849-1-hch@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <86dd18e9-43e9-efe5-8445-88952a95b5d8@kernel.dk>
Date:   Mon, 25 Jan 2021 09:24:03 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210124100241.1167849-1-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 1/24/21 3:02 AM, Christoph Hellwig wrote:
> Hi Jens,
> 
> this series switches back from storing the gendisk + partno to storing
> a block_device pointer in struct bio.  The reason is two fold:  for one
> the new struct block_device actually is always available, removing the
> need to avoid originally.  Second the merge struct block_device is much
> more useful than the old one, as storing it avoids the need for looking
> up what used to be hd_struct during partition remapping and I/O
> accounting.

Applied for 5.12, thanks.

-- 
Jens Axboe

