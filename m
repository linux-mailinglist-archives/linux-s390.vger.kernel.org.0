Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 76D8216234F
	for <lists+linux-s390@lfdr.de>; Tue, 18 Feb 2020 10:23:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726199AbgBRJXX (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Tue, 18 Feb 2020 04:23:23 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:22362 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726252AbgBRJXX (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 18 Feb 2020 04:23:23 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01I9JBXb132469
        for <linux-s390@vger.kernel.org>; Tue, 18 Feb 2020 04:23:22 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2y6e1hdbq6-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Tue, 18 Feb 2020 04:23:22 -0500
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <vneethv@linux.ibm.com>;
        Tue, 18 Feb 2020 09:23:20 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 18 Feb 2020 09:23:19 -0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 01I9NHg248038094
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 18 Feb 2020 09:23:17 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8AF1152052;
        Tue, 18 Feb 2020 09:23:17 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 67B3952054;
        Tue, 18 Feb 2020 09:23:17 +0000 (GMT)
From:   Vineeth Vijayan <vneethv@linux.ibm.com>
To:     oberpar@linux.ibm.com
Cc:     linux-s390@vger.kernel.org
Subject: [RFC v2 0/2] fces event support in cio
Date:   Tue, 18 Feb 2020 10:23:15 +0100
X-Mailer: git-send-email 2.17.1
X-TM-AS-GCONF: 00
x-cbid: 20021809-0008-0000-0000-000003540AE4
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20021809-0009-0000-0000-00004A751348
Message-Id: <20200218092317.49846-1-vneethv@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-18_01:2020-02-17,2020-02-18 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 priorityscore=1501 spamscore=0 adultscore=0 mlxscore=0
 impostorscore=0 malwarescore=0 phishscore=0 suspectscore=1 mlxlogscore=574
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002180076
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Compared to the previous version of this RFC(RFC v1 0/2] support
FC-Endpoint Security events), there is a change in the information we
passed to the consumer-devices using path-event. 

Previously we used to share the exact event of fces, which is derived
from the sei_area->ccdf[0]. In this patch, instead of sending the right
event, simply inform the ccwdev about the occurance of 'fces event'
using path_event. The ccwdev then query more information about the
fces-event using the chsc_scud() call and notify based on the reply.

Sebastian Ott (1):
  s390/cio: handle changes related to endpoint security

Vineeth Vijayan (1):
  s390/cio: add support for fces status notification

 arch/s390/include/asm/ccwdev.h |  1 +
 drivers/s390/cio/chp.h         |  1 +
 drivers/s390/cio/chsc.c        | 73 ++++++++++++++++++++++++++++++++++
 drivers/s390/cio/device.c      | 19 ++++++++-
 4 files changed, 93 insertions(+), 1 deletion(-)

-- 
2.17.1

