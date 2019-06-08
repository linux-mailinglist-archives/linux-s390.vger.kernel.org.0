Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C5D4F39D0B
	for <lists+linux-s390@lfdr.de>; Sat,  8 Jun 2019 13:09:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726967AbfFHLJC (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Sat, 8 Jun 2019 07:09:02 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:43570 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726841AbfFHLJB (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Sat, 8 Jun 2019 07:09:01 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x58B6hFc110225
        for <linux-s390@vger.kernel.org>; Sat, 8 Jun 2019 07:09:00 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2t08au5d8x-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Sat, 08 Jun 2019 07:09:00 -0400
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <heiko.carstens@de.ibm.com>;
        Sat, 8 Jun 2019 12:08:58 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Sat, 8 Jun 2019 12:08:54 +0100
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x58B8s8A37879978
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 8 Jun 2019 11:08:54 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E4BDD42041;
        Sat,  8 Jun 2019 11:08:53 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 96A574203F;
        Sat,  8 Jun 2019 11:08:53 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Sat,  8 Jun 2019 11:08:53 +0000 (GMT)
From:   Heiko Carstens <heiko.carstens@de.ibm.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>
Cc:     linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: [PATCH/RFC 0/3] improve wait logic of stop_machine
Date:   Sat,  8 Jun 2019 13:08:50 +0200
X-Mailer: git-send-email 2.17.1
X-TM-AS-GCONF: 00
x-cbid: 19060811-0020-0000-0000-000003484E25
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19060811-0021-0000-0000-0000219B6AD6
Message-Id: <20190608110853.35961-1-heiko.carstens@de.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-08_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=780 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906080086
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

The stop_machine loop to advance the state machine and to wait for all
affected CPUs to check-in calls cpu_relax_yield in a tight loop until
the last missing CPUs acknowledged the state transition.

On a virtual system where not all logical CPUs are backed by real CPUs
all the time it can take a while for all CPUs to check-in. With the
current definition of cpu_relax_yield on s390 a diagnose 0x44 is done
which tells the hypervisor to schedule *some* other CPU. That can be
any CPU and not necessarily one of the CPUs that need to run in order
to advance the state machine. This can lead to a pretty bad diagnose
0x44 storm until the last missing CPU finally checked-in.

Replace the undirected cpu_relax_yield based on diagnose 0x44 with an
architecture specific directed yield. Each CPU in the wait loop will
pick up the next CPU in the cpumask of stop_machine. The diagnose 0x9c
is used to tell the hypervisor to run this next CPU instead of the
current one. If there is only a limited number of real CPUs backing
the virtual CPUs we end up with the real CPUs passed around in a
round-robin fashion.

Patches 1 and 3 are just possible cleanups; the interesting part is
patch 2.

Heiko Carstens (2):
  processor: remove spin_cpu_yield
  processor: get rid of cpu_relax_yield

Martin Schwidefsky (1):
  s390: improve wait logic of stop_machine

 arch/powerpc/include/asm/processor.h |  2 --
 arch/s390/include/asm/processor.h    |  7 +------
 arch/s390/kernel/processor.c         | 21 +++++++++++++++------
 arch/s390/kernel/smp.c               |  2 +-
 include/linux/processor.h            |  9 ---------
 include/linux/sched.h                |  4 ----
 include/linux/stop_machine.h         |  1 +
 kernel/stop_machine.c                | 19 ++++++++++++++-----
 8 files changed, 32 insertions(+), 33 deletions(-)

-- 
2.17.1

