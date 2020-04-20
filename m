Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3F091B1336
	for <lists+linux-s390@lfdr.de>; Mon, 20 Apr 2020 19:35:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725774AbgDTRfr (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Mon, 20 Apr 2020 13:35:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725784AbgDTRfq (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 20 Apr 2020 13:35:46 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B5F2C061A0F
        for <linux-s390@vger.kernel.org>; Mon, 20 Apr 2020 10:35:46 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id z2so7597148iol.11
        for <linux-s390@vger.kernel.org>; Mon, 20 Apr 2020 10:35:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=KWUS0gz1oE0nMQJEiPNjPzmZbhnBa9zc3bs1bmlvX2c=;
        b=EsTE0F5+UArSrmzWmdXS2OnYEz9PqYIoT8QxMFmD4Vqf3JsvVkJzP+GV8AAvH7v25V
         kSjhsw9GNmTuuY5H3uk7qVx89YQvW1Uh519IZe+t2UWrHboXZmpiBc6PC3nb33fSrS19
         DSjGfw6xlM503ABxZKM72TN0RqQzfkgbIoYAYr8Fobam5Mp+8I+LvWpPBP2K32IZuucJ
         qOQsD8FR5MVjDl46NfaPJR6xgqHip/ObH/gJcN5Y+DwbmAdRKJ2bbRoim2EQGYumDz0i
         cofswoTYBFQ/hpe1PFyF419NmX1w179+0ttK+GbxIpaRzxR5Y9DcjBs0B0+THrHuGcou
         fPwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=KWUS0gz1oE0nMQJEiPNjPzmZbhnBa9zc3bs1bmlvX2c=;
        b=d5AJC96Y4lv5epmrBbjNV0bhhf2I4D3WlmSvmzgjx05NVFEz+iB3611jB+56YAQb63
         Vwg1+i4QTZSx+0+3j6LC/4e7yDHPkfjpS3Q6Lukv6e4FvRo7lIgU+hvrLjpj0KIdBvAR
         N7XCRFV5W4w+LR97iX9GOUGE56Qa1CxPvSECdWVD5GAJZ4JwOF3VzLnw4O39NpWbgrC7
         trGx9jmJYEfpwjUlOIFQcOZ5yclC2Uy8nTNmgYABFcfCWc/4y5vLK7eP5JhTBxpZ+ZB8
         0Rm8UxTbbTdhX68Omc2ByYU3rZ3FYlLmig6nqN7eEPezafxdfCRz1Vi817hlTPwmrSjB
         EaJQ==
X-Gm-Message-State: AGi0PubL1vZE7r6Bzr6sPaAmC9nukv9dE5IL9y1xwbAe8WayPmr2GPPL
        ONMubvjOTdxJEcF/YpLHRw6YxnmLCXmpdA==
X-Google-Smtp-Source: APiQypIXxTDGRNvgFCLq2hn1/eBEIPBWTY0xjKTT8l+2ETFSS2JxOdovZyXYfhoNqW2Y4hbiD2VT5A==
X-Received: by 2002:a02:a806:: with SMTP id f6mr7169204jaj.22.1587404145557;
        Mon, 20 Apr 2020 10:35:45 -0700 (PDT)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id t86sm71688ili.82.2020.04.20.10.35.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Apr 2020 10:35:45 -0700 (PDT)
Subject: Re: more partition handling cleanups v2
To:     Christoph Hellwig <hch@lst.de>
Cc:     Stefan Haberland <sth@linux.ibm.com>,
        Jan Hoeppner <hoeppner@linux.ibm.com>,
        linux-block@vger.kernel.org, linux-s390@vger.kernel.org
References: <20200414072902.324936-1-hch@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <c1c720cb-659c-44ca-1a64-16e08725accd@kernel.dk>
Date:   Mon, 20 Apr 2020 11:35:43 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200414072902.324936-1-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 4/14/20 1:28 AM, Christoph Hellwig wrote:
> Hi Jens,
> 
> this series cleans up more lose ends in the partitioning code.  It also
> removes a rather annoying use of ioctl_by_bdev in the s390 dasd driver.
> 
> Changes since v1:
>  - fix a brown paperbag typo in blkpg_do_ioctl
>  - fix a commit message typo

Applied for 5.8.

-- 
Jens Axboe

