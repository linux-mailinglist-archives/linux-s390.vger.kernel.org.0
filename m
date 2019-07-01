Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D019A30BB8
	for <lists+linux-s390@lfdr.de>; Fri, 31 May 2019 11:36:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726233AbfEaJgd (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Fri, 31 May 2019 05:36:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57114 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726232AbfEaJgc (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Fri, 31 May 2019 05:36:32 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id BA36C30C120A;
        Fri, 31 May 2019 09:36:32 +0000 (UTC)
Received: from t460s.redhat.com (ovpn-116-233.ams2.redhat.com [10.36.116.233])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1E29A1017E33;
        Fri, 31 May 2019 09:36:28 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-s390@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, David Hildenbrand <david@redhat.com>,
        Harald Freudenberger <freude@linux.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH v1] s390/pkey: Use -ENODEV instead of -EOPNOTSUPP
Date:   Fri, 31 May 2019 11:36:28 +0200
Message-Id: <20190531093628.14766-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Fri, 31 May 2019 09:36:32 +0000 (UTC)
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

systemd-modules-load.service automatically tries to load the pkey module
on systems that have MSA.

Pkey also requires the MSA3 facility and a bunch of subfunctions.
Failing with -EOPNOTSUPP makes "systemd-modules-load.service" fail on
any system that does not have all needed subfunctions. For example,
when running under QEMU TCG (but also on systems where protected keys
are disabled via the HMC).

Let's use -ENODEV, so systemd-modules-load.service properly ignores
failing to load the pkey module because of missing HW functionality.

Cc: Harald Freudenberger <freude@linux.ibm.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Cornelia Huck <cohuck@redhat.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 drivers/s390/crypto/pkey_api.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/s390/crypto/pkey_api.c b/drivers/s390/crypto/pkey_api.c
index 45eb0c14b880..ddfcefb47284 100644
--- a/drivers/s390/crypto/pkey_api.c
+++ b/drivers/s390/crypto/pkey_api.c
@@ -1695,15 +1695,15 @@ static int __init pkey_init(void)
 	 * are able to work with protected keys.
 	 */
 	if (!cpacf_query(CPACF_PCKMO, &pckmo_functions))
-		return -EOPNOTSUPP;
+		return -ENODEV;
 
 	/* check for kmc instructions available */
 	if (!cpacf_query(CPACF_KMC, &kmc_functions))
-		return -EOPNOTSUPP;
+		return -ENODEV;
 	if (!cpacf_test_func(&kmc_functions, CPACF_KMC_PAES_128) ||
 	    !cpacf_test_func(&kmc_functions, CPACF_KMC_PAES_192) ||
 	    !cpacf_test_func(&kmc_functions, CPACF_KMC_PAES_256))
-		return -EOPNOTSUPP;
+		return -ENODEV;
 
 	pkey_debug_init();
 
-- 
2.20.1

