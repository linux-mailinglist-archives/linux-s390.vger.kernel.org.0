Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 507DB7879D
	for <lists+linux-s390@lfdr.de>; Mon, 29 Jul 2019 10:39:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727109AbfG2IjB (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Mon, 29 Jul 2019 04:39:01 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:26564 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726305AbfG2IjB (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 29 Jul 2019 04:39:01 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x6T8YCZu033897
        for <linux-s390@vger.kernel.org>; Mon, 29 Jul 2019 04:39:00 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2u1t790as9-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Mon, 29 Jul 2019 04:39:00 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <gor@linux.ibm.com>;
        Mon, 29 Jul 2019 09:38:58 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 29 Jul 2019 09:38:55 +0100
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x6T8crH352297760
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 29 Jul 2019 08:38:53 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C5BC1A4060;
        Mon, 29 Jul 2019 08:38:53 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9E8ACA405F;
        Mon, 29 Jul 2019 08:38:53 +0000 (GMT)
Received: from localhost (unknown [9.152.212.110])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Mon, 29 Jul 2019 08:38:53 +0000 (GMT)
Date:   Mon, 29 Jul 2019 10:38:52 +0200
From:   Vasily Gorbik <gor@linux.ibm.com>
To:     Cornelia Huck <cohuck@redhat.com>
Cc:     linux-s390 <linux-s390@vger.kernel.org>
Subject: [PATCH] vfio-ccw: make vfio_ccw_async_region_ops static
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Patchwork-Bot: notify
X-TM-AS-GCONF: 00
x-cbid: 19072908-0016-0000-0000-000002972DE7
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19072908-0017-0000-0000-000032F5358A
Message-Id: <patch.git-1c8e853871be.your-ad-here.call-01564389487-ext-4282@work.hours>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-29_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=818 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1907290102
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Since vfio_ccw_async_region_ops is not exported and has no reason to be
globally visible make it static to avoid the following sparse warning:
drivers/s390/cio/vfio_ccw_async.c:73:30: warning: symbol 'vfio_ccw_async_region_ops' was not declared. Should it be static?

Signed-off-by: Vasily Gorbik <gor@linux.ibm.com>
---
 drivers/s390/cio/vfio_ccw_async.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/s390/cio/vfio_ccw_async.c b/drivers/s390/cio/vfio_ccw_async.c
index 8c1d2357ef5b..7a838e3d7c0f 100644
--- a/drivers/s390/cio/vfio_ccw_async.c
+++ b/drivers/s390/cio/vfio_ccw_async.c
@@ -70,7 +70,7 @@ static void vfio_ccw_async_region_release(struct vfio_ccw_private *private,
 
 }
 
-const struct vfio_ccw_regops vfio_ccw_async_region_ops = {
+static const struct vfio_ccw_regops vfio_ccw_async_region_ops = {
 	.read = vfio_ccw_async_region_read,
 	.write = vfio_ccw_async_region_write,
 	.release = vfio_ccw_async_region_release,
-- 
2.21.0

