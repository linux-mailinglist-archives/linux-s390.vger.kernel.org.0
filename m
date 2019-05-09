Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BC01418B41
	for <lists+linux-s390@lfdr.de>; Thu,  9 May 2019 16:10:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726087AbfEIOKg (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Thu, 9 May 2019 10:10:36 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:55461 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726411AbfEIOKg (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 9 May 2019 10:10:36 -0400
Received: by mail-it1-f193.google.com with SMTP id q132so3747334itc.5
        for <linux-s390@vger.kernel.org>; Thu, 09 May 2019 07:10:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=2MvD8DryLIpLwVzTpnmpOzWgcT82OOPN0LI9RI8QX0s=;
        b=grrJQz5juTNtlPRDDmOfM+aeVXtfqHebWe8z32utvg+8/3PPqjenzAmcaE58Fxom24
         iscPBei9O7ViuAgOmi8QyvMYf1dGFOpGoTMLmfRFTOHtSIGLTZhCyV8QwjMwxqqcPuV/
         //EsN337NeeBtIO3Of2tkADIxF49Cucc5y5OZkUNX7J667VaIC+tmbJBcfEGTli2sfVc
         3bIcyaS0FUvrsLpSXRv1rZhI7dlMO3VVzA9JO6fWnkWjOJRWMif2cTbr4/+LZaOuFxSq
         4bFtEOu7cYinZD7vWGXIUZsDVLQbjI4G17W6nShdd5Rh75e1uAjp4OgxYme02IG0g9I4
         hdGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=2MvD8DryLIpLwVzTpnmpOzWgcT82OOPN0LI9RI8QX0s=;
        b=pdYs5yEnp8w38A43kpAoyXYyKJ7a5fSLcTM1BsGPJte2XnBgNF6RzbhIAuplfPESvg
         959TytxbBztba4GyfvnA0hBJhULmMkAXrcp7rmbkVhVNwYKsxErxlMvB0JtssHju+Wa8
         4FBL51dSy/KgQN+sZsZ1eNsNcWMb7NrxZfiTa5T972EpcQkuqL4Z6bCXfqij45F4FCh2
         +TUduyV38+v5OYcYHOak1sDTze8M9jRESB0QLpEzTjEdYxmvoxsGXmv1jgG2Sc5n1Ncg
         n6F4/WEnsCVCm85Q4eCA6JobpkyUVCgsA1h930kMlJ/D0Bp43f4KjwN8odl5r8dFPmjA
         5yVw==
X-Gm-Message-State: APjAAAWVUJD1H+t51JI4+rg4/nqxoH2SUptwKetvflgFbm3KtwanGhmt
        QDA4d/X+ODR94anr+3BgJ+8KIGHeHwKnrw==
X-Google-Smtp-Source: APXvYqw7M1dZQzp6R3dXST4qEq3rSCHFv5ZyprN64n1607YrgbcjC+SHHfxkkDvp8FUJT/oKSuSeCQ==
X-Received: by 2002:a24:8602:: with SMTP id u2mr3526731itd.101.1557411035140;
        Thu, 09 May 2019 07:10:35 -0700 (PDT)
Received: from [192.168.1.158] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id j8sm939892itk.0.2019.05.09.07.10.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 May 2019 07:10:33 -0700 (PDT)
Subject: Re: [PATCH] s390/dasd: fix build warning in dasd_eckd_build_cp_raw
To:     Ming Lei <ming.lei@redhat.com>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        linux-s390@vger.kernel.org
References: <20190509100314.19152-1-ming.lei@redhat.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <37bda439-1c86-0fb7-31c5-cf6be6625546@kernel.dk>
Date:   Thu, 9 May 2019 08:10:32 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190509100314.19152-1-ming.lei@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 5/9/19 4:03 AM, Ming Lei wrote:
> Commit 72deb455b5ec619f ("block: remove CONFIG_LBDAF") changes
> sector_t to u64 unconditionaly, so apply '%llu' for print
> sector_t variable.

Applied, thanks Ming.

-- 
Jens Axboe

