Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 92D7EE875F
	for <lists+linux-s390@lfdr.de>; Tue, 29 Oct 2019 12:44:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387746AbfJ2Ln7 (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Tue, 29 Oct 2019 07:43:59 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:52784 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387737AbfJ2Ln7 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 29 Oct 2019 07:43:59 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x9TBdYRX142862
        for <linux-s390@vger.kernel.org>; Tue, 29 Oct 2019 07:43:58 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2vxmrc851y-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Tue, 29 Oct 2019 07:43:58 -0400
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <ubraun@linux.ibm.com>;
        Tue, 29 Oct 2019 11:43:56 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 29 Oct 2019 11:43:53 -0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x9TBhnOs61931534
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 29 Oct 2019 11:43:49 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 67F97A404D;
        Tue, 29 Oct 2019 11:43:49 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0CE8AA4040;
        Tue, 29 Oct 2019 11:43:49 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 29 Oct 2019 11:43:48 +0000 (GMT)
From:   Ursula Braun <ubraun@linux.ibm.com>
To:     davem@davemloft.net
Cc:     netdev@vger.kernel.org, linux-s390@vger.kernel.org,
        gor@linux.ibm.com, heiko.carstens@de.ibm.com, raspl@linux.ibm.com,
        kgraul@linux.ibm.com, ubraun@linux.ibm.com,
        jakub.kicinski@netronome.com
Subject: [PATCH net-next 1/1] net/smc: remove unneeded include for smc.h
Date:   Tue, 29 Oct 2019 12:43:46 +0100
X-Mailer: git-send-email 2.17.1
X-TM-AS-GCONF: 00
x-cbid: 19102911-0028-0000-0000-000003B0B9DD
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19102911-0029-0000-0000-00002472FA70
Message-Id: <20191029114346.73418-1-ubraun@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-10-29_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=813 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1910290118
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

The only smc-related reference in net/sock.h is struct smc_hashinfo.
But just its address is refered to. Thus there is no need for the
include of net/smc.h. Remove it.

Suggested-by: Jakub Kicinski <jakub.kicinski@netronome.com>
Reviewed by: Karsten Graul <kgraul@linux.ibm.com>
Signed-off-by: Ursula Braun <ubraun@linux.ibm.com>
---
 include/net/sock.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/net/sock.h b/include/net/sock.h
index 380312cc67a9..09c26a5ecbff 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -66,7 +66,6 @@
 #include <net/checksum.h>
 #include <net/tcp_states.h>
 #include <linux/net_tstamp.h>
-#include <net/smc.h>
 #include <net/l3mdev.h>
 
 /*
-- 
2.17.1

