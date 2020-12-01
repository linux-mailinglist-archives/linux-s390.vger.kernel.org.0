Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D34D92CABBC
	for <lists+linux-s390@lfdr.de>; Tue,  1 Dec 2020 20:22:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404322AbgLATV4 (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Tue, 1 Dec 2020 14:21:56 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:31112 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728870AbgLATVp (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 1 Dec 2020 14:21:45 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0B1J2Sbu129476;
        Tue, 1 Dec 2020 14:21:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references; s=pp1;
 bh=pttTdUESkBeR5eE/dIPitvmuWql6VqLxapQp+i/eeO0=;
 b=pszRG/016YDwk17z+JD+qgeV+3EFAaYII0JXF6+ikB40bsQWuUKJjW+U8hG4848f9DEy
 qEmUlGwIXyFA2FXFYbR6wzu4yU3wJkWmYgLkWSZ9Y9Wbg2FX/h4/a5IFQ2xMH3Fjcalb
 pnGyyfhY6m1REUGSHIW8FjL7kU9NZ93Q1tG2DMqq4ijMentfvCqIHyHJvvE2t8od1mDE
 MCzR/863rA0FKoy+V8zknTv7lBJeLUbIJnEQV9WAp2lH9czv71grJtKDS9Eqo8S5G8Yr
 rfY66JRC7CF0/G/TE7hzjf8ea3Znu5Unp43eo5l9R5P9Dt72sDAjTgYW09wdYP7r7ZCZ cg== 
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 355j4fn0t5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 01 Dec 2020 14:21:00 -0500
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0B1JGW4D021257;
        Tue, 1 Dec 2020 19:20:58 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma03ams.nl.ibm.com with ESMTP id 353e68bf6m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 01 Dec 2020 19:20:58 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0B1JKtA5328298
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 1 Dec 2020 19:20:56 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D0ECDAE04D;
        Tue,  1 Dec 2020 19:20:55 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 969DFAE045;
        Tue,  1 Dec 2020 19:20:55 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue,  1 Dec 2020 19:20:55 +0000 (GMT)
From:   Karsten Graul <kgraul@linux.ibm.com>
To:     David Miller <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>
Cc:     Heiko Carstens <hca@linux.ibm.com>,
        Stefan Raspl <raspl@linux.ibm.com>, netdev@vger.kernel.org,
        linux-s390@vger.kernel.org
Subject: [PATCH net-next v7 01/14] net/smc: use helper smc_conn_abort() in listen processing
Date:   Tue,  1 Dec 2020 20:20:36 +0100
Message-Id: <20201201192049.53517-2-kgraul@linux.ibm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201201192049.53517-1-kgraul@linux.ibm.com>
References: <20201201192049.53517-1-kgraul@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-12-01_07:2020-11-30,2020-12-01 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=2 bulkscore=0
 adultscore=0 lowpriorityscore=0 mlxlogscore=928 malwarescore=0
 priorityscore=1501 clxscore=1015 spamscore=0 impostorscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012010112
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

The helper smc_connect_abort() can be used by the listen processing
functions, too. And rename this helper to smc_conn_abort() to make the
purpose clearer.
No functional change.

Signed-off-by: Karsten Graul <kgraul@linux.ibm.com>
---
 net/smc/af_smc.c | 17 +++++------------
 1 file changed, 5 insertions(+), 12 deletions(-)

diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
index 811819c849da..13db3f260e94 100644
--- a/net/smc/af_smc.c
+++ b/net/smc/af_smc.c
@@ -552,8 +552,7 @@ static int smc_connect_decline_fallback(struct smc_sock *smc, int reason_code,
 	return smc_connect_fallback(smc, reason_code);
 }
 
-/* abort connecting */
-static void smc_connect_abort(struct smc_sock *smc, int local_first)
+static void smc_conn_abort(struct smc_sock *smc, int local_first)
 {
 	if (local_first)
 		smc_lgr_cleanup_early(&smc->conn);
@@ -814,7 +813,7 @@ static int smc_connect_rdma(struct smc_sock *smc,
 
 	return 0;
 connect_abort:
-	smc_connect_abort(smc, ini->first_contact_local);
+	smc_conn_abort(smc, ini->first_contact_local);
 	mutex_unlock(&smc_client_lgr_pending);
 	smc->connect_nonblock = 0;
 
@@ -893,7 +892,7 @@ static int smc_connect_ism(struct smc_sock *smc,
 
 	return 0;
 connect_abort:
-	smc_connect_abort(smc, ini->first_contact_local);
+	smc_conn_abort(smc, ini->first_contact_local);
 	mutex_unlock(&smc_server_lgr_pending);
 	smc->connect_nonblock = 0;
 
@@ -1321,10 +1320,7 @@ static void smc_listen_decline(struct smc_sock *new_smc, int reason_code,
 			       int local_first, u8 version)
 {
 	/* RDMA setup failed, switch back to TCP */
-	if (local_first)
-		smc_lgr_cleanup_early(&new_smc->conn);
-	else
-		smc_conn_free(&new_smc->conn);
+	smc_conn_abort(new_smc, local_first);
 	if (reason_code < 0) { /* error, no fallback possible */
 		smc_listen_out_err(new_smc);
 		return;
@@ -1430,10 +1426,7 @@ static int smc_listen_ism_init(struct smc_sock *new_smc,
 	/* Create send and receive buffers */
 	rc = smc_buf_create(new_smc, true);
 	if (rc) {
-		if (ini->first_contact_local)
-			smc_lgr_cleanup_early(&new_smc->conn);
-		else
-			smc_conn_free(&new_smc->conn);
+		smc_conn_abort(new_smc, ini->first_contact_local);
 		return (rc == -ENOSPC) ? SMC_CLC_DECL_MAX_DMB :
 					 SMC_CLC_DECL_MEM;
 	}
-- 
2.17.1

