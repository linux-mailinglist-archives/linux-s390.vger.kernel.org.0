Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3521023D211
	for <lists+linux-s390@lfdr.de>; Wed,  5 Aug 2020 22:09:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729098AbgHEUIl (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Wed, 5 Aug 2020 16:08:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:49780 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726869AbgHEQce (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Wed, 5 Aug 2020 12:32:34 -0400
Received: from localhost.localdomain (unknown [194.230.155.117])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4FE192245C;
        Wed,  5 Aug 2020 15:51:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596642663;
        bh=jWj0WeLI2bTZqXoSzm4YiO4duySDXE/ANme0mZDkCFY=;
        h=From:To:Subject:Date:From;
        b=FuyXtPOokL9dq42pPtPfpND3C18XqEmSHiQOVmG3R63oIyrvLDa7yESzWRa/Z071N
         Fa89RISm272D1o+zizen/LZR8qqA7JH4v4Zu+6b4Y1mwWCEJK23UM/KRQV7/lbifxO
         /f7VoKAnW8uqTMY3eC33gWgTx9Mgo8r8mPcpuqfY=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Joerg Roedel <jroedel@suse.de>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] s390/Kconfig: add missing ZCRYPT dependency to VFIO_AP
Date:   Wed,  5 Aug 2020 17:50:53 +0200
Message-Id: <20200805155053.3739-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

The VFIO_AP uses ap_driver_register() (and deregister) functions
implemented in ap_bus.c (compiled into ap.o).  However the ap.o will be
built only if CONFIG_ZCRYPT is selected.

This was not visible before commit e93a1695d7fb ("iommu: Enable compile
testing for some of drivers") because the CONFIG_VFIO_AP depends on
CONFIG_S390_AP_IOMMU which depends on the missing CONFIG_ZCRYPT.  After
adding COMPILE_TEST, it is possible to select a configuration with
VFIO_AP and S390_AP_IOMMU but without the ZCRYPT.

Add proper dependency to the VFIO_AP to fix build errors:

ERROR: modpost: "ap_driver_register" [drivers/s390/crypto/vfio_ap.ko] undefined!
ERROR: modpost: "ap_driver_unregister" [drivers/s390/crypto/vfio_ap.ko] undefined!

Reported-by: kernel test robot <lkp@intel.com>
Fixes: e93a1695d7fb ("iommu: Enable compile testing for some of drivers")
Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/s390/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
index 8c0b52940165..2a31a5e74e42 100644
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -766,6 +766,7 @@ config VFIO_AP
 	def_tristate n
 	prompt "VFIO support for AP devices"
 	depends on S390_AP_IOMMU && VFIO_MDEV_DEVICE && KVM
+	depends on ZCRYPT
 	help
 		This driver grants access to Adjunct Processor (AP) devices
 		via the VFIO mediated device interface.
-- 
2.17.1

