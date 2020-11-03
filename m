Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5AD52A41B5
	for <lists+linux-s390@lfdr.de>; Tue,  3 Nov 2020 11:26:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728164AbgKCKZ5 (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Tue, 3 Nov 2020 05:25:57 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:8682 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728129AbgKCKZ4 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 3 Nov 2020 05:25:56 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0A3A2dpS073620;
        Tue, 3 Nov 2020 05:25:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references; s=pp1;
 bh=I44e3pNUB+xfFTVvpaOC9fkml7k2WSbjn4woBVJekh4=;
 b=K50QCWlGuD6Jjd33mfnJMjzTNNLA4ANu0rTR1WsbTdGS3ZGvbWheZedFMSmBNLHB/UUf
 ym4PjqIrr84zfG+Z/us4pYZ4CeIHuDM6gdLKbKj6ufCSRpPy5yTRxtangFt4NlmzlveK
 Z/SWkKtnJDpIz2stnLDrK4ZNkKU/249lHY45FG3rWj55j5ZUaPodVa7afidYw4ENk8Xl
 1AdvlUBQjPcHp6a1adVll8ng9tH9KktGDQrYZo6S9xyCtluoJ6jqDcx7UuAzMvED/Yq8
 THiCu/5cSyh3oN8sNu+Hb31yVKICWokeZp7wRbIM4AcvjS9ELakU7P27sQS+wQWQ4adg pw== 
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 34jwmh4rwd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 03 Nov 2020 05:25:55 -0500
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0A3ANNEw023251;
        Tue, 3 Nov 2020 10:25:53 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma06ams.nl.ibm.com with ESMTP id 34h0fcu4fh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 03 Nov 2020 10:25:52 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0A3APoe27406278
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 3 Nov 2020 10:25:50 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2F080A4060;
        Tue,  3 Nov 2020 10:25:50 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EC4E3A4065;
        Tue,  3 Nov 2020 10:25:49 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue,  3 Nov 2020 10:25:49 +0000 (GMT)
From:   Karsten Graul <kgraul@linux.ibm.com>
To:     davem@davemloft.net
Cc:     netdev@vger.kernel.org, linux-s390@vger.kernel.org,
        hca@linux.ibm.com, raspl@linux.ibm.com
Subject: [PATCH net-next v2 13/15] net/smc: Add support for obtaining SMCR device list
Date:   Tue,  3 Nov 2020 11:25:29 +0100
Message-Id: <20201103102531.91710-14-kgraul@linux.ibm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201103102531.91710-1-kgraul@linux.ibm.com>
References: <20201103102531.91710-1-kgraul@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-03_07:2020-11-02,2020-11-03 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 spamscore=0
 mlxscore=0 bulkscore=0 phishscore=0 priorityscore=1501 suspectscore=1
 adultscore=0 mlxlogscore=999 clxscore=1015 impostorscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011030065
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

From: Guvenc Gulce <guvenc@linux.ibm.com>

Deliver SMCR device information via netlink based
diagnostic interface.

Signed-off-by: Guvenc Gulce <guvenc@linux.ibm.com>
Signed-off-by: Karsten Graul <kgraul@linux.ibm.com>
---
 include/uapi/linux/smc_diag.h |   6 ++
 net/smc/smc_diag.c            | 133 ++++++++++++++++++++++++++++++++++
 net/smc/smc_ib.c              |   2 +
 3 files changed, 141 insertions(+)

diff --git a/include/uapi/linux/smc_diag.h b/include/uapi/linux/smc_diag.h
index ab8f76bdd1a4..4c6332785533 100644
--- a/include/uapi/linux/smc_diag.h
+++ b/include/uapi/linux/smc_diag.h
@@ -88,6 +88,7 @@ enum {
 /* SMC_DIAG_GET_DEV_INFO command extensions */
 enum {
 	SMC_DIAG_DEV_INFO_SMCD = 1,
+	SMC_DIAG_DEV_INFO_SMCR,
 };
 
 #define SMC_DIAG_MAX (__SMC_DIAG_MAX - 1)
@@ -182,6 +183,11 @@ struct smc_diag_dev_info {
 	__u16		pci_vendor;		/* PCI Vendor */
 	__u16		pci_device;		/* PCI Device Vendor ID */
 	__u8		pci_id[SMC_PCI_ID_STR_LEN]; /* PCI ID */
+	__u8		dev_name[IB_DEVICE_NAME_MAX]; /* IB Device name */
+	__u8		netdev[SMC_MAX_PORTS][IFNAMSIZ]; /* Netdev name(s) */
+	__u8		port_state[SMC_MAX_PORTS]; /* IB Port State */
+	__u8		port_valid[SMC_MAX_PORTS]; /* Is IB Port valid */
+	__u32		lnk_cnt_by_port[SMC_MAX_PORTS]; /* # lnks per port */
 };
 
 struct smc_diag_lgr {
diff --git a/net/smc/smc_diag.c b/net/smc/smc_diag.c
index 252aae0b11d9..58bfbe0bef4d 100644
--- a/net/smc/smc_diag.c
+++ b/net/smc/smc_diag.c
@@ -365,6 +365,34 @@ static int smc_diag_handle_lgr(struct smc_link_group *lgr,
 	return rc;
 }
 
+static bool smcr_diag_is_dev_critical(struct smc_lgr_list *smc_lgr,
+				      struct smc_ib_device *smcibdev)
+{
+	struct smc_link_group *lgr;
+	bool rc = false;
+	int i;
+
+	spin_lock_bh(&smc_lgr->lock);
+	list_for_each_entry(lgr, &smc_lgr->list, list) {
+		if (lgr->is_smcd)
+			continue;
+		for (i = 0; i < SMC_LINKS_PER_LGR_MAX; i++) {
+			if (lgr->lnk[i].state == SMC_LNK_UNUSED)
+				continue;
+			if (lgr->lnk[i].smcibdev == smcibdev) {
+				if (lgr->type == SMC_LGR_SINGLE ||
+				    lgr->type == SMC_LGR_ASYMMETRIC_LOCAL) {
+					rc = true;
+					goto out;
+				}
+			}
+		}
+	}
+out:
+	spin_unlock_bh(&smc_lgr->lock);
+	return rc;
+}
+
 static int smc_diag_fill_lgr_list(struct smc_lgr_list *smc_lgr,
 				  struct sk_buff *skb,
 				  struct netlink_callback *cb,
@@ -520,6 +548,108 @@ static int smc_diag_prep_smcd_dev(struct smcd_dev_list *dev_list,
 	return rc;
 }
 
+static inline void smc_diag_handle_dev_port(struct smc_diag_dev_info *smc_diag_dev,
+					    struct ib_device *ibdev,
+					    struct smc_ib_device *smcibdev,
+					    int port)
+{
+	unsigned char port_state;
+
+	smc_diag_dev->port_valid[port] = 1;
+	snprintf((char *)&smc_diag_dev->netdev[port],
+		 sizeof(smc_diag_dev->netdev[port]),
+		 "%s", (char *)&smcibdev->netdev[port]);
+	snprintf((char *)&smc_diag_dev->pnet_id[port],
+		 sizeof(smc_diag_dev->pnet_id[port]), "%s",
+		 (char *)&smcibdev->pnetid[port]);
+	smc_diag_dev->pnetid_by_user[port] = smcibdev->pnetid_by_user[port];
+	port_state = smc_ib_port_active(smcibdev, port + 1);
+	smc_diag_dev->port_state[port] = port_state;
+	smc_diag_dev->lnk_cnt_by_port[port] =
+			atomic_read(&smcibdev->lnk_cnt_by_port[port]);
+}
+
+static int smc_diag_handle_smcr_dev(struct smc_ib_device *smcibdev,
+				    struct sk_buff *skb,
+				    struct netlink_callback *cb,
+				    struct smc_diag_req_v2 *req)
+{
+	struct smc_diag_dev_info smc_dev;
+	struct smc_pci_dev smc_pci_dev;
+	struct pci_dev *pci_dev;
+	unsigned char is_crit;
+	struct nlmsghdr *nlh;
+	int dummy = 0;
+	int i, rc = 0;
+
+	nlh = nlmsg_put(skb, NETLINK_CB(cb->skb).portid, MAGIC_SEQ_V2_ACK,
+			cb->nlh->nlmsg_type, 0, NLM_F_MULTI);
+	if (!nlh)
+		return -EMSGSIZE;
+
+	memset(&smc_dev, 0, sizeof(smc_dev));
+	memset(&smc_pci_dev, 0, sizeof(smc_pci_dev));
+	for (i = 1; i <= SMC_MAX_PORTS; i++) {
+		if (rdma_is_port_valid(smcibdev->ibdev, i)) {
+			smc_diag_handle_dev_port(&smc_dev, smcibdev->ibdev,
+						 smcibdev, i - 1);
+		}
+	}
+	pci_dev = to_pci_dev(smcibdev->ibdev->dev.parent);
+	smc_set_pci_values(pci_dev, &smc_pci_dev);
+	smc_dev.pci_device = smc_pci_dev.pci_device;
+	smc_dev.pci_fid = smc_pci_dev.pci_fid;
+	smc_dev.pci_pchid = smc_pci_dev.pci_pchid;
+	smc_dev.pci_vendor = smc_pci_dev.pci_vendor;
+	snprintf(smc_dev.pci_id, sizeof(smc_dev.pci_id), "%s",
+		 smc_pci_dev.pci_id);
+	snprintf(smc_dev.dev_name, sizeof(smc_dev.dev_name),
+		 "%s", smcibdev->ibdev->name);
+	is_crit = smcr_diag_is_dev_critical(&smc_lgr_list, smcibdev);
+	smc_dev.is_critical = is_crit;
+
+	/* Just a command place holder to signal back the command reply type */
+	if (nla_put(skb, SMC_DIAG_GET_DEV_INFO, sizeof(dummy), &dummy) < 0)
+		goto errout;
+
+	if (nla_put(skb, SMC_DIAG_DEV_INFO_SMCR,
+		    sizeof(smc_dev), &smc_dev) < 0)
+		goto errout;
+
+	nlmsg_end(skb, nlh);
+	return rc;
+
+errout:
+	nlmsg_cancel(skb, nlh);
+	return -EMSGSIZE;
+}
+
+static int smc_diag_prep_smcr_dev(struct smc_ib_devices *dev_list,
+				  struct sk_buff *skb,
+				  struct netlink_callback *cb,
+				  struct smc_diag_req_v2 *req)
+{
+	struct smc_diag_dump_ctx *cb_ctx = smc_dump_context(cb);
+	struct smc_ib_device *smcibdev;
+	int snum = cb_ctx->pos[0];
+	int rc = 0, num = 0;
+
+	mutex_lock(&dev_list->mutex);
+	list_for_each_entry(smcibdev, &dev_list->list, list) {
+		if (num < snum)
+			goto next;
+		rc = smc_diag_handle_smcr_dev(smcibdev, skb, cb, req);
+		if (rc < 0)
+			goto out;
+next:
+		num++;
+	}
+out:
+	mutex_unlock(&dev_list->mutex);
+	cb_ctx->pos[0] = num;
+	return rc;
+}
+
 static int __smc_diag_dump(struct sock *sk, struct sk_buff *skb,
 			   struct netlink_callback *cb,
 			   const struct smc_diag_req *req)
@@ -625,6 +755,9 @@ static int smc_diag_dump_ext(struct sk_buff *skb, struct netlink_callback *cb)
 		if ((req->cmd_ext & (1 << (SMC_DIAG_DEV_INFO_SMCD - 1))))
 			smc_diag_prep_smcd_dev(&smcd_dev_list, skb, cb,
 					       req);
+		if ((req->cmd_ext & (1 << (SMC_DIAG_DEV_INFO_SMCR - 1))))
+			smc_diag_prep_smcr_dev(&smc_ib_devices, skb, cb,
+					       req);
 	}
 
 	return skb->len;
diff --git a/net/smc/smc_ib.c b/net/smc/smc_ib.c
index c4a04e868bf0..14688aa74d66 100644
--- a/net/smc/smc_ib.c
+++ b/net/smc/smc_ib.c
@@ -37,6 +37,7 @@ struct smc_ib_devices smc_ib_devices = {	/* smc-registered ib devices */
 	.mutex = __MUTEX_INITIALIZER(smc_ib_devices.mutex),
 	.list = LIST_HEAD_INIT(smc_ib_devices.list),
 };
+EXPORT_SYMBOL_GPL(smc_ib_devices);
 
 u8 local_systemid[SMC_SYSTEMID_LEN];		/* unique system identifier */
 
@@ -181,6 +182,7 @@ bool smc_ib_port_active(struct smc_ib_device *smcibdev, u8 ibport)
 {
 	return smcibdev->pattr[ibport - 1].state == IB_PORT_ACTIVE;
 }
+EXPORT_SYMBOL_GPL(smc_ib_port_active);
 
 /* determine the gid for an ib-device port and vlan id */
 int smc_ib_determine_gid(struct smc_ib_device *smcibdev, u8 ibport,
-- 
2.17.1

