Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AB2A459AC0
	for <lists+linux-s390@lfdr.de>; Tue, 23 Nov 2021 04:51:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231150AbhKWDyf (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Mon, 22 Nov 2021 22:54:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229802AbhKWDye (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 22 Nov 2021 22:54:34 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29A97C061714
        for <linux-s390@vger.kernel.org>; Mon, 22 Nov 2021 19:51:27 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id h24so15529909pjq.2
        for <linux-s390@vger.kernel.org>; Mon, 22 Nov 2021 19:51:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=set6lIbZWt1UwkjEncJQUmHWp82483Zo0VHgKUnBt0w=;
        b=jaUppntJAg9/mAuYY2fdr9gBd/oPSVvQjQU9MV63keKS4G12JP+nEpEbf/XFgQhTnX
         lYhroHBz4A/n/ueNjXRdi4PGz3IaMMWx7LGsyQ+k3PmsLBwgA59MgQmr1YDS9DWkwjiz
         h84Lz9nQApqhFCv5vhWhKtFCwv3whkuknXHpmp6xY5puSg20rPurJJzE+22u3JyTEE6e
         V2urCXYlCDQCwVaaqgneBsM+4H995+ijZVTqf+fHfdEatR6QlNecFf1J/UGHfHqEPUgZ
         uA/eGzna5QhHm2jHR+WAFoVlyr/aaF9uDy12SjgTOzdukRcbvTwMgK4DzpeCeqXvlNDK
         as+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=set6lIbZWt1UwkjEncJQUmHWp82483Zo0VHgKUnBt0w=;
        b=V/UT55Kf8wbXHVbgPkCTGwLCf7hTR+JElZjL7+0yAxRZtH1+N0dE94IzMKT1AULh6Q
         PnJI3a/OSUKeFmY/qRSb82FeJ7oStTdnZPqHmOgDMCmSkx5tDS+SwASdLt3jvy4Kd8Dq
         vm86MUpf6qkpSZPGCq5ixSx4QJbJ9ax/HJzL8HplmZL+bD7wy86cgHf/s1hmc5eBSDCB
         5xEQg1duJn5OBWf5nxbng0CQ9DuHAxZHvxOotmV/dBAKorYfbLgZ4hCZDBnlhu8aN8XN
         aA9aL+9LaDrRQioI8j8sUxvUcvpK+N+HcyrMYKyBKFu0Y5aeDLNJRLuJ5XZGAbao75Hg
         7gTQ==
X-Gm-Message-State: AOAM5303XyuhJoEkV9Q62TvBfUPgGArLK5kYAJAs41OppfMRfX/EWQA7
        eAxkipWVxoR1ddGhYM4UJlPJa7iZP667gXo0/dLBoA==
X-Google-Smtp-Source: ABdhPJwgdeM7vJZ2DKKwalEr7KeonINU2K18nZr67CpB7ixzXQKpSb7Eol7dgHhzUPEgLb+CGDYy92xBtwbeaxDZs1M=
X-Received: by 2002:a17:902:6acb:b0:142:76c3:d35f with SMTP id
 i11-20020a1709026acb00b0014276c3d35fmr2967201plt.89.1637639486743; Mon, 22
 Nov 2021 19:51:26 -0800 (PST)
MIME-Version: 1.0
References: <20211109083309.584081-1-hch@lst.de> <20211109083309.584081-8-hch@lst.de>
In-Reply-To: <20211109083309.584081-8-hch@lst.de>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 22 Nov 2021 19:51:15 -0800
Message-ID: <CAPcyv4jnLdFaDwLTeRhJcTzyjd-psZRgWqVDqzOAZr3EGLbF2w@mail.gmail.com>
Subject: Re: [PATCH 07/29] xfs: factor out a xfs_setup_dax_always helper
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
> Factor out another DAX setup helper to simplify future changes.  Also
> move the experimental warning after the checks to not clutter the log
> too much if the setup failed.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Dan Williams <dan.j.williams@intel.com>
