Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7D3CA1A15EA
	for <lists+linux-s390@lfdr.de>; Tue,  7 Apr 2020 21:24:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726701AbgDGTYf (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Tue, 7 Apr 2020 15:24:35 -0400
Received: from mail-pj1-f68.google.com ([209.85.216.68]:55687 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726339AbgDGTYf (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 7 Apr 2020 15:24:35 -0400
Received: by mail-pj1-f68.google.com with SMTP id fh8so162799pjb.5
        for <linux-s390@vger.kernel.org>; Tue, 07 Apr 2020 12:24:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=6GN8OH2/jW9JwHGhBC4VMasJH95BH8giiJV5mLcCQBQ=;
        b=umqPoRxNCHNRpmbH80vy5O201YJUULc6hqGly7WERsycQLmJAhO/fVVs0NUxbo0l+E
         Ei4s58f5tNqvMgLIcwKgvVEnW0BeTKp+LR2xj28quO7X9xzHL1qheZq8K+9zq3fpFXT1
         7Bz/U4ffV/4gQmnphXeuqNVVISlhLjUOwzYBbP8l2iA8/Vk4T8zzQ40zx8ygNihSUJ3K
         iIA1RizX4q3JVeW6dTXuVhqd2CbOnVNHjczZklP/lu6OnSsNR+gGdqswsbT5kB8IcXz8
         uAWz543RkO8Mz2nU8LVlHh6qdTEUVNFTbPhnDQzkXW6hAGebrFdQRcxEKFYqM9Mrasf3
         aTLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=6GN8OH2/jW9JwHGhBC4VMasJH95BH8giiJV5mLcCQBQ=;
        b=NrSJY/OxkI17GvjtNV+oV1POAVGO3lUunoyjTqFA3NUFWcviLBINgnuFR+tS6L5UyL
         Jd6BoVCROauWHDsdw3hQmRcKLF14H76ALLa5Cbx5+tsO1dvbOYxj7NwfdyIWSM4XoBDK
         acIhsto3K2smXOILQR7KwK+Anej6hVqVWA4weJs1cj2CvmVnr3MbUZK01lK9aAechrhd
         QkCKql0VyjCGqDSX82QGQHrKKrOTaZntJAdr4Qcyxux3e0v5lwee0NPbV/40buJLv4DT
         Fyhti1ZNWX98fFcULNnJVadxrrNhIYrVrrhfgPmjX2qnbgEeMWdH3XDNCNNQbDpVzCFt
         ngDw==
X-Gm-Message-State: AGi0Pub+RQIfN4TEWq7bzrPdz4O8WIdOcnaOj5qdRCxjUxdeyUCo/Wzn
        mlCjJVjbRMJ+vkxiu83Ur0mskQ==
X-Google-Smtp-Source: APiQypJkFPl162p4/chu82kIXc2V1RKn4YeyTYS10aBaifyojwyQWsTT5b8OWXXLdeIHmi9Pnd1a7w==
X-Received: by 2002:a17:902:b210:: with SMTP id t16mr1553926plr.71.1586287472981;
        Tue, 07 Apr 2020 12:24:32 -0700 (PDT)
Received: from ?IPv6:2605:e000:100e:8c61:ec7d:96d3:6e2d:dcab? ([2605:e000:100e:8c61:ec7d:96d3:6e2d:dcab])
        by smtp.gmail.com with ESMTPSA id x186sm14543759pfb.151.2020.04.07.12.24.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Apr 2020 12:24:32 -0700 (PDT)
Subject: Re: [PATCH 1/1] s390: Cleanup removed IOSCHED_DEADLINE
To:     Stefan Haberland <sth@linux.ibm.com>
Cc:     linux-block@vger.kernel.org, hoeppner@linux.ibm.com,
        linux-s390@vger.kernel.org, heiko.carstens@de.ibm.com,
        gor@linux.ibm.com, borntraeger@de.ibm.com
References: <20200406074118.86849-1-sth@linux.ibm.com>
 <20200406074118.86849-2-sth@linux.ibm.com>
 <0efad2a5-90f5-8ccf-169e-9715a64a4bb0@kernel.dk>
 <c7ac9c3c-3a1f-3ce3-acbd-422bc4206288@linux.ibm.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <4a51ce19-7827-5ee6-8b06-5b814bdf503a@kernel.dk>
Date:   Tue, 7 Apr 2020 12:24:31 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <c7ac9c3c-3a1f-3ce3-acbd-422bc4206288@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 4/7/20 3:01 AM, Stefan Haberland wrote:
> Am 06.04.20 um 17:32 schrieb Jens Axboe:
>> On 4/6/20 1:41 AM, Stefan Haberland wrote:
>>> From: Krzysztof Kozlowski <krzk@kernel.org>
>>>
>>> CONFIG_IOSCHED_DEADLINE is gone since commit f382fb0bcef4 ("block:
>>> remove legacy IO schedulers").
>> Isn't this a leftover thing from when dasd selected deadline
>> internally? I don't think we need this anymore, just kill the
>> select completely.
>>
> 
> Basically yes.
> We still have the recommendation to use deadline and there are some udev
> rules in place which select it.
> So I thought it might be a good idea to keep the line. But I am also
> fine to drop it completely if you prefer this.

I don't feel super strongly about it, but at the same time I don't
think there's a reason for it. Besides, I think everyone has deadline
enabled. So I guess we should just kill it.

-- 
Jens Axboe

