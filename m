Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4BF17DD265
	for <lists+linux-s390@lfdr.de>; Sat, 19 Oct 2019 00:13:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389699AbfJRWKH (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Fri, 18 Oct 2019 18:10:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:42934 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389673AbfJRWKG (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Fri, 18 Oct 2019 18:10:06 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1FD2B22474;
        Fri, 18 Oct 2019 22:10:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571436605;
        bh=JRJyAaXRNWqpl26dWw+2me9hgFmc8J7yvtbT0XQ5nbo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BXO/y7nEj/oWDl/Y9zaNFQ0w8/67sOtU5Tj6zwOViQym9089tKiwyL94IbJU6ItyP
         g9WeuFq1mmKFM5j7fE2q0AZRn3TTMpTGc9dtwAtzJZmMNPvzFymCuZ9gqr83EFk2hB
         /Mdv00Km9MsygI0YWzkgm8jt7ShTALpVkoXwGBFw=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Christian Borntraeger <borntraeger@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Sasha Levin <sashal@kernel.org>, linux-s390@vger.kernel.org
Subject: [PATCH AUTOSEL 4.9 28/29] s390/uaccess: avoid (false positive) compiler warnings
Date:   Fri, 18 Oct 2019 18:09:19 -0400
Message-Id: <20191018220920.10545-28-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191018220920.10545-1-sashal@kernel.org>
References: <20191018220920.10545-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

From: Christian Borntraeger <borntraeger@de.ibm.com>

[ Upstream commit 062795fcdcb2d22822fb42644b1d76a8ad8439b3 ]

Depending on inlining decisions by the compiler, __get/put_user_fn
might become out of line. Then the compiler is no longer able to tell
that size can only be 1,2,4 or 8 due to the check in __get/put_user
resulting in false positives like

./arch/s390/include/asm/uaccess.h: In function ‘__put_user_fn’:
./arch/s390/include/asm/uaccess.h:113:9: warning: ‘rc’ may be used uninitialized in this function [-Wmaybe-uninitialized]
  113 |  return rc;
      |         ^~
./arch/s390/include/asm/uaccess.h: In function ‘__get_user_fn’:
./arch/s390/include/asm/uaccess.h:143:9: warning: ‘rc’ may be used uninitialized in this function [-Wmaybe-uninitialized]
  143 |  return rc;
      |         ^~

These functions are supposed to be always inlined. Mark it as such.

Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: Vasily Gorbik <gor@linux.ibm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/s390/include/asm/uaccess.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/s390/include/asm/uaccess.h b/arch/s390/include/asm/uaccess.h
index a7ef702201260..31b2913372b56 100644
--- a/arch/s390/include/asm/uaccess.h
+++ b/arch/s390/include/asm/uaccess.h
@@ -151,7 +151,7 @@ unsigned long __must_check __copy_to_user(void __user *to, const void *from,
 	__rc;							\
 })
 
-static inline int __put_user_fn(void *x, void __user *ptr, unsigned long size)
+static __always_inline int __put_user_fn(void *x, void __user *ptr, unsigned long size)
 {
 	unsigned long spec = 0x810000UL;
 	int rc;
@@ -181,7 +181,7 @@ static inline int __put_user_fn(void *x, void __user *ptr, unsigned long size)
 	return rc;
 }
 
-static inline int __get_user_fn(void *x, const void __user *ptr, unsigned long size)
+static __always_inline int __get_user_fn(void *x, const void __user *ptr, unsigned long size)
 {
 	unsigned long spec = 0x81UL;
 	int rc;
-- 
2.20.1

