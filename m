Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B1C24BFB43
	for <lists+linux-s390@lfdr.de>; Tue, 22 Feb 2022 15:55:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232957AbiBVOzb (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Tue, 22 Feb 2022 09:55:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229679AbiBVOzb (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 22 Feb 2022 09:55:31 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4105810C513;
        Tue, 22 Feb 2022 06:55:06 -0800 (PST)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21MDhbe7017062;
        Tue, 22 Feb 2022 14:55:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=6Wu5eDkx8Lixyzh7KShtj7gaZAiMY4doEHgsWPSsmQ8=;
 b=VzCPFpmoQT77wR7u/X/cRqpFZFPriTGW9kHATUXTIj/D3I6GzIexO9YbpkLLnFU2H1lW
 H3rmZ4Xnfs7cN2FuHuuctdSDgKWuluZCgoHZdND98AB4Afcy83vhsPuIuslo0cJWPmbw
 F28sx2SpKSCZBpzyyMJB77wVBy2BHWioDHzjEvVTEvr9e+V8s5Y6AiTBYKSJ1DUP2+4q
 3+CriHxNZBxgchoAQko6WU94pKZOJ/RFMapGUtofOmBk26PFrlQR8CjWIkQPltUJbN03
 B75BpI8yYKrRHS/lq5O4JZWL8El9lLIQ038QB8U13z4KVfp61TV1seuoXUhyT2Y34UR6 ng== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3ed036ug05-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 22 Feb 2022 14:55:05 +0000
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 21MEVSHm028206;
        Tue, 22 Feb 2022 14:55:04 GMT
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3ed036ufyd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 22 Feb 2022 14:55:04 +0000
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 21MEhctm020607;
        Tue, 22 Feb 2022 14:55:03 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma03fra.de.ibm.com with ESMTP id 3ear692frt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 22 Feb 2022 14:55:02 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 21MEiMGj47317368
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 22 Feb 2022 14:44:22 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7CAEAA4062;
        Tue, 22 Feb 2022 14:54:59 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4F17EA405B;
        Tue, 22 Feb 2022 14:54:58 +0000 (GMT)
Received: from linux7.. (unknown [9.114.12.92])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 22 Feb 2022 14:54:58 +0000 (GMT)
From:   Steffen Eiden <seiden@linux.ibm.com>
To:     Thomas Huth <thuth@redhat.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>
Cc:     kvm@vger.kernel.org, linux-s390@vger.kernel.org
Subject: [kvm-unit-tests PATCH v3 1/5] s390x: uv-host: Add attestation test
Date:   Tue, 22 Feb 2022 14:54:52 +0000
Message-Id: <20220222145456.9956-2-seiden@linux.ibm.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220222145456.9956-1-seiden@linux.ibm.com>
References: <20220222145456.9956-1-seiden@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 9crtBt0xRadRXr4Bvhphgtlasa3NNA7F
X-Proofpoint-GUID: n07z4zhYF8aacn1SypA6pb9_Todnuhgy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-22_03,2022-02-21_02,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 malwarescore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0
 mlxscore=0 clxscore=1015 mlxlogscore=999 phishscore=0 bulkscore=0
 suspectscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202220091
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Adds an invalid command test for attestation in the uv-host.

Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>
Reviewed-by: Janosch Frank <frankja@linux.ibm.com>
Reviewed-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
---
 lib/s390x/asm/uv.h | 23 ++++++++++++++++++++++-
 s390x/uv-host.c    |  1 +
 2 files changed, 23 insertions(+), 1 deletion(-)

diff --git a/lib/s390x/asm/uv.h b/lib/s390x/asm/uv.h
index 70bf65c4..c330c0f8 100644
--- a/lib/s390x/asm/uv.h
+++ b/lib/s390x/asm/uv.h
@@ -1,7 +1,7 @@
 /*
  * s390x Ultravisor related definitions
  *
- * Copyright (c) 2020 IBM Corp
+ * Copyright IBM Corp. 2020, 2022
  *
  * Authors:
  *  Janosch Frank <frankja@linux.ibm.com>
@@ -47,6 +47,7 @@
 #define UVC_CMD_UNPIN_PAGE_SHARED	0x0342
 #define UVC_CMD_SET_SHARED_ACCESS	0x1000
 #define UVC_CMD_REMOVE_SHARED_ACCESS	0x1001
+#define UVC_CMD_ATTESTATION		0x1020
 
 /* Bits in installed uv calls */
 enum uv_cmds_inst {
@@ -71,6 +72,7 @@ enum uv_cmds_inst {
 	BIT_UVC_CMD_UNSHARE_ALL = 20,
 	BIT_UVC_CMD_PIN_PAGE_SHARED = 21,
 	BIT_UVC_CMD_UNPIN_PAGE_SHARED = 22,
+	BIT_UVC_CMD_ATTESTATION = 28,
 };
 
 struct uv_cb_header {
@@ -178,6 +180,25 @@ struct uv_cb_cfs {
 	u64 paddr;
 }  __attribute__((packed))  __attribute__((aligned(8)));
 
+/* Retrieve Attestation Measurement */
+struct uv_cb_attest {
+	struct uv_cb_header header;	/* 0x0000 */
+	uint64_t reserved08[2];		/* 0x0008 */
+	uint64_t arcb_addr;		/* 0x0018 */
+	uint64_t continuation_token;	/* 0x0020 */
+	uint8_t  reserved28[6];		/* 0x0028 */
+	uint16_t user_data_length;	/* 0x002e */
+	uint8_t  user_data[256];	/* 0x0030 */
+	uint32_t reserved130[3];	/* 0x0130 */
+	uint32_t measurement_length;	/* 0x013c */
+	uint64_t measurement_address;	/* 0x0140 */
+	uint8_t config_uid[16];		/* 0x0148 */
+	uint32_t reserved158;		/* 0x0158 */
+	uint32_t add_data_length;	/* 0x015c */
+	uint64_t add_data_address;	/* 0x0160 */
+	uint64_t reserved168[4];	/* 0x0168 */
+}  __attribute__((packed))  __attribute__((aligned(8)));
+
 /* Set Secure Config Parameter */
 struct uv_cb_ssc {
 	struct uv_cb_header header;
diff --git a/s390x/uv-host.c b/s390x/uv-host.c
index de2e4850..fe49d7b9 100644
--- a/s390x/uv-host.c
+++ b/s390x/uv-host.c
@@ -418,6 +418,7 @@ static struct cmd_list invalid_cmds[] = {
 	{ "bogus", 0x4242, sizeof(struct uv_cb_header), -1},
 	{ "share", UVC_CMD_SET_SHARED_ACCESS, sizeof(struct uv_cb_share), BIT_UVC_CMD_SET_SHARED_ACCESS },
 	{ "unshare", UVC_CMD_REMOVE_SHARED_ACCESS, sizeof(struct uv_cb_share), BIT_UVC_CMD_REMOVE_SHARED_ACCESS },
+	{ "attest", UVC_CMD_ATTESTATION, sizeof(struct uv_cb_attest), BIT_UVC_CMD_ATTESTATION },
 	{ NULL, 0, 0 },
 };
 
-- 
2.30.2

