Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78C4E281C20
	for <lists+linux-s390@lfdr.de>; Fri,  2 Oct 2020 21:39:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388392AbgJBTjr (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Fri, 2 Oct 2020 15:39:47 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:65014 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388386AbgJBTjr (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 2 Oct 2020 15:39:47 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 092JXC2k106667;
        Fri, 2 Oct 2020 15:39:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=pp1;
 bh=V0RKkdlBxyII9tHKx9E6pKuUYPk1v++lsFL1cnN0jno=;
 b=NTtkiHTCI8Ma6sVFSgoLpZS4IMYCtVQvxl+e89NPIvTeKow1/xmTFVzTN7ZK1yD3a1vu
 XFzjKiLIu/i7a/pFnJ7eTX3w3lBUCWn7tas2yTovF9a4nmeh2C+bETP9ItLm6cyrETue
 kDKNHNoXQJ5sxpcVwvgXmUYvLiBqh7Ri2j2AWR/SqR2an4Kewr6o7Sdw3YmbPKhRMqTv
 p82dfhyP0p/w1zStwa9aMfa+sJ3aInYxrD1N2x4rF8L2NSANRhkerYrZ7+m79njEZG8N
 wcbrliw9cyQokO2d39baJJsyTTHowquFUS5hrRunCEQj7J1uiCHL1lJSFexLE/ASkodD KA== 
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 33x9a2a10m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 02 Oct 2020 15:39:46 -0400
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 092JcTew016028;
        Fri, 2 Oct 2020 19:39:44 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma06ams.nl.ibm.com with ESMTP id 33v6mguedv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 02 Oct 2020 19:39:44 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 092Jdflu20644310
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 2 Oct 2020 19:39:41 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1E1D552057;
        Fri,  2 Oct 2020 19:39:41 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTPS id 15D7552054;
        Fri,  2 Oct 2020 19:39:41 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 20191)
        id AAB75E031C; Fri,  2 Oct 2020 21:39:40 +0200 (CEST)
From:   Stefan Haberland <sth@linux.ibm.com>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, hoeppner@linux.ibm.com,
        linux-s390@vger.kernel.org, heiko.carstens@de.ibm.com,
        gor@linux.ibm.com, borntraeger@de.ibm.com
Subject: [PATCH 04/10] s390/dasd: Remove unused parameter from dasd_generic_probe()
Date:   Fri,  2 Oct 2020 21:39:34 +0200
Message-Id: <20201002193940.24012-5-sth@linux.ibm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201002193940.24012-1-sth@linux.ibm.com>
References: <20201002193940.24012-1-sth@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-10-02_14:2020-10-02,2020-10-02 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 clxscore=1015
 impostorscore=0 mlxscore=0 malwarescore=0 phishscore=0 bulkscore=0
 spamscore=0 suspectscore=3 priorityscore=1501 mlxlogscore=905
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2010020141
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

From: Jan Höppner <hoeppner@linux.ibm.com>

The discipline argument in dasd_generic_probe() isn't used and there is
no history how it was used in the past. Remove it.

Reference-ID: IO1812
Signed-off-by: Jan Höppner <hoeppner@linux.ibm.com>
Reviewed-by: Stefan Haberland <sth@linux.ibm.com>
Signed-off-by: Stefan Haberland <sth@linux.ibm.com>
---
 drivers/s390/block/dasd.c      | 3 +--
 drivers/s390/block/dasd_eckd.c | 2 +-
 drivers/s390/block/dasd_fba.c  | 2 +-
 drivers/s390/block/dasd_int.h  | 2 +-
 4 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/s390/block/dasd.c b/drivers/s390/block/dasd.c
index eb17fea8075c..9a0300d2e744 100644
--- a/drivers/s390/block/dasd.c
+++ b/drivers/s390/block/dasd.c
@@ -3465,8 +3465,7 @@ static void dasd_generic_auto_online(void *data, async_cookie_t cookie)
  * Initial attempt at a probe function. this can be simplified once
  * the other detection code is gone.
  */
-int dasd_generic_probe(struct ccw_device *cdev,
-		       struct dasd_discipline *discipline)
+int dasd_generic_probe(struct ccw_device *cdev)
 {
 	int ret;
 
diff --git a/drivers/s390/block/dasd_eckd.c b/drivers/s390/block/dasd_eckd.c
index ad44d22e8859..2b39d2a5965f 100644
--- a/drivers/s390/block/dasd_eckd.c
+++ b/drivers/s390/block/dasd_eckd.c
@@ -143,7 +143,7 @@ dasd_eckd_probe (struct ccw_device *cdev)
 				"ccw-device options");
 		return ret;
 	}
-	ret = dasd_generic_probe(cdev, &dasd_eckd_discipline);
+	ret = dasd_generic_probe(cdev);
 	return ret;
 }
 
diff --git a/drivers/s390/block/dasd_fba.c b/drivers/s390/block/dasd_fba.c
index 1a44e321b54e..5b0ebf6bf20f 100644
--- a/drivers/s390/block/dasd_fba.c
+++ b/drivers/s390/block/dasd_fba.c
@@ -58,7 +58,7 @@ static struct ccw_driver dasd_fba_driver; /* see below */
 static int
 dasd_fba_probe(struct ccw_device *cdev)
 {
-	return dasd_generic_probe(cdev, &dasd_fba_discipline);
+	return dasd_generic_probe(cdev);
 }
 
 static int
diff --git a/drivers/s390/block/dasd_int.h b/drivers/s390/block/dasd_int.h
index fa552f9f1666..6dce9d4c55ce 100644
--- a/drivers/s390/block/dasd_int.h
+++ b/drivers/s390/block/dasd_int.h
@@ -774,7 +774,7 @@ void dasd_block_set_timer(struct dasd_block *, int);
 void dasd_block_clear_timer(struct dasd_block *);
 int  dasd_cancel_req(struct dasd_ccw_req *);
 int dasd_flush_device_queue(struct dasd_device *);
-int dasd_generic_probe (struct ccw_device *, struct dasd_discipline *);
+int dasd_generic_probe(struct ccw_device *);
 void dasd_generic_free_discipline(struct dasd_device *);
 void dasd_generic_remove (struct ccw_device *cdev);
 int dasd_generic_set_online(struct ccw_device *, struct dasd_discipline *);
-- 
2.17.1

