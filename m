Return-Path: <linux-s390+bounces-6233-lists+linux-s390=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA55698E02D
	for <lists+linux-s390@lfdr.de>; Wed,  2 Oct 2024 18:06:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA36B1C23102
	for <lists+linux-s390@lfdr.de>; Wed,  2 Oct 2024 16:06:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CB671D14EE;
	Wed,  2 Oct 2024 16:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="XkBOnAiE"
X-Original-To: linux-s390@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E93591D0E08;
	Wed,  2 Oct 2024 16:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727885144; cv=none; b=ayiiaJVmYAWnyLXt+YksKl/kG1IecKOUNRAf/sR1+aZBawi/NAzVl/XnbpYq7Kql31c0Wq/aJTiytD44kqmzDen8wKXuj7W1jmSJKwwcWQNiHcRmF2Y3/N2afevOddfy7aBAwRy9Y5iRNSgDku6k8JFjRZx/HIesxNuvNUqreT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727885144; c=relaxed/simple;
	bh=uPflt+3BvfbihsVeUO4D586yMuyy3AcBwrfL2oxrzWI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lc9gYDwI2lCIn50ucV4+agS54wmKmmixcF0bXUUgD7jdjem4UTmt+eXUBJVD7fiQKPW+Dy5JTwBxohJbrOpkP9vr4SkcyHvM2sjUV888SlKki4mqbdh7EJcxYpWY88wTmEayNLpWgoRnxy0LENOYyp4IgGgSHeK5TNED79U7abM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=XkBOnAiE; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 492FlwJF012731;
	Wed, 2 Oct 2024 16:05:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=pp1; bh=M9Pug4/kLwaw1
	5kQNp+B8EPkZUtisMXehpQ4IAn3KGs=; b=XkBOnAiEScuRnxMJHAWok7INmsDNu
	+Zlb73LYooxmZp0lG4MI6rYTG6qh4KoLU0BTHdRZD8YRvFaV1bb4FVEr2aM29Pir
	QqhVL7jxf6lv02ZwWpUZ/AR8X4rUF5Hdp05d7NZUguezeESBBPInNyxsy2M5PC3V
	nbAw9TonmY/d7McnsgcDjenTTK7cirZJGAZVw7rtAk2WMqlZWyeuVTwrL7rCze98
	NbI8E+wV5+rVTL0NYLZ38HLrBrftoy7pZG3FvbEFv8UfyAs3IQ+Jy9Ogzz1A+zDm
	/yO+Z6apOCL5IOFfdRdFcL8r7uXrDZgO6j+Z9Cd/jqAcqqbVHw98+DAvg==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42194mg355-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 02 Oct 2024 16:05:38 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 492FrBYY007989;
	Wed, 2 Oct 2024 16:05:38 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 41xvgy3bys-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 02 Oct 2024 16:05:38 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 492G5YKg18874834
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 2 Oct 2024 16:05:34 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 41C5820040;
	Wed,  2 Oct 2024 16:05:34 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E3B8820043;
	Wed,  2 Oct 2024 16:05:33 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  2 Oct 2024 16:05:33 +0000 (GMT)
From: Steffen Eiden <seiden@linux.ibm.com>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Ingo Franzki <ifranzki@linux.ibm.com>,
        Harald Freudenberger <freude@linux.ibm.com>,
        Christoph Schlameuss <schlameuss@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>
Subject: [PATCH v2 2/6] s390/uv: Retrieve UV secrets support
Date: Wed,  2 Oct 2024 18:05:28 +0200
Message-ID: <20241002160532.2425734-3-seiden@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241002160532.2425734-1-seiden@linux.ibm.com>
References: <20241002160532.2425734-1-seiden@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: hWMAo0V7_K5ahJ1_L5mUbMzvYGBgZLI9
X-Proofpoint-ORIG-GUID: hWMAo0V7_K5ahJ1_L5mUbMzvYGBgZLI9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-02_15,2024-09-30_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 adultscore=0
 malwarescore=0 phishscore=0 lowpriorityscore=0 spamscore=0 clxscore=1015
 suspectscore=0 mlxlogscore=648 priorityscore=1501 mlxscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2408220000
 definitions=main-2410020114

Provide a kernel API to retrieve secrets from the UV secret store.
Add two new functions:
* `uv_get_secret_metadata` - get metadata for a given secret identifier
* `uv_retrieve_secret` - get the secret value for the secret index

With those two functions one can extract the secret for a given secret
id, if the secret is retrievable.

Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>
---
 arch/s390/include/asm/uv.h | 131 ++++++++++++++++++++++++++++++++++++-
 arch/s390/kernel/uv.c      | 127 ++++++++++++++++++++++++++++++++++-
 2 files changed, 256 insertions(+), 2 deletions(-)

diff --git a/arch/s390/include/asm/uv.h b/arch/s390/include/asm/uv.h
index 94ff58336e8e..aef333aaaef4 100644
--- a/arch/s390/include/asm/uv.h
+++ b/arch/s390/include/asm/uv.h
@@ -62,6 +62,7 @@
 #define UVC_CMD_ADD_SECRET		0x1031
 #define UVC_CMD_LIST_SECRETS		0x1033
 #define UVC_CMD_LOCK_SECRETS		0x1034
+#define UVC_CMD_RETR_SECRET		0x1035
 
 /* Bits in installed uv calls */
 enum uv_cmds_inst {
@@ -95,6 +96,7 @@ enum uv_cmds_inst {
 	BIT_UVC_CMD_ADD_SECRET = 29,
 	BIT_UVC_CMD_LIST_SECRETS = 30,
 	BIT_UVC_CMD_LOCK_SECRETS = 31,
+	BIT_UVC_CMD_RETR_SECRETS = 33,
 };
 
 enum uv_feat_ind {
@@ -318,7 +320,6 @@ struct uv_cb_dump_complete {
  * A common UV call struct for pv guests that contains a single address
  * Examples:
  * Add Secret
- * List Secrets
  */
 struct uv_cb_guest_addr {
 	struct uv_cb_header header;
@@ -327,6 +328,91 @@ struct uv_cb_guest_addr {
 	u64 reserved28[4];
 } __packed __aligned(8);
 
+#define UVC_RC_RETR_SECR_BUF_SMALL	0x0109
+#define UVC_RC_RETR_SECR_STORE_EMPTY	0x010f
+#define UVC_RC_RETR_SECR_INV_IDX	0x0110
+#define UVC_RC_RETR_SECR_INV_SECRET	0x0111
+
+struct uv_cb_retr_secr {
+	struct uv_cb_header header;
+	u64 reserved08[2];
+	u16 secret_idx;
+	u16 reserved1a;
+	u32 buf_size;
+	u64 buf_addr;
+	u64 reserved28[4];
+}  __packed __aligned(8);
+
+struct uv_cb_list_secrets {
+	struct uv_cb_header header;
+	u64 reserved08[2];
+	u8  reserved18[6];
+	u16 start_idx;
+	u64 list_addr;
+	u64 reserved28[4];
+} __packed __aligned(8);
+
+enum uv_secret_types {
+	UV_SECRET_INVAL = 0x0,
+	UV_SECRET_NULL = 0x1,
+	UV_SECRET_ASSOCIATION = 0x2,
+	UV_SECRET_PLAIN = 0x3,
+	UV_SECRET_AES_128 = 0x4,
+	UV_SECRET_AES_192 = 0x5,
+	UV_SECRET_AES_256 = 0x6,
+	UV_SECRET_AES_XTS_128 = 0x7,
+	UV_SECRET_AES_XTS_256 = 0x8,
+	UV_SECRET_HMAC_SHA_256 = 0x9,
+	UV_SECRET_HMAC_SHA_512 = 0xa,
+	/* 0x0b - 0x10 reserved */
+	UV_SECRET_ECDSA_P256 = 0x11,
+	UV_SECRET_ECDSA_P384 = 0x12,
+	UV_SECRET_ECDSA_P521 = 0x13,
+	UV_SECRET_ECDSA_ED25519 = 0x14,
+	UV_SECRET_ECDSA_ED448 = 0x15,
+};
+
+/**
+ * uv_secret_list_item_hdr - UV secret metadata
+ * @index: Index of the secret in the secret list
+ * @type: Type of the secret. See `enum uv_secret_types`
+ * @length: Length of the stored secret.
+ */
+struct uv_secret_list_item_hdr {
+	u16 index;
+	u16 type;
+	u32 length;
+};
+
+#define UV_SECRET_ID_LEN 32
+/**
+ * uv_secret_list_item - UV secret entry
+ * @hdr: The metadata of this secret.
+ * @id: The ID of this secret, not the secret itself.
+ */
+struct uv_secret_list_item {
+	struct uv_secret_list_item_hdr hdr;
+	u64 reserverd08;
+	u8 id[UV_SECRET_ID_LEN];
+};
+
+/**
+ * uv_secret_list - UV secret-metadata list
+ * @num_secr_stored: Number of secrets stored in this list
+ * @total_num_secrets: Number of secrets stored in the UV for this guest
+ * @next_secret_idx: positive number if there are more secrets available or zero
+ * @secrets: Up to 85 UV-secret metadata entries.
+ */
+struct uv_secret_list {
+	u16 num_secr_stored;
+	u16 total_num_secrets;
+	u16 next_secret_idx;
+	u16 reserved_06;
+	u64 reserved_08;
+	struct uv_secret_list_item secrets[85];
+} __packed __aligned(8);
+static_assert(sizeof(struct uv_secret_list) == PAGE_SIZE);
+
 static inline int __uv_call(unsigned long r1, unsigned long r2)
 {
 	int cc;
@@ -383,6 +469,45 @@ static inline int uv_cmd_nodata(u64 handle, u16 cmd, u16 *rc, u16 *rrc)
 	return cc ? -EINVAL : 0;
 }
 
+/** uv_list_secrets() - Do a List Secrets UVC
+ *  @buf: Buffer to write list into; size of one page
+ *  @start_idx: The smallest index that should be included in the list.
+ *		For the fist invocation use 0.
+ *  @rc: Pointer to store the return code or NULL.
+ *  @rrc: Pointer to store the return reason code or NULL.
+ *
+ *  This function calls the List Secrets UVC. The result is written into `buf`,
+ *  that needs to be at least one page of writable memory.
+ *  `buf` consists of:
+ *  * %struct uv_secret_list_hdr
+ *  * %struct uv_secret_list_item (multiple)
+ *
+ *  For `start_idx` use _0_ for the first call. If there are more secrets available
+ *  but could not fit into the page then `rc` is `UVC_RC_MORE_DATA`.
+ *  In this case use `uv_secret_list_hdr.next_secret_idx` for `start_idx`.
+ *
+ *  Context: might sleep
+ *
+ *  Return: The UVC condition code
+ */
+static inline int uv_list_secrets(u8 *buf, u16 start_idx, u16 *rc, u16 *rrc)
+{
+	struct uv_cb_list_secrets uvcb = {
+		.header.len = sizeof(uvcb),
+		.header.cmd = UVC_CMD_LIST_SECRETS,
+		.start_idx = start_idx,
+		.list_addr = (u64)buf,
+	};
+	int cc = uv_call_sched(0, (u64)&uvcb);
+
+	if (rc)
+		*rc = uvcb.header.rc;
+	if (rrc)
+		*rrc = uvcb.header.rrc;
+
+	return cc;
+}
+
 struct uv_info {
 	unsigned long inst_calls_list[4];
 	unsigned long uv_base_stor_len;
@@ -469,6 +594,10 @@ static inline int uv_remove_shared(unsigned long addr)
 	return share(addr, UVC_CMD_REMOVE_SHARED_ACCESS);
 }
 
+int uv_get_secret_metadata(const u8 secret_id[UV_SECRET_ID_LEN],
+			   struct uv_secret_list_item_hdr *secret);
+int uv_retrieve_secret(u16 secret_idx, u8 *buf, size_t buf_size);
+
 extern int prot_virt_host;
 
 static inline int is_prot_virt_host(void)
diff --git a/arch/s390/kernel/uv.c b/arch/s390/kernel/uv.c
index 9646f773208a..410f96e06cba 100644
--- a/arch/s390/kernel/uv.c
+++ b/arch/s390/kernel/uv.c
@@ -2,7 +2,7 @@
 /*
  * Common Ultravisor functions and initialization
  *
- * Copyright IBM Corp. 2019, 2020
+ * Copyright IBM Corp. 2019, 2024
  */
 #define KMSG_COMPONENT "prot_virt"
 #define pr_fmt(fmt) KMSG_COMPONENT ": " fmt
@@ -787,3 +787,128 @@ static int __init uv_info_init(void)
 	return rc;
 }
 device_initcall(uv_info_init);
+
+/*
+ * Find the secret with the secret_id in the provided list
+ *
+ * Context: might sleep
+ */
+static int find_secret_in_page(const u8 secret_id[UV_SECRET_ID_LEN],
+			       const struct uv_secret_list *list,
+			       struct uv_secret_list_item_hdr *secret)
+{
+	u16 i;
+
+	for (i = 0; i < list->total_num_secrets; i++) {
+		if (memcmp(secret_id, list->secrets[i].id, UV_SECRET_ID_LEN) == 0) {
+			*secret = list->secrets[i].hdr;
+			return 0;
+		}
+	}
+	return -ENOENT;
+}
+
+/*
+ * Do the actual search for `uv_get_secret_metadata`
+ *
+ * Context: might sleep
+ */
+static int find_secret(const u8 secret_id[UV_SECRET_ID_LEN],
+		       struct uv_secret_list *list,
+		       struct uv_secret_list_item_hdr *secret)
+{
+	u16 start_idx = 0;
+	u16 list_rc;
+	int ret;
+
+	do {
+		uv_list_secrets((u8 *)list, start_idx, &list_rc, NULL);
+		if (!(list_rc == UVC_RC_EXECUTED || list_rc == UVC_RC_MORE_DATA)) {
+			if (list_rc == UVC_RC_INV_CMD)
+				return -ENODEV;
+			else
+				return -EIO;
+		}
+		ret = find_secret_in_page(secret_id, list, secret);
+		if (ret == 0)
+			return ret;
+		start_idx = list->next_secret_idx;
+	} while (list_rc == UVC_RC_MORE_DATA && start_idx < list->next_secret_idx);
+
+	return -ENOENT;
+}
+
+/**
+ * uv_get_secret_metadata() - get secret metadata for a given secret id
+ * @secret_id: search pattern
+ * @secret: output data, containing the secret's metadata
+ *
+ * Search for a secret with the given secret_id in the Ultravisor secret store.
+ *
+ * Context: might sleep
+ *
+ * Return:
+ * * %0:	- Found entry; secret->idx and secret->type are valid
+ * * %ENOENT	- No entry found
+ * * %ENODEV:	- Not supported: UV not available or command not available
+ * * %EIO:	- Other unexpected UV error
+ */
+int uv_get_secret_metadata(const u8 secret_id[UV_SECRET_ID_LEN],
+			   struct uv_secret_list_item_hdr *secret)
+{
+	struct uv_secret_list *buf;
+	int rc;
+
+	buf = kzalloc(sizeof(*buf), GFP_KERNEL);
+	rc = find_secret(secret_id, buf, secret);
+	kfree(buf);
+	return rc;
+}
+EXPORT_SYMBOL_GPL(uv_get_secret_metadata);
+
+/**
+ * uv_retrieve_secret() - get the secret value for the secret index
+ * @secret_idx: Secret index for which the secret should be retrieved
+ * @buf: Buffer to store retrieved secret
+ * @buf_size: Size of the buffer. The correct buffer size is reported as part of
+ * the result from `uv_get_secret_metadata`
+ *
+ * Calls the Retrieve Secret UVC and translates the UV return code into an errno.
+ *
+ * Context: might sleep
+ *
+ * Return:
+ * * %0		- Entry found; buffer contains a valid secret
+ * * %ENOENT:	- No entry found or secret at the index is non-retrievable
+ * * %ENODEV:	- Not supported: UV not available or command not available
+ * * %EINVAL:	- Buffer too small for content
+ * * %EIO:	- Other unexpected UV error
+ */
+int uv_retrieve_secret(u16 secret_idx, u8 *buf, size_t buf_size)
+{
+	struct uv_cb_retr_secr uvcb = {
+		.header.len = sizeof(uvcb),
+		.header.cmd = UVC_CMD_RETR_SECRET,
+		.secret_idx = secret_idx,
+		.buf_addr = (u64)buf,
+		.buf_size = buf_size,
+	};
+
+	uv_call_sched(0, (u64)&uvcb);
+
+	switch (uvcb.header.rc) {
+	case UVC_RC_EXECUTED:
+		return 0;
+	case UVC_RC_INV_CMD:
+		return -ENODEV;
+	case UVC_RC_RETR_SECR_STORE_EMPTY:
+	case UVC_RC_RETR_SECR_INV_SECRET:
+	case UVC_RC_RETR_SECR_INV_IDX:
+		return -ENOENT;
+	case UVC_RC_RETR_SECR_BUF_SMALL:
+		return -EINVAL;
+	default:
+		return -EIO;
+	}
+}
+EXPORT_SYMBOL_GPL(uv_retrieve_secret);
-- 
2.43.0


