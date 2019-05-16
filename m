Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 88A9C20CAD
	for <lists+linux-s390@lfdr.de>; Thu, 16 May 2019 18:14:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726792AbfEPQON (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Thu, 16 May 2019 12:14:13 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:45478 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726541AbfEPQOM (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 16 May 2019 12:14:12 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4GGCbrs086255
        for <linux-s390@vger.kernel.org>; Thu, 16 May 2019 12:14:11 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2sh8wqf1j4-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Thu, 16 May 2019 12:14:11 -0400
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <farman@linux.ibm.com>;
        Thu, 16 May 2019 17:14:09 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 16 May 2019 17:14:07 +0100
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x4GGE5Ex49676444
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 16 May 2019 16:14:06 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E0B9B11C0F4;
        Thu, 16 May 2019 16:14:05 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CEF0E11C066;
        Thu, 16 May 2019 16:14:05 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Thu, 16 May 2019 16:14:05 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 4958)
        id 7AEE3E0639; Thu, 16 May 2019 18:14:05 +0200 (CEST)
From:   Eric Farman <farman@linux.ibm.com>
To:     Cornelia Huck <cohuck@redhat.com>, Farhan Ali <alifm@linux.ibm.com>
Cc:     Halil Pasic <pasic@linux.ibm.com>,
        Pierre Morel <pmorel@linux.ibm.com>,
        linux-s390@vger.kernel.org, kvm@vger.kernel.org,
        Eric Farman <farman@linux.ibm.com>
Subject: [PATCH v3 0/3] s390: vfio-ccw fixes
Date:   Thu, 16 May 2019 18:14:00 +0200
X-Mailer: git-send-email 2.17.1
X-TM-AS-GCONF: 00
x-cbid: 19051616-0028-0000-0000-0000036E6A30
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19051616-0029-0000-0000-0000242E05BB
Message-Id: <20190516161403.79053-1-farman@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-16_14:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=922 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1905160103
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Here are the remaining patches in my fixes series, to handle the more
involved scenario of channel programs that do not move any actual data
to/from the device.  They were reordered per feedback from v2, which
means they received minor massaging because of overlapping code and
some cleanup to the commit messages.

They are based on Conny's vfio-ccw tree.  :)

Changelog:
 v2 -> v3:
  - Patches 1-4:
     - [Farhan] Added r-b
     - [Cornelia] Queued to vfio-ccw, dropped from this version
  - Patches 5/6:
     - [Cornelia/Farhan] Swapped the order of these patches, minor
       rework on the placement of bytes/idaw_nr variables and the
       commit messages that resulted.
 v2: https://patchwork.kernel.org/cover/10944075/
 v1: https://patchwork.kernel.org/cover/10928799/

Eric Farman (3):
  s390/cio: Don't pin vfio pages for empty transfers
  s390/cio: Allow zero-length CCWs in vfio-ccw
  s390/cio: Remove vfio-ccw checks of command codes

 drivers/s390/cio/vfio_ccw_cp.c | 92 ++++++++++++++++++++++++----------
 1 file changed, 65 insertions(+), 27 deletions(-)

-- 
2.17.1

