Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 589B8224B4E
	for <lists+linux-s390@lfdr.de>; Sat, 18 Jul 2020 15:08:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727001AbgGRNGx (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Sat, 18 Jul 2020 09:06:53 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:6268 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726777AbgGRNGx (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Sat, 18 Jul 2020 09:06:53 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06ID2TcC039314;
        Sat, 18 Jul 2020 09:06:52 -0400
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 32budce9qv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 18 Jul 2020 09:06:52 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 06ID6BdI005275;
        Sat, 18 Jul 2020 13:06:50 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma04ams.nl.ibm.com with ESMTP id 32brq80c9b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 18 Jul 2020 13:06:50 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 06ID6lgR21692748
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 18 Jul 2020 13:06:47 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3CB33AE051;
        Sat, 18 Jul 2020 13:06:47 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F4144AE053;
        Sat, 18 Jul 2020 13:06:46 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Sat, 18 Jul 2020 13:06:46 +0000 (GMT)
From:   Karsten Graul <kgraul@linux.ibm.com>
To:     davem@davemloft.net
Cc:     netdev@vger.kernel.org, linux-s390@vger.kernel.org,
        heiko.carstens@de.ibm.com, raspl@linux.ibm.com,
        ubraun@linux.ibm.com
Subject: [PATCH net v2 04/10] net/smc: protect smc ib device initialization
Date:   Sat, 18 Jul 2020 15:06:12 +0200
Message-Id: <20200718130618.16724-5-kgraul@linux.ibm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200718130618.16724-1-kgraul@linux.ibm.com>
References: <20200718130618.16724-1-kgraul@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-18_06:2020-07-17,2020-07-18 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 adultscore=0
 suspectscore=1 malwarescore=0 mlxlogscore=999 priorityscore=1501
 lowpriorityscore=0 mlxscore=0 clxscore=1015 impostorscore=0 bulkscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007180095
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Before an smc ib device is used the first time for an smc link it is
lazily initialized. When there are 2 active link groups and a new ib
device is brought online then it might happen that 2 link creations run
in parallel and enter smc_ib_setup_per_ibdev(). Both allocate new send
and receive completion queues on the device, but only one set of them
keeps assigned and the other leaks.
Fix that by protecting the setup and cleanup code using a mutex.

Reviewed-by: Ursula Braun <ubraun@linux.ibm.com>
Fixes: f3c1deddb21c ("net/smc: separate function for link initialization")
Signed-off-by: Karsten Graul <kgraul@linux.ibm.com>
---
 net/smc/smc_ib.c | 16 +++++++++++++---
 net/smc/smc_ib.h |  1 +
 2 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/net/smc/smc_ib.c b/net/smc/smc_ib.c
index 7637fdebbb78..1c314dbdc7fa 100644
--- a/net/smc/smc_ib.c
+++ b/net/smc/smc_ib.c
@@ -506,6 +506,10 @@ long smc_ib_setup_per_ibdev(struct smc_ib_device *smcibdev)
 	int cqe_size_order, smc_order;
 	long rc;
 
+	mutex_lock(&smcibdev->mutex);
+	rc = 0;
+	if (smcibdev->initialized)
+		goto out;
 	/* the calculated number of cq entries fits to mlx5 cq allocation */
 	cqe_size_order = cache_line_size() == 128 ? 7 : 6;
 	smc_order = MAX_ORDER - cqe_size_order - 1;
@@ -517,7 +521,7 @@ long smc_ib_setup_per_ibdev(struct smc_ib_device *smcibdev)
 	rc = PTR_ERR_OR_ZERO(smcibdev->roce_cq_send);
 	if (IS_ERR(smcibdev->roce_cq_send)) {
 		smcibdev->roce_cq_send = NULL;
-		return rc;
+		goto out;
 	}
 	smcibdev->roce_cq_recv = ib_create_cq(smcibdev->ibdev,
 					      smc_wr_rx_cq_handler, NULL,
@@ -529,21 +533,26 @@ long smc_ib_setup_per_ibdev(struct smc_ib_device *smcibdev)
 	}
 	smc_wr_add_dev(smcibdev);
 	smcibdev->initialized = 1;
-	return rc;
+	goto out;
 
 err:
 	ib_destroy_cq(smcibdev->roce_cq_send);
+out:
+	mutex_unlock(&smcibdev->mutex);
 	return rc;
 }
 
 static void smc_ib_cleanup_per_ibdev(struct smc_ib_device *smcibdev)
 {
+	mutex_lock(&smcibdev->mutex);
 	if (!smcibdev->initialized)
-		return;
+		goto out;
 	smcibdev->initialized = 0;
 	ib_destroy_cq(smcibdev->roce_cq_recv);
 	ib_destroy_cq(smcibdev->roce_cq_send);
 	smc_wr_remove_dev(smcibdev);
+out:
+	mutex_unlock(&smcibdev->mutex);
 }
 
 static struct ib_client smc_ib_client;
@@ -566,6 +575,7 @@ static int smc_ib_add_dev(struct ib_device *ibdev)
 	INIT_WORK(&smcibdev->port_event_work, smc_ib_port_event_work);
 	atomic_set(&smcibdev->lnk_cnt, 0);
 	init_waitqueue_head(&smcibdev->lnks_deleted);
+	mutex_init(&smcibdev->mutex);
 	mutex_lock(&smc_ib_devices.mutex);
 	list_add_tail(&smcibdev->list, &smc_ib_devices.list);
 	mutex_unlock(&smc_ib_devices.mutex);
diff --git a/net/smc/smc_ib.h b/net/smc/smc_ib.h
index ae6776e1e726..2ce481187dd0 100644
--- a/net/smc/smc_ib.h
+++ b/net/smc/smc_ib.h
@@ -52,6 +52,7 @@ struct smc_ib_device {				/* ib-device infos for smc */
 	DECLARE_BITMAP(ports_going_away, SMC_MAX_PORTS);
 	atomic_t		lnk_cnt;	/* number of links on ibdev */
 	wait_queue_head_t	lnks_deleted;	/* wait 4 removal of all links*/
+	struct mutex		mutex;		/* protect dev setup+cleanup */
 };
 
 struct smc_buf_desc;
-- 
2.17.1

