Return-Path: <linux-s390+bounces-639-lists+linux-s390=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CD6108183B4
	for <lists+linux-s390@lfdr.de>; Tue, 19 Dec 2023 09:46:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62B5028401A
	for <lists+linux-s390@lfdr.de>; Tue, 19 Dec 2023 08:46:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC6A311728;
	Tue, 19 Dec 2023 08:45:51 +0000 (UTC)
X-Original-To: linux-s390@vger.kernel.org
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99D3D12B87;
	Tue, 19 Dec 2023 08:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R421e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=guwen@linux.alibaba.com;NM=1;PH=DS;RN=22;SR=0;TI=SMTPD_---0VyqJ4pI_1702975543;
Received: from localhost(mailfrom:guwen@linux.alibaba.com fp:SMTPD_---0VyqJ4pI_1702975543)
          by smtp.aliyun-inc.com;
          Tue, 19 Dec 2023 16:45:45 +0800
From: Wen Gu <guwen@linux.alibaba.com>
To: wintera@linux.ibm.com,
	wenjia@linux.ibm.com,
	hca@linux.ibm.com,
	gor@linux.ibm.com,
	agordeev@linux.ibm.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	kgraul@linux.ibm.com,
	jaka@linux.ibm.com
Cc: borntraeger@linux.ibm.com,
	svens@linux.ibm.com,
	alibuda@linux.alibaba.com,
	tonylu@linux.alibaba.com,
	guwen@linux.alibaba.com,
	raspl@linux.ibm.com,
	schnelle@linux.ibm.com,
	guangguan.wang@linux.alibaba.com,
	linux-s390@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v7 03/10] net/smc: unify the structs of accept or confirm message for v1 and v2
Date: Tue, 19 Dec 2023 16:45:29 +0800
Message-Id: <20231219084536.8158-4-guwen@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20231219084536.8158-1-guwen@linux.alibaba.com>
References: <20231219084536.8158-1-guwen@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The structs of CLC accept and confirm messages for SMCv1 and SMCv2 are
separately defined and often casted to each other in the code, which may
increase the risk of errors caused by future divergence of them. So
unify them into one struct for better maintainability.

Suggested-by: Alexandra Winter <wintera@linux.ibm.com>
Signed-off-by: Wen Gu <guwen@linux.alibaba.com>
---
 net/smc/af_smc.c  | 52 +++++++++++++------------------------
 net/smc/smc_clc.c | 65 ++++++++++++++++++++---------------------------
 net/smc/smc_clc.h | 42 +++++++++++++-----------------
 3 files changed, 62 insertions(+), 97 deletions(-)

diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
index 7fc2f3c6d248..c0d3852fa429 100644
--- a/net/smc/af_smc.c
+++ b/net/smc/af_smc.c
@@ -677,8 +677,6 @@ static bool smc_isascii(char *hostname)
 static void smc_conn_save_peer_info_fce(struct smc_sock *smc,
 					struct smc_clc_msg_accept_confirm *clc)
 {
-	struct smc_clc_msg_accept_confirm_v2 *clc_v2 =
-		(struct smc_clc_msg_accept_confirm_v2 *)clc;
 	struct smc_clc_first_contact_ext *fce;
 	int clc_v2_len;
 
@@ -687,17 +685,15 @@ static void smc_conn_save_peer_info_fce(struct smc_sock *smc,
 		return;
 
 	if (smc->conn.lgr->is_smcd) {
-		memcpy(smc->conn.lgr->negotiated_eid, clc_v2->d1.eid,
+		memcpy(smc->conn.lgr->negotiated_eid, clc->d1.eid,
 		       SMC_MAX_EID_LEN);
-		clc_v2_len = offsetofend(struct smc_clc_msg_accept_confirm_v2,
-					 d1);
+		clc_v2_len = offsetofend(struct smc_clc_msg_accept_confirm, d1);
 	} else {
-		memcpy(smc->conn.lgr->negotiated_eid, clc_v2->r1.eid,
+		memcpy(smc->conn.lgr->negotiated_eid, clc->r1.eid,
 		       SMC_MAX_EID_LEN);
-		clc_v2_len = offsetofend(struct smc_clc_msg_accept_confirm_v2,
-					 r1);
+		clc_v2_len = offsetofend(struct smc_clc_msg_accept_confirm, r1);
 	}
-	fce = (struct smc_clc_first_contact_ext *)(((u8 *)clc_v2) + clc_v2_len);
+	fce = (struct smc_clc_first_contact_ext *)(((u8 *)clc) + clc_v2_len);
 	smc->conn.lgr->peer_os = fce->os_type;
 	smc->conn.lgr->peer_smc_release = fce->release;
 	if (smc_isascii(fce->hostname))
@@ -1149,13 +1145,13 @@ static int smc_connect_ism_vlan_cleanup(struct smc_sock *smc,
 }
 
 #define SMC_CLC_MAX_ACCEPT_LEN \
-	(sizeof(struct smc_clc_msg_accept_confirm_v2) + \
+	(sizeof(struct smc_clc_msg_accept_confirm) + \
 	 sizeof(struct smc_clc_first_contact_ext_v2x) + \
 	 sizeof(struct smc_clc_msg_trail))
 
 /* CLC handshake during connect */
 static int smc_connect_clc(struct smc_sock *smc,
-			   struct smc_clc_msg_accept_confirm_v2 *aclc2,
+			   struct smc_clc_msg_accept_confirm *aclc,
 			   struct smc_init_info *ini)
 {
 	int rc = 0;
@@ -1165,7 +1161,7 @@ static int smc_connect_clc(struct smc_sock *smc,
 	if (rc)
 		return rc;
 	/* receive SMC Accept CLC message */
-	return smc_clc_wait_msg(smc, aclc2, SMC_CLC_MAX_ACCEPT_LEN,
+	return smc_clc_wait_msg(smc, aclc, SMC_CLC_MAX_ACCEPT_LEN,
 				SMC_CLC_ACCEPT, CLC_WAIT_TIME);
 }
 
@@ -1201,10 +1197,8 @@ static int smc_connect_rdma_v2_prepare(struct smc_sock *smc,
 				       struct smc_clc_msg_accept_confirm *aclc,
 				       struct smc_init_info *ini)
 {
-	struct smc_clc_msg_accept_confirm_v2 *clc_v2 =
-		(struct smc_clc_msg_accept_confirm_v2 *)aclc;
 	struct smc_clc_first_contact_ext *fce =
-		smc_get_clc_first_contact_ext(clc_v2, false);
+		smc_get_clc_first_contact_ext(aclc, false);
 	struct net *net = sock_net(&smc->sk);
 	int rc;
 
@@ -1327,10 +1321,7 @@ static int smc_connect_rdma(struct smc_sock *smc,
 	}
 
 	if (aclc->hdr.version > SMC_V1) {
-		struct smc_clc_msg_accept_confirm_v2 *clc_v2 =
-			(struct smc_clc_msg_accept_confirm_v2 *)aclc;
-
-		eid = clc_v2->r1.eid;
+		eid = aclc->r1.eid;
 		if (ini->first_contact_local)
 			smc_fill_gid_list(link->lgr, &ini->smcrv2.gidlist,
 					  link->smcibdev, link->gid);
@@ -1371,7 +1362,7 @@ static int smc_connect_rdma(struct smc_sock *smc,
  * Determine from the CHID of the received CLC ACCEPT the ISM device chosen.
  */
 static int
-smc_v2_determine_accepted_chid(struct smc_clc_msg_accept_confirm_v2 *aclc,
+smc_v2_determine_accepted_chid(struct smc_clc_msg_accept_confirm *aclc,
 			       struct smc_init_info *ini)
 {
 	int i;
@@ -1398,12 +1389,9 @@ static int smc_connect_ism(struct smc_sock *smc,
 	ini->first_contact_peer = aclc->hdr.typev2 & SMC_FIRST_CONTACT_MASK;
 
 	if (aclc->hdr.version == SMC_V2) {
-		struct smc_clc_msg_accept_confirm_v2 *aclc_v2 =
-			(struct smc_clc_msg_accept_confirm_v2 *)aclc;
-
 		if (ini->first_contact_peer) {
 			struct smc_clc_first_contact_ext *fce =
-				smc_get_clc_first_contact_ext(aclc_v2, true);
+				smc_get_clc_first_contact_ext(aclc, true);
 
 			ini->release_nr = fce->release;
 			rc = smc_clc_clnt_v2x_features_validate(fce, ini);
@@ -1411,7 +1399,7 @@ static int smc_connect_ism(struct smc_sock *smc,
 				return rc;
 		}
 
-		rc = smc_v2_determine_accepted_chid(aclc_v2, ini);
+		rc = smc_v2_determine_accepted_chid(aclc, ini);
 		if (rc)
 			return rc;
 	}
@@ -1437,12 +1425,8 @@ static int smc_connect_ism(struct smc_sock *smc,
 	smc_rx_init(smc);
 	smc_tx_init(smc);
 
-	if (aclc->hdr.version > SMC_V1) {
-		struct smc_clc_msg_accept_confirm_v2 *clc_v2 =
-			(struct smc_clc_msg_accept_confirm_v2 *)aclc;
-
-		eid = clc_v2->d1.eid;
-	}
+	if (aclc->hdr.version > SMC_V1)
+		eid = aclc->d1.eid;
 
 	rc = smc_clc_send_confirm(smc, ini->first_contact_local,
 				  aclc->hdr.version, eid, ini);
@@ -1493,7 +1477,6 @@ static int smc_connect_check_aclc(struct smc_init_info *ini,
 static int __smc_connect(struct smc_sock *smc)
 {
 	u8 version = smc_ism_is_v2_capable() ? SMC_V2 : SMC_V1;
-	struct smc_clc_msg_accept_confirm_v2 *aclc2;
 	struct smc_clc_msg_accept_confirm *aclc;
 	struct smc_init_info *ini = NULL;
 	u8 *buf = NULL;
@@ -1541,11 +1524,10 @@ static int __smc_connect(struct smc_sock *smc)
 		rc = SMC_CLC_DECL_MEM;
 		goto fallback;
 	}
-	aclc2 = (struct smc_clc_msg_accept_confirm_v2 *)buf;
-	aclc = (struct smc_clc_msg_accept_confirm *)aclc2;
+	aclc = (struct smc_clc_msg_accept_confirm *)buf;
 
 	/* perform CLC handshake */
-	rc = smc_connect_clc(smc, aclc2, ini);
+	rc = smc_connect_clc(smc, aclc, ini);
 	if (rc) {
 		/* -EAGAIN on timeout, see tcp_recvmsg() */
 		if (rc == -EAGAIN) {
diff --git a/net/smc/smc_clc.c b/net/smc/smc_clc.c
index 1a230d855a5f..64733335b6ca 100644
--- a/net/smc/smc_clc.c
+++ b/net/smc/smc_clc.c
@@ -377,9 +377,9 @@ static bool smc_clc_msg_prop_valid(struct smc_clc_msg_proposal *pclc)
 
 /* check arriving CLC accept or confirm */
 static bool
-smc_clc_msg_acc_conf_valid(struct smc_clc_msg_accept_confirm_v2 *clc_v2)
+smc_clc_msg_acc_conf_valid(struct smc_clc_msg_accept_confirm *clc)
 {
-	struct smc_clc_msg_hdr *hdr = &clc_v2->hdr;
+	struct smc_clc_msg_hdr *hdr = &clc->hdr;
 
 	if (hdr->typev1 != SMC_TYPE_R && hdr->typev1 != SMC_TYPE_D)
 		return false;
@@ -449,7 +449,7 @@ static int smc_clc_fill_fce_v2x(struct smc_clc_first_contact_ext_v2x *fce_v2x,
  */
 static bool smc_clc_msg_hdr_valid(struct smc_clc_msg_hdr *clcm, bool check_trl)
 {
-	struct smc_clc_msg_accept_confirm_v2 *clc_v2;
+	struct smc_clc_msg_accept_confirm *clc;
 	struct smc_clc_msg_proposal *pclc;
 	struct smc_clc_msg_decline *dclc;
 	struct smc_clc_msg_trail *trl;
@@ -467,12 +467,11 @@ static bool smc_clc_msg_hdr_valid(struct smc_clc_msg_hdr *clcm, bool check_trl)
 		break;
 	case SMC_CLC_ACCEPT:
 	case SMC_CLC_CONFIRM:
-		clc_v2 = (struct smc_clc_msg_accept_confirm_v2 *)clcm;
-		if (!smc_clc_msg_acc_conf_valid(clc_v2))
+		clc = (struct smc_clc_msg_accept_confirm *)clcm;
+		if (!smc_clc_msg_acc_conf_valid(clc))
 			return false;
 		trl = (struct smc_clc_msg_trail *)
-			((u8 *)clc_v2 + ntohs(clc_v2->hdr.length) -
-							sizeof(*trl));
+			((u8 *)clc + ntohs(clc->hdr.length) - sizeof(*trl));
 		break;
 	case SMC_CLC_DECLINE:
 		dclc = (struct smc_clc_msg_decline *)clcm;
@@ -1000,7 +999,7 @@ int smc_clc_send_proposal(struct smc_sock *smc, struct smc_init_info *ini)
 
 static void
 smcd_clc_prep_confirm_accept(struct smc_connection *conn,
-			     struct smc_clc_msg_accept_confirm_v2 *clc_v2,
+			     struct smc_clc_msg_accept_confirm *clc,
 			     int first_contact, u8 version,
 			     u8 *eid, struct smc_init_info *ini,
 			     int *fce_len,
@@ -1008,11 +1007,9 @@ smcd_clc_prep_confirm_accept(struct smc_connection *conn,
 			     struct smc_clc_msg_trail *trl)
 {
 	struct smcd_dev *smcd = conn->lgr->smcd;
-	struct smc_clc_msg_accept_confirm *clc;
 	int len;
 
 	/* SMC-D specific settings */
-	clc = (struct smc_clc_msg_accept_confirm *)clc_v2;
 	memcpy(clc->hdr.eyecatcher, SMCD_EYECATCHER,
 	       sizeof(SMCD_EYECATCHER));
 	clc->hdr.typev1 = SMC_TYPE_D;
@@ -1024,15 +1021,15 @@ smcd_clc_prep_confirm_accept(struct smc_connection *conn,
 	if (version == SMC_V1) {
 		clc->hdr.length = htons(SMCD_CLC_ACCEPT_CONFIRM_LEN);
 	} else {
-		clc_v2->d1.chid = htons(smc_ism_get_chid(smcd));
+		clc->d1.chid = htons(smc_ism_get_chid(smcd));
 		if (eid && eid[0])
-			memcpy(clc_v2->d1.eid, eid, SMC_MAX_EID_LEN);
+			memcpy(clc->d1.eid, eid, SMC_MAX_EID_LEN);
 		len = SMCD_CLC_ACCEPT_CONFIRM_LEN_V2;
 		if (first_contact) {
 			*fce_len = smc_clc_fill_fce_v2x(fce_v2x, ini);
 			len += *fce_len;
 		}
-		clc_v2->hdr.length = htons(len);
+		clc->hdr.length = htons(len);
 	}
 	memcpy(trl->eyecatcher, SMCD_EYECATCHER,
 	       sizeof(SMCD_EYECATCHER));
@@ -1040,7 +1037,7 @@ smcd_clc_prep_confirm_accept(struct smc_connection *conn,
 
 static void
 smcr_clc_prep_confirm_accept(struct smc_connection *conn,
-			     struct smc_clc_msg_accept_confirm_v2 *clc_v2,
+			     struct smc_clc_msg_accept_confirm *clc,
 			     int first_contact, u8 version,
 			     u8 *eid, struct smc_init_info *ini,
 			     int *fce_len,
@@ -1048,12 +1045,10 @@ smcr_clc_prep_confirm_accept(struct smc_connection *conn,
 			     struct smc_clc_fce_gid_ext *gle,
 			     struct smc_clc_msg_trail *trl)
 {
-	struct smc_clc_msg_accept_confirm *clc;
 	struct smc_link *link = conn->lnk;
 	int len;
 
 	/* SMC-R specific settings */
-	clc = (struct smc_clc_msg_accept_confirm *)clc_v2;
 	memcpy(clc->hdr.eyecatcher, SMC_EYECATCHER,
 	       sizeof(SMC_EYECATCHER));
 	clc->hdr.typev1 = SMC_TYPE_R;
@@ -1085,7 +1080,7 @@ smcr_clc_prep_confirm_accept(struct smc_connection *conn,
 		clc->hdr.length = htons(SMCR_CLC_ACCEPT_CONFIRM_LEN);
 	} else {
 		if (eid && eid[0])
-			memcpy(clc_v2->r1.eid, eid, SMC_MAX_EID_LEN);
+			memcpy(clc->r1.eid, eid, SMC_MAX_EID_LEN);
 		len = SMCR_CLC_ACCEPT_CONFIRM_LEN_V2;
 		if (first_contact) {
 			*fce_len = smc_clc_fill_fce_v2x(fce_v2x, ini);
@@ -1099,20 +1094,19 @@ smcr_clc_prep_confirm_accept(struct smc_connection *conn,
 				len += gle->gid_cnt * sizeof(gle->gid[0]);
 			}
 		}
-		clc_v2->hdr.length = htons(len);
+		clc->hdr.length = htons(len);
 	}
 	memcpy(trl->eyecatcher, SMC_EYECATCHER, sizeof(SMC_EYECATCHER));
 }
 
 /* build and send CLC CONFIRM / ACCEPT message */
 static int smc_clc_send_confirm_accept(struct smc_sock *smc,
-				       struct smc_clc_msg_accept_confirm_v2 *clc_v2,
+				       struct smc_clc_msg_accept_confirm *clc,
 				       int first_contact, u8 version,
 				       u8 *eid, struct smc_init_info *ini)
 {
 	struct smc_clc_first_contact_ext_v2x fce_v2x;
 	struct smc_connection *conn = &smc->conn;
-	struct smc_clc_msg_accept_confirm *clc;
 	struct smc_clc_fce_gid_ext gle;
 	struct smc_clc_msg_trail trl;
 	int i, fce_len;
@@ -1120,21 +1114,20 @@ static int smc_clc_send_confirm_accept(struct smc_sock *smc,
 	struct msghdr msg;
 
 	/* send SMC Confirm CLC msg */
-	clc = (struct smc_clc_msg_accept_confirm *)clc_v2;
 	clc->hdr.version = version;	/* SMC version */
 	if (first_contact)
 		clc->hdr.typev2 |= SMC_FIRST_CONTACT_MASK;
 	if (conn->lgr->is_smcd)
-		smcd_clc_prep_confirm_accept(conn, clc_v2, first_contact,
+		smcd_clc_prep_confirm_accept(conn, clc, first_contact,
 					     version, eid, ini, &fce_len,
 					     &fce_v2x, &trl);
 	else
-		smcr_clc_prep_confirm_accept(conn, clc_v2, first_contact,
+		smcr_clc_prep_confirm_accept(conn, clc, first_contact,
 					     version, eid, ini, &fce_len,
 					     &fce_v2x, &gle, &trl);
 	memset(&msg, 0, sizeof(msg));
 	i = 0;
-	vec[i].iov_base = clc_v2;
+	vec[i].iov_base = clc;
 	if (version > SMC_V1)
 		vec[i++].iov_len = (clc->hdr.typev1 == SMC_TYPE_D ?
 					SMCD_CLC_ACCEPT_CONFIRM_LEN_V2 :
@@ -1168,16 +1161,16 @@ static int smc_clc_send_confirm_accept(struct smc_sock *smc,
 int smc_clc_send_confirm(struct smc_sock *smc, bool clnt_first_contact,
 			 u8 version, u8 *eid, struct smc_init_info *ini)
 {
-	struct smc_clc_msg_accept_confirm_v2 cclc_v2;
+	struct smc_clc_msg_accept_confirm cclc;
 	int reason_code = 0;
 	int len;
 
 	/* send SMC Confirm CLC msg */
-	memset(&cclc_v2, 0, sizeof(cclc_v2));
-	cclc_v2.hdr.type = SMC_CLC_CONFIRM;
-	len = smc_clc_send_confirm_accept(smc, &cclc_v2, clnt_first_contact,
+	memset(&cclc, 0, sizeof(cclc));
+	cclc.hdr.type = SMC_CLC_CONFIRM;
+	len = smc_clc_send_confirm_accept(smc, &cclc, clnt_first_contact,
 					  version, eid, ini);
-	if (len < ntohs(cclc_v2.hdr.length)) {
+	if (len < ntohs(cclc.hdr.length)) {
 		if (len >= 0) {
 			reason_code = -ENETUNREACH;
 			smc->sk.sk_err = -reason_code;
@@ -1193,14 +1186,14 @@ int smc_clc_send_confirm(struct smc_sock *smc, bool clnt_first_contact,
 int smc_clc_send_accept(struct smc_sock *new_smc, bool srv_first_contact,
 			u8 version, u8 *negotiated_eid, struct smc_init_info *ini)
 {
-	struct smc_clc_msg_accept_confirm_v2 aclc_v2;
+	struct smc_clc_msg_accept_confirm aclc;
 	int len;
 
-	memset(&aclc_v2, 0, sizeof(aclc_v2));
-	aclc_v2.hdr.type = SMC_CLC_ACCEPT;
-	len = smc_clc_send_confirm_accept(new_smc, &aclc_v2, srv_first_contact,
+	memset(&aclc, 0, sizeof(aclc));
+	aclc.hdr.type = SMC_CLC_ACCEPT;
+	len = smc_clc_send_confirm_accept(new_smc, &aclc, srv_first_contact,
 					  version, negotiated_eid, ini);
-	if (len < ntohs(aclc_v2.hdr.length))
+	if (len < ntohs(aclc.hdr.length))
 		len = len >= 0 ? -EPROTO : -new_smc->clcsock->sk->sk_err;
 
 	return len > 0 ? 0 : len;
@@ -1265,10 +1258,8 @@ int smc_clc_clnt_v2x_features_validate(struct smc_clc_first_contact_ext *fce,
 int smc_clc_v2x_features_confirm_check(struct smc_clc_msg_accept_confirm *cclc,
 				       struct smc_init_info *ini)
 {
-	struct smc_clc_msg_accept_confirm_v2 *clc_v2 =
-		(struct smc_clc_msg_accept_confirm_v2 *)cclc;
 	struct smc_clc_first_contact_ext *fce =
-		smc_get_clc_first_contact_ext(clc_v2, ini->is_smcd);
+		smc_get_clc_first_contact_ext(cclc, ini->is_smcd);
 	struct smc_clc_first_contact_ext_v2x *fce_v2x =
 		(struct smc_clc_first_contact_ext_v2x *)fce;
 
diff --git a/net/smc/smc_clc.h b/net/smc/smc_clc.h
index 1697b84d85be..03f9ccea8c5e 100644
--- a/net/smc/smc_clc.h
+++ b/net/smc/smc_clc.h
@@ -257,30 +257,23 @@ struct smc_clc_fce_gid_ext {
 };
 
 struct smc_clc_msg_accept_confirm {	/* clc accept / confirm message */
-	struct smc_clc_msg_hdr hdr;
-	union {
-		struct smcr_clc_msg_accept_confirm r0; /* SMC-R */
-		struct { /* SMC-D */
-			struct smcd_clc_msg_accept_confirm_common d0;
-			u32 reserved5[3];
-		};
-	};
-} __packed;			/* format defined in RFC7609 */
-
-struct smc_clc_msg_accept_confirm_v2 {	/* clc accept / confirm message */
 	struct smc_clc_msg_hdr hdr;
 	union {
 		struct { /* SMC-R */
 			struct smcr_clc_msg_accept_confirm r0;
-			u8 eid[SMC_MAX_EID_LEN];
-			u8 reserved6[8];
-		} r1;
+			struct { /* v2 only */
+				u8 eid[SMC_MAX_EID_LEN];
+				u8 reserved6[8];
+			} __packed r1;
+		};
 		struct { /* SMC-D */
 			struct smcd_clc_msg_accept_confirm_common d0;
-			__be16 chid;
-			u8 eid[SMC_MAX_EID_LEN];
-			u8 reserved5[8];
-		} d1;
+			struct { /* v2 only, but 12 bytes reserved in v1 */
+				__be16 chid;
+				u8 eid[SMC_MAX_EID_LEN];
+				u8 reserved5[8];
+			} __packed d1;
+		};
 	};
 };
 
@@ -389,24 +382,23 @@ smc_get_clc_smcd_v2_ext(struct smc_clc_v2_extension *prop_v2ext)
 }
 
 static inline struct smc_clc_first_contact_ext *
-smc_get_clc_first_contact_ext(struct smc_clc_msg_accept_confirm_v2 *clc_v2,
+smc_get_clc_first_contact_ext(struct smc_clc_msg_accept_confirm *clc,
 			      bool is_smcd)
 {
 	int clc_v2_len;
 
-	if (clc_v2->hdr.version == SMC_V1 ||
-	    !(clc_v2->hdr.typev2 & SMC_FIRST_CONTACT_MASK))
+	if (clc->hdr.version == SMC_V1 ||
+	    !(clc->hdr.typev2 & SMC_FIRST_CONTACT_MASK))
 		return NULL;
 
 	if (is_smcd)
 		clc_v2_len =
-			offsetofend(struct smc_clc_msg_accept_confirm_v2, d1);
+			offsetofend(struct smc_clc_msg_accept_confirm, d1);
 	else
 		clc_v2_len =
-			offsetofend(struct smc_clc_msg_accept_confirm_v2, r1);
+			offsetofend(struct smc_clc_msg_accept_confirm, r1);
 
-	return (struct smc_clc_first_contact_ext *)(((u8 *)clc_v2) +
-						    clc_v2_len);
+	return (struct smc_clc_first_contact_ext *)(((u8 *)clc) + clc_v2_len);
 }
 
 struct smcd_dev;
-- 
2.32.0.3.g01195cf9f


