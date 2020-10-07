Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1AF92860D2
	for <lists+linux-s390@lfdr.de>; Wed,  7 Oct 2020 16:02:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728560AbgJGOCT (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Wed, 7 Oct 2020 10:02:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728535AbgJGOCS (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 7 Oct 2020 10:02:18 -0400
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96337C0613D2
        for <linux-s390@vger.kernel.org>; Wed,  7 Oct 2020 07:02:16 -0700 (PDT)
Received: by mail-il1-x141.google.com with SMTP id q7so2349890ile.8
        for <linux-s390@vger.kernel.org>; Wed, 07 Oct 2020 07:02:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=7PmeV7A2s7ZHQXqDKwao7sD4aBVqIsNQs6VXNj1YEYc=;
        b=KwogTcW4hy9FHKhhK4CoGtwQRNETfccZAi+8JgcEzHJneLzVt0lZRipR6yJHNsnuBl
         9GrSt19QBHfA6YBzAC3B+Z9VD6C11O8+yR6f/vExQfAKz2cZfICjYJUFeZcmvS+TakoZ
         NmQvLUH/GxGJO2E0u3z/RgvJ2KiLBqW5fxhs/cRmnx8ej42ld8kVRK9RAMT6ZpvPaILQ
         SX+ABz1d4p9uOcS0Br6OlkiHDIEgRWd3HziR1kNJv+a+VzPwC5ZAu2/8rUUjGqbw5KrZ
         pYEwmEJHvT+CFcKZWIRZbrYt2+ypPtqanwRPNAC65dmKbnXgc3XrJjQFrRQZVpIskr0d
         MI4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7PmeV7A2s7ZHQXqDKwao7sD4aBVqIsNQs6VXNj1YEYc=;
        b=PB3QrvkEr+1MWHKyqFCr9tjyTye4aBjWp6U0sfAUtr6Px1tNzxpNaiFS/kIArV+hjR
         dcv4czsoksOsbYa8bVTEmY4mpb4I/EIBfWXBqEPe5uQsSZAeFTL1zzAmjFRcG67m9NGs
         54uml4DCLwqDDCwGRYWazWAUtnDRbtBbBqOBRqfbyusjWWHJykqyFQfX85u40+UdgfOT
         OF89+t4xqzx+pIFjjWL6fAHzeTdQTafRqYcP78zg0yWPIppv66Z7LYBbpHFrX7zAhasK
         +VnDkKY0P0vbNYZa73Ng3sI1pFKSmtMHZ+wzDNSLiMCBt1RzMYgFp+Qsif1SeatOzgQ9
         vwAw==
X-Gm-Message-State: AOAM532kvJ1Oztt+ITDTwZ3Ctti7dZn1F+PofKXYC5sbVc9dIkr9+ksM
        o3CBHHV0I7B0Cx5A5doc+PTTkw==
X-Google-Smtp-Source: ABdhPJxT6/PJs6QyWsWwtgVYf7Gzdtu19Vwnqm+ahLG7MbcWcakBIwfdrj7HEip5LfA9Ojd2s4+hXg==
X-Received: by 2002:a92:db45:: with SMTP id w5mr2687206ilq.158.1602079334890;
        Wed, 07 Oct 2020 07:02:14 -0700 (PDT)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id s23sm915544iol.23.2020.10.07.07.02.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Oct 2020 07:02:14 -0700 (PDT)
Subject: Re: [PATCH] partitions/ibm: fix non-DASD devices
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-block@vger.kernel.org, sth@linux.ibm.com,
        linux-s390@vger.kernel.org,
        Christian Borntraeger <borntraeger@de.ibm.com>
References: <20201007124009.1438269-1-hch@lst.de>
 <a8b1c076-c280-d201-8403-2392a42d2163@kernel.dk>
 <20201007135411.GA1000@lst.de>
 <874c518d-7c15-d08a-61a2-116f605c4b5a@kernel.dk>
 <20201007140109.GA1042@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <55d92fb3-acd7-d62c-093b-4f716d98ac52@kernel.dk>
Date:   Wed, 7 Oct 2020 08:02:13 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201007140109.GA1042@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 10/7/20 8:01 AM, Christoph Hellwig wrote:
> On Wed, Oct 07, 2020 at 07:54:45AM -0600, Jens Axboe wrote:
>> On 10/7/20 7:54 AM, Christoph Hellwig wrote:
>>> On Wed, Oct 07, 2020 at 07:53:27AM -0600, Jens Axboe wrote:
>>>> On 10/7/20 6:40 AM, Christoph Hellwig wrote:
>>>>> Don't error out if the dasd_biodasdinfo symbol is not available.
>>>>
>>>> Should this be marked for 5.8-stable?
>>>
>>> The Fixes tag should automatically take care of that.
>>
>> Not if it's not marked for stable. Maybe auto-selection will pick it
>> up, but it's not a given.
> 
> Yes, trivial patches with a fixes tag get reliably picked out.  But
> if you don't trust the system feel free to add a stable tag.

I prefer being explicit instead of assuming it'll get picked up.
I applied it for 5.9, added the tag.

-- 
Jens Axboe

