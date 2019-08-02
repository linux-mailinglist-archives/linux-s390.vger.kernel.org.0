Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A5B187EA81
	for <lists+linux-s390@lfdr.de>; Fri,  2 Aug 2019 04:56:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729062AbfHBC41 (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Thu, 1 Aug 2019 22:56:27 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:38979 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728856AbfHBC40 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 1 Aug 2019 22:56:26 -0400
Received: by mail-pl1-f196.google.com with SMTP id b7so33087394pls.6
        for <linux-s390@vger.kernel.org>; Thu, 01 Aug 2019 19:56:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=BvkY4aVBVPfmgyNrK1xBM8Fg1dpebDjbELoJMy6SXxI=;
        b=fEkUMSb8f0VAD/xcGka5xQk7/E6jRDQogO9opCbYglQs6NjrKOX44pm2RKm+zwT1W4
         Mqvow+9ZBifiKM8Bhf4C2nAVjnTcvkJIldn+kS5xB3NVmk5dGX++Bcr87eLoX0L1kdY4
         hmNwPudcy8RJlOL+HDls7F+LHPUB84lhlq4edLEVljT8UyPFE2p46H63IiD+LZj70ZxQ
         A2G/tonzfkrMXh9QYsx5TWYHDcz9QrLqibOfR6qAWA8O4om8CYrBPBL2jVzxRX+Z6Wzy
         chtYca2cRhes4z2MK5kKL7JUi00FDWFvcjAi/bgpO6Exv2DUhZcxUELO7ikwGTT5tLL4
         rfAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=BvkY4aVBVPfmgyNrK1xBM8Fg1dpebDjbELoJMy6SXxI=;
        b=PyZXBT5KiiUwQtKxnpSizHnCk6XfaGG4xpByO0X+bIpm+gemTFGAriYL4PgeoHEi9s
         GnBPCdtF86KK2+u7yiyrIg5PLDkX2qrdz1XXvMLBckinw+sJuB7ezF5OIRBKRVkBK5WN
         EAersObHI/P/bSgIYBHQLhyWbQisbMMGhZDR0qWO8mUCOSMQ24JqxvBCNYU0ZCBK5sjQ
         hGGsqrYO0O2GLfu3mHpI5Q4RatkuUyGQc185Pjvph9aJk/TrYGUcjq9ZQGxmHsOIRcrR
         gFytjoky2cuSYUb423KTh6JAwgaRTvbjlsGoUqo49heX7VgQ2tOPTa6y1fc25uJ2Pqwu
         70Lg==
X-Gm-Message-State: APjAAAWm/RfCC82Ada8jioYW347TfZESwSTWvaI9j08o5B223Mwp8NTP
        803wNWM3C3geKL+zamwp+4M=
X-Google-Smtp-Source: APXvYqy8GNhUeLTLw/HJEURnHibq3O3UhDOV9vTMK2iJwmC7Cez4RItwvtxsxOo4Vsu7fmErZFtYVg==
X-Received: by 2002:a17:902:7d86:: with SMTP id a6mr128929986plm.199.1564714074979;
        Thu, 01 Aug 2019 19:47:54 -0700 (PDT)
Received: from [192.168.200.229] (rrcs-76-80-14-36.west.biz.rr.com. [76.80.14.36])
        by smtp.gmail.com with ESMTPSA id p2sm100756471pfb.118.2019.08.01.19.47.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 01 Aug 2019 19:47:53 -0700 (PDT)
Subject: Re: [PATCH 1/1] s390/dasd: fix endless loop after read unit address
 configuration
To:     Stefan Haberland <sth@linux.ibm.com>
Cc:     linux-block@vger.kernel.org, linux-s390@vger.kernel.org,
        hoeppner@linux.ibm.com, heiko.carstens@de.ibm.com,
        borntraeger@de.ibm.com, gor@linux.ibm.com
References: <20190801110630.82432-1-sth@linux.ibm.com>
 <20190801110630.82432-2-sth@linux.ibm.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <20c4971d-68cd-b4d0-fb40-deef771602b1@kernel.dk>
Date:   Thu, 1 Aug 2019 20:47:51 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190801110630.82432-2-sth@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 8/1/19 5:06 AM, Stefan Haberland wrote:
> After getting a storage server event that causes the DASD device driver
> to update its unit address configuration during a device shutdown there is
> the possibility of an endless loop in the device driver.
> 
> In the system log there will be ongoing DASD error messages with RC: -19.
> 
> The reason is that the loop starting the ruac request only terminates when
> the retry counter is decreased to 0. But in the sleep_on function there are
> early exit paths that do not decrease the retry counter.
> 
> Prevent an endless loop by handling those cases separately.
> 
> Remove the unnecessary do..while loop since the sleep_on function takes
> care of retries by itself.

Applied for 5.3, thanks.

-- 
Jens Axboe

