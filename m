Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 031477EA7D
	for <lists+linux-s390@lfdr.de>; Fri,  2 Aug 2019 04:55:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727848AbfHBCzk (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Thu, 1 Aug 2019 22:55:40 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:35285 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729400AbfHBCzj (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 1 Aug 2019 22:55:39 -0400
Received: by mail-oi1-f196.google.com with SMTP id a127so55667810oii.2
        for <linux-s390@vger.kernel.org>; Thu, 01 Aug 2019 19:55:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=SZXg7MkvG8X4G/e4/KyUmpRLOzGXiJZkoKc+bGigKJY=;
        b=WVlsnLCY9reULBgfQIA4QFxuBSbdil0JyDx29QmZCA6kdJbwhCqsOqYJZk9tzPrutG
         g2TVFIt3Mqow/U9r82MOuUJFDOGd1+MUL0CbPgXfX0uKm34PjjpPOkdE5/Io9NLGSA++
         i80s6/ZUY1qR1SarBjuFykXltCia6AzsWUvSJI7tkYYspXOL5URCE3EpG3aFI+UzMjuJ
         oJ/D8nA5ZD0q0OTaZe9tbq8uE+ehrHRhRkvsUpnfXJpQq4bVJ6STpUmaIdPiOTI2NNhl
         gmJ0VzWFdRb3pWCooVk+sPiN8qV5df5GHakCsIgnEjl7M1WfrWIxF8Z9+6IrBEPyddYf
         d1kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=SZXg7MkvG8X4G/e4/KyUmpRLOzGXiJZkoKc+bGigKJY=;
        b=mEdBDmY9qsf705tiL5lQAlIJ46Bj7VyZQZ4lq2M/1tdT0OGx/uy0lXqDg23Cq3zK4H
         nFuoJ0kPJgFWgCAg2c43XVmSBprgLos1nvi23FJTnZ3kh0Hm7m2iyJE2/OHUk1S676J4
         W4OWU7X9LRbrHa7B9Gokyg6rgSV2BC14ADMjs/QFMkdSSaIa6216wa5dRfHZcgPzbx1r
         8I2vKjsk5DGL8ZNqA4iH1CITsmAF9Xl3hDKaVH58hM6GVzxPLKxw8o4Z7XJMMnE2vuh9
         oL1ktjW0Um9vxwyikwvXffkkoB2oJV6BALw/M7Ta9BlLN4t0XoyWNHZrsA5doNJUhNHg
         xE6w==
X-Gm-Message-State: APjAAAXZ13Z8z3aXPh04ocbJRrZS6bos3S7cEmtT5yvPLsveW8xLrJvf
        XeNZaxn4PH0AShGZcg5o+8lit+CjRRs=
X-Google-Smtp-Source: APXvYqxMAwM7gRmuihJFSYVFiyid8C3J+3mI4xgjPNsp/9po6iCu1laSZtFXCPcmwZrzuwtRAq4Umw==
X-Received: by 2002:a63:1046:: with SMTP id 6mr125224852pgq.111.1564714049618;
        Thu, 01 Aug 2019 19:47:29 -0700 (PDT)
Received: from [192.168.200.229] (rrcs-76-80-14-36.west.biz.rr.com. [76.80.14.36])
        by smtp.gmail.com with ESMTPSA id p68sm85467533pfb.80.2019.08.01.19.47.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 01 Aug 2019 19:47:28 -0700 (PDT)
Subject: Re: [PATCH 0/1] sending DASD patches through linux-block
To:     Stefan Haberland <sth@linux.ibm.com>
Cc:     linux-block@vger.kernel.org, linux-s390@vger.kernel.org,
        hoeppner@linux.ibm.com, heiko.carstens@de.ibm.com,
        borntraeger@de.ibm.com, gor@linux.ibm.com
References: <20190801110630.82432-1-sth@linux.ibm.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <c66977ae-7a17-5a54-0519-a69d8f825070@kernel.dk>
Date:   Thu, 1 Aug 2019 20:47:27 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190801110630.82432-1-sth@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 8/1/19 5:06 AM, Stefan Haberland wrote:
> Hi Jens,
> 
> we would like to get our DASD related patches upstream through your
> linux-block git tree in the future.
> We hope to get a better integration and that we are able to identify
> potential conflicts with generic blocklayer changes earlier.
> 
> I hope this is OK for you. I have attached a first patch that fixes a
> bug in the DASD driver. This patch is based on the master branch of your
> linux-block git tree.

Certainly. No extra hassle for me, and if it makes it easier for you,
then by all means.

> Please let me know if I should change something in my workflow.

Looks fine to me, I generally prefer patches (individual or series)
to git trees, unless it's a huge series.

-- 
Jens Axboe

