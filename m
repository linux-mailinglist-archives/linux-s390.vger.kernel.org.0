Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 42392124BC6
	for <lists+linux-s390@lfdr.de>; Wed, 18 Dec 2019 16:32:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727313AbfLRPci (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Wed, 18 Dec 2019 10:32:38 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:22810 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727262AbfLRPci (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 18 Dec 2019 10:32:38 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xBIFSY0W084187
        for <linux-s390@vger.kernel.org>; Wed, 18 Dec 2019 10:32:37 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2wyncxbtj9-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Wed, 18 Dec 2019 10:32:36 -0500
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <jwi@linux.ibm.com>;
        Wed, 18 Dec 2019 15:32:35 -0000
Received: from b06avi18626390.portsmouth.uk.ibm.com (9.149.26.192)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 18 Dec 2019 15:32:32 -0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id xBIFVl2348955860
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 18 Dec 2019 15:31:48 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0A0FD52051;
        Wed, 18 Dec 2019 15:32:31 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id B516752050;
        Wed, 18 Dec 2019 15:32:30 +0000 (GMT)
From:   Julian Wiedmann <jwi@linux.ibm.com>
To:     David Miller <davem@davemloft.net>
Cc:     <netdev@vger.kernel.org>, <linux-s390@vger.kernel.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Stefan Raspl <raspl@linux.ibm.com>,
        Ursula Braun <ubraun@linux.ibm.com>,
        Julian Wiedmann <jwi@linux.ibm.com>
Subject: [PATCH net 3/3] s390/qeth: don't return -ENOTSUPP to userspace
Date:   Wed, 18 Dec 2019 16:32:28 +0100
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191218153228.29908-1-jwi@linux.ibm.com>
References: <20191218153228.29908-1-jwi@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 19121815-0008-0000-0000-000003423BB2
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19121815-0009-0000-0000-00004A62515A
Message-Id: <20191218153228.29908-4-jwi@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-18_04:2019-12-17,2019-12-18 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 impostorscore=0 mlxlogscore=999 spamscore=0 mlxscore=0 lowpriorityscore=0
 malwarescore=0 clxscore=1015 bulkscore=0 adultscore=0 phishscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1912180127
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

ENOTSUPP is not uapi, use EOPNOTSUPP instead.

Fixes: d66cb37e9664 ("qeth: Add new priority queueing options")
Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
---
 drivers/s390/net/qeth_core_sys.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/s390/net/qeth_core_sys.c b/drivers/s390/net/qeth_core_sys.c
index e81170ab6d9a..7bd86027f559 100644
--- a/drivers/s390/net/qeth_core_sys.c
+++ b/drivers/s390/net/qeth_core_sys.c
@@ -207,7 +207,7 @@ static ssize_t qeth_dev_prioqing_store(struct device *dev,
 		card->qdio.default_out_queue = QETH_DEFAULT_QUEUE;
 	} else if (sysfs_streq(buf, "prio_queueing_vlan")) {
 		if (IS_LAYER3(card)) {
-			rc = -ENOTSUPP;
+			rc = -EOPNOTSUPP;
 			goto out;
 		}
 		card->qdio.do_prio_queueing = QETH_PRIO_Q_ING_VLAN;
-- 
2.17.1

