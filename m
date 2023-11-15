Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63ACD7E2262
	for <lists+linux-s390@lfdr.de>; Mon,  6 Nov 2023 13:54:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230514AbjKFMyJ (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Mon, 6 Nov 2023 07:54:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229921AbjKFMyJ (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 6 Nov 2023 07:54:09 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42A19BB;
        Mon,  6 Nov 2023 04:54:06 -0800 (PST)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A6Cau8b002951;
        Mon, 6 Nov 2023 12:53:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=gpFvdlFM/zJ2itseIzs88/CrcfONgPAiPey4txj7e+Y=;
 b=H5RKD3VMqzpq6swFMFqaoL4RIRWga6Q778OrQXwdQyQL+hwZ96G4RMm1LPTQaEVgfuai
 mY5x68uwttVaVjIBX6kvxOzjQ+xzybHAgPrQRQdv3CSnCU9gPOwO0StbUzm2vnj989ms
 d3+W9uxF6fz/79HrudHSiVw7DmhUngxO4ODXxCYjLU03EqfW6IKDwg7KjjG9j1bZd+TI
 fH9vlmJdfraEMpv2tgVKbXFETu+EQPX3HgDaxpoXrJkGTSWS4O3t4qbYeNkkS/FAcR2I
 KEjRqOsqV/FPC179eQjfH9R0a8pPfmaZZUMymWfntOh2httaojcfIF+iNdqeAw/fyJMa qQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3u70a4rm35-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Nov 2023 12:53:57 +0000
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3A6CbqBG006482;
        Mon, 6 Nov 2023 12:53:56 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3u70a4rm2v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Nov 2023 12:53:56 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3A6Akln6007918;
        Mon, 6 Nov 2023 12:53:55 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
        by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3u60ny9eb6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Nov 2023 12:53:55 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
        by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3A6CrqiS4588172
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 6 Nov 2023 12:53:52 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AA0BC20049;
        Mon,  6 Nov 2023 12:53:52 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 712C320040;
        Mon,  6 Nov 2023 12:53:52 +0000 (GMT)
Received: from t35lp63.lnxne.boe (unknown [9.152.108.100])
        by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Mon,  6 Nov 2023 12:53:52 +0000 (GMT)
From:   Nico Boehr <nrb@linux.ibm.com>
To:     frankja@linux.ibm.com, imbrenda@linux.ibm.com, thuth@redhat.com,
        david@redhat.com, pbonzini@redhat.com, andrew.jones@linux.dev,
        lvivier@redhat.com
Cc:     kvm@vger.kernel.org, linux-s390@vger.kernel.org
Subject: [kvm-unit-tests PATCH v1 00/10] RFC: Add clang-format and kerneldoc check
Date:   Mon,  6 Nov 2023 13:50:56 +0100
Message-ID: <20231106125352.859992-1-nrb@linux.ibm.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: b-xWC-AOxzykctBZvqMB9KYtNHBFDf4B
X-Proofpoint-ORIG-GUID: mZOAGVDH32R0g4BYn_OJyrE8TyPQj6ml
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-06_11,2023-11-02_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=908
 suspectscore=0 priorityscore=1501 adultscore=0 mlxscore=0 bulkscore=0
 spamscore=0 malwarescore=0 clxscore=1015 phishscore=0 impostorscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310240000 definitions=main-2311060104
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

It is important that we have a consistent formatting of our source code and
comments in kvm-unit-tests.

Yet, it's not always easy since tiny formatting mistakes are hard to spot
for reviewers. Respinning patches because of these issues can also be
frustrating for contributors.

This series is a RFC suggestion on how the situation could be improved
for kvm-unit-tests.

It adds a clang-format file, mostly based on the one already present in the
kernel. A new "make format" target makes it easy to properly format the
source. If maintainers want, they could even re-format the source code of
ther arch to ensure a consistent code formatting, but this is entirely
optional. I am also happy to move the "make format" into arch-specific code
if requested.

Additionally, I noticed that there is quite inconsistent use of kernel-doc
comments in the code. Add a respective check command and fix the existing
issues.

Nico Boehr (10):
  make: add target to check kernel-doc comments
  powerpc: properly format non-kernel-doc comments
  lib: s390x: cpacf: move kernel-doc comment to correct function
  s390x: properly format non-kernel-doc comments
  s390x: ensure kernel-doc parameters are properly formated
  x86: properly format non-kernel-doc comments
  s390x: cpumodel: list tcg_fail explicitly
  s390x: gs: turn off formatter for inline assembly
  add clang-format configuration file
  add make format

 .clang-format         |  689 +++++++++++
 Makefile              |    6 +
 lib/s390x/asm/cpacf.h |   20 +-
 lib/s390x/interrupt.c |    6 +-
 powerpc/emulator.c    |    2 +-
 powerpc/spapr_hcall.c |    6 +-
 powerpc/spapr_vpa.c   |    4 +-
 s390x/cpumodel.c      |   38 +-
 s390x/gs.c            |   44 +-
 s390x/sclp.c          |   32 +-
 scripts/kernel-doc    | 2526 +++++++++++++++++++++++++++++++++++++++++
 x86/msr.c             |    2 +-
 12 files changed, 3299 insertions(+), 76 deletions(-)
 create mode 100644 .clang-format
 create mode 100755 scripts/kernel-doc

-- 
2.41.0

