Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CD722A41D0
	for <lists+linux-s390@lfdr.de>; Tue,  3 Nov 2020 11:27:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728254AbgKCK0Z (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Tue, 3 Nov 2020 05:26:25 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:24708 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728032AbgKCKZz (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 3 Nov 2020 05:25:55 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0A3A2LqV168623;
        Tue, 3 Nov 2020 05:25:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references; s=pp1;
 bh=f45+TYglhnKBzsSq/k2fpO82103odcxyODtnYOvDf1U=;
 b=Yo00Da+UqdLhAMR+EIU1zdoYBU9VyBM1arijiyTeZFE5vUg4dcOfaItR25snm65tcbil
 aNhQtG9EOWwL1REsz5HMu7lJGajtdQcq+j8GLQtv/jFcKSQj9kASawmPM1AYu3mRoKjh
 0B4KsRuIDn2bf7K8fMQKMt2BAodXUwY8WhY122XTQ2LgnEpkdEhY2AAphSm3HeOmpTpf
 3fk+sobxRbxUxaY87g6dmz558hLYHJjuS92TGZwp3oa1KRyB+OlU7wYjkWaAwcdfw5wE
 1886Xc0NfjPwyLQ+8lT8CbQ9pvjutIcebL1EYSX5fMR2XMlhnjm+/SA9O8KfO3UNvmdb wA== 
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0b-001b2d01.pphosted.com with ESMTP id 34jwj150nb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 03 Nov 2020 05:25:52 -0500
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0A3AN2wU023221;
        Tue, 3 Nov 2020 10:25:51 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma06ams.nl.ibm.com with ESMTP id 34h0fcu4fe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 03 Nov 2020 10:25:51 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0A3APmBp61604250
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 3 Nov 2020 10:25:48 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7C01EA4054;
        Tue,  3 Nov 2020 10:25:48 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 40F9FA405B;
        Tue,  3 Nov 2020 10:25:48 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue,  3 Nov 2020 10:25:48 +0000 (GMT)
From:   Karsten Graul <kgraul@linux.ibm.com>
To:     davem@davemloft.net
Cc:     netdev@vger.kernel.org, linux-s390@vger.kernel.org,
        hca@linux.ibm.com, raspl@linux.ibm.com
Subject: [PATCH net-next v2 07/15] net/smc: Refactor the netlink reply processing routine
Date:   Tue,  3 Nov 2020 11:25:23 +0100
Message-Id: <20201103102531.91710-8-kgraul@linux.ibm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201103102531.91710-1-kgraul@linux.ibm.com>
References: <20201103102531.91710-1-kgraul@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-03_07:2020-11-02,2020-11-03 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=1
 adultscore=0 priorityscore=1501 lowpriorityscore=0 bulkscore=0
 impostorscore=0 spamscore=0 mlxlogscore=999 mlxscore=0 clxscore=1015
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011030065
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

From: Guvenc Gulce <guvenc@linux.ibm.com>

Refactor the netlink reply processing routine so that
it provides sub functions for specific parts of the processing.

Signed-off-by: Guvenc Gulce <guvenc@linux.ibm.com>
Signed-off-by: Karsten Graul <kgraul@linux.ibm.com>
---
 net/smc/smc_diag.c | 218 +++++++++++++++++++++++++++------------------
 1 file changed, 133 insertions(+), 85 deletions(-)

diff --git a/net/smc/smc_diag.c b/net/smc/smc_diag.c
index c2225231f679..44be723c97fe 100644
--- a/net/smc/smc_diag.c
+++ b/net/smc/smc_diag.c
@@ -69,35 +69,25 @@ static void smc_diag_msg_common_fill(struct smc_diag_msg *r, struct sock *sk)
 	}
 }
 
-static int smc_diag_msg_attrs_fill(struct sock *sk, struct sk_buff *skb,
-				   struct smc_diag_msg *r,
-				   struct user_namespace *user_ns)
+static bool smc_diag_msg_attrs_fill(struct sock *sk, struct sk_buff *skb,
+				    struct smc_diag_msg *r,
+				    struct user_namespace *user_ns)
 {
-	if (nla_put_u8(skb, SMC_DIAG_SHUTDOWN, sk->sk_shutdown))
-		return 1;
+	if (nla_put_u8(skb, SMC_DIAG_SHUTDOWN, sk->sk_shutdown) < 0)
+		return false;
 
 	r->diag_uid = from_kuid_munged(user_ns, sock_i_uid(sk));
 	r->diag_inode = sock_i_ino(sk);
-	return 0;
+	return true;
 }
 
-static int __smc_diag_dump(struct sock *sk, struct sk_buff *skb,
-			   struct netlink_callback *cb,
-			   const struct smc_diag_req *req,
-			   struct nlattr *bc)
+static bool smc_diag_fill_base_struct(struct sock *sk, struct sk_buff *skb,
+				      struct netlink_callback *cb,
+				      struct smc_diag_msg *r)
 {
 	struct smc_sock *smc = smc_sk(sk);
-	struct smc_diag_fallback fallback;
 	struct user_namespace *user_ns;
-	struct smc_diag_msg *r;
-	struct nlmsghdr *nlh;
 
-	nlh = nlmsg_put(skb, NETLINK_CB(cb->skb).portid, cb->nlh->nlmsg_seq,
-			cb->nlh->nlmsg_type, sizeof(*r), NLM_F_MULTI);
-	if (!nlh)
-		return -EMSGSIZE;
-
-	r = nlmsg_data(nlh);
 	smc_diag_msg_common_fill(r, sk);
 	r->diag_state = sk->sk_state;
 	if (smc->use_fallback)
@@ -107,89 +97,148 @@ static int __smc_diag_dump(struct sock *sk, struct sk_buff *skb,
 	else
 		r->diag_mode = SMC_DIAG_MODE_SMCR;
 	user_ns = sk_user_ns(NETLINK_CB(cb->skb).sk);
-	if (smc_diag_msg_attrs_fill(sk, skb, r, user_ns))
-		goto errout;
+	if (!smc_diag_msg_attrs_fill(sk, skb, r, user_ns))
+		return false;
 
+	return true;
+}
+
+static bool smc_diag_fill_fallback(struct sock *sk, struct sk_buff *skb)
+{
+	struct smc_diag_fallback fallback;
+	struct smc_sock *smc = smc_sk(sk);
+
+	memset(&fallback, 0, sizeof(fallback));
 	fallback.reason = smc->fallback_rsn;
 	fallback.peer_diagnosis = smc->peer_diagnosis;
 	if (nla_put(skb, SMC_DIAG_FALLBACK, sizeof(fallback), &fallback) < 0)
+		return false;
+
+	return true;
+}
+
+static bool smc_diag_fill_conninfo(struct sock *sk, struct sk_buff *skb)
+{
+	struct smc_host_cdc_msg *local_tx, *local_rx;
+	struct smc_diag_conninfo cinfo;
+	struct smc_connection *conn;
+	struct smc_sock *smc;
+
+	smc = smc_sk(sk);
+	conn = &smc->conn;
+	local_tx = &conn->local_tx_ctrl;
+	local_rx = &conn->local_rx_ctrl;
+	memset(&cinfo, 0, sizeof(cinfo));
+	cinfo.token = conn->alert_token_local;
+	cinfo.sndbuf_size = conn->sndbuf_desc ? conn->sndbuf_desc->len : 0;
+	cinfo.rmbe_size = conn->rmb_desc ? conn->rmb_desc->len : 0;
+	cinfo.peer_rmbe_size = conn->peer_rmbe_size;
+
+	cinfo.rx_prod.wrap = local_rx->prod.wrap;
+	cinfo.rx_prod.count = local_rx->prod.count;
+	cinfo.rx_cons.wrap = local_rx->cons.wrap;
+	cinfo.rx_cons.count = local_rx->cons.count;
+
+	cinfo.tx_prod.wrap = local_tx->prod.wrap;
+	cinfo.tx_prod.count = local_tx->prod.count;
+	cinfo.tx_cons.wrap = local_tx->cons.wrap;
+	cinfo.tx_cons.count = local_tx->cons.count;
+
+	cinfo.tx_prod_flags = *(u8 *)&local_tx->prod_flags;
+	cinfo.tx_conn_state_flags = *(u8 *)&local_tx->conn_state_flags;
+	cinfo.rx_prod_flags = *(u8 *)&local_rx->prod_flags;
+	cinfo.rx_conn_state_flags = *(u8 *)&local_rx->conn_state_flags;
+
+	cinfo.tx_prep.wrap = conn->tx_curs_prep.wrap;
+	cinfo.tx_prep.count = conn->tx_curs_prep.count;
+	cinfo.tx_sent.wrap = conn->tx_curs_sent.wrap;
+	cinfo.tx_sent.count = conn->tx_curs_sent.count;
+	cinfo.tx_fin.wrap = conn->tx_curs_fin.wrap;
+	cinfo.tx_fin.count = conn->tx_curs_fin.count;
+
+	if (nla_put(skb, SMC_DIAG_CONNINFO, sizeof(cinfo), &cinfo) < 0)
+		return false;
+
+	return true;
+}
+
+static bool smc_diag_fill_lgrinfo(struct sock *sk, struct sk_buff *skb)
+{
+	struct smc_sock *smc = smc_sk(sk);
+	struct smc_diag_lgrinfo linfo;
+
+	memset(&linfo, 0, sizeof(linfo));
+	linfo.role = smc->conn.lgr->role;
+	linfo.lnk[0].ibport = smc->conn.lnk->ibport;
+	linfo.lnk[0].link_id = smc->conn.lnk->link_id;
+	memcpy(linfo.lnk[0].ibname, smc->conn.lnk->ibname,
+	       sizeof(linfo.lnk[0].ibname));
+	smc_gid_be16_convert(linfo.lnk[0].gid,
+			     smc->conn.lnk->gid);
+	smc_gid_be16_convert(linfo.lnk[0].peer_gid,
+			     smc->conn.lnk->peer_gid);
+
+	if (nla_put(skb, SMC_DIAG_LGRINFO, sizeof(linfo), &linfo) < 0)
+		return false;
+
+	return true;
+}
+
+static bool smc_diag_fill_dmbinfo(struct sock *sk, struct sk_buff *skb)
+{
+	struct smc_sock *smc = smc_sk(sk);
+	struct smcd_diag_dmbinfo dinfo;
+	struct smc_connection *conn;
+
+	memset(&dinfo, 0, sizeof(dinfo));
+	conn = &smc->conn;
+	dinfo.linkid = *((u32 *)conn->lgr->id);
+	dinfo.peer_gid = conn->lgr->peer_gid;
+	dinfo.my_gid = conn->lgr->smcd->local_gid;
+	dinfo.token = conn->rmb_desc->token;
+	dinfo.peer_token = conn->peer_token;
+
+	if (nla_put(skb, SMC_DIAG_DMBINFO, sizeof(dinfo), &dinfo) < 0)
+		return false;
+	return true;
+}
+
+static int __smc_diag_dump(struct sock *sk, struct sk_buff *skb,
+			   struct netlink_callback *cb,
+			   const struct smc_diag_req *req)
+{
+	struct smc_sock *smc = smc_sk(sk);
+	struct smc_diag_msg *r;
+	struct nlmsghdr *nlh;
+
+	nlh = nlmsg_put(skb, NETLINK_CB(cb->skb).portid, cb->nlh->nlmsg_seq,
+			cb->nlh->nlmsg_type, sizeof(*r), NLM_F_MULTI);
+	if (!nlh)
+		return -EMSGSIZE;
+
+	r = nlmsg_data(nlh);
+	if (!smc_diag_fill_base_struct(sk, skb, cb, r))
+		goto errout;
+
+	if (!smc_diag_fill_fallback(sk, skb))
 		goto errout;
 
 	if ((req->diag_ext & (1 << (SMC_DIAG_CONNINFO - 1))) &&
 	    smc->conn.alert_token_local) {
-		struct smc_connection *conn = &smc->conn;
-		struct smc_diag_conninfo cinfo = {
-			.token = conn->alert_token_local,
-			.sndbuf_size = conn->sndbuf_desc ?
-				conn->sndbuf_desc->len : 0,
-			.rmbe_size = conn->rmb_desc ? conn->rmb_desc->len : 0,
-			.peer_rmbe_size = conn->peer_rmbe_size,
-
-			.rx_prod.wrap = conn->local_rx_ctrl.prod.wrap,
-			.rx_prod.count = conn->local_rx_ctrl.prod.count,
-			.rx_cons.wrap = conn->local_rx_ctrl.cons.wrap,
-			.rx_cons.count = conn->local_rx_ctrl.cons.count,
-
-			.tx_prod.wrap = conn->local_tx_ctrl.prod.wrap,
-			.tx_prod.count = conn->local_tx_ctrl.prod.count,
-			.tx_cons.wrap = conn->local_tx_ctrl.cons.wrap,
-			.tx_cons.count = conn->local_tx_ctrl.cons.count,
-
-			.tx_prod_flags =
-				*(u8 *)&conn->local_tx_ctrl.prod_flags,
-			.tx_conn_state_flags =
-				*(u8 *)&conn->local_tx_ctrl.conn_state_flags,
-			.rx_prod_flags = *(u8 *)&conn->local_rx_ctrl.prod_flags,
-			.rx_conn_state_flags =
-				*(u8 *)&conn->local_rx_ctrl.conn_state_flags,
-
-			.tx_prep.wrap = conn->tx_curs_prep.wrap,
-			.tx_prep.count = conn->tx_curs_prep.count,
-			.tx_sent.wrap = conn->tx_curs_sent.wrap,
-			.tx_sent.count = conn->tx_curs_sent.count,
-			.tx_fin.wrap = conn->tx_curs_fin.wrap,
-			.tx_fin.count = conn->tx_curs_fin.count,
-		};
-
-		if (nla_put(skb, SMC_DIAG_CONNINFO, sizeof(cinfo), &cinfo) < 0)
+		if (!smc_diag_fill_conninfo(sk, skb))
 			goto errout;
 	}
 
 	if (smc->conn.lgr && !smc->conn.lgr->is_smcd &&
 	    (req->diag_ext & (1 << (SMC_DIAG_LGRINFO - 1))) &&
 	    !list_empty(&smc->conn.lgr->list)) {
-		struct smc_diag_lgrinfo linfo = {
-			.role = smc->conn.lgr->role,
-			.lnk[0].ibport = smc->conn.lnk->ibport,
-			.lnk[0].link_id = smc->conn.lnk->link_id,
-		};
-
-		memcpy(linfo.lnk[0].ibname,
-		       smc->conn.lgr->lnk[0].smcibdev->ibdev->name,
-		       sizeof(smc->conn.lnk->smcibdev->ibdev->name));
-		smc_gid_be16_convert(linfo.lnk[0].gid,
-				     smc->conn.lnk->gid);
-		smc_gid_be16_convert(linfo.lnk[0].peer_gid,
-				     smc->conn.lnk->peer_gid);
-
-		if (nla_put(skb, SMC_DIAG_LGRINFO, sizeof(linfo), &linfo) < 0)
+		if (!smc_diag_fill_lgrinfo(sk, skb))
 			goto errout;
 	}
 	if (smc->conn.lgr && smc->conn.lgr->is_smcd &&
 	    (req->diag_ext & (1 << (SMC_DIAG_DMBINFO - 1))) &&
 	    !list_empty(&smc->conn.lgr->list)) {
-		struct smc_connection *conn = &smc->conn;
-		struct smcd_diag_dmbinfo dinfo;
-
-		memset(&dinfo, 0, sizeof(dinfo));
-
-		dinfo.linkid = *((u32 *)conn->lgr->id);
-		dinfo.peer_gid = conn->lgr->peer_gid;
-		dinfo.my_gid = conn->lgr->smcd->local_gid;
-		dinfo.token = conn->rmb_desc->token;
-		dinfo.peer_token = conn->peer_token;
-
-		if (nla_put(skb, SMC_DIAG_DMBINFO, sizeof(dinfo), &dinfo) < 0)
+		if (!smc_diag_fill_dmbinfo(sk, skb))
 			goto errout;
 	}
 
@@ -207,7 +256,6 @@ static int smc_diag_dump_proto(struct proto *prot, struct sk_buff *skb,
 	struct smc_diag_dump_ctx *cb_ctx = smc_dump_context(cb);
 	struct net *net = sock_net(skb->sk);
 	int snum = cb_ctx->pos[p_type];
-	struct nlattr *bc = NULL;
 	struct hlist_head *head;
 	int rc = 0, num = 0;
 	struct sock *sk;
@@ -222,7 +270,7 @@ static int smc_diag_dump_proto(struct proto *prot, struct sk_buff *skb,
 			continue;
 		if (num < snum)
 			goto next;
-		rc = __smc_diag_dump(sk, skb, cb, nlmsg_data(cb->nlh), bc);
+		rc = __smc_diag_dump(sk, skb, cb, nlmsg_data(cb->nlh));
 		if (rc < 0)
 			goto out;
 next:
-- 
2.17.1

