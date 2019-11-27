Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 779A510B0A3
	for <lists+linux-s390@lfdr.de>; Wed, 27 Nov 2019 14:54:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726558AbfK0NyK (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Wed, 27 Nov 2019 08:54:10 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:36036 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726320AbfK0NyK (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 27 Nov 2019 08:54:10 -0500
Received: by mail-qt1-f194.google.com with SMTP id y10so25400259qto.3
        for <linux-s390@vger.kernel.org>; Wed, 27 Nov 2019 05:54:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=B8AdbwkolH/zZhIni1bfNeVxIM4SCQqBBGLNihqtq4k=;
        b=UMUZ5uIBB+/yf2ttfNNyKB03xeaf7fBour2E40Dlum/LB5P0LN0sdUowrAkAgtnnHO
         f53AMRdmdyEHPqp85m5Xp26jIE5VlmZm/y+01nTlV4dBn+sz5K/risEIyuyRbypHhDtS
         n+U8eNzA3W7b2JsN/wc1hMghtZLuLzC5MeiThjvJSm9DJWErzEUpL7nZWSJcdPpQvVqG
         F074glBrsV6nUgAesgDNxkPQxJpVV6ugeS8qbo2cwSJAQJuYbLxtB1DCHpXRb+aKWWiz
         Nt/CppCRI+PBuoB/JuzNfe1o7H5FpLaWG49+w49I0gqxCTbghpayGO7Oj1VyoSKeyv7C
         HnoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=B8AdbwkolH/zZhIni1bfNeVxIM4SCQqBBGLNihqtq4k=;
        b=St/2puMOHj45lHE4UBDN2qydjP/Sl7SXfjfKH9oIexgljMWKBp/XHMyjzA5r5VsbNw
         0BMaDJz0Tiqj0rZQ//4bw41moL9+nKF+Vk90L1yYEEtt+zqwUHRR0qgg6xz5KOPxoCvP
         xra8rYR/omogx6SUnZ8ck5ORqx1qQ9mpr/7myQJDMryKujF+aaG/A5Oo9XOkQP1Dar5v
         kIjz3fFnx2MI2Vw47I/fXpF8ZMTiHC72XcxxO3jXcVHuRLvawAfh20FlUWlXdlM7NsBw
         KStk8qYdIaH2qavlXAg4q5dtM3SZKQaA6mCC5pizkvnL6vIZBqC+cjWuLosJ/ruB/5D/
         DltA==
X-Gm-Message-State: APjAAAXhSp1+UC/z3queuQoos3CTOpaKsw1bKZtsrzeNaYNUijjYUign
        RX2uvaK0JY25VLTjO2pvaiwMqA==
X-Google-Smtp-Source: APXvYqzg2k38DbhBUIujL+npAV2fIIwB83882umXaPJTgDAPgB94SSphEydA3B9cm1UhSvaQ+FEYzg==
X-Received: by 2002:ac8:6644:: with SMTP id j4mr38249574qtp.213.1574862847474;
        Wed, 27 Nov 2019 05:54:07 -0800 (PST)
Received: from localhost ([2620:10d:c091:480::e4d7])
        by smtp.gmail.com with ESMTPSA id x1sm6824750qke.125.2019.11.27.05.54.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Nov 2019 05:54:06 -0800 (PST)
Date:   Wed, 27 Nov 2019 08:54:05 -0500
From:   Josef Bacik <josef@toxicpanda.com>
To:     David Sterba <dsterba@suse.cz>
Cc:     Josef Bacik <josef@toxicpanda.com>,
        Mikhail Zaslonko <zaslonko@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>,
        Richard Purdie <rpurdie@rpsys.net>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/5] btrfs: Increase buffer size for zlib functions
Message-ID: <20191127135405.326hmnja2sv3k2kh@macbook-pro-91.dhcp.thefacebook.com>
References: <20191126144130.75710-1-zaslonko@linux.ibm.com>
 <20191126144130.75710-6-zaslonko@linux.ibm.com>
 <20191126155249.j2dktiggykfoz4iz@MacBook-Pro-91.local>
 <20191127121423.GQ2734@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191127121423.GQ2734@suse.cz>
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Wed, Nov 27, 2019 at 01:14:23PM +0100, David Sterba wrote:
> On Tue, Nov 26, 2019 at 10:52:49AM -0500, Josef Bacik wrote:
> > On Tue, Nov 26, 2019 at 03:41:30PM +0100, Mikhail Zaslonko wrote:
> > > Due to the small size of zlib buffer (1 page) set in btrfs code, s390
> > > hardware compression is rather limited in terms of performance. Increasing
> > > the buffer size to 4 pages would bring significant benefit for s390
> > > hardware compression (up to 60% better performance compared to the
> > > PAGE_SIZE buffer) and should not bring much overhead in terms of memory
> > > consumption due to order 2 allocations.
> > > 
> > > Signed-off-by: Mikhail Zaslonko <zaslonko@linux.ibm.com>
> > 
> > We may have to make these allocations under memory pressure in the IO context,
> > order 2 allocations here is going to be not awesome.  If you really want it then
> > you need to at least be able to fall back to single page if you fail to get the
> > allocation.  Thanks,
> 
> The allocation is only for the workspace and it does not happen on the
> IO path for each call. There's the pool and if
> 
> btrfs_get_workspace
>   alloc_workspace
> 
> fails, then there's fallback path to wait for an existing workspace to
> be free.

Only if we are maxed out, otherwise it tries to allocate.  If it can happen it
will happen, and I'll be the guy swearing in the middle of the night trying to
deal with this making boxes fall over in production.  I'm ok if we pre-allocate
them first and only do 1 page on-demand, but having it always this way will bite
us in the ass in production.  Thanks,

Josef
