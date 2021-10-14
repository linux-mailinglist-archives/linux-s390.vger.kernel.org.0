Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6933142DFA4
	for <lists+linux-s390@lfdr.de>; Thu, 14 Oct 2021 18:49:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233506AbhJNQvC (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Thu, 14 Oct 2021 12:51:02 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:3332 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S233350AbhJNQux (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 14 Oct 2021 12:50:53 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19EGUiZ2003161;
        Thu, 14 Oct 2021 12:48:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : content-transfer-encoding
 : mime-version; s=pp1; bh=JNgviS4FyYySwSxVQ5UBLqe/zdbRqvaaT3oifl0p8ws=;
 b=CwyAO98dVLOSKCr/s/LF1u6NmBRYv1woNHIuOg8xvTRhqWH0OaSNCP6T5IrL3walJZ3e
 xJro9w9ih+PS1/g87IZaRY0fCMMFrDxbcSDKsy7if4vcyIAzbKw/A/srd7pdo1QG9lGj
 2RyC0MpOpVMZrlDN9SX/0vt+zFDvCOhnkGEbOLM0q6J3YD8s7Gqwn06L7dNh8oqd3zJF
 Pmlmzu8m0OLQFK6WWTkOIkHL0ZlkjkqCERF0p4Kb1w9x/GlFU4TyL4WkvavW3iDV4IBH
 KeJtpbmWj1ZzJrIDh6/RG8LlEcBRQMmL7nEqQhQQWllcdO4dvCLOMFytYGbUgZy1ootl Eg== 
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3bpgv4mku3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 Oct 2021 12:48:44 -0400
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 19EGbq2u017345;
        Thu, 14 Oct 2021 16:48:42 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma03fra.de.ibm.com with ESMTP id 3bk2qamht2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 Oct 2021 16:48:42 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 19EGmdZK62194056
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Oct 2021 16:48:39 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 98077A4060;
        Thu, 14 Oct 2021 16:48:39 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5BBC1A4054;
        Thu, 14 Oct 2021 16:48:39 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 14 Oct 2021 16:48:39 +0000 (GMT)
From:   Karsten Graul <kgraul@linux.ibm.com>
To:     David Miller <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>
Cc:     netdev@vger.kernel.org, linux-s390@vger.kernel.org,
        Heiko Carstens <hca@linux.ibm.com>, linux-rdma@vger.kernel.org
Subject: [PATCH net-next v2 09/11] net/smc: extend LLC layer for SMC-Rv2
Date:   Thu, 14 Oct 2021 18:47:50 +0200
Message-Id: <20211014164752.3647027-10-kgraul@linux.ibm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211014164752.3647027-1-kgraul@linux.ibm.com>
References: <20211014164752.3647027-1-kgraul@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: hshyQOyS_UrG157FV3hIHkTOBoulw721
X-Proofpoint-ORIG-GUID: hshyQOyS_UrG157FV3hIHkTOBoulw721
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-10-14_09,2021-10-14_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 phishscore=0
 mlxscore=0 priorityscore=1501 mlxlogscore=999 impostorscore=0
 malwarescore=0 lowpriorityscore=0 bulkscore=0 spamscore=0 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2110140095
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Add support for large v2 LLC control messages in smc_llc.c.
The new large work request buffer allows to combine control
messages into one packet that had to be spread over several
packets before.
Add handling of the new v2 LLC messages.

Signed-off-by: Karsten Graul <kgraul@linux.ibm.com>
---
 net/smc/af_smc.c   |   8 +-
 net/smc/smc.h      |  20 +-
 net/smc/smc_core.h |   1 +
 net/smc/smc_llc.c  | 556 ++++++++++++++++++++++++++++++++++++---------
 net/smc/smc_llc.h  |  12 +-
 net/smc/smc_wr.c   |  43 ++++
 net/smc/smc_wr.h   |   6 +
 7 files changed, 531 insertions(+), 115 deletions(-)

diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
index ce5feb68382f..5e50e007a7da 100644
--- a/net/smc/af_smc.c
+++ b/net/smc/af_smc.c
@@ -786,9 +786,9 @@ static int smc_connect_clc(struct smc_sock *smc,
 				SMC_CLC_ACCEPT, CLC_WAIT_TIME);
 }
 
-static void smc_fill_gid_list(struct smc_link_group *lgr,
-			      struct smc_gidlist *gidlist,
-			      struct smc_ib_device *known_dev, u8 *known_gid)
+void smc_fill_gid_list(struct smc_link_group *lgr,
+		       struct smc_gidlist *gidlist,
+		       struct smc_ib_device *known_dev, u8 *known_gid)
 {
 	struct smc_init_info *alt_ini = NULL;
 
@@ -1435,7 +1435,7 @@ static int smcr_serv_conf_first_link(struct smc_sock *smc)
 	smcr_lgr_set_type(link->lgr, SMC_LGR_SINGLE);
 
 	/* initial contact - try to establish second link */
-	smc_llc_srv_add_link(link);
+	smc_llc_srv_add_link(link, NULL);
 	return 0;
 }
 
diff --git a/net/smc/smc.h b/net/smc/smc.h
index 5e7def3ab730..f4286ca1f228 100644
--- a/net/smc/smc.h
+++ b/net/smc/smc.h
@@ -56,7 +56,20 @@ enum smc_state {		/* possible states of an SMC socket */
 struct smc_link_group;
 
 struct smc_wr_rx_hdr {	/* common prefix part of LLC and CDC to demultiplex */
-	u8			type;
+	union {
+		u8 type;
+#if defined(__BIG_ENDIAN_BITFIELD)
+		struct {
+			u8 llc_version:4,
+			   llc_type:4;
+		};
+#elif defined(__LITTLE_ENDIAN_BITFIELD)
+		struct {
+			u8 llc_type:4,
+			   llc_version:4;
+		};
+#endif
+	};
 } __aligned(1);
 
 struct smc_cdc_conn_state_flags {
@@ -286,7 +299,12 @@ static inline bool using_ipsec(struct smc_sock *smc)
 }
 #endif
 
+struct smc_gidlist;
+
 struct sock *smc_accept_dequeue(struct sock *parent, struct socket *new_sock);
 void smc_close_non_accepted(struct sock *sk);
+void smc_fill_gid_list(struct smc_link_group *lgr,
+		       struct smc_gidlist *gidlist,
+		       struct smc_ib_device *known_dev, u8 *known_gid);
 
 #endif	/* __SMC_H */
diff --git a/net/smc/smc_core.h b/net/smc/smc_core.h
index 5997657ee9cc..59cef3b830d8 100644
--- a/net/smc/smc_core.h
+++ b/net/smc/smc_core.h
@@ -218,6 +218,7 @@ enum smc_llc_flowtype {
 	SMC_LLC_FLOW_NONE	= 0,
 	SMC_LLC_FLOW_ADD_LINK	= 2,
 	SMC_LLC_FLOW_DEL_LINK	= 4,
+	SMC_LLC_FLOW_REQ_ADD_LINK = 5,
 	SMC_LLC_FLOW_RKEY	= 6,
 };
 
diff --git a/net/smc/smc_llc.c b/net/smc/smc_llc.c
index 760f5ed7c8f0..a9623c952007 100644
--- a/net/smc/smc_llc.c
+++ b/net/smc/smc_llc.c
@@ -23,16 +23,24 @@
 
 struct smc_llc_hdr {
 	struct smc_wr_rx_hdr common;
-	u8 length;	/* 44 */
-#if defined(__BIG_ENDIAN_BITFIELD)
-	u8 reserved:4,
-	   add_link_rej_rsn:4;
+	union {
+		struct {
+			u8 length;	/* 44 */
+	#if defined(__BIG_ENDIAN_BITFIELD)
+			u8 reserved:4,
+			   add_link_rej_rsn:4;
 #elif defined(__LITTLE_ENDIAN_BITFIELD)
-	u8 add_link_rej_rsn:4,
-	   reserved:4;
+			u8 add_link_rej_rsn:4,
+			   reserved:4;
 #endif
+		};
+		u16 length_v2;	/* 44 - 8192*/
+	};
 	u8 flags;
-};
+} __packed;		/* format defined in
+			 * IBM Shared Memory Communications Version 2
+			 * (https://www.ibm.com/support/pages/node/6326337)
+			 */
 
 #define SMC_LLC_FLAG_NO_RMBE_EYEC	0x03
 
@@ -76,6 +84,32 @@ struct smc_llc_msg_add_link_cont_rt {
 	__be64 rmb_vaddr_new;
 };
 
+struct smc_llc_msg_add_link_v2_ext {
+#if defined(__BIG_ENDIAN_BITFIELD)
+	u8 v2_direct : 1,
+	   reserved  : 7;
+#elif defined(__LITTLE_ENDIAN_BITFIELD)
+	u8 reserved  : 7,
+	   v2_direct : 1;
+#endif
+	u8 reserved2;
+	u8 client_target_gid[SMC_GID_SIZE];
+	u8 reserved3[8];
+	u16 num_rkeys;
+	struct smc_llc_msg_add_link_cont_rt rt[];
+} __packed;		/* format defined in
+			 * IBM Shared Memory Communications Version 2
+			 * (https://www.ibm.com/support/pages/node/6326337)
+			 */
+
+struct smc_llc_msg_req_add_link_v2 {
+	struct smc_llc_hdr hd;
+	u8 reserved[20];
+	u8 gid_cnt;
+	u8 reserved2[3];
+	u8 gid[][SMC_GID_SIZE];
+};
+
 #define SMC_LLC_RKEYS_PER_CONT_MSG	2
 
 struct smc_llc_msg_add_link_cont {	/* type 0x03 */
@@ -114,7 +148,8 @@ struct smc_rmb_rtoken {
 	__be64 rmb_vaddr;
 } __packed;			/* format defined in RFC7609 */
 
-#define SMC_LLC_RKEYS_PER_MSG	3
+#define SMC_LLC_RKEYS_PER_MSG		3
+#define SMC_LLC_RKEYS_PER_MSG_V2	255
 
 struct smc_llc_msg_confirm_rkey {	/* type 0x06 */
 	struct smc_llc_hdr hd;
@@ -135,9 +170,18 @@ struct smc_llc_msg_delete_rkey {	/* type 0x09 */
 	u8 reserved2[4];
 };
 
+struct smc_llc_msg_delete_rkey_v2 {	/* type 0x29 */
+	struct smc_llc_hdr hd;
+	u8 num_rkeys;
+	u8 num_inval_rkeys;
+	u8 reserved[2];
+	__be32 rkey[];
+};
+
 union smc_llc_msg {
 	struct smc_llc_msg_confirm_link confirm_link;
 	struct smc_llc_msg_add_link add_link;
+	struct smc_llc_msg_req_add_link_v2 req_add_link;
 	struct smc_llc_msg_add_link_cont add_link_cont;
 	struct smc_llc_msg_del_link delete_link;
 
@@ -189,7 +233,7 @@ static inline void smc_llc_flow_qentry_set(struct smc_llc_flow *flow,
 static void smc_llc_flow_parallel(struct smc_link_group *lgr, u8 flow_type,
 				  struct smc_llc_qentry *qentry)
 {
-	u8 msg_type = qentry->msg.raw.hdr.common.type;
+	u8 msg_type = qentry->msg.raw.hdr.common.llc_type;
 
 	if ((msg_type == SMC_LLC_ADD_LINK || msg_type == SMC_LLC_DELETE_LINK) &&
 	    flow_type != msg_type && !lgr->delayed_event) {
@@ -219,7 +263,7 @@ static bool smc_llc_flow_start(struct smc_llc_flow *flow,
 		spin_unlock_bh(&lgr->llc_flow_lock);
 		return false;
 	}
-	switch (qentry->msg.raw.hdr.common.type) {
+	switch (qentry->msg.raw.hdr.common.llc_type) {
 	case SMC_LLC_ADD_LINK:
 		flow->type = SMC_LLC_FLOW_ADD_LINK;
 		break;
@@ -306,7 +350,7 @@ struct smc_llc_qentry *smc_llc_wait(struct smc_link_group *lgr,
 		smc_llc_flow_qentry_del(flow);
 		goto out;
 	}
-	rcv_msg = flow->qentry->msg.raw.hdr.common.type;
+	rcv_msg = flow->qentry->msg.raw.hdr.common.llc_type;
 	if (exp_msg && rcv_msg != exp_msg) {
 		if (exp_msg == SMC_LLC_ADD_LINK &&
 		    rcv_msg == SMC_LLC_DELETE_LINK) {
@@ -374,6 +418,30 @@ static int smc_llc_add_pending_send(struct smc_link *link,
 	return 0;
 }
 
+static int smc_llc_add_pending_send_v2(struct smc_link *link,
+				       struct smc_wr_v2_buf **wr_buf,
+				       struct smc_wr_tx_pend_priv **pend)
+{
+	int rc;
+
+	rc = smc_wr_tx_get_v2_slot(link, smc_llc_tx_handler, wr_buf, pend);
+	if (rc < 0)
+		return rc;
+	return 0;
+}
+
+static void smc_llc_init_msg_hdr(struct smc_llc_hdr *hdr,
+				 struct smc_link_group *lgr, size_t len)
+{
+	if (lgr->smc_version == SMC_V2) {
+		hdr->common.llc_version = SMC_V2;
+		hdr->length_v2 = len;
+	} else {
+		hdr->common.llc_version = 0;
+		hdr->length = len;
+	}
+}
+
 /* high-level API to send LLC confirm link */
 int smc_llc_send_confirm_link(struct smc_link *link,
 			      enum smc_llc_reqresp reqresp)
@@ -390,8 +458,8 @@ int smc_llc_send_confirm_link(struct smc_link *link,
 		goto put_out;
 	confllc = (struct smc_llc_msg_confirm_link *)wr_buf;
 	memset(confllc, 0, sizeof(*confllc));
-	confllc->hd.common.type = SMC_LLC_CONFIRM_LINK;
-	confllc->hd.length = sizeof(struct smc_llc_msg_confirm_link);
+	confllc->hd.common.llc_type = SMC_LLC_CONFIRM_LINK;
+	smc_llc_init_msg_hdr(&confllc->hd, link->lgr, sizeof(*confllc));
 	confllc->hd.flags |= SMC_LLC_FLAG_NO_RMBE_EYEC;
 	if (reqresp == SMC_LLC_RESP)
 		confllc->hd.flags |= SMC_LLC_FLAG_RESP;
@@ -426,8 +494,8 @@ static int smc_llc_send_confirm_rkey(struct smc_link *send_link,
 		goto put_out;
 	rkeyllc = (struct smc_llc_msg_confirm_rkey *)wr_buf;
 	memset(rkeyllc, 0, sizeof(*rkeyllc));
-	rkeyllc->hd.common.type = SMC_LLC_CONFIRM_RKEY;
-	rkeyllc->hd.length = sizeof(struct smc_llc_msg_confirm_rkey);
+	rkeyllc->hd.common.llc_type = SMC_LLC_CONFIRM_RKEY;
+	smc_llc_init_msg_hdr(&rkeyllc->hd, send_link->lgr, sizeof(*rkeyllc));
 
 	rtok_ix = 1;
 	for (i = 0; i < SMC_LINKS_PER_LGR_MAX; i++) {
@@ -471,8 +539,8 @@ static int smc_llc_send_delete_rkey(struct smc_link *link,
 		goto put_out;
 	rkeyllc = (struct smc_llc_msg_delete_rkey *)wr_buf;
 	memset(rkeyllc, 0, sizeof(*rkeyllc));
-	rkeyllc->hd.common.type = SMC_LLC_DELETE_RKEY;
-	rkeyllc->hd.length = sizeof(struct smc_llc_msg_delete_rkey);
+	rkeyllc->hd.common.llc_type = SMC_LLC_DELETE_RKEY;
+	smc_llc_init_msg_hdr(&rkeyllc->hd, link->lgr, sizeof(*rkeyllc));
 	rkeyllc->num_rkeys = 1;
 	rkeyllc->rkey[0] = htonl(rmb_desc->mr_rx[link->link_idx]->rkey);
 	/* send llc message */
@@ -482,26 +550,116 @@ static int smc_llc_send_delete_rkey(struct smc_link *link,
 	return rc;
 }
 
+/* return first buffer from any of the next buf lists */
+static struct smc_buf_desc *_smc_llc_get_next_rmb(struct smc_link_group *lgr,
+						  int *buf_lst)
+{
+	struct smc_buf_desc *buf_pos;
+
+	while (*buf_lst < SMC_RMBE_SIZES) {
+		buf_pos = list_first_entry_or_null(&lgr->rmbs[*buf_lst],
+						   struct smc_buf_desc, list);
+		if (buf_pos)
+			return buf_pos;
+		(*buf_lst)++;
+	}
+	return NULL;
+}
+
+/* return next rmb from buffer lists */
+static struct smc_buf_desc *smc_llc_get_next_rmb(struct smc_link_group *lgr,
+						 int *buf_lst,
+						 struct smc_buf_desc *buf_pos)
+{
+	struct smc_buf_desc *buf_next;
+
+	if (!buf_pos || list_is_last(&buf_pos->list, &lgr->rmbs[*buf_lst])) {
+		(*buf_lst)++;
+		return _smc_llc_get_next_rmb(lgr, buf_lst);
+	}
+	buf_next = list_next_entry(buf_pos, list);
+	return buf_next;
+}
+
+static struct smc_buf_desc *smc_llc_get_first_rmb(struct smc_link_group *lgr,
+						  int *buf_lst)
+{
+	*buf_lst = 0;
+	return smc_llc_get_next_rmb(lgr, buf_lst, NULL);
+}
+
+static int smc_llc_fill_ext_v2(struct smc_llc_msg_add_link_v2_ext *ext,
+			       struct smc_link *link, struct smc_link *link_new)
+{
+	struct smc_link_group *lgr = link->lgr;
+	struct smc_buf_desc *buf_pos;
+	int prim_lnk_idx, lnk_idx, i;
+	struct smc_buf_desc *rmb;
+	int len = sizeof(*ext);
+	int buf_lst;
+
+	ext->v2_direct = !lgr->uses_gateway;
+	memcpy(ext->client_target_gid, link_new->gid, SMC_GID_SIZE);
+
+	prim_lnk_idx = link->link_idx;
+	lnk_idx = link_new->link_idx;
+	mutex_lock(&lgr->rmbs_lock);
+	ext->num_rkeys = lgr->conns_num;
+	if (!ext->num_rkeys)
+		goto out;
+	buf_pos = smc_llc_get_first_rmb(lgr, &buf_lst);
+	for (i = 0; i < ext->num_rkeys; i++) {
+		if (!buf_pos)
+			break;
+		rmb = buf_pos;
+		ext->rt[i].rmb_key = htonl(rmb->mr_rx[prim_lnk_idx]->rkey);
+		ext->rt[i].rmb_key_new = htonl(rmb->mr_rx[lnk_idx]->rkey);
+		ext->rt[i].rmb_vaddr_new =
+			cpu_to_be64((u64)sg_dma_address(rmb->sgt[lnk_idx].sgl));
+		buf_pos = smc_llc_get_next_rmb(lgr, &buf_lst, buf_pos);
+		while (buf_pos && !(buf_pos)->used)
+			buf_pos = smc_llc_get_next_rmb(lgr, &buf_lst, buf_pos);
+	}
+	len += i * sizeof(ext->rt[0]);
+out:
+	mutex_unlock(&lgr->rmbs_lock);
+	return len;
+}
+
 /* send ADD LINK request or response */
 int smc_llc_send_add_link(struct smc_link *link, u8 mac[], u8 gid[],
 			  struct smc_link *link_new,
 			  enum smc_llc_reqresp reqresp)
 {
+	struct smc_llc_msg_add_link_v2_ext *ext = NULL;
 	struct smc_llc_msg_add_link *addllc;
 	struct smc_wr_tx_pend_priv *pend;
-	struct smc_wr_buf *wr_buf;
+	int len = sizeof(*addllc);
 	int rc;
 
 	if (!smc_wr_tx_link_hold(link))
 		return -ENOLINK;
-	rc = smc_llc_add_pending_send(link, &wr_buf, &pend);
-	if (rc)
-		goto put_out;
-	addllc = (struct smc_llc_msg_add_link *)wr_buf;
+	if (link->lgr->smc_version == SMC_V2) {
+		struct smc_wr_v2_buf *wr_buf;
+
+		rc = smc_llc_add_pending_send_v2(link, &wr_buf, &pend);
+		if (rc)
+			goto put_out;
+		addllc = (struct smc_llc_msg_add_link *)wr_buf;
+		ext = (struct smc_llc_msg_add_link_v2_ext *)
+						&wr_buf->raw[sizeof(*addllc)];
+		memset(ext, 0, SMC_WR_TX_SIZE);
+	} else {
+		struct smc_wr_buf *wr_buf;
+
+		rc = smc_llc_add_pending_send(link, &wr_buf, &pend);
+		if (rc)
+			goto put_out;
+		addllc = (struct smc_llc_msg_add_link *)wr_buf;
+	}
 
 	memset(addllc, 0, sizeof(*addllc));
-	addllc->hd.common.type = SMC_LLC_ADD_LINK;
-	addllc->hd.length = sizeof(struct smc_llc_msg_add_link);
+	addllc->hd.common.llc_type = SMC_LLC_ADD_LINK;
 	if (reqresp == SMC_LLC_RESP)
 		addllc->hd.flags |= SMC_LLC_FLAG_RESP;
 	memcpy(addllc->sender_mac, mac, ETH_ALEN);
@@ -516,8 +674,14 @@ int smc_llc_send_add_link(struct smc_link *link, u8 mac[], u8 gid[],
 			addllc->qp_mtu = min(link_new->path_mtu,
 					     link_new->peer_mtu);
 	}
+	if (ext && link_new)
+		len += smc_llc_fill_ext_v2(ext, link, link_new);
+	smc_llc_init_msg_hdr(&addllc->hd, link->lgr, len);
 	/* send llc message */
-	rc = smc_wr_tx_send(link, pend);
+	if (link->lgr->smc_version == SMC_V2)
+		rc = smc_wr_tx_v2_send(link, pend, len);
+	else
+		rc = smc_wr_tx_send(link, pend);
 put_out:
 	smc_wr_tx_link_put(link);
 	return rc;
@@ -541,8 +705,8 @@ int smc_llc_send_delete_link(struct smc_link *link, u8 link_del_id,
 	delllc = (struct smc_llc_msg_del_link *)wr_buf;
 
 	memset(delllc, 0, sizeof(*delllc));
-	delllc->hd.common.type = SMC_LLC_DELETE_LINK;
-	delllc->hd.length = sizeof(struct smc_llc_msg_del_link);
+	delllc->hd.common.llc_type = SMC_LLC_DELETE_LINK;
+	smc_llc_init_msg_hdr(&delllc->hd, link->lgr, sizeof(*delllc));
 	if (reqresp == SMC_LLC_RESP)
 		delllc->hd.flags |= SMC_LLC_FLAG_RESP;
 	if (orderly)
@@ -574,8 +738,8 @@ static int smc_llc_send_test_link(struct smc_link *link, u8 user_data[16])
 		goto put_out;
 	testllc = (struct smc_llc_msg_test_link *)wr_buf;
 	memset(testllc, 0, sizeof(*testllc));
-	testllc->hd.common.type = SMC_LLC_TEST_LINK;
-	testllc->hd.length = sizeof(struct smc_llc_msg_test_link);
+	testllc->hd.common.llc_type = SMC_LLC_TEST_LINK;
+	smc_llc_init_msg_hdr(&testllc->hd, link->lgr, sizeof(*testllc));
 	memcpy(testllc->user_data, user_data, sizeof(testllc->user_data));
 	/* send llc message */
 	rc = smc_wr_tx_send(link, pend);
@@ -651,44 +815,6 @@ static int smc_llc_alloc_alt_link(struct smc_link_group *lgr,
 	return -EMLINK;
 }
 
-/* return first buffer from any of the next buf lists */
-static struct smc_buf_desc *_smc_llc_get_next_rmb(struct smc_link_group *lgr,
-						  int *buf_lst)
-{
-	struct smc_buf_desc *buf_pos;
-
-	while (*buf_lst < SMC_RMBE_SIZES) {
-		buf_pos = list_first_entry_or_null(&lgr->rmbs[*buf_lst],
-						   struct smc_buf_desc, list);
-		if (buf_pos)
-			return buf_pos;
-		(*buf_lst)++;
-	}
-	return NULL;
-}
-
-/* return next rmb from buffer lists */
-static struct smc_buf_desc *smc_llc_get_next_rmb(struct smc_link_group *lgr,
-						 int *buf_lst,
-						 struct smc_buf_desc *buf_pos)
-{
-	struct smc_buf_desc *buf_next;
-
-	if (!buf_pos || list_is_last(&buf_pos->list, &lgr->rmbs[*buf_lst])) {
-		(*buf_lst)++;
-		return _smc_llc_get_next_rmb(lgr, buf_lst);
-	}
-	buf_next = list_next_entry(buf_pos, list);
-	return buf_next;
-}
-
-static struct smc_buf_desc *smc_llc_get_first_rmb(struct smc_link_group *lgr,
-						  int *buf_lst)
-{
-	*buf_lst = 0;
-	return smc_llc_get_next_rmb(lgr, buf_lst, NULL);
-}
-
 /* send one add_link_continue msg */
 static int smc_llc_add_link_cont(struct smc_link *link,
 				 struct smc_link *link_new, u8 *num_rkeys_todo,
@@ -734,7 +860,7 @@ static int smc_llc_add_link_cont(struct smc_link *link,
 		while (*buf_pos && !(*buf_pos)->used)
 			*buf_pos = smc_llc_get_next_rmb(lgr, buf_lst, *buf_pos);
 	}
-	addc_llc->hd.common.type = SMC_LLC_ADD_LINK_CONT;
+	addc_llc->hd.common.llc_type = SMC_LLC_ADD_LINK_CONT;
 	addc_llc->hd.length = sizeof(struct smc_llc_msg_add_link_cont);
 	if (lgr->role == SMC_CLNT)
 		addc_llc->hd.flags |= SMC_LLC_FLAG_RESP;
@@ -793,6 +919,8 @@ static int smc_llc_cli_add_link_reject(struct smc_llc_qentry *qentry)
 	qentry->msg.raw.hdr.flags |= SMC_LLC_FLAG_RESP;
 	qentry->msg.raw.hdr.flags |= SMC_LLC_FLAG_ADD_LNK_REJ;
 	qentry->msg.raw.hdr.add_link_rej_rsn = SMC_LLC_REJ_RSN_NO_ALT_PATH;
+	smc_llc_init_msg_hdr(&qentry->msg.raw.hdr, qentry->link->lgr,
+			     sizeof(qentry->msg));
 	return smc_llc_send_message(qentry->link, &qentry->msg);
 }
 
@@ -813,7 +941,7 @@ static int smc_llc_cli_conf_link(struct smc_link *link,
 					      SMC_LLC_DEL_LOST_PATH);
 		return -ENOLINK;
 	}
-	if (qentry->msg.raw.hdr.common.type != SMC_LLC_CONFIRM_LINK) {
+	if (qentry->msg.raw.hdr.common.llc_type != SMC_LLC_CONFIRM_LINK) {
 		/* received DELETE_LINK instead */
 		qentry->msg.raw.hdr.flags |= SMC_LLC_FLAG_RESP;
 		smc_llc_send_message(link, &qentry->msg);
@@ -854,6 +982,26 @@ static int smc_llc_cli_conf_link(struct smc_link *link,
 	return 0;
 }
 
+static void smc_llc_save_add_link_rkeys(struct smc_link *link,
+					struct smc_link *link_new)
+{
+	struct smc_llc_msg_add_link_v2_ext *ext;
+	struct smc_link_group *lgr = link->lgr;
+	int max, i;
+
+	ext = (struct smc_llc_msg_add_link_v2_ext *)((u8 *)lgr->wr_rx_buf_v2 +
+						     SMC_WR_TX_SIZE);
+	max = min_t(u8, ext->num_rkeys, SMC_LLC_RKEYS_PER_MSG_V2);
+	mutex_lock(&lgr->rmbs_lock);
+	for (i = 0; i < max; i++) {
+		smc_rtoken_set(lgr, link->link_idx, link_new->link_idx,
+			       ext->rt[i].rmb_key,
+			       ext->rt[i].rmb_vaddr_new,
+			       ext->rt[i].rmb_key_new);
+	}
+	mutex_unlock(&lgr->rmbs_lock);
+}
+
 static void smc_llc_save_add_link_info(struct smc_link *link,
 				       struct smc_llc_msg_add_link *add_llc)
 {
@@ -884,14 +1032,24 @@ int smc_llc_cli_add_link(struct smc_link *link, struct smc_llc_qentry *qentry)
 	}
 
 	ini->vlan_id = lgr->vlan_id;
+	if (lgr->smc_version == SMC_V2) {
+		ini->check_smcrv2 = true;
+		ini->smcrv2.saddr = lgr->saddr;
+		ini->smcrv2.daddr = smc_ib_gid_to_ipv4(llc->sender_gid);
+	}
 	smc_pnet_find_alt_roce(lgr, ini, link->smcibdev);
 	if (!memcmp(llc->sender_gid, link->peer_gid, SMC_GID_SIZE) &&
-	    !memcmp(llc->sender_mac, link->peer_mac, ETH_ALEN)) {
-		if (!ini->ib_dev)
+	    (lgr->smc_version == SMC_V2 ||
+	     !memcmp(llc->sender_mac, link->peer_mac, ETH_ALEN))) {
+		if (!ini->ib_dev && !ini->smcrv2.ib_dev_v2)
 			goto out_reject;
 		lgr_new_t = SMC_LGR_ASYMMETRIC_PEER;
 	}
-	if (!ini->ib_dev) {
+	if (lgr->smc_version == SMC_V2 && !ini->smcrv2.ib_dev_v2) {
+		lgr_new_t = SMC_LGR_ASYMMETRIC_LOCAL;
+		ini->smcrv2.ib_dev_v2 = link->smcibdev;
+		ini->smcrv2.ib_port_v2 = link->ibport;
+	} else if (lgr->smc_version < SMC_V2 && !ini->ib_dev) {
 		lgr_new_t = SMC_LGR_ASYMMETRIC_LOCAL;
 		ini->ib_dev = link->smcibdev;
 		ini->ib_port = link->ibport;
@@ -916,14 +1074,18 @@ int smc_llc_cli_add_link(struct smc_link *link, struct smc_llc_qentry *qentry)
 		goto out_clear_lnk;
 
 	rc = smc_llc_send_add_link(link,
-				   lnk_new->smcibdev->mac[ini->ib_port - 1],
+				   lnk_new->smcibdev->mac[lnk_new->ibport - 1],
 				   lnk_new->gid, lnk_new, SMC_LLC_RESP);
 	if (rc)
 		goto out_clear_lnk;
-	rc = smc_llc_cli_rkey_exchange(link, lnk_new);
-	if (rc) {
-		rc = 0;
-		goto out_clear_lnk;
+	if (lgr->smc_version == SMC_V2) {
+		smc_llc_save_add_link_rkeys(link, lnk_new);
+	} else {
+		rc = smc_llc_cli_rkey_exchange(link, lnk_new);
+		if (rc) {
+			rc = 0;
+			goto out_clear_lnk;
+		}
 	}
 	rc = smc_llc_cli_conf_link(link, ini, lnk_new, lgr_new_t);
 	if (!rc)
@@ -939,6 +1101,44 @@ int smc_llc_cli_add_link(struct smc_link *link, struct smc_llc_qentry *qentry)
 	return rc;
 }
 
+static void smc_llc_send_request_add_link(struct smc_link *link)
+{
+	struct smc_llc_msg_req_add_link_v2 *llc;
+	struct smc_wr_tx_pend_priv *pend;
+	struct smc_wr_v2_buf *wr_buf;
+	struct smc_gidlist gidlist;
+	int rc, len, i;
+
+	if (!smc_wr_tx_link_hold(link))
+		return;
+	if (link->lgr->type == SMC_LGR_SYMMETRIC ||
+	    link->lgr->type == SMC_LGR_ASYMMETRIC_PEER)
+		goto put_out;
+
+	smc_fill_gid_list(link->lgr, &gidlist, link->smcibdev, link->gid);
+	if (gidlist.len <= 1)
+		goto put_out;
+
+	rc = smc_llc_add_pending_send_v2(link, &wr_buf, &pend);
+	if (rc)
+		goto put_out;
+	llc = (struct smc_llc_msg_req_add_link_v2 *)wr_buf;
+	memset(llc, 0, SMC_WR_TX_SIZE);
+
+	llc->hd.common.llc_type = SMC_LLC_REQ_ADD_LINK;
+	for (i = 0; i < gidlist.len; i++)
+		memcpy(llc->gid[i], gidlist.list[i], sizeof(gidlist.list[0]));
+	llc->gid_cnt = gidlist.len;
+	len = sizeof(*llc) + (gidlist.len * sizeof(gidlist.list[0]));
+	smc_llc_init_msg_hdr(&llc->hd, link->lgr, len);
+	rc = smc_wr_tx_v2_send(link, pend, len);
+	if (!rc)
+		/* set REQ_ADD_LINK flow and wait for response from peer */
+		link->lgr->llc_flow_lcl.type = SMC_LLC_FLOW_REQ_ADD_LINK;
+put_out:
+	smc_wr_tx_link_put(link);
+}
+
 /* as an SMC client, invite server to start the add_link processing */
 static void smc_llc_cli_add_link_invite(struct smc_link *link,
 					struct smc_llc_qentry *qentry)
@@ -946,6 +1146,11 @@ static void smc_llc_cli_add_link_invite(struct smc_link *link,
 	struct smc_link_group *lgr = smc_get_lgr(link);
 	struct smc_init_info *ini = NULL;
 
+	if (lgr->smc_version == SMC_V2) {
+		smc_llc_send_request_add_link(link);
+		goto out;
+	}
+
 	if (lgr->type == SMC_LGR_SYMMETRIC ||
 	    lgr->type == SMC_LGR_ASYMMETRIC_PEER)
 		goto out;
@@ -978,7 +1183,7 @@ static bool smc_llc_is_empty_llc_message(union smc_llc_msg *llc)
 
 static bool smc_llc_is_local_add_link(union smc_llc_msg *llc)
 {
-	if (llc->raw.hdr.common.type == SMC_LLC_ADD_LINK &&
+	if (llc->raw.hdr.common.llc_type == SMC_LLC_ADD_LINK &&
 	    smc_llc_is_empty_llc_message(llc))
 		return true;
 	return false;
@@ -1145,7 +1350,7 @@ static int smc_llc_srv_conf_link(struct smc_link *link,
 	/* receive CONFIRM LINK response over the RoCE fabric */
 	qentry = smc_llc_wait(lgr, link, SMC_LLC_WAIT_FIRST_TIME, 0);
 	if (!qentry ||
-	    qentry->msg.raw.hdr.common.type != SMC_LLC_CONFIRM_LINK) {
+	    qentry->msg.raw.hdr.common.llc_type != SMC_LLC_CONFIRM_LINK) {
 		/* send DELETE LINK */
 		smc_llc_send_delete_link(link, link_new->link_id, SMC_LLC_REQ,
 					 false, SMC_LLC_DEL_LOST_PATH);
@@ -1164,24 +1369,55 @@ static int smc_llc_srv_conf_link(struct smc_link *link,
 	return 0;
 }
 
-int smc_llc_srv_add_link(struct smc_link *link)
+static void smc_llc_send_req_add_link_response(struct smc_llc_qentry *qentry)
+{
+	qentry->msg.raw.hdr.flags |= SMC_LLC_FLAG_RESP;
+	smc_llc_init_msg_hdr(&qentry->msg.raw.hdr, qentry->link->lgr,
+			     sizeof(qentry->msg));
+	memset(&qentry->msg.raw.data, 0, sizeof(qentry->msg.raw.data));
+	smc_llc_send_message(qentry->link, &qentry->msg);
+}
+
+int smc_llc_srv_add_link(struct smc_link *link,
+			 struct smc_llc_qentry *req_qentry)
 {
 	enum smc_lgr_type lgr_new_t = SMC_LGR_SYMMETRIC;
 	struct smc_link_group *lgr = link->lgr;
 	struct smc_llc_msg_add_link *add_llc;
 	struct smc_llc_qentry *qentry = NULL;
+	bool send_req_add_link_resp = false;
 	struct smc_link *link_new = NULL;
-	struct smc_init_info *ini;
+	struct smc_init_info *ini = NULL;
 	int lnk_idx, rc = 0;
 
+	if (req_qentry &&
+	    req_qentry->msg.raw.hdr.common.llc_type == SMC_LLC_REQ_ADD_LINK)
+		send_req_add_link_resp = true;
+
 	ini = kzalloc(sizeof(*ini), GFP_KERNEL);
-	if (!ini)
-		return -ENOMEM;
+	if (!ini) {
+		rc = -ENOMEM;
+		goto out;
+	}
 
 	/* ignore client add link recommendation, start new flow */
 	ini->vlan_id = lgr->vlan_id;
+	if (lgr->smc_version == SMC_V2) {
+		ini->check_smcrv2 = true;
+		ini->smcrv2.saddr = lgr->saddr;
+		if (send_req_add_link_resp) {
+			struct smc_llc_msg_req_add_link_v2 *req_add =
+				&req_qentry->msg.req_add_link;
+
+			ini->smcrv2.daddr = smc_ib_gid_to_ipv4(req_add->gid[0]);
+		}
+	}
 	smc_pnet_find_alt_roce(lgr, ini, link->smcibdev);
-	if (!ini->ib_dev) {
+	if (lgr->smc_version == SMC_V2 && !ini->smcrv2.ib_dev_v2) {
+		lgr_new_t = SMC_LGR_ASYMMETRIC_LOCAL;
+		ini->smcrv2.ib_dev_v2 = link->smcibdev;
+		ini->smcrv2.ib_port_v2 = link->ibport;
+	} else if (lgr->smc_version < SMC_V2 && !ini->ib_dev) {
 		lgr_new_t = SMC_LGR_ASYMMETRIC_LOCAL;
 		ini->ib_dev = link->smcibdev;
 		ini->ib_port = link->ibport;
@@ -1196,11 +1432,17 @@ int smc_llc_srv_add_link(struct smc_link *link)
 	if (rc)
 		goto out;
 	link_new = &lgr->lnk[lnk_idx];
+
+	rc = smcr_buf_map_lgr(link_new);
+	if (rc)
+		goto out_err;
+
 	rc = smc_llc_send_add_link(link,
-				   link_new->smcibdev->mac[ini->ib_port - 1],
+				   link_new->smcibdev->mac[link_new->ibport-1],
 				   link_new->gid, link_new, SMC_LLC_REQ);
 	if (rc)
 		goto out_err;
+	send_req_add_link_resp = false;
 	/* receive ADD LINK response over the RoCE fabric */
 	qentry = smc_llc_wait(lgr, link, SMC_LLC_WAIT_TIME, SMC_LLC_ADD_LINK);
 	if (!qentry) {
@@ -1215,24 +1457,26 @@ int smc_llc_srv_add_link(struct smc_link *link)
 	}
 	if (lgr->type == SMC_LGR_SINGLE &&
 	    (!memcmp(add_llc->sender_gid, link->peer_gid, SMC_GID_SIZE) &&
-	     !memcmp(add_llc->sender_mac, link->peer_mac, ETH_ALEN))) {
+	     (lgr->smc_version == SMC_V2 ||
+	      !memcmp(add_llc->sender_mac, link->peer_mac, ETH_ALEN)))) {
 		lgr_new_t = SMC_LGR_ASYMMETRIC_PEER;
 	}
 	smc_llc_save_add_link_info(link_new, add_llc);
 	smc_llc_flow_qentry_del(&lgr->llc_flow_lcl);
 
 	rc = smc_ib_ready_link(link_new);
-	if (rc)
-		goto out_err;
-	rc = smcr_buf_map_lgr(link_new);
 	if (rc)
 		goto out_err;
 	rc = smcr_buf_reg_lgr(link_new);
 	if (rc)
 		goto out_err;
-	rc = smc_llc_srv_rkey_exchange(link, link_new);
-	if (rc)
-		goto out_err;
+	if (lgr->smc_version == SMC_V2) {
+		smc_llc_save_add_link_rkeys(link, link_new);
+	} else {
+		rc = smc_llc_srv_rkey_exchange(link, link_new);
+		if (rc)
+			goto out_err;
+	}
 	rc = smc_llc_srv_conf_link(link, link_new, lgr_new_t);
 	if (rc)
 		goto out_err;
@@ -1245,23 +1489,27 @@ int smc_llc_srv_add_link(struct smc_link *link)
 	}
 out:
 	kfree(ini);
+	if (send_req_add_link_resp)
+		smc_llc_send_req_add_link_response(req_qentry);
 	return rc;
 }
 
 static void smc_llc_process_srv_add_link(struct smc_link_group *lgr)
 {
 	struct smc_link *link = lgr->llc_flow_lcl.qentry->link;
+	struct smc_llc_qentry *qentry;
 	int rc;
 
-	smc_llc_flow_qentry_del(&lgr->llc_flow_lcl);
+	qentry = smc_llc_flow_qentry_clr(&lgr->llc_flow_lcl);
 
 	mutex_lock(&lgr->llc_conf_mutex);
-	rc = smc_llc_srv_add_link(link);
+	rc = smc_llc_srv_add_link(link, qentry);
 	if (!rc && lgr->type == SMC_LGR_SYMMETRIC) {
 		/* delete any asymmetric link */
 		smc_llc_delete_asym_link(lgr);
 	}
 	mutex_unlock(&lgr->llc_conf_mutex);
+	kfree(qentry);
 }
 
 /* enqueue a local add_link req to trigger a new add_link flow */
@@ -1269,8 +1517,8 @@ void smc_llc_add_link_local(struct smc_link *link)
 {
 	struct smc_llc_msg_add_link add_llc = {};
 
-	add_llc.hd.length = sizeof(add_llc);
-	add_llc.hd.common.type = SMC_LLC_ADD_LINK;
+	add_llc.hd.common.llc_type = SMC_LLC_ADD_LINK;
+	smc_llc_init_msg_hdr(&add_llc.hd, link->lgr, sizeof(add_llc));
 	/* no dev and port needed */
 	smc_llc_enqueue(link, (union smc_llc_msg *)&add_llc);
 }
@@ -1292,7 +1540,8 @@ static void smc_llc_add_link_work(struct work_struct *work)
 	else
 		smc_llc_process_srv_add_link(lgr);
 out:
-	smc_llc_flow_stop(lgr, &lgr->llc_flow_lcl);
+	if (lgr->llc_flow_lcl.type != SMC_LLC_FLOW_REQ_ADD_LINK)
+		smc_llc_flow_stop(lgr, &lgr->llc_flow_lcl);
 }
 
 /* enqueue a local del_link msg to trigger a new del_link flow,
@@ -1302,8 +1551,8 @@ void smc_llc_srv_delete_link_local(struct smc_link *link, u8 del_link_id)
 {
 	struct smc_llc_msg_del_link del_llc = {};
 
-	del_llc.hd.length = sizeof(del_llc);
-	del_llc.hd.common.type = SMC_LLC_DELETE_LINK;
+	del_llc.hd.common.llc_type = SMC_LLC_DELETE_LINK;
+	smc_llc_init_msg_hdr(&del_llc.hd, link->lgr, sizeof(del_llc));
 	del_llc.link_num = del_link_id;
 	del_llc.reason = htonl(SMC_LLC_DEL_LOST_PATH);
 	del_llc.hd.flags |= SMC_LLC_FLAG_DEL_LINK_ORDERLY;
@@ -1373,8 +1622,8 @@ void smc_llc_send_link_delete_all(struct smc_link_group *lgr, bool ord, u32 rsn)
 	struct smc_llc_msg_del_link delllc = {};
 	int i;
 
-	delllc.hd.common.type = SMC_LLC_DELETE_LINK;
-	delllc.hd.length = sizeof(delllc);
+	delllc.hd.common.llc_type = SMC_LLC_DELETE_LINK;
+	smc_llc_init_msg_hdr(&delllc.hd, lgr, sizeof(delllc));
 	if (ord)
 		delllc.hd.flags |= SMC_LLC_FLAG_DEL_LINK_ORDERLY;
 	delllc.hd.flags |= SMC_LLC_FLAG_DEL_LINK_ALL;
@@ -1490,6 +1739,8 @@ static void smc_llc_rmt_conf_rkey(struct smc_link_group *lgr)
 	link = qentry->link;
 
 	num_entries = llc->rtoken[0].num_rkeys;
+	if (num_entries > SMC_LLC_RKEYS_PER_MSG)
+		goto out_err;
 	/* first rkey entry is for receiving link */
 	rk_idx = smc_rtoken_add(link,
 				llc->rtoken[0].rmb_vaddr,
@@ -1508,6 +1759,7 @@ static void smc_llc_rmt_conf_rkey(struct smc_link_group *lgr)
 	llc->hd.flags |= SMC_LLC_FLAG_RKEY_RETRY;
 out:
 	llc->hd.flags |= SMC_LLC_FLAG_RESP;
+	smc_llc_init_msg_hdr(&llc->hd, link->lgr, sizeof(*llc));
 	smc_llc_send_message(link, &qentry->msg);
 	smc_llc_flow_qentry_del(&lgr->llc_flow_rmt);
 }
@@ -1525,6 +1777,28 @@ static void smc_llc_rmt_delete_rkey(struct smc_link_group *lgr)
 	llc = &qentry->msg.delete_rkey;
 	link = qentry->link;
 
+	if (lgr->smc_version == SMC_V2) {
+		struct smc_llc_msg_delete_rkey_v2 *llcv2;
+
+		memcpy(lgr->wr_rx_buf_v2, llc, sizeof(*llc));
+		llcv2 = (struct smc_llc_msg_delete_rkey_v2 *)lgr->wr_rx_buf_v2;
+		llcv2->num_inval_rkeys = 0;
+
+		max = min_t(u8, llcv2->num_rkeys, SMC_LLC_RKEYS_PER_MSG_V2);
+		for (i = 0; i < max; i++) {
+			if (smc_rtoken_delete(link, llcv2->rkey[i]))
+				llcv2->num_inval_rkeys++;
+		}
+		memset(&llc->rkey[0], 0, sizeof(llc->rkey));
+		memset(&llc->reserved2, 0, sizeof(llc->reserved2));
+		smc_llc_init_msg_hdr(&llc->hd, link->lgr, sizeof(*llc));
+		if (llcv2->num_inval_rkeys) {
+			llc->hd.flags |= SMC_LLC_FLAG_RKEY_NEG;
+			llc->err_mask = llcv2->num_inval_rkeys;
+		}
+		goto finish;
+	}
+
 	max = min_t(u8, llc->num_rkeys, SMC_LLC_DEL_RKEY_MAX);
 	for (i = 0; i < max; i++) {
 		if (smc_rtoken_delete(link, llc->rkey[i]))
@@ -1534,6 +1808,7 @@ static void smc_llc_rmt_delete_rkey(struct smc_link_group *lgr)
 		llc->hd.flags |= SMC_LLC_FLAG_RKEY_NEG;
 		llc->err_mask = err_mask;
 	}
+finish:
 	llc->hd.flags |= SMC_LLC_FLAG_RESP;
 	smc_llc_send_message(link, &qentry->msg);
 	smc_llc_flow_qentry_del(&lgr->llc_flow_rmt);
@@ -1569,7 +1844,7 @@ static void smc_llc_event_handler(struct smc_llc_qentry *qentry)
 	if (!smc_link_usable(link))
 		goto out;
 
-	switch (llc->raw.hdr.common.type) {
+	switch (llc->raw.hdr.common.llc_type) {
 	case SMC_LLC_TEST_LINK:
 		llc->test_link.hd.flags |= SMC_LLC_FLAG_RESP;
 		smc_llc_send_message(link, llc);
@@ -1594,8 +1869,18 @@ static void smc_llc_event_handler(struct smc_llc_qentry *qentry)
 				smc_llc_flow_qentry_set(&lgr->llc_flow_lcl,
 							qentry);
 				wake_up(&lgr->llc_msg_waiter);
-			} else if (smc_llc_flow_start(&lgr->llc_flow_lcl,
-						      qentry)) {
+				return;
+			}
+			if (lgr->llc_flow_lcl.type ==
+					SMC_LLC_FLOW_REQ_ADD_LINK) {
+				/* server started add_link processing */
+				lgr->llc_flow_lcl.type = SMC_LLC_FLOW_ADD_LINK;
+				smc_llc_flow_qentry_set(&lgr->llc_flow_lcl,
+							qentry);
+				schedule_work(&lgr->llc_add_link_work);
+				return;
+			}
+			if (smc_llc_flow_start(&lgr->llc_flow_lcl, qentry)) {
 				schedule_work(&lgr->llc_add_link_work);
 			}
 		} else if (smc_llc_flow_start(&lgr->llc_flow_lcl, qentry)) {
@@ -1643,6 +1928,23 @@ static void smc_llc_event_handler(struct smc_llc_qentry *qentry)
 			smc_llc_flow_stop(lgr, &lgr->llc_flow_rmt);
 		}
 		return;
+	case SMC_LLC_REQ_ADD_LINK:
+		/* handle response here, smc_llc_flow_stop() cannot be called
+		 * in tasklet context
+		 */
+		if (lgr->role == SMC_CLNT &&
+		    lgr->llc_flow_lcl.type == SMC_LLC_FLOW_REQ_ADD_LINK &&
+		    (llc->raw.hdr.flags & SMC_LLC_FLAG_RESP)) {
+			smc_llc_flow_stop(link->lgr, &lgr->llc_flow_lcl);
+		} else if (lgr->role == SMC_SERV) {
+			if (smc_llc_flow_start(&lgr->llc_flow_lcl, qentry)) {
+				/* as smc server, handle client suggestion */
+				lgr->llc_flow_lcl.type = SMC_LLC_FLOW_ADD_LINK;
+				schedule_work(&lgr->llc_add_link_work);
+			}
+			return;
+		}
+		break;
 	default:
 		smc_llc_protocol_violation(lgr, llc->raw.hdr.common.type);
 		break;
@@ -1686,7 +1988,7 @@ static void smc_llc_rx_response(struct smc_link *link,
 {
 	enum smc_llc_flowtype flowtype = link->lgr->llc_flow_lcl.type;
 	struct smc_llc_flow *flow = &link->lgr->llc_flow_lcl;
-	u8 llc_type = qentry->msg.raw.hdr.common.type;
+	u8 llc_type = qentry->msg.raw.hdr.common.llc_type;
 
 	switch (llc_type) {
 	case SMC_LLC_TEST_LINK:
@@ -1712,7 +2014,8 @@ static void smc_llc_rx_response(struct smc_link *link,
 		/* not used because max links is 3 */
 		break;
 	default:
-		smc_llc_protocol_violation(link->lgr, llc_type);
+		smc_llc_protocol_violation(link->lgr,
+					   qentry->msg.raw.hdr.common.type);
 		break;
 	}
 	kfree(qentry);
@@ -1737,7 +2040,8 @@ static void smc_llc_enqueue(struct smc_link *link, union smc_llc_msg *llc)
 	memcpy(&qentry->msg, llc, sizeof(union smc_llc_msg));
 
 	/* process responses immediately */
-	if (llc->raw.hdr.flags & SMC_LLC_FLAG_RESP) {
+	if ((llc->raw.hdr.flags & SMC_LLC_FLAG_RESP) &&
+	    llc->raw.hdr.common.llc_type != SMC_LLC_REQ_ADD_LINK) {
 		smc_llc_rx_response(link, qentry);
 		return;
 	}
@@ -1757,8 +2061,13 @@ static void smc_llc_rx_handler(struct ib_wc *wc, void *buf)
 
 	if (wc->byte_len < sizeof(*llc))
 		return; /* short message */
-	if (llc->raw.hdr.length != sizeof(*llc))
-		return; /* invalid message */
+	if (!llc->raw.hdr.common.llc_version) {
+		if (llc->raw.hdr.length != sizeof(*llc))
+			return; /* invalid message */
+	} else {
+		if (llc->raw.hdr.length_v2 < sizeof(*llc))
+			return; /* invalid message */
+	}
 
 	smc_llc_enqueue(link, llc);
 }
@@ -1977,6 +2286,35 @@ static struct smc_wr_rx_handler smc_llc_rx_handlers[] = {
 		.handler	= smc_llc_rx_handler,
 		.type		= SMC_LLC_DELETE_RKEY
 	},
+	/* V2 types */
+	{
+		.handler	= smc_llc_rx_handler,
+		.type		= SMC_LLC_CONFIRM_LINK_V2
+	},
+	{
+		.handler	= smc_llc_rx_handler,
+		.type		= SMC_LLC_TEST_LINK_V2
+	},
+	{
+		.handler	= smc_llc_rx_handler,
+		.type		= SMC_LLC_ADD_LINK_V2
+	},
+	{
+		.handler	= smc_llc_rx_handler,
+		.type		= SMC_LLC_DELETE_LINK_V2
+	},
+	{
+		.handler	= smc_llc_rx_handler,
+		.type		= SMC_LLC_REQ_ADD_LINK_V2
+	},
+	{
+		.handler	= smc_llc_rx_handler,
+		.type		= SMC_LLC_CONFIRM_RKEY_V2
+	},
+	{
+		.handler	= smc_llc_rx_handler,
+		.type		= SMC_LLC_DELETE_RKEY_V2
+	},
 	{
 		.handler	= NULL,
 	}
diff --git a/net/smc/smc_llc.h b/net/smc/smc_llc.h
index cc00a2ec4e92..4404e52b3346 100644
--- a/net/smc/smc_llc.h
+++ b/net/smc/smc_llc.h
@@ -30,10 +30,19 @@ enum smc_llc_msg_type {
 	SMC_LLC_ADD_LINK		= 0x02,
 	SMC_LLC_ADD_LINK_CONT		= 0x03,
 	SMC_LLC_DELETE_LINK		= 0x04,
+	SMC_LLC_REQ_ADD_LINK		= 0x05,
 	SMC_LLC_CONFIRM_RKEY		= 0x06,
 	SMC_LLC_TEST_LINK		= 0x07,
 	SMC_LLC_CONFIRM_RKEY_CONT	= 0x08,
 	SMC_LLC_DELETE_RKEY		= 0x09,
+	/* V2 types */
+	SMC_LLC_CONFIRM_LINK_V2		= 0x21,
+	SMC_LLC_ADD_LINK_V2		= 0x22,
+	SMC_LLC_DELETE_LINK_V2		= 0x24,
+	SMC_LLC_REQ_ADD_LINK_V2		= 0x25,
+	SMC_LLC_CONFIRM_RKEY_V2		= 0x26,
+	SMC_LLC_TEST_LINK_V2		= 0x27,
+	SMC_LLC_DELETE_RKEY_V2		= 0x29,
 };
 
 #define smc_link_downing(state) \
@@ -102,7 +111,8 @@ void smc_llc_flow_qentry_del(struct smc_llc_flow *flow);
 void smc_llc_send_link_delete_all(struct smc_link_group *lgr, bool ord,
 				  u32 rsn);
 int smc_llc_cli_add_link(struct smc_link *link, struct smc_llc_qentry *qentry);
-int smc_llc_srv_add_link(struct smc_link *link);
+int smc_llc_srv_add_link(struct smc_link *link,
+			 struct smc_llc_qentry *req_qentry);
 void smc_llc_add_link_local(struct smc_link *link);
 int smc_llc_init(void) __init;
 
diff --git a/net/smc/smc_wr.c b/net/smc/smc_wr.c
index 22d7324969cd..600ab5889227 100644
--- a/net/smc/smc_wr.c
+++ b/net/smc/smc_wr.c
@@ -258,6 +258,33 @@ int smc_wr_tx_get_free_slot(struct smc_link *link,
 	return 0;
 }
 
+int smc_wr_tx_get_v2_slot(struct smc_link *link,
+			  smc_wr_tx_handler handler,
+			  struct smc_wr_v2_buf **wr_buf,
+			  struct smc_wr_tx_pend_priv **wr_pend_priv)
+{
+	struct smc_wr_tx_pend *wr_pend;
+	struct ib_send_wr *wr_ib;
+	u64 wr_id;
+
+	if (link->wr_tx_v2_pend->idx == link->wr_tx_cnt)
+		return -EBUSY;
+
+	*wr_buf = NULL;
+	*wr_pend_priv = NULL;
+	wr_id = smc_wr_tx_get_next_wr_id(link);
+	wr_pend = link->wr_tx_v2_pend;
+	wr_pend->wr_id = wr_id;
+	wr_pend->handler = handler;
+	wr_pend->link = link;
+	wr_pend->idx = link->wr_tx_cnt;
+	wr_ib = link->wr_tx_v2_ib;
+	wr_ib->wr_id = wr_id;
+	*wr_buf = link->lgr->wr_tx_buf_v2;
+	*wr_pend_priv = &wr_pend->priv;
+	return 0;
+}
+
 int smc_wr_tx_put_slot(struct smc_link *link,
 		       struct smc_wr_tx_pend_priv *wr_pend_priv)
 {
@@ -307,6 +334,22 @@ int smc_wr_tx_send(struct smc_link *link, struct smc_wr_tx_pend_priv *priv)
 	return rc;
 }
 
+int smc_wr_tx_v2_send(struct smc_link *link, struct smc_wr_tx_pend_priv *priv,
+		      int len)
+{
+	int rc;
+
+	link->wr_tx_v2_ib->sg_list[0].length = len;
+	ib_req_notify_cq(link->smcibdev->roce_cq_send,
+			 IB_CQ_NEXT_COMP | IB_CQ_REPORT_MISSED_EVENTS);
+	rc = ib_post_send(link->roce_qp, link->wr_tx_v2_ib, NULL);
+	if (rc) {
+		smc_wr_tx_put_slot(link, priv);
+		smcr_link_down_cond_sched(link);
+	}
+	return rc;
+}
+
 /* Send prepared WR slot via ib_post_send and wait for send completion
  * notification.
  * @priv: pointer to smc_wr_tx_pend_priv identifying prepared message buffer
diff --git a/net/smc/smc_wr.h b/net/smc/smc_wr.h
index 6d2cdb231859..f353311e6f84 100644
--- a/net/smc/smc_wr.h
+++ b/net/smc/smc_wr.h
@@ -113,10 +113,16 @@ int smc_wr_tx_get_free_slot(struct smc_link *link, smc_wr_tx_handler handler,
 			    struct smc_wr_buf **wr_buf,
 			    struct smc_rdma_wr **wrs,
 			    struct smc_wr_tx_pend_priv **wr_pend_priv);
+int smc_wr_tx_get_v2_slot(struct smc_link *link,
+			  smc_wr_tx_handler handler,
+			  struct smc_wr_v2_buf **wr_buf,
+			  struct smc_wr_tx_pend_priv **wr_pend_priv);
 int smc_wr_tx_put_slot(struct smc_link *link,
 		       struct smc_wr_tx_pend_priv *wr_pend_priv);
 int smc_wr_tx_send(struct smc_link *link,
 		   struct smc_wr_tx_pend_priv *wr_pend_priv);
+int smc_wr_tx_v2_send(struct smc_link *link,
+		      struct smc_wr_tx_pend_priv *priv, int len);
 int smc_wr_tx_send_wait(struct smc_link *link, struct smc_wr_tx_pend_priv *priv,
 			unsigned long timeout);
 void smc_wr_tx_cq_handler(struct ib_cq *ib_cq, void *cq_context);
-- 
2.25.1

