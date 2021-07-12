Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A904A3C4B08
	for <lists+linux-s390@lfdr.de>; Mon, 12 Jul 2021 12:36:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239513AbhGLGz0 (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Mon, 12 Jul 2021 02:55:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:49904 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239993AbhGLGuK (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Mon, 12 Jul 2021 02:50:10 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1FF4560241;
        Mon, 12 Jul 2021 06:47:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1626072441;
        bh=gzhXpDsp0afo7XKHsTFQbbp4JDYZz4RlN1QSALguuyA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GSiWnr1QpJLvnQT3YrqYDqB6EUceEJ+stfHsm0Hp9UxkFdJKH/fTUPfwnY1AQB9JH
         ywtGpdlZ4HJwat/evpZ3ESWHjHj6eynpQvFUg3AdrcwUmq55YGSnV2eEGDaVrBQZl9
         FHK8iiM7DXYH/Dymk+qZEGzL/7rindNyNFTwJ1Uk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-s390@vger.kernel.org, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 498/593] s390: appldata depends on PROC_SYSCTL
Date:   Mon, 12 Jul 2021 08:10:58 +0200
Message-Id: <20210712060946.273745483@linuxfoundation.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210712060843.180606720@linuxfoundation.org>
References: <20210712060843.180606720@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

[ Upstream commit 5d3516b3647621d5a1180672ea9e0817fb718ada ]

APPLDATA_BASE should depend on PROC_SYSCTL instead of PROC_FS.
Building with PROC_FS but not PROC_SYSCTL causes a build error,
since appldata_base.c uses data and APIs from fs/proc/proc_sysctl.c.

arch/s390/appldata/appldata_base.o: in function `appldata_generic_handler':
appldata_base.c:(.text+0x192): undefined reference to `sysctl_vals'

Fixes: c185b783b099 ("[S390] Remove config options.")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Heiko Carstens <hca@linux.ibm.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: linux-s390@vger.kernel.org
Signed-off-by: Vasily Gorbik <gor@linux.ibm.com>
Link: https://lore.kernel.org/r/20210528002420.17634-1-rdunlap@infradead.org
Signed-off-by: Vasily Gorbik <gor@linux.ibm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/s390/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
index 7105d44a335b..896b68e541b2 100644
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -858,7 +858,7 @@ config CMM_IUCV
 config APPLDATA_BASE
 	def_bool n
 	prompt "Linux - VM Monitor Stream, base infrastructure"
-	depends on PROC_FS
+	depends on PROC_SYSCTL
 	help
 	  This provides a kernel interface for creating and updating z/VM APPLDATA
 	  monitor records. The monitor records are updated at certain time
-- 
2.30.2



