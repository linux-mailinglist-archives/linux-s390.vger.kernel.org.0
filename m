Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F5D0220FC2
	for <lists+linux-s390@lfdr.de>; Wed, 15 Jul 2020 16:46:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729534AbgGOOqx (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Wed, 15 Jul 2020 10:46:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728855AbgGOOqw (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 15 Jul 2020 10:46:52 -0400
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BA19C08C5DB
        for <linux-s390@vger.kernel.org>; Wed, 15 Jul 2020 07:46:52 -0700 (PDT)
Received: by mail-il1-x143.google.com with SMTP id q3so2177849ilt.8
        for <linux-s390@vger.kernel.org>; Wed, 15 Jul 2020 07:46:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=F4RPWWzGL3R/GCn0bvbwjBdbK6S6cE2QN9yjE6Xn0cU=;
        b=0u2Kc4BbWmwqMLQKEJHRDpBEJQpzqwYbPJxfunBxjCbM9XoXIJdh4ic5sLff+bM3HS
         UVxabkw47fb1BNRMp+j3OBgdFXAZKAiJWSmwGGcMv6s9XbdCdZtxIR+Lp2hMbwpbd1RP
         0Wzw70fTs9QvLPAL8nuBWNGO9v5wIWi2t5mct1IkS/k8x4Rdx1J5jKNaZt1fhKj6qwcB
         FnFD2kanifPSCY5VGAb+fNiHM+yrXN9ZMsYflEtECyqB263KwRGlR6qy2JbBRRNLaHW+
         BoPMFk5DuXaHL7N2cVYtmq5x1fW+tNwEjXz1G/IjNwFO/hNuUjn3jXRJRw96iiurE/VT
         fTlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=F4RPWWzGL3R/GCn0bvbwjBdbK6S6cE2QN9yjE6Xn0cU=;
        b=Dqy+Cpf0eaTB67XObHCpzkLa+5plAfrRA0tb7wsdx6D0qlb5VfQtgyrT5biMD1mzZA
         xAvKEZCuFQY/U2VrQRlY9chjSjgGHnZ5avjIhGZVEiZATuiSuoB/neCqD8Kaq1eTxZgJ
         QGxJFdvVd4YBlff4oSueTc0Kzeq/5ZRV9DXkJN49aPbZt0ar6ibwKzeGjUmqlQiClxMP
         5wfV6Y8X2tKCsjYjAKDiVE7F36FyBQAzVxEYc9/Ek1/jlY/Ic97pt5Db58VIyqL8KbrV
         YptKubwTX2DipP64wlRW7wnvlGxYegPRTUALuqDDXl9Usc2ZTwXBLWR7okT2CSYC6aXx
         1ehA==
X-Gm-Message-State: AOAM53026mlNlAx73/2YTk7btB02QEaU8ByGBjTW2KSXFpq+8om5SZpc
        nE77EYGu9+lya6GuUD0NjwRM8w==
X-Google-Smtp-Source: ABdhPJxrHJBSTzgZh/+7MHQ8okNVpQMZE1Sc68iJMdEjxrNZwXRKvb3UvJu7xbyC0ol40FSQSY7guA==
X-Received: by 2002:a05:6e02:606:: with SMTP id t6mr9861925ils.181.1594824411871;
        Wed, 15 Jul 2020 07:46:51 -0700 (PDT)
Received: from [192.168.1.58] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id u15sm1249813iog.18.2020.07.15.07.46.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Jul 2020 07:46:51 -0700 (PDT)
Subject: Re: [PATCH 1/2] s390/dasd: fix inability to use DASD with DIAG driver
To:     Stefan Haberland <sth@linux.ibm.com>,
        Christoph Hellwig <hch@infradead.org>
Cc:     linux-block@vger.kernel.org, hoeppner@linux.ibm.com,
        linux-s390@vger.kernel.org, heiko.carstens@de.ibm.com,
        gor@linux.ibm.com, borntraeger@de.ibm.com
References: <20200714200327.40927-1-sth@linux.ibm.com>
 <20200714200327.40927-2-sth@linux.ibm.com>
 <c368fa07-4a7d-3eae-6143-a2db298c204e@kernel.dk>
 <20200715064854.GA5409@infradead.org>
 <88f32826-4bd2-27c1-c9e0-204aa556b0a6@linux.ibm.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <85ea2f21-64e3-aae6-b069-013bb929045a@kernel.dk>
Date:   Wed, 15 Jul 2020 08:46:50 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <88f32826-4bd2-27c1-c9e0-204aa556b0a6@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 7/15/20 7:32 AM, Stefan Haberland wrote:
> Am 15.07.20 um 08:48 schrieb Christoph Hellwig:
>> On Tue, Jul 14, 2020 at 02:12:27PM -0600, Jens Axboe wrote:
>>> Just curious, any reason this isn't just using bio_alloc()?
>> The dasd_diag_bio doesn't seem to have anything to do with the
>> block layer struct bio..
> 
> exactly, that's a struct dasd_diag_bio.

Duh, guess I should have looked a bit more closely...

-- 
Jens Axboe

