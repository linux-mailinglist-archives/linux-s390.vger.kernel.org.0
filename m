Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 938BF42DF85
	for <lists+linux-s390@lfdr.de>; Thu, 14 Oct 2021 18:48:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232828AbhJNQuv (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Thu, 14 Oct 2021 12:50:51 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:20888 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231811AbhJNQuu (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 14 Oct 2021 12:50:50 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19EGjKJe022063;
        Thu, 14 Oct 2021 12:48:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=1/7FauJuDC5iN9e0L2eMlYKuQkXTgwwiBHep53egnNc=;
 b=Vcb1Qp3+DtR+gvqIWG5CgrZi5cv/irGjSa7x813DOP3ZRN1oDiPxCPFUf4ugujLOvUAE
 20xSj1dFrliz/garabjmqxN/vVlBPxTvvz/a1Hsk3R9gqsBhX7hjHQRaEpBxiVUbW4oS
 SSheR0MBDQRI+31xldQl4rx+DScLmHI0MZuVUVGUACdBbXPyio2T8mAS5BkOiJ2wAkYc
 TWf+XdtC3LwYUejZ4Woio2U8uoUfQLT9m6QUNeIAof3f1kWCvNm9sEE1wjXHUy1gkjp+
 wcreRe94YAwBgcrcawkgvgWnCGiDNgre8BrlhfwNZ2g25xrh5A60RVUXTkSjKACClRya WA== 
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3bnqmqbmbm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 Oct 2021 12:48:43 -0400
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 19EGbjCv004461;
        Thu, 14 Oct 2021 16:48:41 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma06fra.de.ibm.com with ESMTP id 3bk2bk4n24-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 Oct 2021 16:48:40 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 19EGmcvc60293570
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Oct 2021 16:48:38 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 68BDCA405C;
        Thu, 14 Oct 2021 16:48:38 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2DFCEA405F;
        Thu, 14 Oct 2021 16:48:38 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 14 Oct 2021 16:48:38 +0000 (GMT)
From:   Karsten Graul <kgraul@linux.ibm.com>
To:     David Miller <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>
Cc:     netdev@vger.kernel.org, linux-s390@vger.kernel.org,
        Heiko Carstens <hca@linux.ibm.com>, linux-rdma@vger.kernel.org
Subject: [PATCH net-next v2 05/11] net/smc: add listen processing for SMC-Rv2
Date:   Thu, 14 Oct 2021 18:47:46 +0200
Message-Id: <20211014164752.3647027-6-kgraul@linux.ibm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211014164752.3647027-1-kgraul@linux.ibm.com>
References: <20211014164752.3647027-1-kgraul@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: GIGY77Fa1hpv2WEsYxBr73AZvD1uNkkS
X-Proofpoint-ORIG-GUID: GIGY77Fa1hpv2WEsYxBr73AZvD1uNkkS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-10-14_09,2021-10-14_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 priorityscore=1501 bulkscore=0 impostorscore=0 lowpriorityscore=0
 phishscore=0 clxscore=1015 mlxscore=0 adultscore=0 spamscore=0
 suspectscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2109230001 definitions=main-2110140095
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Implement the server side of the SMC-Rv2 processing. Process incoming
CLC messages, find eligible devices and check for a valid route to the
remote peer.

Signed-off-by: Karsten Graul <kgraul@linux.ibm.com>
---
 net/smc/af_smc.c   | 165 ++++++++++++++++++++++++++++++++-------------
 net/smc/smc_clc.h  |   1 +
 net/smc/smc_core.c |  64 +++++++++++++-----
 net/smc/smc_core.h |   1 -
 4 files changed, 165 insertions(+), 66 deletions(-)

diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
index d4280262b829..ce5feb68382f 100644
--- a/net/smc/af_smc.c
+++ b/net/smc/af_smc.c
@@ -1515,33 +1515,48 @@ static int smc_listen_v2_check(struct smc_sock *new_smc,
 
 	ini->smc_type_v1 = pclc->hdr.typev1;
 	ini->smc_type_v2 = pclc->hdr.typev2;
-	ini->smcd_version = ini->smc_type_v1 != SMC_TYPE_N ? SMC_V1 : 0;
-	if (pclc->hdr.version > SMC_V1)
-		ini->smcd_version |=
-				ini->smc_type_v2 != SMC_TYPE_N ? SMC_V2 : 0;
-	if (!(ini->smcd_version & SMC_V2)) {
+	ini->smcd_version = smcd_indicated(ini->smc_type_v1) ? SMC_V1 : 0;
+	ini->smcr_version = smcr_indicated(ini->smc_type_v1) ? SMC_V1 : 0;
+	if (pclc->hdr.version > SMC_V1) {
+		if (smcd_indicated(ini->smc_type_v2))
+			ini->smcd_version |= SMC_V2;
+		if (smcr_indicated(ini->smc_type_v2))
+			ini->smcr_version |= SMC_V2;
+	}
+	if (!(ini->smcd_version & SMC_V2) && !(ini->smcr_version & SMC_V2)) {
 		rc = SMC_CLC_DECL_PEERNOSMC;
 		goto out;
 	}
-	if (!smc_ism_is_v2_capable()) {
-		ini->smcd_version &= ~SMC_V2;
-		rc = SMC_CLC_DECL_NOISM2SUPP;
-		goto out;
-	}
 	pclc_v2_ext = smc_get_clc_v2_ext(pclc);
 	if (!pclc_v2_ext) {
 		ini->smcd_version &= ~SMC_V2;
+		ini->smcr_version &= ~SMC_V2;
 		rc = SMC_CLC_DECL_NOV2EXT;
 		goto out;
 	}
 	pclc_smcd_v2_ext = smc_get_clc_smcd_v2_ext(pclc_v2_ext);
-	if (!pclc_smcd_v2_ext) {
-		ini->smcd_version &= ~SMC_V2;
-		rc = SMC_CLC_DECL_NOV2DEXT;
+	if (ini->smcd_version & SMC_V2) {
+		if (!smc_ism_is_v2_capable()) {
+			ini->smcd_version &= ~SMC_V2;
+			rc = SMC_CLC_DECL_NOISM2SUPP;
+		} else if (!pclc_smcd_v2_ext) {
+			ini->smcd_version &= ~SMC_V2;
+			rc = SMC_CLC_DECL_NOV2DEXT;
+		} else if (!pclc_v2_ext->hdr.eid_cnt &&
+			   !pclc_v2_ext->hdr.flag.seid) {
+			ini->smcd_version &= ~SMC_V2;
+			rc = SMC_CLC_DECL_NOUEID;
+		}
+	}
+	if (ini->smcr_version & SMC_V2) {
+		if (!pclc_v2_ext->hdr.eid_cnt) {
+			ini->smcr_version &= ~SMC_V2;
+			rc = SMC_CLC_DECL_NOUEID;
+		}
 	}
 
 out:
-	if (!ini->smcd_version)
+	if (!ini->smcd_version && !ini->smcr_version)
 		return rc;
 
 	return 0;
@@ -1661,10 +1676,6 @@ static void smc_find_ism_v2_device_serv(struct smc_sock *new_smc,
 	pclc_smcd = smc_get_clc_msg_smcd(pclc);
 	smc_v2_ext = smc_get_clc_v2_ext(pclc);
 	smcd_v2_ext = smc_get_clc_smcd_v2_ext(smc_v2_ext);
-	if (!smcd_v2_ext) {
-		smc_find_ism_store_rc(SMC_CLC_DECL_NOV2DEXT, ini);
-		goto not_found;
-	}
 
 	mutex_lock(&smcd_dev_list.mutex);
 	if (pclc_smcd->ism.chid)
@@ -1682,8 +1693,10 @@ static void smc_find_ism_v2_device_serv(struct smc_sock *new_smc,
 	}
 	mutex_unlock(&smcd_dev_list.mutex);
 
-	if (!ini->ism_dev[0])
+	if (!ini->ism_dev[0]) {
+		smc_find_ism_store_rc(SMC_CLC_DECL_NOSMCD2DEV, ini);
 		goto not_found;
+	}
 
 	smc_ism_get_system_eid(&eid);
 	if (!smc_clc_match_eid(ini->negotiated_eid, smc_v2_ext,
@@ -1736,6 +1749,7 @@ static void smc_find_ism_v1_device_serv(struct smc_sock *new_smc,
 
 not_found:
 	smc_find_ism_store_rc(rc, ini);
+	ini->smcd_version &= ~SMC_V1;
 	ini->ism_dev[0] = NULL;
 	ini->is_smcd = false;
 }
@@ -1754,24 +1768,69 @@ static int smc_listen_rdma_reg(struct smc_sock *new_smc, bool local_first)
 	return 0;
 }
 
+static void smc_find_rdma_v2_device_serv(struct smc_sock *new_smc,
+					 struct smc_clc_msg_proposal *pclc,
+					 struct smc_init_info *ini)
+{
+	struct smc_clc_v2_extension *smc_v2_ext;
+	u8 smcr_version;
+	int rc;
+
+	if (!(ini->smcr_version & SMC_V2) || !smcr_indicated(ini->smc_type_v2))
+		goto not_found;
+
+	smc_v2_ext = smc_get_clc_v2_ext(pclc);
+	if (!smc_clc_match_eid(ini->negotiated_eid, smc_v2_ext, NULL, NULL))
+		goto not_found;
+
+	/* prepare RDMA check */
+	memcpy(ini->peer_systemid, pclc->lcl.id_for_peer, SMC_SYSTEMID_LEN);
+	memcpy(ini->peer_gid, smc_v2_ext->roce, SMC_GID_SIZE);
+	memcpy(ini->peer_mac, pclc->lcl.mac, ETH_ALEN);
+	ini->check_smcrv2 = true;
+	ini->smcrv2.clc_sk = new_smc->clcsock->sk;
+	ini->smcrv2.saddr = new_smc->clcsock->sk->sk_rcv_saddr;
+	ini->smcrv2.daddr = smc_ib_gid_to_ipv4(smc_v2_ext->roce);
+	rc = smc_find_rdma_device(new_smc, ini);
+	if (rc) {
+		smc_find_ism_store_rc(rc, ini);
+		goto not_found;
+	}
+	if (!ini->smcrv2.uses_gateway)
+		memcpy(ini->smcrv2.nexthop_mac, pclc->lcl.mac, ETH_ALEN);
+
+	smcr_version = ini->smcr_version;
+	ini->smcr_version = SMC_V2;
+	rc = smc_listen_rdma_init(new_smc, ini);
+	if (!rc)
+		rc = smc_listen_rdma_reg(new_smc, ini->first_contact_local);
+	if (!rc)
+		return;
+	ini->smcr_version = smcr_version;
+	smc_find_ism_store_rc(rc, ini);
+
+not_found:
+	ini->smcr_version &= ~SMC_V2;
+	ini->check_smcrv2 = false;
+}
+
 static int smc_find_rdma_v1_device_serv(struct smc_sock *new_smc,
 					struct smc_clc_msg_proposal *pclc,
 					struct smc_init_info *ini)
 {
 	int rc;
 
-	if (!smcr_indicated(ini->smc_type_v1))
+	if (!(ini->smcr_version & SMC_V1) || !smcr_indicated(ini->smc_type_v1))
 		return SMC_CLC_DECL_NOSMCDEV;
 
 	/* prepare RDMA check */
-	ini->ib_lcl = &pclc->lcl;
+	memcpy(ini->peer_systemid, pclc->lcl.id_for_peer, SMC_SYSTEMID_LEN);
+	memcpy(ini->peer_gid, pclc->lcl.gid, SMC_GID_SIZE);
+	memcpy(ini->peer_mac, pclc->lcl.mac, ETH_ALEN);
 	rc = smc_find_rdma_device(new_smc, ini);
 	if (rc) {
 		/* no RDMA device found */
-		if (ini->smc_type_v1 == SMC_TYPE_B)
-			/* neither ISM nor RDMA device found */
-			rc = SMC_CLC_DECL_NOSMCDEV;
-		return rc;
+		return SMC_CLC_DECL_NOSMCDEV;
 	}
 	rc = smc_listen_rdma_init(new_smc, ini);
 	if (rc)
@@ -1784,51 +1843,60 @@ static int smc_listen_find_device(struct smc_sock *new_smc,
 				  struct smc_clc_msg_proposal *pclc,
 				  struct smc_init_info *ini)
 {
-	int rc;
+	int prfx_rc;
 
 	/* check for ISM device matching V2 proposed device */
 	smc_find_ism_v2_device_serv(new_smc, pclc, ini);
 	if (ini->ism_dev[0])
 		return 0;
 
-	if (!(ini->smcd_version & SMC_V1))
-		return ini->rc ?: SMC_CLC_DECL_NOSMCD2DEV;
-
-	/* check for matching IP prefix and subnet length */
-	rc = smc_listen_prfx_check(new_smc, pclc);
-	if (rc)
-		return ini->rc ?: rc;
+	/* check for matching IP prefix and subnet length (V1) */
+	prfx_rc = smc_listen_prfx_check(new_smc, pclc);
+	if (prfx_rc)
+		smc_find_ism_store_rc(prfx_rc, ini);
 
 	/* get vlan id from IP device */
 	if (smc_vlan_by_tcpsk(new_smc->clcsock, ini))
 		return ini->rc ?: SMC_CLC_DECL_GETVLANERR;
 
 	/* check for ISM device matching V1 proposed device */
-	smc_find_ism_v1_device_serv(new_smc, pclc, ini);
+	if (!prfx_rc)
+		smc_find_ism_v1_device_serv(new_smc, pclc, ini);
 	if (ini->ism_dev[0])
 		return 0;
 
-	if (pclc->hdr.typev1 == SMC_TYPE_D)
+	if (!smcr_indicated(pclc->hdr.typev1) &&
+	    !smcr_indicated(pclc->hdr.typev2))
 		/* skip RDMA and decline */
 		return ini->rc ?: SMC_CLC_DECL_NOSMCDDEV;
 
-	/* check if RDMA is available */
-	rc = smc_find_rdma_v1_device_serv(new_smc, pclc, ini);
-	smc_find_ism_store_rc(rc, ini);
+	/* check if RDMA V2 is available */
+	smc_find_rdma_v2_device_serv(new_smc, pclc, ini);
+	if (ini->smcrv2.ib_dev_v2)
+		return 0;
 
-	return (!rc) ? 0 : ini->rc;
+	/* check if RDMA V1 is available */
+	if (!prfx_rc) {
+		int rc;
+
+		rc = smc_find_rdma_v1_device_serv(new_smc, pclc, ini);
+		smc_find_ism_store_rc(rc, ini);
+		return (!rc) ? 0 : ini->rc;
+	}
+	return SMC_CLC_DECL_NOSMCDEV;
 }
 
 /* listen worker: finish RDMA setup */
 static int smc_listen_rdma_finish(struct smc_sock *new_smc,
 				  struct smc_clc_msg_accept_confirm *cclc,
-				  bool local_first)
+				  bool local_first,
+				  struct smc_init_info *ini)
 {
 	struct smc_link *link = new_smc->conn.lnk;
 	int reason_code = 0;
 
 	if (local_first)
-		smc_link_save_peer_info(link, cclc, NULL);
+		smc_link_save_peer_info(link, cclc, ini);
 
 	if (smc_rmb_rtoken_handling(&new_smc->conn, link, cclc))
 		return SMC_CLC_DECL_ERR_RTOK;
@@ -1849,12 +1917,13 @@ static void smc_listen_work(struct work_struct *work)
 {
 	struct smc_sock *new_smc = container_of(work, struct smc_sock,
 						smc_listen_work);
-	u8 version = smc_ism_is_v2_capable() ? SMC_V2 : SMC_V1;
 	struct socket *newclcsock = new_smc->clcsock;
 	struct smc_clc_msg_accept_confirm *cclc;
 	struct smc_clc_msg_proposal_area *buf;
 	struct smc_clc_msg_proposal *pclc;
 	struct smc_init_info *ini = NULL;
+	u8 proposal_version = SMC_V1;
+	u8 accept_version;
 	int rc = 0;
 
 	if (new_smc->listen_smc->sk.sk_state != SMC_LISTEN)
@@ -1885,7 +1954,9 @@ static void smc_listen_work(struct work_struct *work)
 			      SMC_CLC_PROPOSAL, CLC_WAIT_TIME);
 	if (rc)
 		goto out_decl;
-	version = pclc->hdr.version == SMC_V1 ? SMC_V1 : version;
+
+	if (pclc->hdr.version > SMC_V1)
+		proposal_version = SMC_V2;
 
 	/* IPSec connections opt out of SMC optimizations */
 	if (using_ipsec(new_smc)) {
@@ -1915,9 +1986,9 @@ static void smc_listen_work(struct work_struct *work)
 		goto out_unlock;
 
 	/* send SMC Accept CLC message */
+	accept_version = ini->is_smcd ? ini->smcd_version : ini->smcr_version;
 	rc = smc_clc_send_accept(new_smc, ini->first_contact_local,
-				 ini->smcd_version == SMC_V2 ? SMC_V2 : SMC_V1,
-				 ini->negotiated_eid);
+				 accept_version, ini->negotiated_eid);
 	if (rc)
 		goto out_unlock;
 
@@ -1939,7 +2010,7 @@ static void smc_listen_work(struct work_struct *work)
 	/* finish worker */
 	if (!ini->is_smcd) {
 		rc = smc_listen_rdma_finish(new_smc, cclc,
-					    ini->first_contact_local);
+					    ini->first_contact_local, ini);
 		if (rc)
 			goto out_unlock;
 		mutex_unlock(&smc_server_lgr_pending);
@@ -1953,7 +2024,7 @@ static void smc_listen_work(struct work_struct *work)
 	mutex_unlock(&smc_server_lgr_pending);
 out_decl:
 	smc_listen_decline(new_smc, rc, ini ? ini->first_contact_local : 0,
-			   version);
+			   proposal_version);
 out_free:
 	kfree(ini);
 	kfree(buf);
diff --git a/net/smc/smc_clc.h b/net/smc/smc_clc.h
index 4f2fe278f404..22c079ed77a9 100644
--- a/net/smc/smc_clc.h
+++ b/net/smc/smc_clc.h
@@ -44,6 +44,7 @@
 #define SMC_CLC_DECL_NOV2DEXT	0x03030005  /* peer sent no clc SMC-Dv2 ext.  */
 #define SMC_CLC_DECL_NOSEID	0x03030006  /* peer sent no SEID	      */
 #define SMC_CLC_DECL_NOSMCD2DEV	0x03030007  /* no SMC-Dv2 device found	      */
+#define SMC_CLC_DECL_NOUEID	0x03030008  /* peer sent no UEID	      */
 #define SMC_CLC_DECL_MODEUNSUPP	0x03040000  /* smc modes do not match (R or D)*/
 #define SMC_CLC_DECL_RMBE_EC	0x03050000  /* peer has eyecatcher in RMBE    */
 #define SMC_CLC_DECL_OPTUNSUPP	0x03060000  /* fastopen sockopt not supported */
diff --git a/net/smc/smc_core.c b/net/smc/smc_core.c
index 4d463701a759..a081582e5669 100644
--- a/net/smc/smc_core.c
+++ b/net/smc/smc_core.c
@@ -684,24 +684,30 @@ static void smcr_copy_dev_info_to_link(struct smc_link *link)
 int smcr_link_init(struct smc_link_group *lgr, struct smc_link *lnk,
 		   u8 link_idx, struct smc_init_info *ini)
 {
+	struct smc_ib_device *smcibdev;
 	u8 rndvec[3];
 	int rc;
 
-	get_device(&ini->ib_dev->ibdev->dev);
-	atomic_inc(&ini->ib_dev->lnk_cnt);
+	if (lgr->smc_version == SMC_V2) {
+		lnk->smcibdev = ini->smcrv2.ib_dev_v2;
+		lnk->ibport = ini->smcrv2.ib_port_v2;
+	} else {
+		lnk->smcibdev = ini->ib_dev;
+		lnk->ibport = ini->ib_port;
+	}
+	get_device(&lnk->smcibdev->ibdev->dev);
+	atomic_inc(&lnk->smcibdev->lnk_cnt);
+	lnk->path_mtu = lnk->smcibdev->pattr[lnk->ibport - 1].active_mtu;
 	lnk->link_id = smcr_next_link_id(lgr);
 	lnk->lgr = lgr;
 	lnk->link_idx = link_idx;
-	lnk->smcibdev = ini->ib_dev;
-	lnk->ibport = ini->ib_port;
 	smc_ibdev_cnt_inc(lnk);
 	smcr_copy_dev_info_to_link(lnk);
-	lnk->path_mtu = ini->ib_dev->pattr[ini->ib_port - 1].active_mtu;
 	atomic_set(&lnk->conn_cnt, 0);
 	smc_llc_link_set_uid(lnk);
 	INIT_WORK(&lnk->link_down_wrk, smc_link_down_work);
-	if (!ini->ib_dev->initialized) {
-		rc = (int)smc_ib_setup_per_ibdev(ini->ib_dev);
+	if (!lnk->smcibdev->initialized) {
+		rc = (int)smc_ib_setup_per_ibdev(lnk->smcibdev);
 		if (rc)
 			goto out;
 	}
@@ -740,11 +746,12 @@ int smcr_link_init(struct smc_link_group *lgr, struct smc_link *lnk,
 	smc_llc_link_clear(lnk, false);
 out:
 	smc_ibdev_cnt_dec(lnk);
-	put_device(&ini->ib_dev->ibdev->dev);
+	put_device(&lnk->smcibdev->ibdev->dev);
+	smcibdev = lnk->smcibdev;
 	memset(lnk, 0, sizeof(struct smc_link));
 	lnk->state = SMC_LNK_UNUSED;
-	if (!atomic_dec_return(&ini->ib_dev->lnk_cnt))
-		wake_up(&ini->ib_dev->lnks_deleted);
+	if (!atomic_dec_return(&smcibdev->lnk_cnt))
+		wake_up(&smcibdev->lnks_deleted);
 	return rc;
 }
 
@@ -808,10 +815,25 @@ static int smc_lgr_create(struct smc_sock *smc, struct smc_init_info *ini)
 		atomic_inc(&ini->ism_dev[ini->ism_selected]->lgr_cnt);
 	} else {
 		/* SMC-R specific settings */
+		struct smc_ib_device *ibdev;
+		int ibport;
+
 		lgr->role = smc->listen_smc ? SMC_SERV : SMC_CLNT;
-		memcpy(lgr->peer_systemid, ini->ib_lcl->id_for_peer,
+		lgr->smc_version = ini->smcr_version;
+		memcpy(lgr->peer_systemid, ini->peer_systemid,
 		       SMC_SYSTEMID_LEN);
-		memcpy(lgr->pnet_id, ini->ib_dev->pnetid[ini->ib_port - 1],
+		if (lgr->smc_version == SMC_V2) {
+			ibdev = ini->smcrv2.ib_dev_v2;
+			ibport = ini->smcrv2.ib_port_v2;
+			lgr->saddr = ini->smcrv2.saddr;
+			lgr->uses_gateway = ini->smcrv2.uses_gateway;
+			memcpy(lgr->nexthop_mac, ini->smcrv2.nexthop_mac,
+			       ETH_ALEN);
+		} else {
+			ibdev = ini->ib_dev;
+			ibport = ini->ib_port;
+		}
+		memcpy(lgr->pnet_id, ibdev->pnetid[ibport - 1],
 		       SMC_MAX_PNETID_LEN);
 		smc_llc_lgr_init(lgr, smc);
 
@@ -1636,13 +1658,15 @@ int smc_vlan_by_tcpsk(struct socket *clcsock, struct smc_init_info *ini)
 	return rc;
 }
 
-static bool smcr_lgr_match(struct smc_link_group *lgr,
-			   struct smc_clc_msg_local *lcl,
+static bool smcr_lgr_match(struct smc_link_group *lgr, u8 smcr_version,
+			   u8 peer_systemid[],
+			   u8 peer_gid[],
+			   u8 peer_mac_v1[],
 			   enum smc_lgr_role role, u32 clcqpn)
 {
 	int i;
 
-	if (memcmp(lgr->peer_systemid, lcl->id_for_peer, SMC_SYSTEMID_LEN) ||
+	if (memcmp(lgr->peer_systemid, peer_systemid, SMC_SYSTEMID_LEN) ||
 	    lgr->role != role)
 		return false;
 
@@ -1650,8 +1674,9 @@ static bool smcr_lgr_match(struct smc_link_group *lgr,
 		if (!smc_link_active(&lgr->lnk[i]))
 			continue;
 		if ((lgr->role == SMC_SERV || lgr->lnk[i].peer_qpn == clcqpn) &&
-		    !memcmp(lgr->lnk[i].peer_gid, &lcl->gid, SMC_GID_SIZE) &&
-		    !memcmp(lgr->lnk[i].peer_mac, lcl->mac, sizeof(lcl->mac)))
+		    !memcmp(lgr->lnk[i].peer_gid, peer_gid, SMC_GID_SIZE) &&
+		    (smcr_version == SMC_V2 ||
+		     !memcmp(lgr->lnk[i].peer_mac, peer_mac_v1, ETH_ALEN)))
 			return true;
 	}
 	return false;
@@ -1690,7 +1715,10 @@ int smc_conn_create(struct smc_sock *smc, struct smc_init_info *ini)
 		if ((ini->is_smcd ?
 		     smcd_lgr_match(lgr, ini->ism_dev[ini->ism_selected],
 				    ini->ism_peer_gid[ini->ism_selected]) :
-		     smcr_lgr_match(lgr, ini->ib_lcl, role, ini->ib_clcqpn)) &&
+		     smcr_lgr_match(lgr, ini->smcr_version,
+				    ini->peer_systemid,
+				    ini->peer_gid, ini->peer_mac, role,
+				    ini->ib_clcqpn)) &&
 		    !lgr->sync_err &&
 		    (ini->smcd_version == SMC_V2 ||
 		     lgr->vlan_id == ini->vlan_id) &&
diff --git a/net/smc/smc_core.h b/net/smc/smc_core.h
index 128474f33b8f..dd3198bb6cb9 100644
--- a/net/smc/smc_core.h
+++ b/net/smc/smc_core.h
@@ -340,7 +340,6 @@ struct smc_init_info {
 	u32			rc;
 	u8			negotiated_eid[SMC_MAX_EID_LEN];
 	/* SMC-R */
-	struct smc_clc_msg_local *ib_lcl;
 	u8			smcr_version;
 	u8			check_smcrv2;
 	u8			peer_gid[SMC_GID_SIZE];
-- 
2.25.1

