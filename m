Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AF8DD1918FD
	for <lists+linux-s390@lfdr.de>; Tue, 24 Mar 2020 19:25:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727937AbgCXSZH (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Tue, 24 Mar 2020 14:25:07 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:65250 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727957AbgCXSZG (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 24 Mar 2020 14:25:06 -0400
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02OI3NKM037454
        for <linux-s390@vger.kernel.org>; Tue, 24 Mar 2020 14:25:05 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2ywejwp2me-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Tue, 24 Mar 2020 14:25:04 -0400
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <jwi@linux.ibm.com>;
        Tue, 24 Mar 2020 18:24:59 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 24 Mar 2020 18:24:56 -0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 02OIOvTR41484450
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 24 Mar 2020 18:24:58 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E3DF5A405B;
        Tue, 24 Mar 2020 18:24:57 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AD0A7A405C;
        Tue, 24 Mar 2020 18:24:57 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 24 Mar 2020 18:24:57 +0000 (GMT)
From:   Julian Wiedmann <jwi@linux.ibm.com>
To:     David Miller <davem@davemloft.net>
Cc:     netdev <netdev@vger.kernel.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Ursula Braun <ubraun@linux.ibm.com>,
        Julian Wiedmann <jwi@linux.ibm.com>
Subject: [PATCH net-next 11/11] s390/qeth: modernize two list helpers
Date:   Tue, 24 Mar 2020 19:24:48 +0100
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200324182448.95362-1-jwi@linux.ibm.com>
References: <20200324182448.95362-1-jwi@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 20032418-0020-0000-0000-000003BA4DAA
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20032418-0021-0000-0000-00002212CFCF
Message-Id: <20200324182448.95362-12-jwi@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.645
 definitions=2020-03-24_06:2020-03-23,2020-03-24 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 clxscore=1015
 suspectscore=2 spamscore=0 mlxscore=0 mlxlogscore=966 adultscore=0
 bulkscore=0 phishscore=0 lowpriorityscore=0 priorityscore=1501
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2003240091
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Replace list_for_each() with list_for_each_entry(), and
list_entry(head.next) with list_first_entry().

Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
---
 drivers/s390/net/qeth_core_main.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/s390/net/qeth_core_main.c b/drivers/s390/net/qeth_core_main.c
index 4940e4fb556e..79a92761e50a 100644
--- a/drivers/s390/net/qeth_core_main.c
+++ b/drivers/s390/net/qeth_core_main.c
@@ -2629,15 +2629,13 @@ static void qeth_initialize_working_pool_list(struct qeth_card *card)
 static struct qeth_buffer_pool_entry *qeth_find_free_buffer_pool_entry(
 					struct qeth_card *card)
 {
-	struct list_head *plh;
 	struct qeth_buffer_pool_entry *entry;
 	int i, free;
 
 	if (list_empty(&card->qdio.in_buf_pool.entry_list))
 		return NULL;
 
-	list_for_each(plh, &card->qdio.in_buf_pool.entry_list) {
-		entry = list_entry(plh, struct qeth_buffer_pool_entry, list);
+	list_for_each_entry(entry, &card->qdio.in_buf_pool.entry_list, list) {
 		free = 1;
 		for (i = 0; i < QETH_MAX_BUFFER_ELEMENTS(card); ++i) {
 			if (page_count(entry->elements[i]) > 1) {
@@ -2652,8 +2650,8 @@ static struct qeth_buffer_pool_entry *qeth_find_free_buffer_pool_entry(
 	}
 
 	/* no free buffer in pool so take first one and swap pages */
-	entry = list_entry(card->qdio.in_buf_pool.entry_list.next,
-			struct qeth_buffer_pool_entry, list);
+	entry = list_first_entry(&card->qdio.in_buf_pool.entry_list,
+				 struct qeth_buffer_pool_entry, list);
 	for (i = 0; i < QETH_MAX_BUFFER_ELEMENTS(card); ++i) {
 		if (page_count(entry->elements[i]) > 1) {
 			struct page *page = dev_alloc_page();
-- 
2.17.1

