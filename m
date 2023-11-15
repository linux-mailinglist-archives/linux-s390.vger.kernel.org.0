Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AB527EC2EE
	for <lists+linux-s390@lfdr.de>; Wed, 15 Nov 2023 13:51:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343834AbjKOMv0 (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Wed, 15 Nov 2023 07:51:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234924AbjKOMvY (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 15 Nov 2023 07:51:24 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57686E6;
        Wed, 15 Nov 2023 04:51:19 -0800 (PST)
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AFCgKV1004414;
        Wed, 15 Nov 2023 12:51:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : content-transfer-encoding : mime-version; s=pp1;
 bh=sdg0tZeHq4CWFHZzWnTeZUL4/SbOzBOaLLU0UV06BxE=;
 b=RrchHLT7d76wgGFI2or2vuTDL4hdtxJ+YdfvNE36evquM84qvmyDKzerGGm11lz+ntrS
 fm0rCmcUAiTA7psJCrK1k1EaUlf3taOJndxPq7rrcUFarMEy2LWYsLuNTyC18Lx2tjNN
 dAXHlL2qf34Ubgi0p+U3iJ6sbUhcqXsSCaRk4SJeKmWfvSQ10gyrdQypjd588q6G3+7y
 ydKqpj7EVXsDsnjah/h+mekZUvod3F3KzOxyQFx8gqTc4SRukr4U5uyammtAIVXXmB5a
 ujwgC2r6U+J/t97lseI+2qGIvRhQMw7ACKA7lTUz0SezUlyTXVsluFt2Cmj7qu5LTNoJ 9A== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ucx7p0a6q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Nov 2023 12:51:18 +0000
Received: from m0353728.ppops.net (m0353728.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3AFCgoiN006516;
        Wed, 15 Nov 2023 12:51:18 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ucx7p0a5m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Nov 2023 12:51:18 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3AFCYE49000988;
        Wed, 15 Nov 2023 12:51:17 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
        by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3uamxnf5ky-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Nov 2023 12:51:16 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
        by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3AFCpBRL4063844
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 Nov 2023 12:51:11 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 936EF20043;
        Wed, 15 Nov 2023 12:51:11 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6714A20040;
        Wed, 15 Nov 2023 12:51:11 +0000 (GMT)
Received: from p-imbrenda.boeblingen.de.ibm.com (unknown [9.152.224.66])
        by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Wed, 15 Nov 2023 12:51:11 +0000 (GMT)
From:   Claudio Imbrenda <imbrenda@linux.ibm.com>
To:     pbonzini@redhat.com
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-s390@vger.kernel.org, frankja@linux.ibm.com,
        borntraeger@de.ibm.com, hca@linux.ibm.com, agordeev@linux.ibm.com,
        gor@linux.ibm.com
Subject: [GIT PULL v1 0/2] KVM: s390: two small but important fixes
Date:   Wed, 15 Nov 2023 13:51:09 +0100
Message-ID: <20231115125111.28217-1-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.41.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: n-gkju0PLL4g0dNKmyT8cm4LPxWcBa_p
X-Proofpoint-GUID: M8FsnaIQZauswbhmTxxbDAr2icgBcK4s
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-15_11,2023-11-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 clxscore=1015
 suspectscore=0 malwarescore=0 adultscore=0 phishscore=0 mlxlogscore=680
 bulkscore=0 spamscore=0 impostorscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311150099
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Hi Paolo,

two small but important fixes, please pull :)


Claudio



The following changes since commit b85ea95d086471afb4ad062012a4d73cd328fa86:

  Linux 6.7-rc1 (2023-11-12 16:19:07 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux.git tags/kvm-s390-master-6.7-1

for you to fetch changes up to 27072b8e18a73ffeffb1c140939023915a35134b:

  KVM: s390/mm: Properly reset no-dat (2023-11-14 18:56:46 +0100)

----------------------------------------------------------------
Two small but important bugfixes.

----------------------------------------------------------------
Claudio Imbrenda (2):
      KVM: s390: vsie: fix wrong VIR 37 when MSO is used
      KVM: s390/mm: Properly reset no-dat

 arch/s390/kvm/vsie.c   | 4 ----
 arch/s390/mm/pgtable.c | 2 +-
 2 files changed, 1 insertion(+), 5 deletions(-)

-- 
2.41.0

