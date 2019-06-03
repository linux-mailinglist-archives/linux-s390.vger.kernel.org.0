Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 252343330F
	for <lists+linux-s390@lfdr.de>; Mon,  3 Jun 2019 17:05:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729282AbfFCPFk (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Mon, 3 Jun 2019 11:05:40 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:42316 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729045AbfFCPFk (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 3 Jun 2019 11:05:40 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x53F3EkZ104371
        for <linux-s390@vger.kernel.org>; Mon, 3 Jun 2019 11:05:39 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2sw5u686kr-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Mon, 03 Jun 2019 11:05:39 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <jwi@linux.ibm.com>;
        Mon, 3 Jun 2019 16:05:36 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 3 Jun 2019 16:05:33 +0100
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x53F5Wkj48627950
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 3 Jun 2019 15:05:32 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 553314C050;
        Mon,  3 Jun 2019 15:05:32 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 070E74C04A;
        Mon,  3 Jun 2019 15:05:32 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon,  3 Jun 2019 15:05:31 +0000 (GMT)
From:   Julian Wiedmann <jwi@linux.ibm.com>
To:     David Miller <davem@davemloft.net>
Cc:     <netdev@vger.kernel.org>, <linux-s390@vger.kernel.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Stefan Raspl <raspl@linux.ibm.com>,
        Ursula Braun <ubraun@linux.ibm.com>,
        Julian Wiedmann <jwi@linux.ibm.com>
Subject: [PATCH net 0/4] s390/qeth: fixes 2019-06-03
Date:   Mon,  3 Jun 2019 17:04:42 +0200
X-Mailer: git-send-email 2.17.1
X-TM-AS-GCONF: 00
x-cbid: 19060315-0016-0000-0000-00000283391F
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19060315-0017-0000-0000-000032E04444
Message-Id: <20190603150446.23351-1-jwi@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-03_11:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906030105
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Hi Dave,

please apply the following set of qeth fixes to -net.

- The first two patches fix issues in the L3 driver's cast type
  selection for transmitted skbs.
- Alexandra adds a sanity check when retrieving VLAN information from
  neighbour address events.
- The last patch adds some missing error handling for qeth's new
  multiqueue code.

Thanks,
Julian


Alexandra Winter (1):
  s390/qeth: fix VLAN attribute in bridge_hostnotify udev event

Julian Wiedmann (3):
  s390/qeth: handle limited IPv4 broadcast in L3 TX path
  s390/qeth: don't use obsolete dst entry
  s390/qeth: handle error when updating TX queue count

 drivers/s390/net/qeth_core.h      |  2 +-
 drivers/s390/net/qeth_core_main.c | 22 ++++++++----
 drivers/s390/net/qeth_l2_main.c   |  2 +-
 drivers/s390/net/qeth_l3_main.c   | 59 +++++++++++++++++++------------
 4 files changed, 55 insertions(+), 30 deletions(-)

-- 
2.17.1

