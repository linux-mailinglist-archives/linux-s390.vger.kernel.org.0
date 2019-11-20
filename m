Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 966F81044AC
	for <lists+linux-s390@lfdr.de>; Wed, 20 Nov 2019 20:56:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727702AbfKTT4V (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Wed, 20 Nov 2019 14:56:21 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:40086 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727305AbfKTT4V (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 20 Nov 2019 14:56:21 -0500
Received: by mail-qk1-f196.google.com with SMTP id z16so930998qkg.7
        for <linux-s390@vger.kernel.org>; Wed, 20 Nov 2019 11:56:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6PqYdDpGGWCVE8hu3feKwX1cy6I6vx26jAUo36ByRBc=;
        b=MZEMAgymPpZPMZFpCP0c+tUdsx1npLc9lS3L/V9/tx62cvHYOeIPRnzn7p717XyhAm
         KHi54PubUolzF062CMNG+QkztdlBCa7wbspw1gLZmLlo3X0wlY5H6n6AEG6FRE0B/H23
         BwxTLLSFA3mRWpmL4bkoHrYY9LQUFF2xKADYrGrZEeFWj4DsouiRMvYEctSUBmdSDCVp
         WSC7oPn+3jSUTY+5KCv/PsFm9FRKMSZrcLZ9tTtROPTg0SMHdos/Y4JWidv7RMzCy7C2
         rY7CtlEh2VfFEDq1ay7a/Dz61hnBUhCGYvgtugs6v4hCrQuw8ClqztIVHOImNSN25+Hs
         9lcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6PqYdDpGGWCVE8hu3feKwX1cy6I6vx26jAUo36ByRBc=;
        b=iuf9OGJL1n4N1SSWPQySGo13jgR86XjxeUecZmh+l7xGLUTPSCvbVq/YDSNTuWAIGo
         gcdz2/BfkHaV0jaL7GYqkoo4lfTWIJ7HgouZk+8kAnbKRmM/Suzz7Kf7OQjxYs3vnzYh
         XxBRfh5ucaPNWIYokdFsBJATEzMC/ulhVEJwTIUwnKXCVsLsDr1ZHeVGuRAve4OA5UFV
         k111N5VTtugARFSyefYT4M7TmRMH1IgaR/abxV7UBW0BlOIh6T6b/OnU8u1xzh7rU0To
         vcsH+nBjoMinv5lqTToO0wi6wdodczGZa5IWVm7HVfAaLpAbLryEBXDYOI8E1YsALHpg
         TfTA==
X-Gm-Message-State: APjAAAVNfptCYu6LM47cXQRoGsTgjsV2bTVK9EDKsh6peF9/R2SCu5dP
        8yh+x+czkheb7I6asEytGaqtnQ==
X-Google-Smtp-Source: APXvYqxTzh/k0kFIiA5WJFz9zsIz55dG8h+cL5MqwavoO2RPkWMLuNhyp7KDW/Zj2h3ECyUR3vQAKw==
X-Received: by 2002:a05:620a:648:: with SMTP id a8mr4058641qka.426.1574279780352;
        Wed, 20 Nov 2019 11:56:20 -0800 (PST)
Received: from dhcp-41-57.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id t2sm146241qkt.95.2019.11.20.11.56.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Nov 2019 11:56:19 -0800 (PST)
Message-ID: <1574279778.9585.15.camel@lca.pw>
Subject: Re: [PATCH -next] writeback: fix -Wformat compilation warnings
From:   Qian Cai <cai@lca.pw>
To:     Tejun Heo <tj@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     jack@suse.cz, gregkh@linuxfoundation.org, cgroups@vger.kernel.org,
        heiko.carstens@de.ibm.com, gor@linux.ibm.com,
        borntraeger@de.ibm.com, linux-s390@vger.kernel.org,
        axboe@kernel.dk, linux-kernel@vger.kernel.org
Date:   Wed, 20 Nov 2019 14:56:18 -0500
In-Reply-To: <20191115145540.GP4163745@devbig004.ftw2.facebook.com>
References: <20191114192118.GK4163745@devbig004.ftw2.facebook.com>
         <9D52EBB0-BE48-4C59-9145-857C3247B20D@lca.pw>
         <20191115145540.GP4163745@devbig004.ftw2.facebook.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 (3.22.6-10.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Fri, 2019-11-15 at 06:55 -0800, Tejun Heo wrote:
> On Thu, Nov 14, 2019 at 07:26:21PM -0500, Qian Cai wrote:
> > 
> > 
> > > On Nov 14, 2019, at 2:21 PM, Tejun Heo <tj@kernel.org> wrote:
> > > 
> > > Acked-by: Tejun Heo <tj@kernel.org>
> > 
> > Tejun, suppose you will take this patch via your tree together with the series or should I Cc Andrew who normally handle this file?
> 
> Patches in this area usually goes through Jens's block tree.

I remember that last time Jens had no interests in picking up trivial patches
like this one. See the commit d1a445d3b86c ("include/trace/events/writeback.h:
fix -Wstringop-truncation warnings").

Andrew, care to pick up this again?

https://lore.kernel.org/lkml/1573751861-10303-1-git-send-email-cai@lca.pw/
