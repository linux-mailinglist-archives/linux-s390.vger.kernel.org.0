Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9438B2D1A70
	for <lists+linux-s390@lfdr.de>; Mon,  7 Dec 2020 21:24:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725799AbgLGUVi (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Mon, 7 Dec 2020 15:21:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725939AbgLGUVh (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 7 Dec 2020 15:21:37 -0500
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A194C061749
        for <linux-s390@vger.kernel.org>; Mon,  7 Dec 2020 12:20:57 -0800 (PST)
Received: by mail-il1-x134.google.com with SMTP id k8so13437606ilr.4
        for <linux-s390@vger.kernel.org>; Mon, 07 Dec 2020 12:20:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Tej9GY05mZXgV9mNE704/sNm7beFt5nAhjB/8/aBReQ=;
        b=qVz/hPJJWHdcZHxyVJ8JMM9+L35D4za6j+qkK2Wtztfzdb3ErEPtrM9mH/UQTJeDHI
         7BvEq6Zh/3hXeOPvRPvsc3cIG7l0ez3EpuqYLqGEtbIMmNcBOM8Iea36oLC/YnTgxN7x
         SP4lPrG7E4kLDqKtAvvdiA/SbyENzgRWvpYTJ/14QC8VSIvLtWi/oLwDVUlF83qQVPm0
         AH7IakvwgEJuxvUXzQ5vqmoOiZ0gCtwMEyJCAiCZDXPJLxOkQzcwrKFEE+DJvh8+Wjez
         fMjLxxrviZtTsvUpQ6cqL3XeWlzKBdsX0DWUzV3u0UFbx8MB1aWPN4OT5qqBWYQf1I0/
         M3kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Tej9GY05mZXgV9mNE704/sNm7beFt5nAhjB/8/aBReQ=;
        b=tMlac4p3Ru/REvfEp7K/8PrZRGW2QmVKS8r/H6wzsENHz8e/YUBVTBj9RzJiUxSR70
         ocZ5nCDq8KgcL3zjDbEQPKlWxYJGGIyR0EKLc/t83p2KK/kDjoRIlDWl8McW0Kisq0I7
         sq0Yiim8KeePdtB12QNNAukzySGg87+v61P6vbOBu+pST44x6jcgJmcW4UlzJNmEgV5o
         p/jqaO+CYy+D3LS/eGP2ZZd7rEKq1UIxq9IGFDymjvkEfV2mEURcGbxgiNpLmA0+Xkox
         6W7zjsS9Qyw8iSHaaurrgA+GNVLSVZOCPZ4/o06kPOoCNbfo/lOOAUC55y3XZW1UEybN
         I6Uw==
X-Gm-Message-State: AOAM5312Npl4XG9oMJvWANzUg0jcjwen/IniI/RaMb2byObR9rHmUApX
        NNMFRmVyCNcTY2grxEBmEUGgjQ==
X-Google-Smtp-Source: ABdhPJy0Jnsr7/OtLB3lcu38tiaUnDGbRUb9mNjvFf3jY7wBcRk6npkyOfNJF05HCytsclSzwVrwaQ==
X-Received: by 2002:a05:6e02:13cf:: with SMTP id v15mr22654778ilj.222.1607372456254;
        Mon, 07 Dec 2020 12:20:56 -0800 (PST)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id s17sm7855074ilj.25.2020.12.07.12.20.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Dec 2020 12:20:55 -0800 (PST)
Subject: Re: store a pointer to the block_device in struct bio (again)
To:     Christoph Hellwig <hch@lst.de>, Qian Cai <qcai@redhat.com>
Cc:     Tejun Heo <tj@kernel.org>, Coly Li <colyli@suse.de>,
        Song Liu <song@kernel.org>, dm-devel@redhat.com,
        linux-bcache@vger.kernel.org, linux-raid@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-block@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20201201165424.2030647-1-hch@lst.de>
 <920899710c9e8dcce16e561c6d832e4e9c03cd73.camel@redhat.com>
 <20201207190149.GA22524@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <ed7a484d-91d5-50fa-7927-2703b9426d65@kernel.dk>
Date:   Mon, 7 Dec 2020 13:20:53 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201207190149.GA22524@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 12/7/20 12:01 PM, Christoph Hellwig wrote:
> Thanks for the report.
> 
> Jens, can you revert the series for now?  I think waiting any longer
> with a report like this is not helpful.  I'll look into it with
> Qian in the meantime.

Agree, I reverted it.

-- 
Jens Axboe

