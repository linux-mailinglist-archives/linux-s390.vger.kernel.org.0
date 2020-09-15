Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 720F826B28A
	for <lists+linux-s390@lfdr.de>; Wed, 16 Sep 2020 00:49:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727476AbgIOWtZ (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Tue, 15 Sep 2020 18:49:25 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:54670 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727473AbgIOPnx (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 15 Sep 2020 11:43:53 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08FFVpAt090384;
        Tue, 15 Sep 2020 11:43:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id; s=pp1;
 bh=zlHQLvWnc5XWrXXIxI06CvoD6r8g5ZsGxa9524B8SbY=;
 b=SynRZfAe7nzOmcXY4Yo4i1i/xiX/bV/vqAZzeyU7d9v8dE0nGwOo7Y+w6t8PF2PIQB6M
 jyihxDcGxPcRibBgwbF3149SZ3Xs8W8wO5JBrH1CSlpAjhhcDet3kHFdP7Jn5COiy9b0
 a+rsyse7SFCVHH1Mwwb4Cox81pNBUSQgtWZ0LfDM7mv7FyFgkeGH9PO4edgeToWTL3n3
 gJcamjoN8N8LKTwP7JxTo+1F79vUWq/+R0lmLIMV9SHDz6DzMTOWe3iiPxXy44ZBG/TX
 aQ7g8HZPWQukakS20gNjDcM6c7z2jTlwpLZ0hYZcx2xh8hjKLLhm77glBht+v9GumEAQ cA== 
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 33k056rprw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 15 Sep 2020 11:43:46 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 08FFNsLv007028;
        Tue, 15 Sep 2020 15:43:44 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma04ams.nl.ibm.com with ESMTP id 33h2r9b7kp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 15 Sep 2020 15:43:44 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 08FFhfrj26214890
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Sep 2020 15:43:41 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5A5F4A4062;
        Tue, 15 Sep 2020 15:43:41 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 23442A405B;
        Tue, 15 Sep 2020 15:43:41 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 15 Sep 2020 15:43:41 +0000 (GMT)
From:   Heiko Carstens <hca@linux.ibm.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Harald Freudenberger <freude@linux.ibm.com>,
        linux-s390@vger.kernel.org
Subject: [PATCH 0/4] s390: set_fs() removal
Date:   Tue, 15 Sep 2020 17:43:36 +0200
Message-Id: <20200915154340.4215-1-hca@linux.ibm.com>
X-Mailer: git-send-email 2.17.1
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-15_11:2020-09-15,2020-09-15 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=831
 impostorscore=0 malwarescore=0 bulkscore=0 lowpriorityscore=0 phishscore=0
 adultscore=0 priorityscore=1501 spamscore=0 mlxscore=0 clxscore=1015
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009150127
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Hi Christoph,

as requested by you s390 specific set_fs() removal patches are
available here:

https://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git/log/?h=set_fs

See also this patch series. I'll ask Stephen to get the branch
included in linux-next. The above branch should not be considered
stable.. if something is broken fixes will be merged into the
corresponding commits.
Any review appreciated, of course!

Harald Freudenberger (1):
  s390/zcrypt: remove set_fs() invocation in zcrypt device driver

Heiko Carstens (3):
  s390/dis: get rid of set_fs() usage
  s390/uaccess: implement HAVE_GET_KERNEL_NOFAULT support
  s390/uaccess: remove set_fs() interface

 arch/s390/Kconfig                     |   1 -
 arch/s390/include/asm/futex.h         |  12 +--
 arch/s390/include/asm/mmu_context.h   |   7 +-
 arch/s390/include/asm/processor.h     |   4 +-
 arch/s390/include/asm/uaccess.h       | 129 ++++++++++++++++++++++----
 arch/s390/kernel/dis.c                |  24 +++--
 arch/s390/kernel/entry.S              |  19 +---
 arch/s390/kernel/entry.h              |   1 -
 arch/s390/kernel/process.c            |  15 +--
 arch/s390/lib/uaccess.c               |  76 +++++++--------
 arch/s390/mm/fault.c                  |   9 +-
 arch/s390/mm/pgalloc.c                |  11 +--
 arch/s390/pci/pci_mmio.c              |  12 +--
 drivers/s390/crypto/zcrypt_api.c      |  30 +++---
 drivers/s390/crypto/zcrypt_api.h      |  26 +++++-
 drivers/s390/crypto/zcrypt_ccamisc.c  |  32 ++-----
 drivers/s390/crypto/zcrypt_ep11misc.c |  28 +-----
 drivers/s390/crypto/zcrypt_msgtype6.c |  78 ++++++++--------
 drivers/s390/crypto/zcrypt_msgtype6.h |   4 +-
 19 files changed, 280 insertions(+), 238 deletions(-)

-- 
2.17.1

