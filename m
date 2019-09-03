Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 23852A69FD
	for <lists+linux-s390@lfdr.de>; Tue,  3 Sep 2019 15:36:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727941AbfICNgx (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Tue, 3 Sep 2019 09:36:53 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:26784 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728490AbfICNgx (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 3 Sep 2019 09:36:53 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x83DXMGH011977
        for <linux-s390@vger.kernel.org>; Tue, 3 Sep 2019 09:36:52 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2usqvykqq5-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Tue, 03 Sep 2019 09:36:52 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <pasic@linux.ibm.com>;
        Tue, 3 Sep 2019 14:36:43 +0100
Received: from b06avi18878370.portsmouth.uk.ibm.com (9.149.26.194)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 3 Sep 2019 14:36:41 +0100
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x83Dad3F32768276
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 3 Sep 2019 13:36:39 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7B661A4054;
        Tue,  3 Sep 2019 13:36:39 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2E555A405F;
        Tue,  3 Sep 2019 13:36:39 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue,  3 Sep 2019 13:36:39 +0000 (GMT)
From:   Halil Pasic <pasic@linux.ibm.com>
To:     Tony Krowiak <akrowiak@linux.ibm.com>,
        Halil Pasic <pasic@linux.ibm.com>,
        Harald Freudenberger <freude@linux.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Heiko Carstens <heiko.carstens@de.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Cornelia Huck <cohuck@redhat.com>
Subject: [PATCH 1/1] s390: vfio-ap: fix warning reset not completed
Date:   Tue,  3 Sep 2019 15:36:18 +0200
X-Mailer: git-send-email 2.17.1
X-TM-AS-GCONF: 00
x-cbid: 19090313-0016-0000-0000-000002A62061
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19090313-0017-0000-0000-000033068869
Message-Id: <20190903133618.9122-1-pasic@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-09-03_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1909030143
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

The intention seems to be to warn once when we don't wait enough for the
reset to complete. Let's use the right retry counter to accomplish that
semantic.

Signed-off-by: Halil Pasic <pasic@linux.ibm.com>
---
 drivers/s390/crypto/vfio_ap_ops.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
index 0604b49a4d32..5c0f53c6dde7 100644
--- a/drivers/s390/crypto/vfio_ap_ops.c
+++ b/drivers/s390/crypto/vfio_ap_ops.c
@@ -1143,7 +1143,7 @@ int vfio_ap_mdev_reset_queue(unsigned int apid, unsigned int apqi,
 				msleep(20);
 				status = ap_tapq(apqn, NULL);
 			}
-			WARN_ON_ONCE(retry <= 0);
+			WARN_ON_ONCE(retry2 <= 0);
 			return 0;
 		case AP_RESPONSE_RESET_IN_PROGRESS:
 		case AP_RESPONSE_BUSY:
-- 
2.17.1

