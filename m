Return-Path: <linux-s390+bounces-5280-lists+linux-s390=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CFA2944A82
	for <lists+linux-s390@lfdr.de>; Thu,  1 Aug 2024 13:37:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C94A7B21113
	for <lists+linux-s390@lfdr.de>; Thu,  1 Aug 2024 11:37:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6998D18E045;
	Thu,  1 Aug 2024 11:37:44 +0000 (UTC)
X-Original-To: linux-s390@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 336B2189B95;
	Thu,  1 Aug 2024 11:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722512264; cv=none; b=s6nxN8mWWIvgFkBAlHY/XosoLfdETSEKDORJz2+Rv55xrI/LqA9S2YfYWn9FV1NVbzb909tLNi0GGbQcc+I7/CO7TLsTOZvnPYvai1ylKDTFrxwgNhsIm+v8IyDr8IHvjoFgQeac8pVSST94we7DT9E0o6YV3fCSlnTcvnHh020=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722512264; c=relaxed/simple;
	bh=J403FPHz5mdD+eBsT2Z07rNmO+DYQwC1asI2XEI/9Mo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=XiC69HiqmXyJjhgeh8ZVT3yWSiM0gXd+MBpThTft5tAQ4U8lDwuc+BgLuSqiqXzlqnYGb4lfnuKQPuk+4Wtjhw26H6tOaOXI4ozw5hkwVOKq6ypkJrPnDS6KGilVYfCD3rayqGdxA3+nbJ8t4dSCCwcAgqmT1SV8uTIfYTVQSg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4WZRkX3cvpznd3p;
	Thu,  1 Aug 2024 19:36:36 +0800 (CST)
Received: from dggpeml500026.china.huawei.com (unknown [7.185.36.106])
	by mail.maildlp.com (Postfix) with ESMTPS id 85EFE140109;
	Thu,  1 Aug 2024 19:37:37 +0800 (CST)
Received: from huawei.com (10.175.101.6) by dggpeml500026.china.huawei.com
 (7.185.36.106) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 1 Aug
 2024 19:37:36 +0800
From: Zhengchao Shao <shaozhengchao@huawei.com>
To: <linux-s390@vger.kernel.org>, <netdev@vger.kernel.org>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>
CC: <wenjia@linux.ibm.com>, <jaka@linux.ibm.com>, <alibuda@linux.alibaba.com>,
	<tonylu@linux.alibaba.com>, <guwen@linux.alibaba.com>,
	<weiyongjun1@huawei.com>, <yuehaibing@huawei.com>, <shaozhengchao@huawei.com>
Subject: [PATCH net-next] net/smc: add the max value of fallback reason count
Date: Thu, 1 Aug 2024 19:35:49 +0800
Message-ID: <20240801113549.98301-1-shaozhengchao@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpeml500026.china.huawei.com (7.185.36.106)

The number of fallback reasons defined in the smc_clc.h file has reached
36. For historical reasons, some are no longer quoted, and there's 33
actually in use. So, add the max value of fallback reason count to 50.

Signed-off-by: Zhengchao Shao <shaozhengchao@huawei.com>
---
 net/smc/smc_stats.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/smc/smc_stats.h b/net/smc/smc_stats.h
index 9d32058db2b5..ab5aafc6f44c 100644
--- a/net/smc/smc_stats.h
+++ b/net/smc/smc_stats.h
@@ -19,7 +19,7 @@
 
 #include "smc_clc.h"
 
-#define SMC_MAX_FBACK_RSN_CNT 30
+#define SMC_MAX_FBACK_RSN_CNT 50
 
 enum {
 	SMC_BUF_8K,
-- 
2.34.1


