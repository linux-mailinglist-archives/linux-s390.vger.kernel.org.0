Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 784A345AE35
	for <lists+linux-s390@lfdr.de>; Tue, 23 Nov 2021 22:17:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239613AbhKWVUZ (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Tue, 23 Nov 2021 16:20:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239691AbhKWVUR (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 23 Nov 2021 16:20:17 -0500
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38CC5C061714
        for <linux-s390@vger.kernel.org>; Tue, 23 Nov 2021 13:17:09 -0800 (PST)
Received: by mail-pf1-x434.google.com with SMTP id x5so608120pfr.0
        for <linux-s390@vger.kernel.org>; Tue, 23 Nov 2021 13:17:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PQeh1LIqbqFtSovgn5WZ7VLYBwfefd3KuHYAxcJ6bdE=;
        b=z/Kv5aF3II2Q1LX6Aazu4oeYGV1DsHDm6VPftSCm/GsXUqcvpUYlHGhNQfvcAEzM+t
         KHEErzvzy9AE7efI2veDZidjjq+fK6s2UJs7fEhnYmQiPFx9rvXEwel822roodlc/FcK
         DEv5SfZdo4Mf/qMs7Jb75ZFTHTDu0awILjq9sqTvXs+VIsFn7y/1XB/C+/lY4NwLFtHP
         cHAfa2a7eS26AcezybSCXTWBbxiGPri9iUr8Wx/IV+DiOD4YHSNiMvTZGqn4/3tFE8gU
         fEqZVpI1Dt83hXy63DNbfv4vosQWDr6RKn8ZmI1PKEqbMIgBEyzoH/HXIZQqJ3XqzuZq
         V9lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PQeh1LIqbqFtSovgn5WZ7VLYBwfefd3KuHYAxcJ6bdE=;
        b=FJVWuQs78ZWwFK4gTQoGIBTtkGgt553EVVGwDG56VrQj95t4UVWUWIsIVp2Am4hII4
         Al5L9c+XNS6IL2dYhTLf2IGpSH02oZfa+AXVYPBC30yY6WkHROo2/og30205NeAg7gO/
         RaGlbdYznRjvX0OvSsYLP8EGrhUjCddojamr0RE9/sal3U57w+E48lhuqmTBv3jl8C3y
         jaLS9eJB/XkODJQrHtMa8PlncjJvPvXQ361lAAYC6fIjo/N2F7gacfuFA4kD0NsPvAGE
         XNqcBjiWYt6lRU/K/9PtA6eRqgfoS7StrSQlDqgBxkXQVy9w3W5S25/UNeI5wrKSM6Pr
         12RQ==
X-Gm-Message-State: AOAM5307Zs2YFTQqaQVRRhmzhGhUdL3wr6V5cCmMo4gdu1i98JY7zN3L
        RhARHrh49ofBVzEQv4O2SVQc/y+5Fnalzk2mynoKPQ==
X-Google-Smtp-Source: ABdhPJxo6xmNJWXyaaVPBEUy4anrM6xGk5zJ5S54bOFTPTbJYWg88+GG8ODe3guk693xmG8x/Zkzy+Ul3gB1uuDCJIA=
X-Received: by 2002:a63:5401:: with SMTP id i1mr6112849pgb.356.1637702228750;
 Tue, 23 Nov 2021 13:17:08 -0800 (PST)
MIME-Version: 1.0
References: <20211109083309.584081-1-hch@lst.de> <20211109083309.584081-17-hch@lst.de>
In-Reply-To: <20211109083309.584081-17-hch@lst.de>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 23 Nov 2021 13:16:58 -0800
Message-ID: <CAPcyv4jjvoT=aW+_Ks+8L60HG0ypesSi8A+a5F2JXu1dEWHVCw@mail.gmail.com>
Subject: Re: [PATCH 16/29] fsdax: simplify the offset check in dax_iomap_zero
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

On Tue, Nov 9, 2021 at 12:34 AM Christoph Hellwig <hch@lst.de> wrote:
>
> The file relative offset must have the same alignment as the storage
> offset, so use that and get rid of the call to iomap_sector.

Agree.

Reviewed-by: Dan Williams <dan.j.williams@intel.com>
