Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 025831C3927
	for <lists+linux-s390@lfdr.de>; Mon,  4 May 2020 14:19:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728767AbgEDMTT (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Mon, 4 May 2020 08:19:19 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:20986 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728587AbgEDMTP (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 4 May 2020 08:19:15 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 044CBcY5153447;
        Mon, 4 May 2020 08:19:12 -0400
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 30s1svmus1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 04 May 2020 08:19:11 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 044C9tiA029258;
        Mon, 4 May 2020 12:19:10 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma03ams.nl.ibm.com with ESMTP id 30s0g5mryg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 04 May 2020 12:19:10 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 044CJ73u54132926
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 4 May 2020 12:19:07 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 83E51A404D;
        Mon,  4 May 2020 12:19:07 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4A322A4053;
        Mon,  4 May 2020 12:19:07 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon,  4 May 2020 12:19:07 +0000 (GMT)
From:   Karsten Graul <kgraul@linux.ibm.com>
To:     davem@davemloft.net
Cc:     netdev@vger.kernel.org, linux-s390@vger.kernel.org,
        heiko.carstens@de.ibm.com, raspl@linux.ibm.com,
        ubraun@linux.ibm.com
Subject: [PATCH net-next 01/12] net/smc: save state of last sent CDC message
Date:   Mon,  4 May 2020 14:18:37 +0200
Message-Id: <20200504121848.46585-2-kgraul@linux.ibm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200504121848.46585-1-kgraul@linux.ibm.com>
References: <20200504121848.46585-1-kgraul@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-05-04_06:2020-05-04,2020-05-04 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 lowpriorityscore=0 malwarescore=0 phishscore=0 adultscore=0
 impostorscore=0 mlxlogscore=900 bulkscore=0 clxscore=1015 suspectscore=1
 mlxscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2005040100
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

When a link goes down and all connections of this link need to be
switched to an other link then the producer cursor and the sequence of
the last successfully sent CDC message must be known. Add the two fields
to the SMC connection and update it in the tx completion handler.
And to allow matching of sequences in error cases reset the seqno to the
old value in smc_cdc_msg_send() when the actual send failed.

Signed-off-by: Karsten Graul <kgraul@linux.ibm.com>
Reviewed-by: Ursula Braun <ubraun@linux.ibm.com>
---
 net/smc/smc.h     | 4 ++++
 net/smc/smc_cdc.c | 6 ++++++
 2 files changed, 10 insertions(+)

diff --git a/net/smc/smc.h b/net/smc/smc.h
index 1a084afa7372..1e9113771600 100644
--- a/net/smc/smc.h
+++ b/net/smc/smc.h
@@ -143,6 +143,9 @@ struct smc_connection {
 						 * .prod cf. TCP snd_nxt
 						 * .cons cf. TCP sends ack
 						 */
+	union smc_host_cursor	local_tx_ctrl_fin;
+						/* prod crsr - confirmed by peer
+						 */
 	union smc_host_cursor	tx_curs_prep;	/* tx - prepared data
 						 * snd_max..wmem_alloc
 						 */
@@ -154,6 +157,7 @@ struct smc_connection {
 						 */
 	atomic_t		sndbuf_space;	/* remaining space in sndbuf */
 	u16			tx_cdc_seq;	/* sequence # for CDC send */
+	u16			tx_cdc_seq_fin;	/* sequence # - tx completed */
 	spinlock_t		send_lock;	/* protect wr_sends */
 	struct delayed_work	tx_work;	/* retry of smc_cdc_msg_send */
 	u32			tx_off;		/* base offset in peer rmb */
diff --git a/net/smc/smc_cdc.c b/net/smc/smc_cdc.c
index f64589d823aa..c5e33296e55c 100644
--- a/net/smc/smc_cdc.c
+++ b/net/smc/smc_cdc.c
@@ -47,6 +47,9 @@ static void smc_cdc_tx_handler(struct smc_wr_tx_pend_priv *pnd_snd,
 		/* guarantee 0 <= sndbuf_space <= sndbuf_desc->len */
 		smp_mb__after_atomic();
 		smc_curs_copy(&conn->tx_curs_fin, &cdcpend->cursor, conn);
+		smc_curs_copy(&conn->local_tx_ctrl_fin, &cdcpend->p_cursor,
+			      conn);
+		conn->tx_cdc_seq_fin = cdcpend->ctrl_seq;
 	}
 	smc_tx_sndbuf_nonfull(smc);
 	bh_unlock_sock(&smc->sk);
@@ -104,6 +107,9 @@ int smc_cdc_msg_send(struct smc_connection *conn,
 	if (!rc) {
 		smc_curs_copy(&conn->rx_curs_confirmed, &cfed, conn);
 		conn->local_rx_ctrl.prod_flags.cons_curs_upd_req = 0;
+	} else {
+		conn->tx_cdc_seq--;
+		conn->local_tx_ctrl.seqno = conn->tx_cdc_seq;
 	}
 
 	return rc;
-- 
2.17.1

