Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C8FC1ADA5F
	for <lists+linux-s390@lfdr.de>; Fri, 17 Apr 2020 11:48:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728083AbgDQJsp (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Fri, 17 Apr 2020 05:48:45 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:5038 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728094AbgDQJsm (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 17 Apr 2020 05:48:42 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03H9aoBH013584
        for <linux-s390@vger.kernel.org>; Fri, 17 Apr 2020 05:48:41 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0b-001b2d01.pphosted.com with ESMTP id 30f9f6rx82-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Fri, 17 Apr 2020 05:48:41 -0400
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <sth@linux.ibm.com>;
        Fri, 17 Apr 2020 10:48:35 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 17 Apr 2020 10:48:32 +0100
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 03H9maHm62652548
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Apr 2020 09:48:36 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F4200A4051;
        Fri, 17 Apr 2020 09:48:35 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E314CA4057;
        Fri, 17 Apr 2020 09:48:35 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Fri, 17 Apr 2020 09:48:35 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 20191)
        id 9D560E03BC; Fri, 17 Apr 2020 11:48:35 +0200 (CEST)
From:   Stefan Haberland <sth@linux.ibm.com>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, hoeppner@linux.ibm.com,
        linux-s390@vger.kernel.org, heiko.carstens@de.ibm.com,
        gor@linux.ibm.com, borntraeger@de.ibm.com
Subject: [PATCH 1/1] s390/dasd: remove IOSCHED_DEADLINE from DASD Kconfig
Date:   Fri, 17 Apr 2020 11:48:35 +0200
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200417094835.60247-1-sth@linux.ibm.com>
References: <20200417094835.60247-1-sth@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 20041709-0028-0000-0000-000003F9D3D3
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20041709-0029-0000-0000-000024BF8D09
Message-Id: <20200417094835.60247-2-sth@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-17_03:2020-04-17,2020-04-17 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 spamscore=0 clxscore=1015 impostorscore=0 bulkscore=0
 lowpriorityscore=0 adultscore=0 mlxscore=0 mlxlogscore=997 phishscore=0
 suspectscore=1 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004170074
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

CONFIG_IOSCHED_DEADLINE was removed with
commit f382fb0bcef4 ("block: remove legacy IO schedulers")

and setting of the scheduler was removed with
commit a5fd8ddce2af ("s390/dasd: remove setting of scheduler from driver").

So get rid of the select.

Reported-by: Krzysztof Kozlowski <krzk@kernel.org>
Signed-off-by: Stefan Haberland <sth@linux.ibm.com>
---
 drivers/s390/block/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/s390/block/Kconfig b/drivers/s390/block/Kconfig
index a8682f69effc..376f1efbbb86 100644
--- a/drivers/s390/block/Kconfig
+++ b/drivers/s390/block/Kconfig
@@ -26,7 +26,6 @@ config DASD
 	def_tristate y
 	prompt "Support for DASD devices"
 	depends on CCW && BLOCK
-	select IOSCHED_DEADLINE
 	help
 	  Enable this option if you want to access DASDs directly utilizing
 	  S/390s channel subsystem commands. This is necessary for running
-- 
2.17.1

