Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9354D2B494A
	for <lists+linux-s390@lfdr.de>; Mon, 16 Nov 2020 16:31:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728717AbgKPP2a (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Mon, 16 Nov 2020 10:28:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728029AbgKPP2a (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 16 Nov 2020 10:28:30 -0500
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64121C0613CF
        for <linux-s390@vger.kernel.org>; Mon, 16 Nov 2020 07:28:30 -0800 (PST)
Received: by mail-io1-xd42.google.com with SMTP id n12so17817689ioc.2
        for <linux-s390@vger.kernel.org>; Mon, 16 Nov 2020 07:28:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=5cjrSC5QyZm1b9x+1TfHrkUsiua1ov2aE33mdC49A8s=;
        b=hYh1H8oI2IM6Bil0tmxzNEh4RKYUx/+nhK+eKlQb7zOj/vrW3FSN4b6BJrrDWYWctR
         RDPA+F5lQClMvYY3WN3gOq7cLvMhZTqtB/wbpUJ4rjPw/NlXEvgpaP2vVy4O+HLotRTS
         DkD/OX8Od682zSv5nIDskqBtjeDKsa9ggHsvJ+gAIy/dLJL2De2Sd9Qe1iQZUX73rqIg
         eqejiStQ8VGV84DSHwNOten9Rqg00AxZ/NT0rKFgjgxUJZ6biwYDCfErHKd+pH+8t2Zf
         pBFH7WhP/jYZ5YzHiaoU4JhCCy2ZF0VxD0fLT+4Mih8R1FAIIb5ncqgGEyZzmJoCC05k
         mZ4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5cjrSC5QyZm1b9x+1TfHrkUsiua1ov2aE33mdC49A8s=;
        b=mK0avD704ltaqdrNrgG5Me5Bftiw0FqImYxQki93V+8YWuwslIHdnlM/0HavrB2k9Y
         +O6qZaWOpE9sr4T/Ph9IjIgXQ4x8rG6NGLcjVEyKBI6oQ4mNeUpaR+hwcxXYE28o7nEB
         eOib6XiG2yjGIO2dOiFBy49YU55gdS+bzifSaqRW/zM3lifiElIrF0D4uQv46EEwQNRK
         lK3B9XFZb5g3LoLwrvPQRRVJotrkTsBHay/IUZm+pF9k+e06z2E84l+OLgE7DXRbd4ob
         eE40GqATcYj5vndZeFWKtr1K0Gr9F0UW+bluu0M4h7O/nZSo0wIc3dtW+t8U+S7s6BPW
         o17g==
X-Gm-Message-State: AOAM531oUUxtnDuQrCZai1XJp5uroyh/imT3n5PXe970n8IQ7wy6+AvN
        zNwPzKeMwD9SiOnTYwDA4kZxIA==
X-Google-Smtp-Source: ABdhPJwXvh6hBJkw2iVfweDYQzCcK9t0E9MIUxf+RJhx68sba6/zEYLYAGsimcnpdpkxYzMxL1qHgQ==
X-Received: by 2002:a02:a68b:: with SMTP id j11mr33352jam.32.1605540509666;
        Mon, 16 Nov 2020 07:28:29 -0800 (PST)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id x13sm11280105ilo.54.2020.11.16.07.28.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Nov 2020 07:28:29 -0800 (PST)
Subject: Re: [PATCH 0/1] fix null pointer dereference for ERP requests
To:     Stefan Haberland <sth@linux.ibm.com>
Cc:     linux-block@vger.kernel.org, Jan Hoeppner <hoeppner@linux.ibm.com>,
        linux-s390@vger.kernel.org,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>
References: <20201116152347.61093-1-sth@linux.ibm.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <8d6a4ff9-d5dc-131c-3fa7-afe0c843a731@kernel.dk>
Date:   Mon, 16 Nov 2020 08:28:27 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201116152347.61093-1-sth@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 11/16/20 8:23 AM, Stefan Haberland wrote:
> Hi Jens,
> 
> pleas apply the following patch that fixes a null pointer derefernce in the
> DASD driver.

Applied, thanks.

-- 
Jens Axboe

