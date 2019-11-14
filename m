Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 201CBFC91E
	for <lists+linux-s390@lfdr.de>; Thu, 14 Nov 2019 15:44:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726956AbfKNOom (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Thu, 14 Nov 2019 09:44:42 -0500
Received: from mail-il1-f170.google.com ([209.85.166.170]:43592 "EHLO
        mail-il1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726957AbfKNOom (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 14 Nov 2019 09:44:42 -0500
Received: by mail-il1-f170.google.com with SMTP id r9so5543474ilq.10
        for <linux-s390@vger.kernel.org>; Thu, 14 Nov 2019 06:44:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ADPstWN7XNqk2D3Z/6arxgDRYwL1lVKXj/5T7iJkTkw=;
        b=RA7v7ikhHyI5R001zRHpdNHi+xRAIHKJYoD0OyMKxYwQs63RcEkcfdgq5RaCHhI0RV
         PQmLrg5AbUUiXLg+jy376cg97inXPEZB3JvMbwrvFPPULe9bmTKpSnQCEdn1QLOYqIdT
         /3IS6HLQPUixTWjDfpzTTZ4QHiNDdsIq9NPUTPKdQbSbqd1kD32I9i/kPchg+T1RwNaX
         72zWDtFaGbkKgCM3v0aS4+VCtmGRu3zMK/xJFT8AAt8UZ9LOIUD564qmQ3SWtAeAYNp+
         EKdzIJ8uPPZFrGvDuRM207NYhCFM2dl8RWdj1lmIfXSq3R/iAQZpRY3BlenZoo7QUziF
         mGEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ADPstWN7XNqk2D3Z/6arxgDRYwL1lVKXj/5T7iJkTkw=;
        b=CBAUkwH7ZKDO22a278cv5Kigjq9kVlVi5ajh2OYQFeju1QYOmRFRkR9U+KLonU95MF
         wbtJi2MKFWrmZIWc1F2t6b6+PqQgkUpuhKHyNi4UoVzr0jg6heRzXyDCBThPdKG9FV85
         uQbSFWMzX0/zg8Hx/METs9KZAPxTemrvH3UBrIirB7dZILSNAfQn6BcMuZEKc4VAAB8a
         nQqIygcOO4rQ5qkTtlZjWN0rMKed3eYJQB2cW1rr7T9odYib8tReuKKEyF7FmBWtmsS4
         tr+ZIyAlC5tzlL2WV966DSGjSb/4I0pfEuNltoO91BtuDpHEikAuv5fO7QqlBvwlNFvM
         qH1A==
X-Gm-Message-State: APjAAAXQAaJprlEAov3sdn94jdd6LvT/LjirvRqvkHICnGAR6qjyAA6A
        smj73PxlZZW8DsRNUCwH+wZLZu5mU3g=
X-Google-Smtp-Source: APXvYqwL/ZYZ3r/XCkgmpVkdlTYTAXHO8wASbNOYcIDy3XlAGojjl6i+3UBjpw4hz0xQC0tPoXqgjQ==
X-Received: by 2002:a92:83d0:: with SMTP id p77mr10091426ilk.116.1573742680801;
        Thu, 14 Nov 2019 06:44:40 -0800 (PST)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id c73sm763672ila.9.2019.11.14.06.44.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Nov 2019 06:44:39 -0800 (PST)
Subject: Re: disk revalidation cleanups and fixlets v2
To:     Christoph Hellwig <hch@lst.de>, Jan Kara <jack@suse.cz>
Cc:     linux-block@vger.kernel.org, linux-s390@vger.kernel.org
References: <20191114143438.14681-1-hch@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <10175732-a3f0-510d-e423-f7f7072fef2b@kernel.dk>
Date:   Thu, 14 Nov 2019 07:44:38 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191114143438.14681-1-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 11/14/19 7:34 AM, Christoph Hellwig wrote:
> Hi Jens and Jan,
> 
> this series takes the disk size change detection and revalidations
> from Jan a step further and fully integrate the code path for
> partitioned vs non-partitioned devices.  It also fixes up a few
> bits where we have unintentionally differing behavior.
> 
> Changes since v1:
>   - rebased on to of for-5.5/zoned
>   - fixed a commit message
>   - added two new trivial patches

Applied, thanks.

-- 
Jens Axboe

