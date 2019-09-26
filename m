Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1D335BF557
	for <lists+linux-s390@lfdr.de>; Thu, 26 Sep 2019 16:58:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725884AbfIZO6o (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Thu, 26 Sep 2019 10:58:44 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:60508 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725813AbfIZO6o (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 26 Sep 2019 10:58:44 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x8QEqR95118380
        for <linux-s390@vger.kernel.org>; Thu, 26 Sep 2019 10:58:43 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2v8x0dn8kq-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Thu, 26 Sep 2019 10:58:43 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <gor@linux.ibm.com>;
        Thu, 26 Sep 2019 15:58:41 +0100
Received: from b06avi18878370.portsmouth.uk.ibm.com (9.149.26.194)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 26 Sep 2019 15:58:37 +0100
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x8QEwaLT41746886
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 26 Sep 2019 14:58:36 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 261974C04A;
        Thu, 26 Sep 2019 14:58:36 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E2AFE4C044;
        Thu, 26 Sep 2019 14:58:35 +0000 (GMT)
Received: from localhost (unknown [9.145.74.47])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Thu, 26 Sep 2019 14:58:35 +0000 (GMT)
Date:   Thu, 26 Sep 2019 16:58:34 +0200
From:   Vasily Gorbik <gor@linux.ibm.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL] s390 patches for the 5.4 merge window #2
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-TM-AS-GCONF: 00
x-cbid: 19092614-0016-0000-0000-000002B1034E
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19092614-0017-0000-0000-00003311D0FF
Message-Id: <your-ad-here.call-01569509914-ext-6285@work.hours>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-09-26_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=923 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1909260138
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Hello Linus,

please pull the second round of s390 fixes and features for 5.4.

Thank you,
Vasily

The following changes since commit d590284419b1d7cc2dc646e9bdde4da19061cf0f:

  Merge tag 's390-5.4-1' of git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux (2019-09-17 14:04:43 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-5.4-2

for you to fetch changes up to ab5758848039de9a4b249d46e4ab591197eebaf2:

  s390/cio: exclude subchannels with no parent from pseudo check (2019-09-23 23:27:53 +0200)

----------------------------------------------------------------
s390 updates for the 5.4 merge window #2

 - Fix 3 kasan findings.

 - Add PERF_EVENT_IOC_PERIOD ioctl support.

 - Add Crypto Express7S support and extend sysfs attributes for pkey.

 - Minor common I/O layer documentation corrections.

----------------------------------------------------------------
Cornelia Huck (1):
      s390/cio: fix intparm documentation

Harald Freudenberger (1):
      s390/zcrypt: CEX7S exploitation support

Ingo Franzki (1):
      s390/pkey: Add sysfs attributes to emit AES CIPHER key blobs

Thomas Richter (2):
      s390/cpum_sf: Support ioctl PERF_EVENT_IOC_PERIOD
      s390/cpumf: Remove mixed white space

Vasily Gorbik (3):
      s390/topology: avoid firing events before kobjs are created
      s390/cio: avoid calling strlen on null pointer
      s390/cio: exclude subchannels with no parent from pseudo check

 arch/s390/include/asm/cpu_mf.h      |  10 +--
 arch/s390/include/asm/perf_event.h  |   2 +
 arch/s390/include/uapi/asm/zcrypt.h |   4 +-
 arch/s390/kernel/perf_cpum_sf.c     | 165 +++++++++++++++++++++++++++---------
 arch/s390/kernel/topology.c         |   3 +-
 drivers/s390/cio/ccwgroup.c         |   2 +-
 drivers/s390/cio/css.c              |   2 +
 drivers/s390/cio/device_ops.c       |  23 +++--
 drivers/s390/crypto/ap_bus.c        |  12 +--
 drivers/s390/crypto/ap_bus.h        |   3 +-
 drivers/s390/crypto/pkey_api.c      | 113 ++++++++++++++++++++++++
 drivers/s390/crypto/vfio_ap_drv.c   |   2 +
 drivers/s390/crypto/zcrypt_api.h    |   3 +-
 drivers/s390/crypto/zcrypt_cex4.c   |  72 +++++++++++-----
 14 files changed, 334 insertions(+), 82 deletions(-)

