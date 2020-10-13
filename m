Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE74B28D4AF
	for <lists+linux-s390@lfdr.de>; Tue, 13 Oct 2020 21:40:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727457AbgJMTkp (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Tue, 13 Oct 2020 15:40:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726400AbgJMTko (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 13 Oct 2020 15:40:44 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F3CFC0613D0
        for <linux-s390@vger.kernel.org>; Tue, 13 Oct 2020 12:40:43 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id az3so525491pjb.4
        for <linux-s390@vger.kernel.org>; Tue, 13 Oct 2020 12:40:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Qx2BybEdOPOSCVofa6xFZsnc7BPTTmhJIZH9vHo+CeI=;
        b=jLVYGC3jWw64V1IUmZzhCzuCNNoBZIGEWJnGVmfsomGCbvd9x8TTxOXRYMRBD4K9ud
         2S4OVfnMbMEQ1sL71xGpyrpil2GWDGC9JXJE+/+HZ6QQ0lLbLAxGVWq3hTizsEPvmXTH
         QKJFGdi9M0epMWFrdoMoFy/iZYMoZDqy6zKUVRTHejwECwjnFerQpQTFEC5iZ3rhKxB9
         6nypGhi0ClyDpunbzZyGVpeIKZst9MnvZF1P0zhrClW7LdM8Ew/N+KGHvCt/TcEchhAi
         sDYopNKv7R4DS/cS5EMUhjTqCSK6n6n450dKiRwXDL9nN1GnTYyK1TV8nyNCTUYx14hF
         3cFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Qx2BybEdOPOSCVofa6xFZsnc7BPTTmhJIZH9vHo+CeI=;
        b=jl2JcOxLWV9RrB3RUyUoVQvfxSZcmicRfg3tyxe+xX+c6HwTcQ8eKk85d/pHX3hLgx
         Rln3fg2uRKazTsYMOXlZyt8Ayp9s2+6c8Xv+KyTTBZ43jIi5v/WyIb8WEa8U7Abi3TVQ
         00BbPvnZkouSjcLg+ls3pFUWEpeuJcbTZMTZdwrZcfyGuqBO/oT5C3RukcWckxyS97A0
         KHlD6Ko4/IJ8G7Pxv4fJgMtjZGMlmGDfCijDRgUxtRebguSgRTQdU5awJ6r92UH99jo/
         RtnboH9tDm+SKiqdPIeG4lmb+gAnpiz8YLc+9R9NUS1MPLAE19/8ncQFiJHEjw5iVHw8
         iojg==
X-Gm-Message-State: AOAM531fWhedlVBJ0rCvNNjIlN/40FwxpiKgIIQQUqsQ3jcJxC+jbDOI
        arM/te/gSj2boI3uk+5EAG1RbA==
X-Google-Smtp-Source: ABdhPJwmJP3z72OIdBYDheyuEPP/j8D1RMBREm+aFTbG8BIF7XFtA3H/0zQerBLNjR889UrTjzuyRw==
X-Received: by 2002:a17:90a:1861:: with SMTP id r88mr1300470pja.222.1602618042911;
        Tue, 13 Oct 2020 12:40:42 -0700 (PDT)
Received: from [192.168.1.134] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id v3sm441046pfu.165.2020.10.13.12.40.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Oct 2020 12:40:42 -0700 (PDT)
Subject: Re: [PATCH v2 00/10] DASD FC endpoint security
To:     Stefan Haberland <sth@linux.ibm.com>
Cc:     linux-block@vger.kernel.org, Jan Hoeppner <hoeppner@linux.ibm.com>,
        linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>
References: <20201008131336.61100-1-sth@linux.ibm.com>
 <20201012183550.GA12341@imap.linux.ibm.com>
 <07b0f296-e0b2-1383-56a1-0d5411c101da@kernel.dk>
 <b5038d44-aa46-bbde-7a9f-0de46fed516a@linux.ibm.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <17e1142c-4108-6f74-971a-dee007162786@kernel.dk>
Date:   Tue, 13 Oct 2020 13:40:41 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <b5038d44-aa46-bbde-7a9f-0de46fed516a@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 10/12/20 1:50 PM, Stefan Haberland wrote:
> Am 12.10.20 um 21:33 schrieb Jens Axboe:
>> On 10/12/20 1:06 PM, Stefan Haberland wrote:
>>> Hi Jens,
>>>
>>> quick ping. Are you going to apply this for 5.10?
>> I actually wasn't planning on it - it arrived a bit late, and
>> it seemed like one of those things that needed a bit more review
>> talk before being able to be applied.
>>
> 
> OK, too bad. I had hoped that this was still OK.
> The patches have been tested and reviewed internally for quite a while.
> Which actually was the reason for the late submission. Cornelia also
> gave her RB last week.

I'm not worried about the stability of it as much as whether the special
feature is warranted. From the former point of view, it's probably fine
to go in now.

> But OK, if you think this needs some more review we will have to wait
> for 5.11.
I'd definitely feel more comfortable with that.

-- 
Jens Axboe

