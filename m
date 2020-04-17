Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D66321ADF39
	for <lists+linux-s390@lfdr.de>; Fri, 17 Apr 2020 16:10:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731005AbgDQOFq (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Fri, 17 Apr 2020 10:05:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731000AbgDQOFq (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 17 Apr 2020 10:05:46 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E135C061A0C
        for <linux-s390@vger.kernel.org>; Fri, 17 Apr 2020 07:05:46 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id o15so592650pgi.1
        for <linux-s390@vger.kernel.org>; Fri, 17 Apr 2020 07:05:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=i1IMqZs1rCNg+Kakd6PCCsTWURNUZOM+kVoAEiJdagU=;
        b=cnzAd38SaoQ3yLyq48Cx+BL26/4L7SE5w/HKzAkiWJJVi1KXQWhPpnE0dHEBwjCFyu
         bFk37IMexjdV/NHqvSjHuW4j8l07gePSDMqodv06UHEj9hQCgIA8hBGowEbFcHPtyiuS
         neT83FS1KGhdwa6ZpHOhHz0s5ruLz6d5PMCP3YtnnOs/DGtWQeSRJv7naX/9H05iVXWF
         IB7ae0In9VxDQYVMRswbX1MZMa8+W+Be9uusMywbw2cmgH73gOcK3N1yZzOAd5xKvnKk
         cntnE2crWiiJAJT3TaP6cw+NJudMDwFZr9HR1y5xFOqfnU3BODr1Y1b7HHKmB+hnrq7E
         bq/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=i1IMqZs1rCNg+Kakd6PCCsTWURNUZOM+kVoAEiJdagU=;
        b=VmnQBkyxDDbBf7CEO2yOAbUjMw0XQZbfqeeCF8/qNO3yY7JEpKjNcKZWZzmmrJPjXB
         F2T0VNgRg758j+m9XC3GgscFSx+8+oyb/3XlGJui4/YLxgaY5B9Uov43n7K1WINoHx8A
         WxBrupdnM2BJGQ0EtdN6fqPwIMMiCJgrrLNaRCCqydx274du/5pl9YLhpNmtTNjobrRo
         z5Jb5K6nm8RRpes1PXSI1VfRxtskwX1kh+TPqVXRPtCQjEeWwUG0WA+zGnrjGVdPCb5E
         zzVGB2uPtvon8iNRTP4XbqkRp+LAepFmk1LfBdUQ0DbM0xChJnECOTwDaBTfOywF9WBR
         4mrg==
X-Gm-Message-State: AGi0PuagbT5TqJxabbL5uPoVGTeicZcZCWtj8vOCiIHz2cTX6eWZ261d
        ev000dSnOcFNBsaAbKBHTiwj5w==
X-Google-Smtp-Source: APiQypKFDdJJi0cffxPk+IgS4DQdL81dp2NOAuWFNFDAz31Fj+A/HtPaD9Cs1tHDmM4dZcx12zbU0Q==
X-Received: by 2002:a63:c34e:: with SMTP id e14mr3295875pgd.212.1587132345488;
        Fri, 17 Apr 2020 07:05:45 -0700 (PDT)
Received: from [192.168.1.188] ([66.219.217.145])
        by smtp.gmail.com with ESMTPSA id jx1sm5812584pjb.5.2020.04.17.07.05.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Apr 2020 07:05:43 -0700 (PDT)
Subject: Re: [PATCH 1/1] s390/dasd: remove IOSCHED_DEADLINE from DASD Kconfig
To:     Stefan Haberland <sth@linux.ibm.com>
Cc:     linux-block@vger.kernel.org, hoeppner@linux.ibm.com,
        linux-s390@vger.kernel.org, heiko.carstens@de.ibm.com,
        gor@linux.ibm.com, borntraeger@de.ibm.com
References: <20200417094835.60247-1-sth@linux.ibm.com>
 <20200417094835.60247-2-sth@linux.ibm.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <b748b144-86b8-f0de-e391-f24b50718a2a@kernel.dk>
Date:   Fri, 17 Apr 2020 08:05:40 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200417094835.60247-2-sth@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 4/17/20 3:48 AM, Stefan Haberland wrote:
> CONFIG_IOSCHED_DEADLINE was removed with
> commit f382fb0bcef4 ("block: remove legacy IO schedulers")
> 
> and setting of the scheduler was removed with
> commit a5fd8ddce2af ("s390/dasd: remove setting of scheduler from driver").
> 
> So get rid of the select.

Applied, thanks.

-- 
Jens Axboe

