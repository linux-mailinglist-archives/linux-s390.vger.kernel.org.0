Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3B77B161611
	for <lists+linux-s390@lfdr.de>; Mon, 17 Feb 2020 16:25:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728883AbgBQPZI (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Mon, 17 Feb 2020 10:25:08 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:49892 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728794AbgBQPZI (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 17 Feb 2020 10:25:08 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01HFKqLO144889
        for <linux-s390@vger.kernel.org>; Mon, 17 Feb 2020 10:25:07 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2y6e1gh690-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Mon, 17 Feb 2020 10:25:07 -0500
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <ubraun@linux.ibm.com>;
        Mon, 17 Feb 2020 15:25:05 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 17 Feb 2020 15:25:01 -0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 01HFOwWQ44499062
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 17 Feb 2020 15:24:58 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2DEF8A4040;
        Mon, 17 Feb 2020 15:24:58 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D6AAFA4053;
        Mon, 17 Feb 2020 15:24:57 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 17 Feb 2020 15:24:57 +0000 (GMT)
From:   Ursula Braun <ubraun@linux.ibm.com>
To:     davem@davemloft.net
Cc:     netdev@vger.kernel.org, linux-s390@vger.kernel.org,
        heiko.carstens@de.ibm.com, raspl@linux.ibm.com,
        kgraul@linux.ibm.com, ubraun@linux.ibm.com
Subject: [PATCH net-next 1/6] net/smc: improve smc_lgr_cleanup()
Date:   Mon, 17 Feb 2020 16:24:50 +0100
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200217152455.15341-1-ubraun@linux.ibm.com>
References: <20200217152455.15341-1-ubraun@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 20021715-0012-0000-0000-00000387A8C5
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20021715-0013-0000-0000-000021C43651
Message-Id: <20200217152455.15341-2-ubraun@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-17_10:2020-02-17,2020-02-17 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 priorityscore=1501 spamscore=0 adultscore=0 mlxscore=0
 impostorscore=0 malwarescore=0 phishscore=0 suspectscore=1 mlxlogscore=780
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002170126
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

From: Karsten Graul <kgraul@linux.ibm.com>

smc_lgr_cleanup() is called during termination processing, there is no
need to send a DELETE_LINK at that time. A DELETE_LINK should have been
sent before the termination is initiated, if needed.
And remove the extra call to wake_up(&lnk->wr_reg_wait) because
smc_llc_link_inactive() already calls the related helper function
smc_wr_wakeup_reg_wait().

Signed-off-by: Karsten Graul <kgraul@linux.ibm.com>
Signed-off-by: Ursula Braun <ubraun@linux.ibm.com>
---
 net/smc/smc_core.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/net/smc/smc_core.c b/net/smc/smc_core.c
index 2249de5379ee..8f3c1fced334 100644
--- a/net/smc/smc_core.c
+++ b/net/smc/smc_core.c
@@ -576,11 +576,8 @@ static void smc_lgr_cleanup(struct smc_link_group *lgr)
 	} else {
 		struct smc_link *lnk = &lgr->lnk[SMC_SINGLE_LINK];
 
-		wake_up(&lnk->wr_reg_wait);
-		if (lnk->state != SMC_LNK_INACTIVE) {
-			smc_link_send_delete(lnk, false);
+		if (lnk->state != SMC_LNK_INACTIVE)
 			smc_llc_link_inactive(lnk);
-		}
 	}
 }
 
-- 
2.17.1

