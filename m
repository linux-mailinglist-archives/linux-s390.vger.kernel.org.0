Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 910871C5D85
	for <lists+linux-s390@lfdr.de>; Tue,  5 May 2020 18:26:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730761AbgEEQ0g (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Tue, 5 May 2020 12:26:36 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:51980 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730650AbgEEQ0K (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 5 May 2020 12:26:10 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 045G3YaL110781;
        Tue, 5 May 2020 12:26:09 -0400
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 30u8sy6drf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 05 May 2020 12:26:09 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 045GJjur003079;
        Tue, 5 May 2020 16:26:06 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma04ams.nl.ibm.com with ESMTP id 30s0g5qakx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 05 May 2020 16:26:06 +0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 045GQ4FM60293278
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 5 May 2020 16:26:04 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E489942045;
        Tue,  5 May 2020 16:26:03 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A461142049;
        Tue,  5 May 2020 16:26:03 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue,  5 May 2020 16:26:03 +0000 (GMT)
From:   Julian Wiedmann <jwi@linux.ibm.com>
To:     David Miller <davem@davemloft.net>
Cc:     netdev <netdev@vger.kernel.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Ursula Braun <ubraun@linux.ibm.com>,
        Julian Wiedmann <jwi@linux.ibm.com>
Subject: [PATCH net-next 07/11] s390/qeth: indicate contiguous TX buffer elements
Date:   Tue,  5 May 2020 18:25:55 +0200
Message-Id: <20200505162559.14138-8-jwi@linux.ibm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200505162559.14138-1-jwi@linux.ibm.com>
References: <20200505162559.14138-1-jwi@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-05-05_09:2020-05-04,2020-05-05 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 phishscore=0
 suspectscore=2 clxscore=1015 impostorscore=0 priorityscore=1501 mlxscore=0
 adultscore=0 spamscore=0 lowpriorityscore=0 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2005050124
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

The TX path usually maps the full content of a page into a buffer
element. But there's specific skb layouts (ie. linearized TSO skbs)
where the HW header (1) requires a separate buffer element, and (2) is
page-contiguous with the packet data that's mapped into the next buffer
element.
Flag such buffer elements accordingly, so that HW can optimize its data
access for them.

Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
---
 drivers/s390/net/qeth_core_main.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/s390/net/qeth_core_main.c b/drivers/s390/net/qeth_core_main.c
index 9c9a6edb5384..4d1d053eebb7 100644
--- a/drivers/s390/net/qeth_core_main.c
+++ b/drivers/s390/net/qeth_core_main.c
@@ -4110,8 +4110,16 @@ static unsigned int qeth_fill_buffer(struct qeth_qdio_out_buffer *buf,
 		buffer->element[element].addr = virt_to_phys(hdr);
 		buffer->element[element].length = hd_len;
 		buffer->element[element].eflags = SBAL_EFLAGS_FIRST_FRAG;
-		/* remember to free cache-allocated HW header: */
-		buf->is_header[element] = ((void *)hdr != skb->data);
+
+		/* HW header is allocated from cache: */
+		if ((void *)hdr != skb->data)
+			buf->is_header[element] = 1;
+		/* HW header was pushed and is contiguous with linear part: */
+		else if (length > 0 && !PAGE_ALIGNED(data) &&
+			 (data == (char *)hdr + hd_len))
+			buffer->element[element].eflags |=
+				SBAL_EFLAGS_CONTIGUOUS;
+
 		element++;
 	}
 
-- 
2.17.1

