Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 236D1FC867
	for <lists+linux-s390@lfdr.de>; Thu, 14 Nov 2019 15:08:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726628AbfKNOI6 (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Thu, 14 Nov 2019 09:08:58 -0500
Received: from mail-io1-f54.google.com ([209.85.166.54]:41303 "EHLO
        mail-io1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726605AbfKNOI6 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 14 Nov 2019 09:08:58 -0500
Received: by mail-io1-f54.google.com with SMTP id r144so6882704iod.8
        for <linux-s390@vger.kernel.org>; Thu, 14 Nov 2019 06:08:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=IZwgKmH1FAobFu9aPkm4pTqaHcl3j2dKrzm5t8hdzjU=;
        b=Iukl2JLyDAGQkDzizJVV2gUe2YbuO3Z1oIbf49qui0lo5aL4YQhQPouOICeJ9J3qGN
         LZIYYHpFxRug60xT64uDxL9yMfi5v1r3z4LYSM2qGjNyEj240dq5YA51lyB0asKYTov3
         0DIKCYhDpaKWiUXrWkHOr1dUJ68IceGTAXMlZXi9FRexq3slQNJOshFhcPAF3JlxPRQW
         2R2/OFGBY+pOJarlI20JQtsvmHy7QntH9U4E8/MnJ0g3UV9/4J5OyZ+PwGWWJX7PXsx2
         6T0F+yOFDmBV/Yv0KAp2yLjUom+dK8matPex6XovhUPsXJAjKn3Y03DzDNwhtFK1DijQ
         sWvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=IZwgKmH1FAobFu9aPkm4pTqaHcl3j2dKrzm5t8hdzjU=;
        b=L0QlApkfqRhuGFpr1Ke4cONti2YOyOoK9hCi48QAxxkDCPiOfHesmatDDa9Kyv2UIn
         5akMC5yvKztRtTuC2LjTMS1I4/GgCgyAQUaLKA2Zye3BR+mQWzDLwkMJ1rttQlgpQvi3
         Dw50Way1NQhB3nfenh2hVxYpFU0iLUVU9gGaFKE6uXHFYbFy1shHQQbYHWqpgsYlycz+
         CHMmcibZ+xHgAZ8FXW9WD7wwcmaZwIh/JwZ8C/9LdQAsuGV3+EwWXHe5yMcAufTNhxg3
         OtF6POuZKXJKTldVyufO6/c9kAZbSgWpaD5gAPsDwzUTKeLuoJBQBK9WC91KekO3Idox
         C8YQ==
X-Gm-Message-State: APjAAAWgySP0hpPxnk0ZeisJ5tLG6+MJCCtHzhEQ/Lzsta0KYNeEC97S
        qv7njz7nycjH2z3mU7JnT9KOmhT51tA=
X-Google-Smtp-Source: APXvYqzq6/rW5qb0q4xiD0FoGvfebxZDSkHTSEkxFe2ku3aIsU4BhGp4FmozblzIlkV9S21Tmem+Ww==
X-Received: by 2002:a5d:80d5:: with SMTP id h21mr8292113ior.298.1573740536951;
        Thu, 14 Nov 2019 06:08:56 -0800 (PST)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id t18sm573258ioc.41.2019.11.14.06.08.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Nov 2019 06:08:56 -0800 (PST)
Subject: Re: disk revalidation cleanups and fixlets
To:     Christoph Hellwig <hch@lst.de>, Jan Kara <jack@suse.cz>
Cc:     linux-block@vger.kernel.org, linux-s390@vger.kernel.org
References: <20191106151439.30056-1-hch@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <e994fc4b-cc72-c2db-cc2c-754a0aa03057@kernel.dk>
Date:   Thu, 14 Nov 2019 07:08:55 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191106151439.30056-1-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 11/6/19 8:14 AM, Christoph Hellwig wrote:
> Hi Jens and Jan,
> 
> this series takes the disk size change detection and revalidations
> from Jan a step further and fully integrate the code path for
> partitioned vs non-partitioned devices.  It also fixes up a few
> bits where we have unintentionally differing behavior.
> 

Were you going to re-send this on top of the other stuff for 5.5?
If so, should probably get queued up...

-- 
Jens Axboe

