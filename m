Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DA2A454C58
	for <lists+linux-s390@lfdr.de>; Wed, 17 Nov 2021 18:44:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239569AbhKQRri (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Wed, 17 Nov 2021 12:47:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239559AbhKQRrh (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 17 Nov 2021 12:47:37 -0500
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33B9AC061766
        for <linux-s390@vger.kernel.org>; Wed, 17 Nov 2021 09:44:39 -0800 (PST)
Received: by mail-pg1-x52e.google.com with SMTP id h63so2882030pgc.12
        for <linux-s390@vger.kernel.org>; Wed, 17 Nov 2021 09:44:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+uFdsysPKBJg8+GUKCjjrR+fu42d0RKVIlJ5p5O3Gqw=;
        b=AhgC+2wjkr5d9yDLbCved4jaDjwAVOHHegPWWTmEA1k+UoMOMYjm4jdejJ0FNzHR6s
         c5CZZTpF5RcDbQWqOsFLQ+5n3WzHTDlujVf/JCPu7XZBET18Z8qLE0BanPT0rnfK5Zu9
         KyIvCY0B/udnAqmbfZZUOtpDWwYOaZvFxMVOaWJLK5nqRMnfBvKrqK4xPQYQJSiLOVa8
         0rlfBALzCZrz1lMqwQv6qq3GRi5Jd7hsx8WgDG14wOcf8TDRiDnZ6oCTTfiQ53aT4YRB
         Vf3FTTZZnWUbXVIHLEPwTQXniddBnZWJsqT6SgaoHFJDwC1BLNE6VpCGlp3JGhptmlcC
         V9cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+uFdsysPKBJg8+GUKCjjrR+fu42d0RKVIlJ5p5O3Gqw=;
        b=7hCJvctSFpumnU3YxzYIBidhCOyAxX6bGxjWhCk0iWVlolQ4wnUPMF75Kt9m8SjHDR
         1W2Iba/6TDgGEEzy3KCo5YINBbTJax6bW5NqqWnQ9rOkjrhwryPuQFRhuS94ZId+z3GY
         PHNLmV7ymTAp/p1cXEZ3XRPVXRzCdYoXR+qYPB41pxgaTV1yeBNitQTliVdaubmMOJ45
         3BkgFBKdQw2HS0zAmnsODHBjL5/rbE/OxM2xQU0Pd5DdT8AX792v3QacXm8J7k6msWrF
         Izm+7V6sojiCny7aRyRanx7BmQJCc4XNRs5cVws38AKNUWsg9P/fu5Af8m4IQUP5DKag
         wzVA==
X-Gm-Message-State: AOAM530yN5tHBh6XZyn9SUtReg6cwrIeDv7MATtdaKq3LlpKlPtBnWMt
        Z1O2ZSc7sXfFUpVpkIthdBKlKZUkyctqkg+ecUE4mA==
X-Google-Smtp-Source: ABdhPJxiiB8Ak1RjXFinVMdC+8Tb3rrtEkfJ8k6NlxRhm42dcgWCdDR0kkUYUFwrF8G9DBBrfo1Xmvo4+uUGPt+QmE4=
X-Received: by 2002:aa7:8d0a:0:b0:4a2:82d7:1695 with SMTP id
 j10-20020aa78d0a000000b004a282d71695mr37260918pfe.86.1637171078758; Wed, 17
 Nov 2021 09:44:38 -0800 (PST)
MIME-Version: 1.0
References: <20211109083309.584081-1-hch@lst.de> <20211109083309.584081-2-hch@lst.de>
In-Reply-To: <20211109083309.584081-2-hch@lst.de>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 17 Nov 2021 09:44:25 -0800
Message-ID: <CAPcyv4ijKTcABMs2tZEuPWo1WDOux+4XWN=DNF5v8SrQRSbfDg@mail.gmail.com>
Subject: Re: [PATCH 01/29] nvdimm/pmem: move dax_attribute_group from dax to pmem
To:     Christoph Hellwig <hch@lst.de>
Cc:     Mike Snitzer <snitzer@redhat.com>, Ira Weiny <ira.weiny@intel.com>,
        device-mapper development <dm-devel@redhat.com>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        Linux NVDIMM <nvdimm@lists.linux.dev>,
        linux-s390 <linux-s390@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-erofs@lists.ozlabs.org,
        linux-ext4 <linux-ext4@vger.kernel.org>,
        virtualization@lists.linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Tue, Nov 9, 2021 at 12:33 AM Christoph Hellwig <hch@lst.de> wrote:
>
> dax_attribute_group is only used by the pmem driver, and can avoid the
> completely pointless lookup by the disk name if moved there.  This
> leaves just a single caller of dax_get_by_host, so move dax_get_by_host
> into the same ifdef block as that caller.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Dan Williams <dan.j.williams@intel.com>
> Link: https://lore.kernel.org/r/20210922173431.2454024-3-hch@lst.de
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

This one already made v5.16-rc1.
