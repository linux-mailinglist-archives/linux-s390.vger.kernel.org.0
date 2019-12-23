Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 313B91296C5
	for <lists+linux-s390@lfdr.de>; Mon, 23 Dec 2019 15:03:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726933AbfLWODm (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Mon, 23 Dec 2019 09:03:42 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:6214 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726934AbfLWODl (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 23 Dec 2019 09:03:41 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xBNE3NRC141748
        for <linux-s390@vger.kernel.org>; Mon, 23 Dec 2019 09:03:39 -0500
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2x21wbdfus-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Mon, 23 Dec 2019 09:03:39 -0500
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <jwi@linux.ibm.com>;
        Mon, 23 Dec 2019 14:03:36 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 23 Dec 2019 14:03:33 -0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id xBNE3VqM35258524
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 23 Dec 2019 14:03:31 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AF8BCA4062;
        Mon, 23 Dec 2019 14:03:31 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6D421A4065;
        Mon, 23 Dec 2019 14:03:31 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 23 Dec 2019 14:03:31 +0000 (GMT)
From:   Julian Wiedmann <jwi@linux.ibm.com>
To:     David Miller <davem@davemloft.net>
Cc:     <netdev@vger.kernel.org>, <linux-s390@vger.kernel.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Stefan Raspl <raspl@linux.ibm.com>,
        Ursula Braun <ubraun@linux.ibm.com>,
        Alexandra Winter <wintera@linux.ibm.com>,
        Julian Wiedmann <jwi@linux.ibm.com>
Subject: [PATCH net 4/6] s390/qeth: Fix vnicc_is_in_use if rx_bcast not set
Date:   Mon, 23 Dec 2019 15:03:24 +0100
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191223140326.16488-1-jwi@linux.ibm.com>
References: <20191223140326.16488-1-jwi@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 19122314-4275-0000-0000-00000391C000
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19122314-4276-0000-0000-000038A594EA
Message-Id: <20191223140326.16488-5-jwi@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-23_06:2019-12-23,2019-12-23 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 spamscore=0
 clxscore=1015 malwarescore=0 mlxlogscore=999 impostorscore=0 adultscore=0
 mlxscore=0 suspectscore=0 priorityscore=1501 bulkscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1912230121
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

From: Alexandra Winter <wintera@linux.ibm.com>

Symptom: After vnicc/rx_bcast has been manually set to 0,
	bridge_* sysfs parameters can still be set or written.
Only occurs on HiperSockets, as OSA doesn't support changing rx_bcast.

Vnic characteristics and bridgeport settings are mutually exclusive.
rx_bcast defaults to 1, so manually setting it to 0 should disable
bridge_* parameters.

Instead it makes sense here to check the supported mask. If the card
does not support vnicc at all, bridge commands are always allowed.

Fixes: caa1f0b10d18 ("s390/qeth: add VNICC enable/disable support")
Signed-off-by: Alexandra Winter <wintera@linux.ibm.com>
Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
---
 drivers/s390/net/qeth_l2_main.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/s390/net/qeth_l2_main.c b/drivers/s390/net/qeth_l2_main.c
index fc5d8ed3a737..8024a2112a87 100644
--- a/drivers/s390/net/qeth_l2_main.c
+++ b/drivers/s390/net/qeth_l2_main.c
@@ -1952,8 +1952,7 @@ int qeth_l2_vnicc_get_timeout(struct qeth_card *card, u32 *timeout)
 /* check if VNICC is currently enabled */
 bool qeth_l2_vnicc_is_in_use(struct qeth_card *card)
 {
-	/* if everything is turned off, VNICC is not active */
-	if (!card->options.vnicc.cur_chars)
+	if (!card->options.vnicc.sup_chars)
 		return false;
 	/* default values are only OK if rx_bcast was not enabled by user
 	 * or the card is offline.
-- 
2.17.1

