Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A10628C184
	for <lists+linux-s390@lfdr.de>; Mon, 12 Oct 2020 21:33:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728233AbgJLTdd (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Mon, 12 Oct 2020 15:33:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728031AbgJLTdd (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 12 Oct 2020 15:33:33 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 800D0C0613D0
        for <linux-s390@vger.kernel.org>; Mon, 12 Oct 2020 12:33:31 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id n6so18777299ioc.12
        for <linux-s390@vger.kernel.org>; Mon, 12 Oct 2020 12:33:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=C8sNmLoSFxlYfZxUwMFlxG4rV54hIYRn+EU7ipQkT6U=;
        b=vq98jG2iYw0BLMiGIjvEDfZhLdneIxWqnB0uJpyAgiQU/j0kRv4/TTsx7BM1kKOYa8
         LhLLHVyGddUrO9h/ph+J5bCwjUIpqHMoO2BdpPLew0CU950aihx8CeTnZfDKqbWoraOF
         uhzOemRscBB4gBSqRkHIg/HVUpEM6sdP28EGj+4wFGchCG6dSYi1fblv+G8Y3RIVuZKM
         i6KPh6pqjUx38RAAKzg8a/ZlRQmbUYlnLTEQ7hNKrkQKnOYNsRv4sVW6s8W9ZpKMgA8P
         4JMDX0M1g15ebFdpF3z9cbyRPCS8KVvLvlJSyWrt2MHmaoGTac2ZYeHEZa64YgKvGF7T
         qL4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=C8sNmLoSFxlYfZxUwMFlxG4rV54hIYRn+EU7ipQkT6U=;
        b=Fj5ujsHwk1A+uoN4QlnGIXFJjLZw9Jg5TswgULvY5yzIM+KAbxEVr6+AXH3fPQz2wy
         6fpyJmo1nQcjrnhWNbBD/+h55P8mzTOo55uEDdsiCBgLzQ39XVu2L9ji6se2XG4m0xhJ
         yitBPNQS+zS7WgfBnJ7HO4RB/Xo/D7Zo/tavmqGjLIO58Pl3iHamI6DQbVHitFq/So2V
         h6BzaqrqjaiSpjqScPE3bco1Hsfu1tUVbS9K10oDS4qR1sJunAMSHFWD6nSBxK7P7l4M
         K2iEw+v/9v5ey9C7TyYkwwBezHZBFLT6UI9CbS0m4PNJy3h/k9GN+GU8aiYLnP28J5d5
         w46w==
X-Gm-Message-State: AOAM532FZUAciT0N3lIG+f4dJdnmzLuzxqvDm6oy23rqPVVa9J40oelX
        b/W075JimNNeUHjTcna1azNVOA==
X-Google-Smtp-Source: ABdhPJzYPTj5Coyc6Is7fEUBjgibYwothILYm/lDvJM8rX6a8+tp7K7gfIoxT+65uOAzEuTbt4K1Ew==
X-Received: by 2002:a05:6638:d0b:: with SMTP id q11mr19701658jaj.68.1602531210528;
        Mon, 12 Oct 2020 12:33:30 -0700 (PDT)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id y75sm7803398iof.36.2020.10.12.12.33.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Oct 2020 12:33:29 -0700 (PDT)
Subject: Re: [PATCH v2 00/10] DASD FC endpoint security
To:     Stefan Haberland <sth@linux.ibm.com>
Cc:     linux-block@vger.kernel.org, Jan Hoeppner <hoeppner@linux.ibm.com>,
        linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>
References: <20201008131336.61100-1-sth@linux.ibm.com>
 <20201012183550.GA12341@imap.linux.ibm.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <07b0f296-e0b2-1383-56a1-0d5411c101da@kernel.dk>
Date:   Mon, 12 Oct 2020 13:33:29 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201012183550.GA12341@imap.linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 10/12/20 1:06 PM, Stefan Haberland wrote:
> Hi Jens,
> 
> quick ping. Are you going to apply this for 5.10?

I actually wasn't planning on it - it arrived a bit late, and
it seemed like one of those things that needed a bit more review
talk before being able to be applied.

-- 
Jens Axboe

