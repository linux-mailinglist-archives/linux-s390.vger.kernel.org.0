Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BDF18D1E20
	for <lists+linux-s390@lfdr.de>; Thu, 10 Oct 2019 04:04:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731134AbfJJCEm (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Wed, 9 Oct 2019 22:04:42 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:42975 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732252AbfJJCCY (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 9 Oct 2019 22:02:24 -0400
Received: by mail-pf1-f194.google.com with SMTP id q12so2834661pff.9
        for <linux-s390@vger.kernel.org>; Wed, 09 Oct 2019 19:02:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=FbH5/M1kecQb0plbAd/dEDw3t0kvnc34T2To18NEpXo=;
        b=UtlzfI0tLccGKmIdWg9sx90/N7dfUKvpSt2dxGBvzZcHiqHR6ejVlnBv7sY+H7Y8u5
         jfj71fne8PGRt3C//aAWr7o5WdlEJskXxuiefyoeDtC1rZV+CFLDyPxqPzzPPy0NsSy6
         +sB60oYcvdCeKeNgtsWDCMhF8AXjBqcls/KPSvyfXnRipMfhhadGsWUdURQF4hII01XR
         Tn/UCTqgpnrdNeK02wycBUegegEnBSPCz6oGK+6IMx4UQ/SXTz7RfJyRy/ySQyZMxUVp
         anuQLUe8rDzSrdI+MGgcE8Y5lxtY5RujyK0onYdGNU8vV7NCM7sC5ay+wgdRdORupkCh
         9S/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=FbH5/M1kecQb0plbAd/dEDw3t0kvnc34T2To18NEpXo=;
        b=CiExRZAH20xKpHjHGjYn93KmEsqcvSYog0ENjBa2gtMyTkP5cCZmK5j6f7F58pEcTo
         ax+QlBUtYiS+gLOmEYY6w7QB76HhqNvjO8K6WEwv+gTEv/RUveKmoUXgqaKEv1b7kfIw
         r+8vY2+Tk80TM4xXF200t6EYMUuQT2ltTiIiajghsgpdJmYQqLOaYO1k+38hOS3aLrR8
         GvOMPUqwORef/M4+cFOrNGC5ReIkAYOr9p2FvKXTWIq/7Y0JbAo1ydAkuo/ZLQD5UWXP
         eknNBw3KWDznsVcVWPIDRb+6K385f3/O3fakF363yyml3IFJY0Ne55n8sABKOhxbaeHv
         Hf4Q==
X-Gm-Message-State: APjAAAVU8VnDHAh8AqybiQZP7vLvUhS6DZDEKpfchRxgVkwAXq7dnORk
        dDRvx5f9qg22duCNTVhpUIhsBg==
X-Google-Smtp-Source: APXvYqxMtARq5aDsakYUWw19M1n5cuACR5SNjPQpNTVv6S3ZguHUColDn4ep8TA0yfaBW421SW6ZTg==
X-Received: by 2002:a63:1f58:: with SMTP id q24mr7172058pgm.298.1570672944094;
        Wed, 09 Oct 2019 19:02:24 -0700 (PDT)
Received: from cakuba.netronome.com (c-73-202-202-92.hsd1.ca.comcast.net. [73.202.202.92])
        by smtp.gmail.com with ESMTPSA id u9sm3490761pfl.138.2019.10.09.19.02.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2019 19:02:23 -0700 (PDT)
Date:   Wed, 9 Oct 2019 19:02:10 -0700
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     Karsten Graul <kgraul@linux.ibm.com>
Cc:     davem@davemloft.net, netdev@vger.kernel.org,
        linux-s390@vger.kernel.org, gor@linux.ibm.com,
        heiko.carstens@de.ibm.com, raspl@linux.ibm.com,
        ubraun@linux.ibm.com
Subject: Re: [PATCH net 0/3] net/smc: fixes for -net
Message-ID: <20191009190210.4592990b@cakuba.netronome.com>
In-Reply-To: <20191009080441.76077-1-kgraul@linux.ibm.com>
References: <20191009080441.76077-1-kgraul@linux.ibm.com>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Wed,  9 Oct 2019 10:04:38 +0200, Karsten Graul wrote:
> Fixes for -net, more info in commit logs.

Please write a sentence or two describing the nature of the fixes.
This message ends up in merge commits in the tree, pointing at the
commits themselves is unhelpful.

Please provide Fixes tags pointing at the commit which introduced the
bug in all of the patches.

Thank you.
