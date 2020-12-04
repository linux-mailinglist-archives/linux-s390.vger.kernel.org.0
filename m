Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EF392CF21E
	for <lists+linux-s390@lfdr.de>; Fri,  4 Dec 2020 17:46:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730821AbgLDQm4 (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Fri, 4 Dec 2020 11:42:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728382AbgLDQm4 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 4 Dec 2020 11:42:56 -0500
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC60FC061A51
        for <linux-s390@vger.kernel.org>; Fri,  4 Dec 2020 08:42:10 -0800 (PST)
Received: by mail-il1-x12b.google.com with SMTP id q1so5759469ilt.6
        for <linux-s390@vger.kernel.org>; Fri, 04 Dec 2020 08:42:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=fikGB5tiwbaXtQtRZDejlU5o/PV+EqzyE1dSj5rzFBI=;
        b=bHiFuCI22AZUnNQBHXT6REoQEzckuQnfklBROQQuCQtPbr+ryyHI3/pLtt8VoCk+ps
         ONudM1PD8q/KEEZEAjy61xxHR9GuhlgiAzjsU/lD9M+TL1zbBzJEx7YJqWgYtjdmS14I
         xtGYUaM8Rh2C5gkaCUW2tP+MGsW04Ot92aC5zICkV6oozDh5teeY5ZkC+x7K+D/BANVj
         3uzhgRSyfXDxJjYoMw2QZCISqhM9oCYzAhLiucg+EMULUrI4Cq9I5wKbhc5LQEfh7X/H
         0mUYOtWhEgNuc8rfdXggbUAfYFrdg5xl3F9NN3vTQEkrBY3OpI/Zy102mmDdV2eJXkmw
         Wl/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=fikGB5tiwbaXtQtRZDejlU5o/PV+EqzyE1dSj5rzFBI=;
        b=uD+Ewv28+yZrukm/eyKAiyR91w3W21XqxcLN23N8LRzzYz0V3MiCzbL6LA3vhOC80o
         gcLzfB3XuLZ0gVkwqWK/OzHjNK5EGwIMb7uafTHLNzmk+Ch+fONLEHSBRul/eeHLA4L5
         kClz3C7uXElP9srtIJRky7GwYpCZw82ngvY3gQnXvjxGJskc36Mn+JPP4ihN0IChoOGW
         I4ByBL+nxghj1VCUUV5c35sTV0U7JTuweNo1Y3+Fz91m+Ch1ez1ZIPFK/9S5NwhIYoId
         nwJUOft59XYYLq0zRRF5mvPONJkHcSe8kJH3GLbyJuWktoTRBMaA321JcU7u0s/rGcMA
         kAOQ==
X-Gm-Message-State: AOAM5328t2OrRUD7EVQTnKKhaxvyqP3uyttdIGJ6l6ceTmvQ1mgBvFvd
        kQVUUp+zykYSHlddUHBo6Ozp/GPBrsf4DA==
X-Google-Smtp-Source: ABdhPJyW5yIk7VMQwzcjfu979UjnKKVuVKC1F7TQhIJYUX++QDtGzNaJxMSREo0fly/SWSE8ENM4PA==
X-Received: by 2002:a92:204:: with SMTP id 4mr5121778ilc.79.1607100129990;
        Fri, 04 Dec 2020 08:42:09 -0800 (PST)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id u16sm1849585ilj.6.2020.12.04.08.42.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Dec 2020 08:42:09 -0800 (PST)
Subject: Re: block tracepoint cleanups v2
To:     Christoph Hellwig <hch@lst.de>
Cc:     Tejun Heo <tj@kernel.org>, dm-devel@redhat.com,
        linux-block@vger.kernel.org, linux-raid@vger.kernel.org,
        linux-s390@vger.kernel.org
References: <20201203162139.2110977-1-hch@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <8859c43f-a1fa-60dc-ea27-4a126f95dc68@kernel.dk>
Date:   Fri, 4 Dec 2020 09:42:08 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201203162139.2110977-1-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 12/3/20 9:21 AM, Christoph Hellwig wrote:
> Hi Jens,
> 
> this series cleans up the block layer tracepoints by removing unused
> tracepoints or tracepoint arguments and consolidating the implementation
> of various bio based tracepoints.

Applied, thanks.

-- 
Jens Axboe

