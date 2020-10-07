Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7108028607B
	for <lists+linux-s390@lfdr.de>; Wed,  7 Oct 2020 15:53:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728526AbgJGNxe (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Wed, 7 Oct 2020 09:53:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728177AbgJGNxb (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 7 Oct 2020 09:53:31 -0400
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4462C061755
        for <linux-s390@vger.kernel.org>; Wed,  7 Oct 2020 06:53:29 -0700 (PDT)
Received: by mail-il1-x142.google.com with SMTP id o9so2369942ilo.0
        for <linux-s390@vger.kernel.org>; Wed, 07 Oct 2020 06:53:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=pdKwGBt3vgEIkMtFrGuBx1104sQ/OZxI5mRem7H/luA=;
        b=NM2EJSU9oepcqmQFPhB+ORVpWNM8GYWasYStTx8+pD9QdARrzWi7qYyFClCE5qKcVU
         xg7TJY7jhnUYiNcvHPO7FFvTxdLf1L2WN3ZWn2HQAe3hprZKzhCkUFakz+tBMA92RlcF
         lFg+3mHuuKfEEOIRF2LAPskq43J+IOltuBtaj7X7FJAOSrySbAWd/Z4gyuYia99TguLN
         PnMkWU930Rg9yDQ6h11ZrXOoL48Omu8h9X0a5HUL7ZaaM1TtdT3x7PM6cDK0WeNEuCay
         hA9FQrNJzccvOgUxScko+Vdz2BMYE2oYexAHq2iqdTmCUjvbFJhEmSUqJIlRTflTsDGK
         xIeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=pdKwGBt3vgEIkMtFrGuBx1104sQ/OZxI5mRem7H/luA=;
        b=ajD2Qok7fSQgHv51juW1awSebiCNCQjPoVs6dXFeYdrHYPPrCanjSrp1dEWEoxlpAx
         6Qb7Q9P5cweQJSS0BYqd1rmDdIsOATM8n8mzuMbbZuibMAgAiknM0WjaN1hZ7q5xF9fT
         E3855gtzF6+2elgaAKGbwgBhOr5Y5sBnci2fLEKXr86xZuwKxNbyVDg/gX4cJWrSNHvu
         YreUORVDCuZaONCWA8lecsMNeQ5UOOhP4lOXjA4maByfdVAnbmDZl/RAIwxAcCgpTYBy
         pT+Oc4eSqN7LZSH/EMVpMGF9zOJD5nZTv69VmbxNlNnO3N9qCsuxW/BurhgfuYjSeMre
         X+gQ==
X-Gm-Message-State: AOAM530kHULmehx8Om1E8kuQ2FS8TYjYL0sSqwoNgeBMD8Uak0+e8ldh
        RmgnABwAaXYwDJy9vyU3BdT6iw==
X-Google-Smtp-Source: ABdhPJy+KHwm4tS/zT5SnmmwL9ihwwYYWTSFP8EZ49Y85mXn9AVlsDgS/j8gAC1w4xi4cTs4QqM0CQ==
X-Received: by 2002:a92:8e03:: with SMTP id c3mr2962127ild.16.1602078809013;
        Wed, 07 Oct 2020 06:53:29 -0700 (PDT)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id t64sm1114077ild.10.2020.10.07.06.53.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Oct 2020 06:53:28 -0700 (PDT)
Subject: Re: [PATCH] partitions/ibm: fix non-DASD devices
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-block@vger.kernel.org, sth@linux.ibm.com,
        linux-s390@vger.kernel.org,
        Christian Borntraeger <borntraeger@de.ibm.com>
References: <20201007124009.1438269-1-hch@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <a8b1c076-c280-d201-8403-2392a42d2163@kernel.dk>
Date:   Wed, 7 Oct 2020 07:53:27 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201007124009.1438269-1-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 10/7/20 6:40 AM, Christoph Hellwig wrote:
> Don't error out if the dasd_biodasdinfo symbol is not available.

Should this be marked for 5.8-stable?

-- 
Jens Axboe

