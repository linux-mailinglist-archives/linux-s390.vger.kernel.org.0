Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18F1A4807B8
	for <lists+linux-s390@lfdr.de>; Tue, 28 Dec 2021 10:20:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233131AbhL1JUx (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Tue, 28 Dec 2021 04:20:53 -0500
Received: from out30-56.freemail.mail.aliyun.com ([115.124.30.56]:51016 "EHLO
        out30-56.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231370AbhL1JUx (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 28 Dec 2021 04:20:53 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R931e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04395;MF=guwen@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0V057EhM_1640683240;
Received: from e02h04404.eu6sqa(mailfrom:guwen@linux.alibaba.com fp:SMTPD_---0V057EhM_1640683240)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 28 Dec 2021 17:20:50 +0800
From:   Wen Gu <guwen@linux.alibaba.com>
To:     kgraul@linux.ibm.com, davem@davemloft.net, kuba@kernel.org
Cc:     linux-s390@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, dust.li@linux.alibaba.com,
        tonylu@linux.alibaba.com
Subject: [RFC PATCH net 0/2] net/smc: Fix for race in smc link group termination
Date:   Tue, 28 Dec 2021 17:20:38 +0800
Message-Id: <1640683240-62472-1-git-send-email-guwen@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

We encountered some crashes recently and they are caused by the
race between the access and free of link/link group in smc link
group termination. The crashes can be reproduced in frequent
abnormal link group termination, like set RNICs up/down.

This set of patches tries to fix this by extending the life cycle
of link/link group to ensure that they won't be referred to after
cleared or freed.

Best wishes,
Wen Gu

Wen Gu (2):
  net/smc: Resolve the race between link group access and termination
  net/smc: Resolve the race between SMC-R link access and clear

 net/smc/smc.h      |  1 +
 net/smc/smc_core.c | 80 ++++++++++++++++++++++++++++++++++++++++++++++++------
 net/smc/smc_core.h |  7 +++++
 3 files changed, 79 insertions(+), 9 deletions(-)

-- 
1.8.3.1

