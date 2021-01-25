Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 649AE3029FD
	for <lists+linux-s390@lfdr.de>; Mon, 25 Jan 2021 19:22:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726589AbhAYSU1 (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Mon, 25 Jan 2021 13:20:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726586AbhAYSUI (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 25 Jan 2021 13:20:08 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2386C061573
        for <linux-s390@vger.kernel.org>; Mon, 25 Jan 2021 10:19:27 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id d13so2416450plg.0
        for <linux-s390@vger.kernel.org>; Mon, 25 Jan 2021 10:19:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Q+/mfuYQSBHyRxbxoCqJHONl7gyYID+NujOLx72Mjs0=;
        b=hxAyfMOitGzK0bhVEXGRHnZMY/veb9wzOuWr9RDd3o72My/wYEhkOZ/ZdVkwPE3hXt
         5aMcFCX38VwGgwWw5oM3u3VV+Gyp61iDwmogf2xSes8yHeNhqMN3OvbtJwbMCHpNvTC8
         XAuCA3TAlVJjFKquRQ3x0FzJC7x0RlGBw7gJ/3ZdbXa5EdIcQhoxWgmc4UBChCjz/v/+
         2KF0k+2Ydfwr4F8+fjMtTlH2Dq+Wa3c18EB7lp+l5N9wcSObxpm+idttbuoKRPoYiPZh
         Wnxij+fsYh5wvQ63YbpbvP/TNIBdOl1pLGuGIU2XoBwerZCCaxd4qFVIy3GMZRyxl8aR
         w+Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Q+/mfuYQSBHyRxbxoCqJHONl7gyYID+NujOLx72Mjs0=;
        b=k81eaLl/UduaSWMRZPHdUH7A6w5PxJZZv/DAx7nD3jjghSSHllq7qcFj0T+yM5ZAYM
         2LzH5fi85SyMkli7494wr4K9wERE0H8XJSufzZpXVyHCUCJxaAYfiKVl70vTMPc9R4y/
         W31LzDbph8D0aQ3gKm7Pq/cIU0JCMyGdiZMw1/GuRHco8LGcj1N7RKd2+ZMKGp2nfff/
         okSvvIKIob6csW9pxPo8EpEzRoT+r/bLsa3sJJt80Qmb0xtsQ14YHItfBNOjEzX8A3j0
         24ITB+/+yXeAlwh+2Kh/sog6StaFywd1yImeyZkXgNNWEmDu8Ncv9vwxDKHZljLxasas
         BMTw==
X-Gm-Message-State: AOAM533G+D/xLyfY3D93mLDEzs+ct2N8lYQ7vTMauRaYQCjcfiZquvtE
        tYmU9p0Ejdporsde4xIIn5eeAg==
X-Google-Smtp-Source: ABdhPJzLxWAjZR087hDUUpZIANX9xYizUG/Yfc4cDQXg+npguCra4sXCIPHWABpU2lEAEkIShp5VPg==
X-Received: by 2002:a17:902:e8cc:b029:de:a258:68af with SMTP id v12-20020a170902e8ccb02900dea25868afmr1729070plg.7.1611598765943;
        Mon, 25 Jan 2021 10:19:25 -0800 (PST)
Received: from [192.168.4.41] (cpe-72-132-29-68.dc.res.rr.com. [72.132.29.68])
        by smtp.gmail.com with ESMTPSA id mj21sm68984pjb.12.2021.01.25.10.19.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Jan 2021 10:19:25 -0800 (PST)
Subject: Re: [PATCH 05/10] block: do not reassig ->bi_bdev when partition
 remapping
To:     Christoph Hellwig <hch@lst.de>
Cc:     Tejun Heo <tj@kernel.org>, Coly Li <colyli@suse.de>,
        Song Liu <song@kernel.org>,
        device-mapper development <dm-devel@redhat.com>,
        linux-bcache <linux-bcache@vger.kernel.org>,
        "open list:SOFTWARE RAID (Multiple Disks) SUPPORT" 
        <linux-raid@vger.kernel.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>
References: <20210124100241.1167849-1-hch@lst.de>
 <20210124100241.1167849-6-hch@lst.de>
 <dfdff48c-c263-8e7c-cb52-28e7bee00c45@kernel.dk>
 <20210125175528.GA13451@lst.de>
 <2b600368-96fa-7caf-f05b-321de616f7c9@kernel.dk>
 <13667b22-029b-d7be-02da-96fce22cfd8f@kernel.dk>
 <20210125181349.GA14432@lst.de>
 <1c0fabdc-9b73-dfd7-f49d-c211d58cbf12@kernel.dk>
 <20210125181826.GA14957@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <22e0f687-3165-e9d1-e1bd-9769a11dc0ea@kernel.dk>
Date:   Mon, 25 Jan 2021 11:19:23 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210125181826.GA14957@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 1/25/21 11:18 AM, Christoph Hellwig wrote:
> On Mon, Jan 25, 2021 at 11:15:04AM -0700, Jens Axboe wrote:
>> On 1/25/21 11:13 AM, Christoph Hellwig wrote:
>>> On Mon, Jan 25, 2021 at 11:03:24AM -0700, Jens Axboe wrote:
>>>> Partition table entries are not in disk order.
>>>
>>> And the issue shows up with the series just up to the this patch,
>>> without any later patches?
>>
>> At that patch specifically. I bisected it, and then I double checked
>> by running the previous commit (boots fine), then apply this one, and
>> then I run into that error. So it should be 100% reliable.
> 
> Ok, I have an idea.  With EOD message you mean this printk, right:
> 
> 	pr_info_ratelimited("attempt to access beyond end of device\n"
>                             "%s: rw=%d, want=%llu, limit=%llu\n",
> 			    ...
> 
> right?

Yep

-- 
Jens Axboe

