Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9C1B7C3960
	for <lists+linux-s390@lfdr.de>; Tue,  1 Oct 2019 17:45:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389652AbfJAPpE (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Tue, 1 Oct 2019 11:45:04 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:40085 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727299AbfJAPpD (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 1 Oct 2019 11:45:03 -0400
Received: by mail-io1-f66.google.com with SMTP id h144so49084224iof.7
        for <linux-s390@vger.kernel.org>; Tue, 01 Oct 2019 08:45:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=2FQ7h8PlUPexVQ4SErsdRg9fch/Ili1SumdwNo+CuGE=;
        b=PGOhX1typrW/DdFt1VNA8LXSgPONjgn/VwRLwa1RzrzsQdisUP04uuJIh89CFHHtgy
         AiK6BpvaD67feenvq/RC3zuCeeYbibmlO7sOY2nofS2Pks78qHwPoCI2l+SRELBoZ3pG
         FM//74+r/TwVUnKTQNhYWS78tduKtq3Jh9hNBx4FZ5fD54pcP3gIMly7ekPX9Mms0fCI
         tbR4LPDdNL7LszIbySMBHm7XLr2Nw8Zj/Jzzk380brULZeqrRLmN6BOi0NQ9dnHcCGIz
         oMHDsQspidge6DRWf/bGKDpDdID0ymutZ5qpcgdr8ZoYeT4d0j7JMgC4FLOf/fK8Itb/
         NrBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=2FQ7h8PlUPexVQ4SErsdRg9fch/Ili1SumdwNo+CuGE=;
        b=uKVcC4wjUwckPzxN947pAIs9/vdnX8PGv91WSCHvrs4vSFvXvIVqpzX4wIoqxOa1ck
         WNPyTnlcXqZ828iLod5d/VBAy/w97WERYs3TSWnVRGeooYS1etdQBQzcWXE0dcrQaI/t
         INUBBqWIQ3k3irA2s387r0jjKLTUMQAaaXrSu3JypEyCDvFb7nOS8sa/R/cYnVcyGbv+
         sMGZn5Y5FRsp/gaCR14ER9lEOH4Gu4rvFvOc4oqRc2W2hUNBGDDsGSb5WDxXi0qcmjPZ
         tIGTw5tGi8GYNote8PVXQ5tju0n+IvWossO6ebuaXysEu+vPeYPdqm/ot7Mzd0gsictB
         dmNw==
X-Gm-Message-State: APjAAAVM2EOVLbqILS0+VmyeXRGaviv1z9Fvwq+NtVjjMKWDZSHPVI/a
        caMgsO3RdA5jmHBWvNLt/UtTrr0Qe5SPjw==
X-Google-Smtp-Source: APXvYqzVLqLxf6IrL3xdLHLHlgtql0RK4SaTmUAx7AzwBBaPfe4GaXN28iewATx8LVZ9doiakpovVQ==
X-Received: by 2002:a6b:8e82:: with SMTP id q124mr3144396iod.267.1569944702907;
        Tue, 01 Oct 2019 08:45:02 -0700 (PDT)
Received: from [192.168.1.50] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id l21sm6851713iok.87.2019.10.01.08.45.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 01 Oct 2019 08:45:02 -0700 (PDT)
Subject: Re: [PATCH 0/2] s390/dasd: fixes for thin provisioning support
To:     Stefan Haberland <sth@linux.ibm.com>
Cc:     linux-block@vger.kernel.org, hoeppner@linux.ibm.com,
        linux-s390@vger.kernel.org, heiko.carstens@de.ibm.com,
        gor@linux.ibm.com, borntraeger@de.ibm.com
References: <20191001153439.62672-1-sth@linux.ibm.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <deaa7dff-5b1a-851f-4f08-74ab369e58b8@kernel.dk>
Date:   Tue, 1 Oct 2019 09:45:00 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191001153439.62672-1-sth@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 10/1/19 9:34 AM, Stefan Haberland wrote:
> Hi Jens,
> 
> please see the following two patches that
> 
> - fix a bug in the thin provisioning base support
> - revert a commit because of possible data corruption

Applied, thanks Stefan.

-- 
Jens Axboe

