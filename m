Return-Path: <linux-s390+bounces-6625-lists+linux-s390=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 935C09A39C0
	for <lists+linux-s390@lfdr.de>; Fri, 18 Oct 2024 11:17:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 15D1C1F25E33
	for <lists+linux-s390@lfdr.de>; Fri, 18 Oct 2024 09:17:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82CA31EABA5;
	Fri, 18 Oct 2024 09:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="T3gt0xzh"
X-Original-To: linux-s390@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C3BD1E7679;
	Fri, 18 Oct 2024 09:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729242925; cv=none; b=JgfhjJM3LMNWRzsqg7hbRE/Wy0etfVM4N7NQjaZjIkp3SUmeSuNbb+bFX3qEoab+C7gN/4G4V1M2Kx1ClIIQfSE6hKyS+KCwzAsFX33/24I9e9BGEOVumWMysii1mW9HKFInzY5+5U4z2/9dlxVIsllMkOEoRe9xTaWOuhiJbDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729242925; c=relaxed/simple;
	bh=X0lNSp5i0RziXGNOcFt9fGsob4bt2+pxmaZ2WNS/D1Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hYVs1Hj7wNqcZtZ9zdKr8sTmvL8IKeOdBZXPqZVyXnFT86OO8GJxLQ19OR5APQg6yyUxmLU5N+EKORdMkNvU2a+31grelZSBA5vxbwwucLyJBNX9e1p9jB04Em88O0aDWd50mkL5rj40iHKUjSdet+zeGTdTUZ9eYn9r1pE21Yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=T3gt0xzh; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49I8oFWb007998;
	Fri, 18 Oct 2024 09:15:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=d08ypVT9LBTk7Vtys
	NIxYzD0+Ptc9czUV8HQyOnJZ/o=; b=T3gt0xzhziKNwYiFmEepImiywpduH9Ws7
	vwtB/2RAC9iVIUo7UW8JY7ZAA0Pql9ZqonHtEbqBVCS6gvDVpj5Bnr1AnNWLmmkY
	TYpW4h5EQOWu6DhR9Qos6GSefhgrwDxSftWLsDOM1BDxppXdg92xBJ6l0jHIaEzW
	9dA7Ku0xX/OL35dfbkpp0xx/ovfdQKIgh2krvhplLAv5iDSSxPUpdchAIL+n+/q1
	Gi4f8RJpUb5ET/xP0Os1keBtRHHNxNYCSzdKAL87jHgQHm3E2cJPtC5rXjLNpgct
	aWcD4Nr6d855tFZHcki6NGBQ/7N9UaQMRiCxsWa41kIFXfkNkPcug==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42as8a7f7m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 18 Oct 2024 09:15:22 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 49I7UkYi006663;
	Fri, 18 Oct 2024 09:15:21 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4283esbr6u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 18 Oct 2024 09:15:21 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 49I9FHxJ41157054
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 18 Oct 2024 09:15:17 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 95E192004E;
	Fri, 18 Oct 2024 09:15:17 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6D7E32005A;
	Fri, 18 Oct 2024 09:15:17 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 18 Oct 2024 09:15:17 +0000 (GMT)
From: Steffen Eiden <seiden@linux.ibm.com>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Ingo Franzki <ifranzki@linux.ibm.com>,
        Harald Freudenberger <freude@linux.ibm.com>,
        Christoph Schlameuss <schlameuss@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>
Subject: [PATCH v4 5/6] s390/uvdevice: Add List Secrets Ext IOCTL
Date: Fri, 18 Oct 2024 11:15:15 +0200
Message-ID: <20241018091516.2167885-6-seiden@linux.ibm.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241018091516.2167885-1-seiden@linux.ibm.com>
References: <20241018091516.2167885-1-seiden@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 6FU905V6Ut5qVUpVW7c_Mc_GIdauUwAw
X-Proofpoint-ORIG-GUID: 6FU905V6Ut5qVUpVW7c_Mc_GIdauUwAw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxscore=0
 lowpriorityscore=0 suspectscore=0 mlxlogscore=999 phishscore=0
 adultscore=0 impostorscore=0 priorityscore=1501 spamscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410180056

Add an extended List Secrets IOCTL. In contrast to the first list IOCTL
this accepts an index as the first two bytes of the provided page as an
input. This index is then taken as the index offset for the list UVC to
receive later entries for the list. While at it fix some kernel doc
issues with the list function.

Reviewed-by: Christoph Schlameuss <schlameuss@linux.ibm.com>
Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>
---
 arch/s390/include/uapi/asm/uvdevice.h |  4 ++
 drivers/s390/char/uvdevice.c          | 98 +++++++++++++++++++--------
 2 files changed, 74 insertions(+), 28 deletions(-)

diff --git a/arch/s390/include/uapi/asm/uvdevice.h b/arch/s390/include/uapi/asm/uvdevice.h
index 4947f26ad9fb..1cfa4e17af03 100644
--- a/arch/s390/include/uapi/asm/uvdevice.h
+++ b/arch/s390/include/uapi/asm/uvdevice.h
@@ -72,6 +72,7 @@ struct uvio_uvdev_info {
 #define UVIO_ADD_SECRET_MAX_LEN		0x100000
 #define UVIO_LIST_SECRETS_LEN		0x1000
 #define UVIO_RETR_SECRET_MAX_LEN	0x2000
+#define UVIO_LIST_SECRETS_EXT_LEN	UVIO_LIST_SECRETS_LEN
 
 #define UVIO_DEVICE_NAME "uv"
 #define UVIO_TYPE_UVC 'u'
@@ -83,6 +84,7 @@ enum UVIO_IOCTL_NR {
 	UVIO_IOCTL_LIST_SECRETS_NR,
 	UVIO_IOCTL_LOCK_SECRETS_NR,
 	UVIO_IOCTL_RETR_SECRET_NR,
+	UVIO_IOCTL_LIST_SECRETS_EXT_NR,
 	/* must be the last entry */
 	UVIO_IOCTL_NUM_IOCTLS
 };
@@ -94,6 +96,7 @@ enum UVIO_IOCTL_NR {
 #define UVIO_IOCTL_LIST_SECRETS		UVIO_IOCTL(UVIO_IOCTL_LIST_SECRETS_NR)
 #define UVIO_IOCTL_LOCK_SECRETS		UVIO_IOCTL(UVIO_IOCTL_LOCK_SECRETS_NR)
 #define UVIO_IOCTL_RETR_SECRET		UVIO_IOCTL(UVIO_IOCTL_RETR_SECRET_NR)
+#define UVIO_IOCTL_LIST_SECRETS_EXT	UVIO_IOCTL(UVIO_IOCTL_LIST_SECRETS_EXT_NR)
 
 #define UVIO_SUPP_CALL(nr)		(1ULL << (nr))
 #define UVIO_SUPP_UDEV_INFO		UVIO_SUPP_CALL(UVIO_IOCTL_UDEV_INFO_NR)
@@ -102,5 +105,6 @@ enum UVIO_IOCTL_NR {
 #define UVIO_SUPP_LIST_SECRETS		UVIO_SUPP_CALL(UVIO_IOCTL_LIST_SECRETS_NR)
 #define UVIO_SUPP_LOCK_SECRETS		UVIO_SUPP_CALL(UVIO_IOCTL_LOCK_SECRETS_NR)
 #define UVIO_SUPP_RETR_SECRET		UVIO_SUPP_CALL(UVIO_IOCTL_RETR_SECRET_NR)
+#define UVIO_SUPP_LIST_SECRETS_EXT	UVIO_SUPP_CALL(UVIO_IOCTL_LIST_SECRETS_EXT_NR)
 
 #endif /* __S390_ASM_UVDEVICE_H */
diff --git a/drivers/s390/char/uvdevice.c b/drivers/s390/char/uvdevice.c
index 1f90976293e8..18bae2d45bf6 100644
--- a/drivers/s390/char/uvdevice.c
+++ b/drivers/s390/char/uvdevice.c
@@ -41,6 +41,7 @@ static const u32 ioctl_nr_to_uvc_bit[] __initconst = {
 	[UVIO_IOCTL_LIST_SECRETS_NR] = BIT_UVC_CMD_LIST_SECRETS,
 	[UVIO_IOCTL_LOCK_SECRETS_NR] = BIT_UVC_CMD_LOCK_SECRETS,
 	[UVIO_IOCTL_RETR_SECRET_NR] = BIT_UVC_CMD_RETR_ATTEST,
+	[UVIO_IOCTL_LIST_SECRETS_EXT_NR] = BIT_UVC_CMD_LIST_SECRETS,
 };
 
 static_assert(ARRAY_SIZE(ioctl_nr_to_uvc_bit) == UVIO_IOCTL_NUM_IOCTLS);
@@ -297,8 +298,39 @@ static int uvio_add_secret(struct uvio_ioctl_cb *uv_ioctl)
 	return ret;
 }
 
-/** uvio_list_secrets() - perform a List Secret UVC
- * @uv_ioctl: ioctl control block
+/*
+ * The actual list(_ext) IOCTL.
+ * If list_ext is true, the first two bytes of the user buffer set the starting
+ * index of the list-UVC.
+ */
+static int list_secrets(struct uvio_ioctl_cb *uv_ioctl, bool list_ext)
+{
+	void __user *user_buf_arg = (void __user *)uv_ioctl->argument_addr;
+	u16 __user *user_index = (u16 __user *)uv_ioctl->argument_addr;
+	u16 start_idx = 0;
+	u8 *secrets;
+	int ret = 0;
+
+	BUILD_BUG_ON(UVIO_LIST_SECRETS_LEN != PAGE_SIZE);
+	if (uv_ioctl->argument_len != UVIO_LIST_SECRETS_LEN)
+		return -EINVAL;
+	/* The extended call accepts an u16 index as input */
+	if (list_ext && get_user(start_idx, user_index))
+		return -EFAULT;
+	secrets = (u8 *)get_zeroed_page(GFP_KERNEL);
+	if (!secrets)
+		return -ENOMEM;
+	uv_list_secrets(secrets, start_idx, &uv_ioctl->uv_rc, &uv_ioctl->uv_rrc);
+	if (copy_to_user(user_buf_arg, secrets, UVIO_LIST_SECRETS_LEN))
+		ret = -EFAULT;
+
+	free_page((unsigned long)secrets);
+	return ret;
+}
+
+/**
+ * uvio_list_secrets() - perform a List Secret UVC.
+ * @uv_ioctl: ioctl control block.
  *
  * uvio_list_secrets() performs the List Secret Ultravisor Call. It verifies
  * that the given userspace argument address is valid and its size is sane.
@@ -312,37 +344,13 @@ static int uvio_add_secret(struct uvio_ioctl_cb *uv_ioctl)
  * command rc. This won't be fenced in the driver and does not result in a
  * negative return value.
  *
- * Context: might sleep
+ * Context: might sleep.
  *
  * Return: 0 on success or a negative error code on error.
  */
 static int uvio_list_secrets(struct uvio_ioctl_cb *uv_ioctl)
 {
-	void __user *user_buf_arg = (void __user *)uv_ioctl->argument_addr;
-	struct uv_cb_guest_addr uvcb = {
-		.header.len = sizeof(uvcb),
-		.header.cmd = UVC_CMD_LIST_SECRETS,
-	};
-	void *secrets = NULL;
-	int ret = 0;
-
-	if (uv_ioctl->argument_len != UVIO_LIST_SECRETS_LEN)
-		return -EINVAL;
-
-	secrets = kvzalloc(UVIO_LIST_SECRETS_LEN, GFP_KERNEL);
-	if (!secrets)
-		return -ENOMEM;
-
-	uvcb.addr = (u64)secrets;
-	uv_call_sched(0, (u64)&uvcb);
-	uv_ioctl->uv_rc = uvcb.header.rc;
-	uv_ioctl->uv_rrc = uvcb.header.rrc;
-
-	if (copy_to_user(user_buf_arg, secrets, UVIO_LIST_SECRETS_LEN))
-		ret = -EFAULT;
-
-	kvfree(secrets);
-	return ret;
+	return list_secrets(uv_ioctl, false);
 }
 
 /** uvio_lock_secrets() - perform a Lock Secret Store UVC
@@ -432,6 +440,37 @@ static int uvio_retr_secret(struct uvio_ioctl_cb *uv_ioctl)
 	return ret;
 }
 
+/**
+ * uvio_list_secrets_ext() - perform a List Secret UVC with a starting index.
+ * @uv_ioctl: ioctl control block.
+ *
+ * uvio_list_secrets_ext() performs the List Secret Ultravisor Call. It verifies
+ * that the given userspace argument address is valid and its size is sane.
+ * Every other check is made by the Ultravisor (UV) and won't result in a
+ * negative return value. It builds the request, performs the UV-call, and
+ * copies the result to userspace.
+ *
+ * The argument specifies the location for the result of the UV-Call.
+ * The first two bytes of the argument specify the starting index of the list.
+ * This should be zero for the first IOCTL. If UV reports more data
+ * (rc UVC_RC_MORE_DATA) another list_ext IOCTL with a higher starting index
+ * shows the following entries of the secret list. Choose next_valid_index from
+ * the list header as starting index for the list in the following IOCTLs to
+ * get a continuous list without holes.
+ *
+ * If the List Secrets UV facility is not present, UV will return invalid
+ * command rc. This won't be fenced in the driver and does not result in a
+ * negative return value.
+ *
+ * Context: might sleep.
+ *
+ * Return: 0 on success or a negative error code on error.
+ */
+static int uvio_list_secrets_ext(struct uvio_ioctl_cb *uv_ioctl)
+{
+	return list_secrets(uv_ioctl, true);
+}
+
 static int uvio_copy_and_check_ioctl(struct uvio_ioctl_cb *ioctl, void __user *argp,
 				     unsigned long cmd)
 {
@@ -488,6 +527,9 @@ static long uvio_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 	case UVIO_IOCTL_RETR_SECRET_NR:
 		ret = uvio_retr_secret(&uv_ioctl);
 		break;
+	case UVIO_IOCTL_LIST_SECRETS_EXT_NR:
+		ret = uvio_list_secrets_ext(&uv_ioctl);
+		break;
 	default:
 		ret = -ENOIOCTLCMD;
 		break;
-- 
2.45.2


