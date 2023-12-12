Return-Path: <linux-s390+bounces-516-lists+linux-s390=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EF6F80E6C0
	for <lists+linux-s390@lfdr.de>; Tue, 12 Dec 2023 09:54:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C45D1282B27
	for <lists+linux-s390@lfdr.de>; Tue, 12 Dec 2023 08:54:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9042157870;
	Tue, 12 Dec 2023 08:53:00 +0000 (UTC)
X-Original-To: linux-s390@vger.kernel.org
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AF6CDB;
	Tue, 12 Dec 2023 00:52:56 -0800 (PST)
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R901e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046060;MF=guwen@linux.alibaba.com;NM=1;PH=DS;RN=22;SR=0;TI=SMTPD_---0VyLt.aH_1702371170;
Received: from localhost(mailfrom:guwen@linux.alibaba.com fp:SMTPD_---0VyLt.aH_1702371170)
          by smtp.aliyun-inc.com;
          Tue, 12 Dec 2023 16:52:52 +0800
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
	lzinux-kernel@vger.kernel.org
Subject: [PATCH net-next v6 08/10] net/smc: support extended GID in SMC-D lgr netlink attribute
Date: Tue, 12 Dec 2023 16:52:29 +0800
Message-Id: <1702371151-125258-9-git-send-email-guwen@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1702371151-125258-1-git-send-email-guwen@linux.alibaba.com>
References: <1702371151-125258-1-git-send-email-guwen@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Virtual ISM devices introduced in SMCv2.1 requires a 128 bit extended
GID vs. the existing ISM 64bit GID. So the 2nd 64 bit of extended GID
should be included in SMC-D linkgroup netlink attribute as well.

Signed-off-by: Wen Gu <guwen@linux.alibaba.com>
---
 include/uapi/linux/smc.h      | 2 ++
 include/uapi/linux/smc_diag.h | 2 ++
 net/smc/smc_core.c            | 6 ++++++
 net/smc/smc_diag.c            | 2 ++
 4 files changed, 12 insertions(+)

diff --git a/include/uapi/linux/smc.h b/include/uapi/linux/smc.h
index 837fcd4..b531e3e 100644
--- a/include/uapi/linux/smc.h
+++ b/include/uapi/linux/smc.h
@@ -160,6 +160,8 @@ enum {
 	SMC_NLA_LGR_D_CHID,		/* u16 */
 	SMC_NLA_LGR_D_PAD,		/* flag */
 	SMC_NLA_LGR_D_V2_COMMON,	/* nest */
+	SMC_NLA_LGR_D_EXT_GID,		/* u64 */
+	SMC_NLA_LGR_D_PEER_EXT_GID,	/* u64 */
 	__SMC_NLA_LGR_D_MAX,
 	SMC_NLA_LGR_D_MAX = __SMC_NLA_LGR_D_MAX - 1
 };
diff --git a/include/uapi/linux/smc_diag.h b/include/uapi/linux/smc_diag.h
index 8cb3a6f..58eceb7 100644
--- a/include/uapi/linux/smc_diag.h
+++ b/include/uapi/linux/smc_diag.h
@@ -107,6 +107,8 @@ struct smcd_diag_dmbinfo {		/* SMC-D Socket internals */
 	__aligned_u64	my_gid;		/* My GID */
 	__aligned_u64	token;		/* Token of DMB */
 	__aligned_u64	peer_token;	/* Token of remote DMBE */
+	__aligned_u64	peer_gid_ext;	/* Peer GID (extended part) */
+	__aligned_u64	my_gid_ext;	/* My GID (extended part) */
 };
 
 #endif /* _UAPI_SMC_DIAG_H_ */
diff --git a/net/smc/smc_core.c b/net/smc/smc_core.c
index 672eff0..95cc954 100644
--- a/net/smc/smc_core.c
+++ b/net/smc/smc_core.c
@@ -526,9 +526,15 @@ static int smc_nl_fill_smcd_lgr(struct smc_link_group *lgr,
 	if (nla_put_u64_64bit(skb, SMC_NLA_LGR_D_GID,
 			      smcd_gid.gid, SMC_NLA_LGR_D_PAD))
 		goto errattr;
+	if (nla_put_u64_64bit(skb, SMC_NLA_LGR_D_EXT_GID,
+			      smcd_gid.gid_ext, SMC_NLA_LGR_D_PAD))
+		goto errattr;
 	if (nla_put_u64_64bit(skb, SMC_NLA_LGR_D_PEER_GID, lgr->peer_gid.gid,
 			      SMC_NLA_LGR_D_PAD))
 		goto errattr;
+	if (nla_put_u64_64bit(skb, SMC_NLA_LGR_D_PEER_EXT_GID,
+			      lgr->peer_gid.gid_ext, SMC_NLA_LGR_D_PAD))
+		goto errattr;
 	if (nla_put_u8(skb, SMC_NLA_LGR_D_VLAN_ID, lgr->vlan_id))
 		goto errattr;
 	if (nla_put_u32(skb, SMC_NLA_LGR_D_CONNS_NUM, lgr->conns_num))
diff --git a/net/smc/smc_diag.c b/net/smc/smc_diag.c
index c180c18..3fbe14e 100644
--- a/net/smc/smc_diag.c
+++ b/net/smc/smc_diag.c
@@ -175,8 +175,10 @@ static int __smc_diag_dump(struct sock *sk, struct sk_buff *skb,
 
 		dinfo.linkid = *((u32 *)conn->lgr->id);
 		dinfo.peer_gid = conn->lgr->peer_gid.gid;
+		dinfo.peer_gid_ext = conn->lgr->peer_gid.gid_ext;
 		smcd->ops->get_local_gid(smcd, &smcd_gid);
 		dinfo.my_gid = smcd_gid.gid;
+		dinfo.my_gid_ext = smcd_gid.gid_ext;
 		dinfo.token = conn->rmb_desc->token;
 		dinfo.peer_token = conn->peer_token;
 
-- 
1.8.3.1


