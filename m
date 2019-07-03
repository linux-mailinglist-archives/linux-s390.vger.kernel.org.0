Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 39C9A5E1E1
	for <lists+linux-s390@lfdr.de>; Wed,  3 Jul 2019 12:20:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726993AbfGCKUP (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Wed, 3 Jul 2019 06:20:15 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:32898 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726765AbfGCKUP (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 3 Jul 2019 06:20:15 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x63AJGtC146420
        for <linux-s390@vger.kernel.org>; Wed, 3 Jul 2019 06:20:13 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2tgrdrwm4k-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Wed, 03 Jul 2019 06:20:13 -0400
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <maier@linux.ibm.com>;
        Wed, 3 Jul 2019 11:20:11 +0100
Received: from b06avi18878370.portsmouth.uk.ibm.com (9.149.26.194)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 3 Jul 2019 11:20:08 +0100
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x63AK7qr34800090
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 3 Jul 2019 10:20:07 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 007124C044;
        Wed,  3 Jul 2019 10:20:07 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B087C4C04A;
        Wed,  3 Jul 2019 10:20:06 +0000 (GMT)
Received: from oc4120165700.ibm.com (unknown [9.152.97.10])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed,  3 Jul 2019 10:20:06 +0000 (GMT)
From:   Steffen Maier <maier@linux.ibm.com>
To:     linux-doc@vger.kernel.org
Cc:     linux-s390@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] docs: s390: restore content and update s390dbf.rst
Date:   Wed,  3 Jul 2019 12:19:46 +0200
X-Mailer: git-send-email 1.8.3.1
X-TM-AS-GCONF: 00
x-cbid: 19070310-0028-0000-0000-0000037FF27A
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19070310-0029-0000-0000-000024403038
Message-Id: <1562149189-1417-1-git-send-email-maier@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-03_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=744 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1907030125
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

This is based on top of the 3 s390 patches Heiko already queued on our
s390 features branch.
[("Re: [PATCH v3 00/33] Convert files to ReST - part 1")
 https://www.spinics.net/lists/linux-doc/msg66137.html
 https://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git/log/Documentation/s390?h=features]

If I was not mistaken, some documentation was accidentally lost
and patch 1 restores it.

After having looked closer, I came up with patches 2 and 3.
Rendered successfully on a current Fedora 30 and it looks good:
$ make SPHINXDIRS="s390" htmldocs

Steffen Maier (3):
  docs: s390: restore important non-kdoc parts of s390dbf.rst
  docs: s390: unify and update s390dbf kdocs at debug.c
  docs: s390: s390dbf: typos and formatting, update crash command

 Documentation/s390/s390dbf.rst | 390 +++++++++++++++++++++++++++++++++++++++--
 arch/s390/include/asm/debug.h  | 112 ++----------
 arch/s390/kernel/debug.c       | 105 +++++++++--
 3 files changed, 473 insertions(+), 134 deletions(-)

-- 
1.8.3.1

