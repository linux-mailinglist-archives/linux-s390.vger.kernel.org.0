Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 69C86104868
	for <lists+linux-s390@lfdr.de>; Thu, 21 Nov 2019 03:06:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725904AbfKUCGT (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Wed, 20 Nov 2019 21:06:19 -0500
Received: from mail-pj1-f67.google.com ([209.85.216.67]:37133 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725819AbfKUCGT (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 20 Nov 2019 21:06:19 -0500
Received: by mail-pj1-f67.google.com with SMTP id f3so716843pjg.4
        for <linux-s390@vger.kernel.org>; Wed, 20 Nov 2019 18:06:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=uo9mEPcaYcwnzYyWGiXlb2tEqoly25jIf2ri/BJ7dDw=;
        b=Am9AlC+yrXpYjI9tLZJABP+RtHy2I4MpTU3JDy2quw9lARH0E9nsUx5sZLzW3WsDXO
         MTT+d/n1iXXdDWbHu/+5ZNlEjJkBCfuMGQ0lkn8Y7lm/Tzm4N0xy3n8V3/0Et0gCoKEN
         La77ktcLIHHNXLrDobr2UBGIDQa807YwOkRStoKCQx7d8nF5nRTY9eGyAdB04aZCf5yD
         rO4aRJlugOJko5ct311BHN7FOI/OtYpsdzrpnaN7mckQkPbFwVkF+LgJJq63UARVC8nL
         O2ZgCy5Q6Agt+f5TU+Sl3EUB3XFTfODjPAndMGYek+NU+pNGWBS4nA0GY5D6/JQ4Jzi9
         BNsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=uo9mEPcaYcwnzYyWGiXlb2tEqoly25jIf2ri/BJ7dDw=;
        b=QZT3w709yNbV9hZf5fq4bR5LzqPKOoPtBtR9UxayuHe3b9pLj5vjQjONihi1e+RR7p
         EKTu7F2HhoR83umc5D+a866OstqcnxiXSaVjtPsFpMyqj7vkKh7254Xegh3gaCVY0WZa
         SUt7f6uvLcgxEH5HDqj2JwfSC79Nai7xMMQfVhr1CUNYrQ1Lchcy8iirEmQRsifZabfx
         YEJLkeXgl5u5GOUipbLRZtGSu3/VuvUvsK6lwEF4zgv13+kiWlAPHBrsplTNteWifAjZ
         VFA4kMhoC5K7T/MHDK/s9WhrJ/Nq+c59QFIfyqbS3kK9jawu9LsgVb4eB5mK10THk+Le
         UDog==
X-Gm-Message-State: APjAAAU3FVWkGq6MwOov9TbxVkrY7EvSQPzoy+C9yHd3H/DscZ6eMEf0
        /74jgpasWe+1EhM9U9t/f2NY+Q==
X-Google-Smtp-Source: APXvYqytngQq8IjjeiFBpEFRQm5zInwYRJW6QSTLANZYdx6eBrIH2RFe+esQWcWUc+a6h1YGF2wf6w==
X-Received: by 2002:a17:90a:ec13:: with SMTP id l19mr8419701pjy.0.1574301978779;
        Wed, 20 Nov 2019 18:06:18 -0800 (PST)
Received: from [192.168.1.188] ([66.219.217.79])
        by smtp.gmail.com with ESMTPSA id s15sm541405pjp.3.2019.11.20.18.06.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Nov 2019 18:06:17 -0800 (PST)
Subject: Re: [PATCH -next] writeback: fix -Wformat compilation warnings
To:     Qian Cai <cai@lca.pw>, Tejun Heo <tj@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     jack@suse.cz, gregkh@linuxfoundation.org, cgroups@vger.kernel.org,
        heiko.carstens@de.ibm.com, gor@linux.ibm.com,
        borntraeger@de.ibm.com, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20191114192118.GK4163745@devbig004.ftw2.facebook.com>
 <9D52EBB0-BE48-4C59-9145-857C3247B20D@lca.pw>
 <20191115145540.GP4163745@devbig004.ftw2.facebook.com>
 <1574279778.9585.15.camel@lca.pw>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <26dc5699-9223-3e35-65f3-955fef7a990a@kernel.dk>
Date:   Wed, 20 Nov 2019 16:17:51 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <1574279778.9585.15.camel@lca.pw>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 11/20/19 12:56 PM, Qian Cai wrote:
> On Fri, 2019-11-15 at 06:55 -0800, Tejun Heo wrote:
>> On Thu, Nov 14, 2019 at 07:26:21PM -0500, Qian Cai wrote:
>>>
>>>
>>>> On Nov 14, 2019, at 2:21 PM, Tejun Heo <tj@kernel.org> wrote:
>>>>
>>>> Acked-by: Tejun Heo <tj@kernel.org>
>>>
>>> Tejun, suppose you will take this patch via your tree together with the series or should I Cc Andrew who normally handle this file?
>>
>> Patches in this area usually goes through Jens's block tree.
> 
> I remember that last time Jens had no interests in picking up trivial patches
> like this one. See the commit d1a445d3b86c ("include/trace/events/writeback.h:
> fix -Wstringop-truncation warnings").
> 
> Andrew, care to pick up this again?
> 
> https://lore.kernel.org/lkml/1573751861-10303-1-git-send-email-cai@lca.pw/

I'm fine with picking it up, this one isn't trivial and it's fixing
warnings. But I didn't (and don't) carry f05499a06fb4 in my tree,
so it'd be more logical to funnel this one through the tree that
has the offending commit.

-- 
Jens Axboe

