Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D586E125CDC
	for <lists+linux-s390@lfdr.de>; Thu, 19 Dec 2019 09:43:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726633AbfLSIn7 (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Thu, 19 Dec 2019 03:43:59 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:8388 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726599AbfLSIn7 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 19 Dec 2019 03:43:59 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xBJ8gaA3053032
        for <linux-s390@vger.kernel.org>; Thu, 19 Dec 2019 03:43:58 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2x00sfaxr4-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Thu, 19 Dec 2019 03:43:58 -0500
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <sth@linux.ibm.com>;
        Thu, 19 Dec 2019 08:43:56 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 19 Dec 2019 08:43:54 -0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id xBJ8hrtR30867578
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 Dec 2019 08:43:53 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0A06911C054;
        Thu, 19 Dec 2019 08:43:53 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E9B8B11C052;
        Thu, 19 Dec 2019 08:43:52 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Thu, 19 Dec 2019 08:43:52 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 20191)
        id 8AF16E02BD; Thu, 19 Dec 2019 09:43:52 +0100 (CET)
From:   Stefan Haberland <sth@linux.ibm.com>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, hoeppner@linux.ibm.com,
        linux-s390@vger.kernel.org, heiko.carstens@de.ibm.com,
        gor@linux.ibm.com, borntraeger@de.ibm.com
Subject: [PATCH 0/3] s390/dasd patches
Date:   Thu, 19 Dec 2019 09:43:49 +0100
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19121908-0016-0000-0000-000002D67786
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19121908-0017-0000-0000-00003338BA2B
Message-Id: <20191219084352.75114-1-sth@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-18_08:2019-12-17,2019-12-18 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 mlxscore=0
 lowpriorityscore=0 suspectscore=1 priorityscore=1501 impostorscore=0
 phishscore=0 spamscore=0 mlxlogscore=592 clxscore=1011 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1912190074
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Hi Jens,

please see the following three patches that

 - fix a dead code path for DASD
 - fix a memleak in DASD error case
 - fix typo in copyright statement

Regards,
Stefan

Jan Höppner (1):
  s390/dasd/cio: Interpret ccw_device_get_mdc return value correctly

Stefan Haberland (2):
  s390/dasd: fix memleak in path handling error case
  s390/dasd: fix typo in copyright statement

 drivers/s390/block/dasd_eckd.c | 28 +++++++---------------------
 drivers/s390/block/dasd_fba.h  |  2 +-
 drivers/s390/block/dasd_proc.c |  2 +-
 drivers/s390/cio/device_ops.c  |  2 +-
 4 files changed, 10 insertions(+), 24 deletions(-)

-- 
2.17.1

